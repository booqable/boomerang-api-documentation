---
title: Booqable API documentation

# language_tabs: # must be one of https://git.io/vQNgJ
#   - shell

# toc_footers:
#   - <a href='#'>Sign Up for a Developer Account</a>

includes:
  - errors
  - session
  - companies
  - employees
  - employee_invitations
  - items
  - product_groups
  - products
  - bundles
  - bundle_items
  - stock_items
  - stock_counts
  - photos
  - categories
  - barcodes
  - customers
  - customer_merges
  - users
  - orders
  - documents
  - lines
  - plannings
  - stock_item_plannings
  - payment_methods
  - payments
  - transactions
  - clusters
  - locations
  - transfers
  - notes
  - emails
  - email_templates
  - tax_categories
  - tax_regions
  - tax_rates
  - price_structures
  - price_tiles
  - price_rulesets
  - price_rules
  - default_properties
  - properties
  - tags
  - coupons
  - currencies
  - ip_addresses
  - operating_rules
  - billing_invoices
  - users
  - operations
  - authentication_methods
  - login_activities

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Kittn API
---

# Introduction

The Booqable API is a RESTful [JSON API](https://jsonapi.org/) as such is designed to have predictable, resource-oriented URLs and to use HTTP response codes to indicate API errors. We use standard HTTP features, like HTTP authentication and HTTP verbs, which can be understood by [off-the-shelf HTTP clients](https://jsonapi.org/implementations/).

<aside class="warning">
  <b>WARNING:</b> Booqable's API is still in Beta we might introduce non-backwards compatible changes in the future!
</aside>

# Endpoint

All API requests need to be directed to the correct company-specific endpoint.
The format is as follows:

`https://{company_slug}.booqable.com/api/boomerang/`

<aside class="notice">
  You must replace <code>{company_slug}</code> with the name of your company.
</aside>

# Authentication

To interact with the Booqable API, first, you have to have a means of authentification, here's how to setup authentication.

<aside class="notice">
  Unless otherwise specified all further examples will omit authentication for the sake of brevity
</aside>

## Access Token

1. Go to your account settings page
`{company-name-here}.booqable.com/employees/current`
2. Name your new token
3. Click "Create new authentication method"

<aside class="success">
  You now have a <b>Booqable Access Token!</b>
</aside>

You can manage your Access Tokens from your account. You can have multiple Access Tokens active at one time.

<aside class="warning">
  Your Access Tokens carry many privileges, so be sure to keep them secret! <br>
  <b>Don't expose your Access Token in any public websites client-side code.</b>
</aside>

> Example of an authorized request

```shell
curl --request GET \
  --url 'https://example.booqable.com/api/boomerang/customers' \
  --header 'Authorization: Bearer 9bcabeaa827810ad6383d2e15feab2d0c7d039093e22fdd955f11fe83437a32a'
```

You authenticate to the Booqable API by providing on of your Access Tokens in the request.

## Request signing

Single-Use Tokens to sign requests are generated on the client and can only be used once for one particular request. The Booqable API supports the following signing algorithms:

- `ES256`
- `RS256`
- `HS256`

1. Go to your account settings page
`{company-name-here}.booqable.com/employees/current`
2. Name your new authentication method
3. Insert your public key (for `ES256` and `RS256` only)
4. Click "Create new authentication method"

<aside class="success">
  You are now ready to <b>Sign requests!</b>
</aside>

You can manage your authentication methods from your account.
You can have multiple authentication methods active at one time.

<aside class="warning">
  In case you're using HS256: Your Signing Tokens carry many privileges, so be sure to keep them secret! <br>
  <b>Don't expose your Signing Token in any public websites client-side code.</b>
</aside>

> Signing a request (in Ruby, other languages should work like this as well)

```ruby
# To prevent tampering with the request (making a DELETE from a GET, or posting different params with
# the same signature) we include all request data in the data value.  Note that we generate a SHA256 from it.
request_method = 'POST'

# Encoded request params
fullpath = '/?filter%5Bcreated_at%5D%5Bgte%5D%3D1231232131132'

# Base64 encoded SHA256 body
body = '{"note":"Let me in!"}'
encoded_body = Base64.strict_encode64(::OpenSSL::Digest::SHA256.new(body).digest)

# Compute data value
data = Base64.strict_encode64([request_method, fullpath, encoded_body].join('.'))

# Generate a unique request identifier (can be anything unique)
uuid = Digest::UUID.uuid_v4

# We define the authentication method id (which you have obtained in a previous step) and kind in the header
headers = { kid: authentication_method.id, kind: 'single_use' }
payload = {
  iss: 'http://company-name.booqable.com',
  sub: employee.id,
  aud: Company.current.id,
  exp: (Time.current + 10.minutes).to_i, # Can not exceed 10 minutes
  iat: Time.current.to_i,
  jti: "#{uuid}.#{data}"
}

# Note that with HS256 you don't have to supply a public key but a secret is generated for you.
token = JWT.encode payload, private_key, 'ES256', headers
token #=> eyJraWQiOiIwZTJkM2I2YS00OTU0LTQyZTItYTAyNS1kYjMzODE1ZDU2YzUiLCJraW5kIjoic2luZ2xlX3VzZSIsImFsZyI6IkVTMjU2In0.eyJpc3MiOiJodHRwOi8vY29tcGFueS1uYW1lLmJvb3FhYmxlLmNvbSIsInN1YiI6IjVlMWViZmFmLWM5YmEtNDMyOC1hM2U1LThlNzNmZGQ1NGNiOSIsImF1ZCI6IjE4ZGI4YTE0LThhYzctNDE1OS05NmJkLTMxMzI0NmRhYTExMCIsImV4cCI6MTYzNTk0ODk3MiwiaWF0IjoxNjM1OTQ4MzcyLCJqdGkiOiJmMTNkZjNlOC0zMWNjLTQxYTUtOWVlNy1mZjgzMTdmNWQ0Y2EuVUU5VFZDNHZQMlpwYkhSbGNpVTFRbU55WldGMFpXUmZZWFFsTlVRbE5VSm5kR1VsTlVRbE0wUXhNak14TWpNeU1UTXhNVE15TGpWemNGcEhSak5IZFdVeVoycFZRVVZ3ZUhsVll6VTVVbTlIZW5sb2NHMXNWbVo0WlVGNVRrSlZUazA5In0.7S2eI3R6meFPPgZ5iyZQOsTDBHRCihKozKMjvIrNHeYoEsxzKltQhGjb2rnfSlpGrCL38-ub-FTs5EXP39rJfw
```

> The algorithm to generate the data value in the payload looks like this:

```ruby
Base64(
  SHA256(
    [
      request_method,
      encoded_request_fullpath_with_paramaters,
      Base64(
        SHA256(request_body)
      )
    ].join('.')
  )
)
```

> Example of an authorized request

```shell
curl --request GET \
  --url 'https://example.booqable.com/api/boomerang/customers' \
  --header 'Authorization: Bearer eyJraWQiOiIwZTJkM2I2YS00OTU0LTQyZTItYTAyNS1kYjMzODE1ZDU2YzUiLCJraW5kIjoic2luZ2xlX3VzZSIsImFsZyI6IkVTMjU2In0.eyJpc3MiOiJodHRwOi8vY29tcGFueS1uYW1lLmJvb3FhYmxlLmNvbSIsInN1YiI6IjVlMWViZmFmLWM5YmEtNDMyOC1hM2U1LThlNzNmZGQ1NGNiOSIsImF1ZCI6IjE4ZGI4YTE0LThhYzctNDE1OS05NmJkLTMxMzI0NmRhYTExMCIsImV4cCI6MTYzNTk0ODk3MiwiaWF0IjoxNjM1OTQ4MzcyLCJqdGkiOiJmMTNkZjNlOC0zMWNjLTQxYTUtOWVlNy1mZjgzMTdmNWQ0Y2EuVUU5VFZDNHZQMlpwYkhSbGNpVTFRbU55WldGMFpXUmZZWFFsTlVRbE5VSm5kR1VsTlVRbE0wUXhNak14TWpNeU1UTXhNVE15TGpWemNGcEhSak5IZFdVeVoycFZRVVZ3ZUhsVll6VTVVbTlIZW5sb2NHMXNWbVo0WlVGNVRrSlZUazA5In0.7S2eI3R6meFPPgZ5iyZQOsTDBHRCihKozKMjvIrNHeYoEsxzKltQhGjb2rnfSlpGrCL38-ub-FTs5EXP39rJfw
```

You authenticate to the Booqable API by signing the request.
