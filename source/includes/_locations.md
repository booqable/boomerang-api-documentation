# Locations

A location is a place (like a store) where customers pick up and return orders or a warehouse that only stocks inventory.

## Endpoints
`GET /api/boomerang/locations`

`GET /api/boomerang/locations/{id}`

`POST /api/boomerang/locations`

`PUT /api/boomerang/locations/{id}`

`DELETE /api/boomerang/locations/{id}`

## Fields
Every location has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether location is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the location was archived
`name` | **String** <br>Name of the location
`code` | **String** <br>Code used to identify the location
`location_type` | **String** <br>Determines if the location can be seen in the online webshop. One of `rental`, `internal`
`address_line_1` | **String** <br>First address line
`address_line_2` | **String** <br>Second address line
`zipcode` | **String** <br>Address zipcode
`city` | **String** <br>Address city
`region` | **String** <br>Address region
`country` | **String** <br>Address country
`cluster_ids` | **Array** <br>Clusters this location belongs to
`main_address_attributes` | **Hash** `writeonly`<br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information
`carrier_ids` | **Array** <br>Delivery carriers this location supports
`pickup_enabled` | **Boolean** <br>Whether the location supports pickup
`main_address` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


## Relationships
Locations have the following relationships:

Name | Description
-- | --
`clusters` | **Clusters** `readonly`<br>Associated Clusters
`carriers` | **Carriers** `readonly`<br>Associated Carriers


## Listing locations



> How to fetch locations:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/locations' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e9d5099a-0866-4065-a3c3-20b87aa16b22",
      "type": "locations",
      "attributes": {
        "created_at": "2024-07-08T09:26:42.053606+00:00",
        "updated_at": "2024-07-08T09:26:42.060451+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000043",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "cluster_ids": [],
        "carrier_ids": [],
        "pickup_enabled": true,
        "main_address": {
          "meets_validation_requirements": false,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuisplein 40",
          "address2": "Department II",
          "city": "Leeuwarden",
          "region": "Friesland",
          "zipcode": "8911LJ",
          "country": "Netherlands",
          "country_id": null,
          "province_id": null,
          "latitude": null,
          "longitude": null,
          "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden Friesland\nNetherlands"
        }
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/locations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=main_address,clusters,carriers`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`code` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`main_address` | **Hash** <br>`eq`
`cluster_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`main_address`


`clusters`


`carriers`






## Fetching a location



> How to fetch a single location:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/locations/b5abec37-4e5c-484d-832c-ffed937ae630' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b5abec37-4e5c-484d-832c-ffed937ae630",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-08T09:26:37.896697+00:00",
      "updated_at": "2024-07-08T09:26:37.902892+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000037",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
      "carrier_ids": [],
      "pickup_enabled": true,
      "main_address": {
        "meets_validation_requirements": false,
        "first_name": null,
        "last_name": null,
        "address1": "Blokhuisplein 40",
        "address2": "Department II",
        "city": "Leeuwarden",
        "region": "Friesland",
        "zipcode": "8911LJ",
        "country": "Netherlands",
        "country_id": null,
        "province_id": null,
        "latitude": null,
        "longitude": null,
        "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden Friesland\nNetherlands"
      }
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/locations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=main_address,clusters,carriers`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`main_address`


`clusters`


`carriers`






## Creating a location



> How to create a location and assign it to a cluster:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/locations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "locations",
        "attributes": {
          "name": "Store",
          "code": "STR",
          "location_type": "rental",
          "address_line_1": "Blokhuisplein 40",
          "address_line_2": "Department II",
          "zipcode": "8911LJ",
          "city": "Leeuwarden",
          "region": "Friesland",
          "country": "Netherlands",
          "cluster_ids": [
            "3835b628-23b2-46f8-b570-df6fdbddcb0f"
          ],
          "carrier_ids": [
            "342687ff-be2d-4578-8d8e-6697b7d1cdbe"
          ]
        }
      },
      "include": "clusters,carriers"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b2e37575-711c-443d-ba9b-39d8630bcbb5",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-08T09:26:38.684292+00:00",
      "updated_at": "2024-07-08T09:26:38.701700+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Store",
      "code": "STR",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "3835b628-23b2-46f8-b570-df6fdbddcb0f"
      ],
      "carrier_ids": [
        "342687ff-be2d-4578-8d8e-6697b7d1cdbe"
      ],
      "pickup_enabled": true,
      "main_address": {
        "meets_validation_requirements": false,
        "first_name": null,
        "last_name": null,
        "address1": "Blokhuisplein 40",
        "address2": "Department II",
        "city": "Leeuwarden",
        "region": "Friesland",
        "zipcode": "8911LJ",
        "country": "Netherlands",
        "country_id": null,
        "province_id": null,
        "latitude": null,
        "longitude": null,
        "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden Friesland\nNetherlands"
      }
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "3835b628-23b2-46f8-b570-df6fdbddcb0f"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "342687ff-be2d-4578-8d8e-6697b7d1cdbe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3835b628-23b2-46f8-b570-df6fdbddcb0f",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-08T09:26:38.487750+00:00",
        "updated_at": "2024-07-08T09:26:38.487750+00:00",
        "name": "North",
        "location_ids": [
          "b2e37575-711c-443d-ba9b-39d8630bcbb5"
        ]
      },
      "relationships": {}
    },
    {
      "id": "342687ff-be2d-4578-8d8e-6697b7d1cdbe",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-07-08T09:26:38.600870+00:00",
        "updated_at": "2024-07-08T09:26:38.600870+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "a79c71e4-6671-46e2-b2fa-b361135d7c23",
        "app_subscription_id": "e7fdeaaa-7778-4b97-bc5f-f2f39c3a1e41"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/locations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=main_address,clusters,carriers`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the location
`data[attributes][code]` | **String** <br>Code used to identify the location
`data[attributes][location_type]` | **String** <br>Determines if the location can be seen in the online webshop. One of `rental`, `internal`
`data[attributes][address_line_1]` | **String** <br>First address line
`data[attributes][address_line_2]` | **String** <br>Second address line
`data[attributes][zipcode]` | **String** <br>Address zipcode
`data[attributes][city]` | **String** <br>Address city
`data[attributes][region]` | **String** <br>Address region
`data[attributes][country]` | **String** <br>Address country
`data[attributes][cluster_ids][]` | **Array** <br>Clusters this location belongs to
`data[attributes][main_address_attributes]` | **Hash** <br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information
`data[attributes][carrier_ids][]` | **Array** <br>Delivery carriers this location supports
`data[attributes][pickup_enabled]` | **Boolean** <br>Whether the location supports pickup
`data[attributes][main_address]` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


### Includes

This request accepts the following includes:

`main_address`


`clusters`


`carriers`






## Updating a location

Note that disassociating clusters may result in a shortage error.


> How to update a location and assign it to multiple clusters:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/6cbf3d5d-2b50-4099-bfce-0bd8bbe0cd45' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6cbf3d5d-2b50-4099-bfce-0bd8bbe0cd45",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "780187b4-4964-44ef-95b0-5181a55eb04a",
            "694f6a9e-f880-4f9f-9de0-71ead6771651"
          ],
          "carrier_ids": [
            "96f1570e-ea9f-4589-a76b-858c0cb319ef"
          ]
        }
      },
      "include": "clusters,carriers"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6cbf3d5d-2b50-4099-bfce-0bd8bbe0cd45",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-08T09:26:42.674595+00:00",
      "updated_at": "2024-07-08T09:26:42.960445+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000044",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "780187b4-4964-44ef-95b0-5181a55eb04a",
        "694f6a9e-f880-4f9f-9de0-71ead6771651"
      ],
      "carrier_ids": [
        "96f1570e-ea9f-4589-a76b-858c0cb319ef"
      ],
      "pickup_enabled": true,
      "main_address": {
        "meets_validation_requirements": false,
        "first_name": null,
        "last_name": null,
        "address1": "Blokhuisplein 40",
        "address2": "Department II",
        "city": "Leeuwarden",
        "region": "Friesland",
        "zipcode": "8911LJ",
        "country": "Netherlands",
        "country_id": null,
        "province_id": null,
        "latitude": null,
        "longitude": null,
        "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden Friesland\nNetherlands"
      }
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "780187b4-4964-44ef-95b0-5181a55eb04a"
          },
          {
            "type": "clusters",
            "id": "694f6a9e-f880-4f9f-9de0-71ead6771651"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "96f1570e-ea9f-4589-a76b-858c0cb319ef"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "780187b4-4964-44ef-95b0-5181a55eb04a",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-08T09:26:42.691245+00:00",
        "updated_at": "2024-07-08T09:26:42.691245+00:00",
        "name": "North",
        "location_ids": [
          "6cbf3d5d-2b50-4099-bfce-0bd8bbe0cd45"
        ]
      },
      "relationships": {}
    },
    {
      "id": "694f6a9e-f880-4f9f-9de0-71ead6771651",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-08T09:26:42.702137+00:00",
        "updated_at": "2024-07-08T09:26:42.702137+00:00",
        "name": "Central",
        "location_ids": [
          "6cbf3d5d-2b50-4099-bfce-0bd8bbe0cd45"
        ]
      },
      "relationships": {}
    },
    {
      "id": "96f1570e-ea9f-4589-a76b-858c0cb319ef",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-07-08T09:26:42.793327+00:00",
        "updated_at": "2024-07-08T09:26:42.793327+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "2b1043a8-c02a-429f-a678-99178a31d9d3",
        "app_subscription_id": "304186bf-d261-495d-97cb-d3dd115d725f"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> Disassociating cluster resulting in shortage error:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/6945fe8e-0482-4f0b-af22-f8a6d51087c7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6945fe8e-0482-4f0b-af22-f8a6d51087c7",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": []
        }
      },
      "include": "clusters"
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "shortage",
      "status": "422",
      "title": "Shortage",
      "detail": "This will create shortage for running or future orders",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "shortage",
            "shortage": 2,
            "item_id": "b701633e-9ec2-4a6f-95b6-1753d898c200",
            "mutation": 0,
            "order_ids": [
              "e809a716-2d12-41c3-93b4-61694c4b3438"
            ],
            "location_id": "6945fe8e-0482-4f0b-af22-f8a6d51087c7",
            "available": -2,
            "plannable": -2,
            "stock_count": 0,
            "planned": 2,
            "needed": 2,
            "cluster_available": -2,
            "cluster_plannable": -2,
            "cluster_stock_count": 0,
            "cluster_planned": 2,
            "cluster_needed": 2
          }
        ]
      }
    }
  ]
}
```

### HTTP Request

`PUT /api/boomerang/locations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=main_address,clusters,carriers`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the location
`data[attributes][code]` | **String** <br>Code used to identify the location
`data[attributes][location_type]` | **String** <br>Determines if the location can be seen in the online webshop. One of `rental`, `internal`
`data[attributes][address_line_1]` | **String** <br>First address line
`data[attributes][address_line_2]` | **String** <br>Second address line
`data[attributes][zipcode]` | **String** <br>Address zipcode
`data[attributes][city]` | **String** <br>Address city
`data[attributes][region]` | **String** <br>Address region
`data[attributes][country]` | **String** <br>Address country
`data[attributes][cluster_ids][]` | **Array** <br>Clusters this location belongs to
`data[attributes][main_address_attributes]` | **Hash** <br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information
`data[attributes][carrier_ids][]` | **Array** <br>Delivery carriers this location supports
`data[attributes][pickup_enabled]` | **Boolean** <br>Whether the location supports pickup
`data[attributes][main_address]` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


### Includes

This request accepts the following includes:

`main_address`


`clusters`


`carriers`






## Archiving a location

To archive a location make sure that:

- There is no active stock at the location
- There are no running or future orders for this location
- This is not the last active location


> How to archive a location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/6c5aae0b-19b3-4d33-9ce8-0cd45a363c0a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6c5aae0b-19b3-4d33-9ce8-0cd45a363c0a",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-08T09:26:41.272809+00:00",
      "updated_at": "2024-07-08T09:26:41.333092+00:00",
      "archived": true,
      "archived_at": "2024-07-08T09:26:41.333092+00:00",
      "name": "Warehouse",
      "code": "LOC1000041",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
      "carrier_ids": [],
      "pickup_enabled": true,
      "main_address": {
        "meets_validation_requirements": false,
        "first_name": null,
        "last_name": null,
        "address1": "Blokhuisplein 40",
        "address2": "Department II",
        "city": "Leeuwarden",
        "region": "Friesland",
        "zipcode": "8911LJ",
        "country": "Netherlands",
        "country_id": null,
        "province_id": null,
        "latitude": null,
        "longitude": null,
        "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden Friesland\nNetherlands"
      }
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Failure due to a future order:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/5dd351cc-cc88-4e21-b881-41f7c48bd636' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "location_has_orders",
      "status": "422",
      "title": "Location has orders",
      "detail": "This location has running or future orders",
      "meta": {
        "order_ids": [
          "f26172e0-ff32-4c10-95a4-9d45bc197f94"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/c1666c17-363b-463c-bcaf-88fef6b463d2' \
    --header 'content-type: application/json' \
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "location_has_stock",
      "status": "422",
      "title": "Location has stock",
      "detail": "This location has active stock",
      "meta": {
        "item_ids": [
          "92df131e-e04e-43a9-b93c-c4f658330cbd"
        ]
      }
    }
  ]
}
```

### HTTP Request

`DELETE /api/boomerang/locations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=created_at,updated_at,archived`


### Includes

This request does not accept any includes