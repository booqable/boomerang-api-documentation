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
    --url 'https://example.booqable.com/api/boomerang/delivery_distance_calculations?filter%5Bdelivery_address_property_id%5D=7641345d-2510-489c-9399-f94412bc059b&filter%5Blocation_ids%5D%5B%5D=a461fcb7-d35b-45e1-b2f9-034581cf62cc&filter%5Blocation_ids%5D%5B%5D=f668ac97-bd54-45dd-9d97-d695d0bdfe9f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e39f8fee-22a3-4d35-bad1-d8daf97c94d2",
      "type": "delivery_distance_calculations",
      "attributes": {
        "distance": 10.0,
        "distance_unit": "km",
        "location_id": "a461fcb7-d35b-45e1-b2f9-034581cf62cc"
      }
    },
    {
      "id": "57f5841f-51f1-4645-a47b-87c3c7c08973",
      "type": "delivery_distance_calculations",
      "attributes": {
        "distance": 20.0,
        "distance_unit": "km",
        "location_id": "f668ac97-bd54-45dd-9d97-d695d0bdfe9f"
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