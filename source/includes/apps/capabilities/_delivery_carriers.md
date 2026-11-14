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

### Rate requests

```jsonc
// POST {rates_url}?company_id=3b5e8f0c-2a41-4c7d-9e16-8d0f4a7b2c95&ts=1798761600&v=1&signature=… (request)
{
  "distance": 4.813,
  "distance_unit": "metric",
  "order_amount_in_cents": 300000,
  "origin_address": "Industrieweg 4,,1021 KZ,Amsterdam,Noord-Holland,Netherlands",
  "origin_coordinates": "4.9265,52.3912",
  "origin_location_id": "e1a4c2d8-5b37-4f90-8c6e-2d7b9a1f3e64",
  "origin_country": "NL",
  "destination_address": "Keizersgracht 123,,1015 CJ,Amsterdam,Noord-Holland,Netherlands",
  "destination_coordinates": "4.884,52.3752",
  "destination_zipcode": "1015 CJ",
  "destination_region": "Noord-Holland",
  "destination_country": "NL",
  "starts_at": "2026-12-04T09:00:00+01:00", // only through GET /api/4/order_delivery_rates
  "stops_at": "2026-12-06T17:00:00+01:00", // same
  "products": [ // same
    {
      "id": "9d2f6b1a-7c4e-4a85-b3d0-6e8f1c2a5b47",
      "title": "Party tent 6x3m",
      "price_in_cents": "300000.0",
      "quantity": 1.0
    }
  ]
}
```

Whenever Booqable needs a delivery price, at checkout or in the back office, it sends a JSON `POST` to every active carrier's `rates_url`:

- **`distance`**: driving distance from origin to destination, in the shop's `distance_unit` (`metric` for km, `imperial` for miles).
- **`order_amount_in_cents`**: the order total before delivery and discounts, including tax if the shop's prices include it.
- **`origin_address`**, **`destination_address`**: one comma-separated line: address lines, postcode, city, region, country.
- **`origin_coordinates`**, **`destination_coordinates`**: `"lng,lat"`, longitude first.
- **`destination_zipcode`**, **`destination_region`**, **`destination_country`**: the destination's postcode, region and ISO alpha-2 country code.
- **`origin_location_id`**, **`origin_country`**: the location Booqable picked to deliver from, which `distance` is measured from, and its country.
- **`starts_at`**, **`stops_at`**, **`products`**: the rental period and product lines, each line with the product's `id`, `title`, `quantity` and `price_in_cents` (the line total, as a decimal string). Only filled in when rates are fetched through [`GET /api/4/order_delivery_rates`](/v4.html#order-delivery-rates); otherwise `null`, `null` and `[]`.

Every key is always present, with `null` for unknown values. Every `_in_cents` amount, in the request and in your response, is in hundredths of the main currency unit, whatever the currency: ¥3,000 is `300000`.

The request is [signed](#booqable-interop-signed-requests); verify it before you answer. Booqable waits 3 seconds and doesn't retry. If you time out or don't answer with a valid JSON `200`, Booqable skips your carrier. If you don't serve a request, for example because it's outside your coverage, respond with an empty `data` array.

### Responding with rates

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

Each rate's own `identifier` is yours to choose (e.g. `standard-shipping`, `express-shipping`) and is separate from the carrier's `identifier` used at registration. `label` is shown to the customer; if omitted, the rate's `identifier` is used.

Each rate must have an `id`, a `type` of `delivery_rates`, and `attributes` including `carrier_id` (the id Booqable returned when you registered the carrier) and `price_in_cents`. If any rate in the response is invalid, Booqable discards the entire response for your carrier.

### Uninstalling

Uninstalling the app archives all of its carriers, removes their location links, and re-enables pickup at any location left without a carrier.
