# Delivery distance calculations

It calculates the distance (the route length) between the given locations and the delivery address.

## Fields
Every delivery distance calculation has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`distance` | **Float** `readonly`<br>The distance between the location and the delivery address
`distance_unit` | **String** `readonly`<br>The unit of the distance
`location_id` | **Uuid** `readonly`<br>The location ID


## Calculating delivery distances



> How to fetch a list of delivery distance calculations:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/delivery_distance_calculations?filter%5Bdelivery_address_property_id%5D=ffc7b000-7c91-40b4-8931-d94cbc797e14&filter%5Blocation_ids%5D%5B%5D=cbf9195e-b6d3-4566-9642-948b67912700&filter%5Blocation_ids%5D%5B%5D=5f67ab9c-4d37-4121-bb57-c21de627b22e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "220a26ae-4e85-425d-8c38-41c8c249b16d",
      "type": "delivery_distance_calculations",
      "attributes": {
        "distance": 10.0,
        "distance_unit": "km",
        "location_id": "cbf9195e-b6d3-4566-9642-948b67912700"
      }
    },
    {
      "id": "a812d200-015b-472f-bcd7-a293b37fc937",
      "type": "delivery_distance_calculations",
      "attributes": {
        "distance": 20.0,
        "distance_unit": "km",
        "location_id": "5f67ab9c-4d37-4121-bb57-c21de627b22e"
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/delivery_distance_calculations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[delivery_distance_calculations]=distance,distance_unit,location_id`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`location_ids` | **Array** <br>`eq`
`delivery_address_property_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes