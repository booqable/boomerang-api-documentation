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
- **`tax_category`**: optional, writable. Associates this carrier with a tax category used to calculate tax on its delivery rates.

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
        "price_in_cents": 500,
        "minimum_order_amount_in_cents": 0
      }
    }
  ]
}
```

When a customer requests delivery rates at checkout, Booqable sends a `POST` request to your `rates_url` with a JSON body (not query parameters) containing:

- `distance`, `distance_unit` (`metric` by default)
- `order_amount_in_cents`
- `origin_address`, `origin_coordinates`, `destination_address`, `destination_coordinates`
- `starts_at`, `stops_at`
- `products`: an array of `{ id, title, price_in_cents, quantity }`
- `token`: a JWT identifying the request as coming from Booqable

Booqable waits 3 seconds for a response before treating the request as failed.

Each rate's own `identifier` is yours to choose (e.g. `standard-shipping`, `express-shipping`) and is separate from the carrier's `identifier` used at registration. `id` and `type` are required for Booqable to accept the response.

### Uninstalling

Uninstalling the app archives all of its carriers, removes their location links, and re-enables pickup at any location left without a carrier.
