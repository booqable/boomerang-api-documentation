## Delivery Carriers

Delivery carriers let your app offer custom shipping rates at checkout. Unlike tracking scripts or theme blocks, this isn't declared in the manifest at all. You register your carrier through the API once your app is installed.

### Registering a carrier

```jsonc
// POST /api/4/app_carriers (request)
{
  "data": {
    "type": "app_carriers",
    "attributes": {
      "identifier": "my-carrier",
      "rates_url": "https://example.com/api/rates"
    }
  }
}
```

`POST /api/4/app_carriers`, typically called right after your OAuth install completes.

- **`identifier`**: a stable key for this carrier.
- **`rates_url`**: where Booqable sends rate requests.
- **`tax_category_id`**: optional, writable. Associates this carrier with a tax category used to calculate tax on its delivery rates.

A carrier can also be updated later with `PATCH`/`PUT /api/4/app_carriers/{id}`, same attributes.

### Fetching rates

```jsonc
// your rates_url responds with this (response)
{
  "data": [
    {
      "id": "standard-shipping",
      "type": "delivery_rates",
      "attributes": {
        "identifier": "standard-shipping",
        "label": "Standard shipping",
        "carrier_id": "7c1f0a52-3b9e-4d6a-8e24-5f2a9c3b1d70", // id returned when you registered the carrier
        "price_in_cents": 500,
        "minimum_order_amount_in_cents": 0
      }
    }
  ]
}
```

When a customer requests delivery rates at checkout, Booqable sends a `POST` request to your `rates_url` with a form-encoded body (`application/x-www-form-urlencoded`) containing:

- `distance`, `distance_unit` (`metric` by default)
- `order_amount_in_cents`
- `origin_address`, `origin_coordinates`, `destination_address`, `destination_coordinates`
- `starts_at`, `stops_at`
- `products`: an array of `{ id, title, price_in_cents, quantity }`
- `token`: a JWT identifying the request as coming from Booqable

Coordinates are sent as a `"lat,lng"` string and addresses as single-line strings. `token` is a JWT signed with your app's OAuth client secret; verify it to confirm the request came from Booqable.

Booqable waits 3 seconds for a response before treating the request as failed.

Booqable sends this request to every active carrier on every rates request. If you don't serve a request, for example because the destination is outside your coverage, respond with an empty `data` array. If your carrier fails or times out, Booqable skips it and uses the rates from the other carriers.

Each rate's own `identifier` is yours to choose (e.g. `standard-shipping`, `express-shipping`) and is separate from the carrier's `identifier` used at registration. `label` is shown to the customer; if omitted, the rate's `identifier` is used.

Each rate must have an `id`, a `type` of `delivery_rates`, and `attributes` including `carrier_id` (the id Booqable returned when you registered the carrier) and `price_in_cents`. If any rate in the response is invalid, Booqable discards the entire response for your carrier.

### Uninstalling

Uninstalling the app archives all of its carriers, removes their location links, and re-enables pickup at any location left without a carrier.
