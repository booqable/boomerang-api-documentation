## Delivery Carriers

This capability allows your app to add custom delivery carriers to provide shipping rates for orders.

### Configuration

```shell
curl --request POST \
  --url 'https://example.booqable.com/api/4/app_carriers' \
  --header 'content-type: application/json' \
  --data '{
    "data": {
      "type": "app_carriers",
      "attributes": {
        "identifier": "my_delivery_service",
        "rates_url": "https://my-app.com/api/v1/rates"
      }
    }
  }'
```

When a user installs your delivery carrier app, you must create a delivery carrier record using Booqable's [Carriers API endpoint](/v4.html#app-carriers). The carrier requires:

* `identifier` - A unique identifier for your carrier.
* `rates_url` - The URL where Booqable will send rate calculation requests.
* `app_subscription_id` - The ID of the app subscription (provided during installation).

#### App installation flow

1. **User installs app** - User selects your app from the Booqable App Store.
2. **App subscription created** - Booqable creates an app subscription and sends webhook notification.
3. **Carrier configuration** - Your app receives the `app.installed` webhook and creates the carrier.
4. **Carrier ready** - The delivery carrier is now available for users to select in orders.

```json
{
  "event": "app.installed",
  "data": {
    "id": "a2a94184-00f3-424f-bc36-c46a84eb1461",
    "identifier": "my_delivery_app",
    "app_subscription_id": "18ad296f-16af-4172-a3de-44bd1218543f"
  }
}
```

Listen for the `app.installed` webhook to automatically configure your carrier. Use the `app_subscription_id` from the webhook to create your carrier record.

### How it works

Delivery carriers must provide a `rates_url`. When a user selects a rate in the order screen or during checkout we issue a `POST` request to this URL with several query parameters that can be used to calculate the shipping rate. They are:

* `distance` - The distance between the origin and destination in the unit specified by `distance_unit`.
* `distance_unit` - The unit of the distance. One of `metric` or `imperial`.
* `order_amount_in_cents` - The total order amount in cents.
* `origin_address` - The order origin address in the format `address_line_1,address_line_2,zipcode,city,region,country_name`.
* `origin_coordinates` - The order origin coordinates in the format `longitude,latitude`.
* `destination_address` - The order destination address in the same format as `origin_address`.
* `destination_coordinates` - The order destination coordinates in the same format as `origin_coordinates`.
* `starts_at` - The start date and time of the order.
* `stops_at` - The end date and time of the order.
* `products` - An array of products in the order, with the `id`, `title`, `price_in_cents` and `quantity` for each product.
* `token` - A JWT token that can be used to verify the request came from Booqable.

```
POST /api/v1/rates

distance=3.317
distance_unit=metric
order_amount_in_cents=60000
origin_address=Rua de Belem 84,,1300-085,Lisboa,Lisbon,Portugal
origin_coordinates=-9.20301506928,38.697395054265
destination_address=Av. Brasília,,1400-038,Lisboa,Lisbon,Portugal
destination_coordinates=-9.2057249,38.6937838
starts_at=2025-08-15T09:00:00Z
stops_at=2025-08-16T15:00:00Z
products[][id]=1938440d-49c2-499a-83f1-a276927d5d6c
products[][title]=Batavus male bike
products[][price_in_cents]=45000.0
products[][quantity]=1.0
products[][id]=c07d6a9e-1def-4933-bc2a-dfd663c09656
products[][title]=Bike helmet
products[][price_in_cents]=15000.0
products[][quantity]=1.0
token=<JWT token>
```

Your rates endpoint must respond within 3000ms or the request will be considered failed. The endpoint must return a 200 status code with a JSON response containing an array of rates in the following format:

```jsonc
{
  "data": [
    {
      "id": "a6236947-a671-4d16-ae21-8efcc388994f",
      "type": "delivery_rates",
      "attributes": {
        "label": "Standard Rate",
        "description": "My rate description.",
        "type": "flat",
        "range": "50 km",
        "price_in_cents": 1000,
        "minimum_order_amount_in_cents": 0,
        "free_delivery_threshold_in_cents": 0,
        "carrier_id": "eaccc770-dOda-4dla-8201-b596b79a2f97",
        "identifier": "Standard Rate",
      }
    },
    // ... other rates here ...
  ]
}
```

* `id` — Unique identifier for the rate, as an UUID.
* `type` — Fixed constant. Must be the string `"delivery_rates"`.
* `attributes.identifier` — Human readable identifier for the rate.
* `attributes.label` — Additional label for the rate.
* `attributes.description` — Extra context for the rate.
* `attributes.type` — Rate type, either `"flat"` or `"calculated"`.
* `attributes.range` — Delivery range.
* `attributes.price_in_cents` — Delivery cost in cents.
* `attributes.minimum_order_amount_in_cents` — Minimum order value required.
* `attributes.free_delivery_threshold_in_cents` — Threshold for free delivery.
* `attributes.carrier_id` — ID of the delivery carrier.

If any other status code is returned or if the response does not follow the above format the request will be considered failed and no rates will be shown to users.
