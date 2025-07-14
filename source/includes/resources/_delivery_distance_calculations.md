# Delivery distance calculations

It calculates the distance (the route length) between the given locations and the delivery address.

## Fields

 Name | Description
-- | --
`distance` | **float** `readonly`<br>The distance between the location and the delivery address. 
`distance_unit` | **enum** `readonly`<br>The unit of the distance.<br> One of: `metric`, `imperial`.
`id` | **uuid** `readonly`<br>Primary key.
`location_id` | **uuid** `readonly`<br>The location ID. 


## Calculate delivery distances


> How to fetch a list of delivery distance calculations:

```shell
  curl --get 'https://example.booqable.com/api/4/delivery_distance_calculations'
       --header 'content-type: application/json'
       --data-urlencode 'filter[delivery_address_property_id]=2e70e73b-04ee-4e00-835e-13ad1d52e6fc'
       --data-urlencode 'filter[location_ids][]=df2395bd-72f3-4078-8c07-4c1f636a1a03'
       --data-urlencode 'filter[location_ids][]=acea1410-5c2a-412d-8910-e48a9224a44d'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f8d4975d-f633-4703-8e3d-8c7c36951675",
        "type": "delivery_distance_calculations",
        "attributes": {
          "distance": 10.0,
          "distance_unit": "km",
          "location_id": "df2395bd-72f3-4078-8c07-4c1f636a1a03"
        }
      },
      {
        "id": "8dc19268-75fd-4a1c-88e5-4a0bf08fb148",
        "type": "delivery_distance_calculations",
        "attributes": {
          "distance": 20.0,
          "distance_unit": "km",
          "location_id": "acea1410-5c2a-412d-8910-e48a9224a44d"
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/delivery_distance_calculations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[delivery_distance_calculations]=distance,distance_unit,location_id`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`delivery_address_property_id` | **uuid** <br>`eq`
`location_ids` | **array** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes