## Signed requests

Booqable signs these requests and iframe URLs with your app's OAuth client secret. Verify the signature before you trust anything in them.

- [Delivery carrier](https://developers.booqable.com/apps.html#capabilities-delivery-carriers) rate requests
- calls to your [payment option](https://developers.booqable.com/apps.html#capabilities-payment-options) routes
- [embedded pages](https://developers.booqable.com/apps.html#capabilities-embedded-pages), including a `configuration_page.iframe`
- [sidebar frames](https://developers.booqable.com/apps.html#capabilities-sidebar-frames)
- the [status message](https://developers.booqable.com/apps.html#configuration-status-message) endpoint
- [webhook deliveries](https://developers.booqable.com/apps.html#booqable-interop-webhooks-verifying-deliveries) to endpoints your app created

Theme block settings iframes aren't signed. Webhook deliveries also carry a `token` query param, an HS256 JWT signed with your client secret that expires after 10 minutes. It's deprecated and will be removed, so verify the signature instead.

### Signed params

```
POST https://example.com/api/rates?company_id=7c1f0a52-3b9e-4d6a-8e24-5f2a9c3b1d70&region=eu&ts=1798761600&v=1&signature=15eb8124970543dc99cdf437ddd0b2c63c351abb9adb3eab94af7b13bc2fabe2
```

Booqable adds these query params to the URL you configured, keeping the params it already has (`region=eu` in the example), and sorts them by name:

- **`company_id`**: the company the request is for. Some requests add more context params; each capability lists its own.
- **`v`**: the signing version, currently `1`.
- **`ts`**: when Booqable signed the request, in Unix seconds.
- **`signature`**: the HMAC described below, always last.

Every other param in the query string, including your own, is covered by the signature. Your URL can't already contain a param Booqable adds or repeat a param, and a `+` in it is read as a space.

### Verifying a request

```ruby
require "openssl"
require "digest"

MAX_AGE = 300 # seconds

def verify!(method:, path:, raw_query:, body:, secret:, now: Time.now)
  pairs = raw_query.to_s.split("&").reject(&:empty?).map do |pair|
    key, value = pair.split("=", 2)
    [decode(key), decode(value.to_s)]
  end

  keys = pairs.map(&:first)
  raise "repeated param" if keys.uniq.size != keys.size

  params = pairs.to_h
  raise "unsupported version" unless params["v"] == "1"
  raise "stale" unless params["ts"].to_s.match?(/\A\d+\z/) &&
    (now.to_i - params["ts"].to_i).abs <= MAX_AGE

  query = pairs
    .reject { |key, _| key == "signature" }
    .map { |key, value| [encode(key), encode(value)] }
    .sort_by(&:first)
    .map { |key, value| "#{key}=#{value}" }
    .join("&")

  message = ["v1", method, path, query, Digest::SHA256.hexdigest(body)].join("\n")
  expected = OpenSSL::HMAC.hexdigest("SHA256", secret, message)
  signature = params["signature"].to_s

  unless expected.bytesize == signature.bytesize &&
      OpenSSL.fixed_length_secure_compare(expected, signature)
    raise "bad signature"
  end

  params.except("signature", "v")
end

# Percent-decodes only; "+" stays a "+".
def decode(component)
  component.b.gsub(/%\h\h/) { |escape| escape[1, 2].hex.chr }.force_encoding(Encoding::UTF_8)
end

# Encodes every byte except A-Z, a-z, 0-9, "-", ".", "_" and "~".
def encode(component)
  component.b.gsub(/[^A-Za-z0-9\-._~]/n) { |byte| format("%%%02X", byte.ord) }
end
```

To verify a request:

1. Read the raw query string as it arrived, not your framework's parsed params, which may drop repeated keys, decode `+` as a space, or reorder params.
2. Split it on `&`, then each pair on the first `=`, and percent-decode keys and values.
3. Reject the request if any key appears more than once, if `v` isn't `1`, if `signature` is missing, or if `ts` is more than 5 minutes away from your clock, in either direction.
4. Build the canonical query: every pair except `signature`, keys and values percent-encoded as in RFC 3986 (every byte except `A-Z a-z 0-9 - . _ ~`, as uppercase `%XX`), sorted by the encoded key in byte order, joined as `key=value` with `&`.
5. Build the message from these five lines, joined by `\n` with no trailing newline:
   - `v1`
   - the HTTP method in uppercase, such as `GET` or `POST`
   - the request path as sent, still percent-encoded, without the query string; `/` if it's empty
   - the canonical query
   - the SHA-256 of the raw request body, in lowercase hex. An empty body, as on every `GET`, hashes the empty string.
6. Compute the HMAC-SHA256 of the message with your app's OAuth client secret, in lowercase hex, and compare it with `signature` in constant time.

The body is part of the signature, so hash the bytes you received, before parsing them as JSON or form data.

A signature proves the request came from Booqable within the last 5 minutes. It doesn't stop the same request from being sent twice within that time, so make the endpoints it reaches safe to repeat. A valid signature also doesn't mean every param you need is there, so check that `company_id` is present before you use it. Keep `signature` out of your logs.

### Test vector

Take the request above, sent with the client secret `test-secret` and this body:

```json
{"distance":12.5,"destination_zipcode":"1011 AB"}
```

Its message is:

```
v1
POST
/api/rates
company_id=7c1f0a52-3b9e-4d6a-8e24-5f2a9c3b1d70&region=eu&ts=1798761600&v=1
9bb1626b22cbfdd5409cf13c9922f207146e8370abf7840c50e4f640cac42695
```

and its signature is `15eb8124970543dc99cdf437ddd0b2c63c351abb9adb3eab94af7b13bc2fabe2`. The timestamp is fixed, so check against it with your clock set to `ts`, such as `now: Time.at(1798761600)` in the snippet above.

```
GET https://example.com/panels/order?company_id=7c1f0a52-3b9e-4d6a-8e24-5f2a9c3b1d70&employee_id=2b6e4f1a-8c3d-4e5f-9a7b-6c1d2e3f4a5b&locale=en&order_id=9d8c7b6a-5e4f-4a3b-8c2d-1e0f9a8b7c6d&ts=1798761600&v=1&signature=266a51dba11a32f3abe1cadf05e166c3aac6ec155641608ff01fe2aa1faa9761
```

Iframe URLs are signed the same way, as a `GET` with an empty body. With the same secret, the [sidebar frame](https://developers.booqable.com/apps.html#capabilities-sidebar-frames) URL above has this message:

```
v1
GET
/panels/order
company_id=7c1f0a52-3b9e-4d6a-8e24-5f2a9c3b1d70&employee_id=2b6e4f1a-8c3d-4e5f-9a7b-6c1d2e3f4a5b&locale=en&order_id=9d8c7b6a-5e4f-4a3b-8c2d-1e0f9a8b7c6d&ts=1798761600&v=1
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

and its signature is `266a51dba11a32f3abe1cadf05e166c3aac6ec155641608ff01fe2aa1faa9761`.
