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
        "carrier_id": "c4d9e7a1-6f2b-4e83-9a5c-1b8d3f0e7a26", // id returned when you registered the carrier
        "identifier": "Standard shipping",
        "label": "Standard shipping",
        "description": "Delivered between 9:00 and 17:00",
        "type": "flat",
        "price_in_cents": 2500,
        "range": "10 km",
        "minimum_order_amount_in_cents": null,
        "free_delivery_threshold_in_cents": 500000,
        "errors": []
      }
    },
    {
      "id": "express-shipping",
      "type": "delivery_rates",
      "attributes": {
        "carrier_id": "c4d9e7a1-6f2b-4e83-9a5c-1b8d3f0e7a26",
        "identifier": "Express shipping",
        "label": "Express shipping",
        "description": null,
        "type": "calculated",
        "price_in_cents": 4250,
        "range": "4.82 km",
        "minimum_order_amount_in_cents": 400000,
        "free_delivery_threshold_in_cents": null,
        "errors": ["under_minimum_order_amount"]
      }
    }
  ]
}
```

Respond with `Content-Type: application/json` and a JSON:API list of the rates you offer for this request. Each rate has a string `id`, a `type` of `delivery_rates`, and these `attributes`:

- **`carrier_id`** (required): the id Booqable returned when you registered the carrier.
- **`price_in_cents`** (required): the delivery price.
- **`identifier`** (required), **`label`**: the rate's name. Booqable shows `identifier`; an order placed at checkout is named after `label`. Send the same name in both.
- **`description`**: optional text shown under the name.
- **`type`**: `flat` or `calculated`. For a `flat` rate, Booqable shows `range` as "up to 10 km".
- **`range`**: the distance to show, such as `"10 km"`, or `null` to show none.
- **`minimum_order_amount_in_cents`**: the minimum order for this rate, or `null` when there's none.
- **`free_delivery_threshold_in_cents`**: the order amount from which this rate is free, or `null` when there's none. Return a `price_in_cents` of 0 yourself once `order_amount_in_cents` reaches it: the back office uses your price as is. Checkout shows the threshold to the customer until it's reached.
- **`errors`**: why the rate can't be used for this order. Checkout shows a rate with errors but won't let the customer pick it, and Booqable avoids such rates when it picks one itself. Booqable doesn't check the minimum order: send `under_minimum_order_amount` when the order is below it, and checkout shows the customer the minimum amount.

Keep each rate's `id` the same across requests: Booqable stores it on the order and uses it to find the rate again when the order changes.

If the response isn't a JSON `200`, or any rate lacks an `id`, `attributes` or the `delivery_rates` type, Booqable discards your whole response.

Booqable passes your rates' attributes as they are to the shop's checkout and to API clients, for example through [`GET /api/4/order_delivery_rates`](/v4.html#order-delivery-rates), so don't put anything private in them.

### Uninstalling

Uninstalling the app archives all of its carriers, removes their location links, and re-enables pickup at any location left without a carrier.
