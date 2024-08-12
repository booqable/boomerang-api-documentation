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
      "id": "47af356b-a014-435e-9263-4d70ad058c60",
      "type": "locations",
      "attributes": {
        "created_at": "2024-08-12T09:25:57.568991+00:00",
        "updated_at": "2024-08-12T09:25:57.572247+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000030",
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
    --url 'https://example.booqable.com/api/boomerang/locations/0f5858ee-a6af-4754-aff1-b3798b838ef2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0f5858ee-a6af-4754-aff1-b3798b838ef2",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-12T09:25:56.469273+00:00",
      "updated_at": "2024-08-12T09:25:56.473755+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000028",
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
            "b85973b7-d5cd-4094-9dbc-96b4c3f14952"
          ],
          "carrier_ids": [
            "94efd77c-7355-4ed2-b580-2468375d8287"
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
    "id": "c6f0ae40-8415-4dd2-84b9-2fa97ea6a825",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-12T09:25:57.066320+00:00",
      "updated_at": "2024-08-12T09:25:57.075795+00:00",
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
        "b85973b7-d5cd-4094-9dbc-96b4c3f14952"
      ],
      "carrier_ids": [
        "94efd77c-7355-4ed2-b580-2468375d8287"
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
            "id": "b85973b7-d5cd-4094-9dbc-96b4c3f14952"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "94efd77c-7355-4ed2-b580-2468375d8287"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b85973b7-d5cd-4094-9dbc-96b4c3f14952",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-08-12T09:25:56.979805+00:00",
        "updated_at": "2024-08-12T09:25:56.979805+00:00",
        "name": "North",
        "location_ids": [
          "c6f0ae40-8415-4dd2-84b9-2fa97ea6a825"
        ]
      },
      "relationships": {}
    },
    {
      "id": "94efd77c-7355-4ed2-b580-2468375d8287",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-08-12T09:25:57.025443+00:00",
        "updated_at": "2024-08-12T09:25:57.025443+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "cd605466-1578-4f15-97f5-1056831c86c4",
        "app_subscription_id": "9823afbf-bbea-4fc4-8701-ce687cf94f9c"
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
    --url 'https://example.booqable.com/api/boomerang/locations/c63ef2d8-946d-432e-b7da-9b54f2a91558' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c63ef2d8-946d-432e-b7da-9b54f2a91558",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "44a29133-78b3-4f44-b77a-9c5e5ec85100",
            "a2d6fa11-521b-4a33-b66e-b7f0c2a4b4bf"
          ],
          "carrier_ids": [
            "1cb0785e-6d35-4dc1-af99-1b3d87da0274"
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
    "id": "c63ef2d8-946d-432e-b7da-9b54f2a91558",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-12T09:25:51.531747+00:00",
      "updated_at": "2024-08-12T09:25:51.738066+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000021",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "44a29133-78b3-4f44-b77a-9c5e5ec85100",
        "a2d6fa11-521b-4a33-b66e-b7f0c2a4b4bf"
      ],
      "carrier_ids": [
        "1cb0785e-6d35-4dc1-af99-1b3d87da0274"
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
            "id": "44a29133-78b3-4f44-b77a-9c5e5ec85100"
          },
          {
            "type": "clusters",
            "id": "a2d6fa11-521b-4a33-b66e-b7f0c2a4b4bf"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "1cb0785e-6d35-4dc1-af99-1b3d87da0274"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "44a29133-78b3-4f44-b77a-9c5e5ec85100",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-08-12T09:25:51.599516+00:00",
        "updated_at": "2024-08-12T09:25:51.599516+00:00",
        "name": "North",
        "location_ids": [
          "c63ef2d8-946d-432e-b7da-9b54f2a91558"
        ]
      },
      "relationships": {}
    },
    {
      "id": "a2d6fa11-521b-4a33-b66e-b7f0c2a4b4bf",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-08-12T09:25:51.605224+00:00",
        "updated_at": "2024-08-12T09:25:51.605224+00:00",
        "name": "Central",
        "location_ids": [
          "c63ef2d8-946d-432e-b7da-9b54f2a91558"
        ]
      },
      "relationships": {}
    },
    {
      "id": "1cb0785e-6d35-4dc1-af99-1b3d87da0274",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-08-12T09:25:51.679873+00:00",
        "updated_at": "2024-08-12T09:25:51.679873+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "bbfc084f-7c77-4270-b930-1821160da45d",
        "app_subscription_id": "f50e0e8a-0060-4eb3-ba16-214d166d6ad0"
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
    --url 'https://example.booqable.com/api/boomerang/locations/0db4e40f-69b5-41e2-afb6-c871e73a79ad' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0db4e40f-69b5-41e2-afb6-c871e73a79ad",
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
            "item_id": "406515d0-daa0-4f46-845f-5fb0d6cbff25",
            "mutation": 0,
            "order_ids": [
              "3a8aef10-94da-48eb-8b20-616df6ada31d"
            ],
            "location_id": "0db4e40f-69b5-41e2-afb6-c871e73a79ad",
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
    --url 'https://example.booqable.com/api/boomerang/locations/045856ae-2f8a-4314-9921-aa007b807a3d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "045856ae-2f8a-4314-9921-aa007b807a3d",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-12T09:25:55.952404+00:00",
      "updated_at": "2024-08-12T09:25:55.983338+00:00",
      "archived": true,
      "archived_at": "2024-08-12T09:25:55.983338+00:00",
      "name": "Warehouse",
      "code": "LOC1000026",
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
    --url 'https://example.booqable.com/api/boomerang/locations/97cbe88f-b76e-4599-ae9a-9a0dff302c49' \
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
          "9e766a38-2c02-4b14-8c6e-d89f84392509"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/8a44d8fc-9f8e-414c-b1e1-4e27ffd037ac' \
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
          "ef1e9254-3049-451e-bb0d-317e113de593"
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