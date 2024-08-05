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
      "id": "04fb11d4-bdda-46a3-8923-eca6718f7da4",
      "type": "locations",
      "attributes": {
        "created_at": "2024-08-05T09:23:32.984342+00:00",
        "updated_at": "2024-08-05T09:23:32.991483+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000007",
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
    --url 'https://example.booqable.com/api/boomerang/locations/dca19c85-f61f-41f3-a050-ae22be4177af' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dca19c85-f61f-41f3-a050-ae22be4177af",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-05T09:23:33.712795+00:00",
      "updated_at": "2024-08-05T09:23:33.716573+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000008",
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
            "ffa03acd-299d-47f1-8e6a-cf4c4fc029d9"
          ],
          "carrier_ids": [
            "4b687d24-796f-4130-9b0c-1db04634e921"
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
    "id": "1c0533f1-12e6-40d8-99b9-1f123a39ccfe",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-05T09:23:34.610960+00:00",
      "updated_at": "2024-08-05T09:23:34.622995+00:00",
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
        "ffa03acd-299d-47f1-8e6a-cf4c4fc029d9"
      ],
      "carrier_ids": [
        "4b687d24-796f-4130-9b0c-1db04634e921"
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
            "id": "ffa03acd-299d-47f1-8e6a-cf4c4fc029d9"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "4b687d24-796f-4130-9b0c-1db04634e921"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ffa03acd-299d-47f1-8e6a-cf4c4fc029d9",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-08-05T09:23:34.387472+00:00",
        "updated_at": "2024-08-05T09:23:34.387472+00:00",
        "name": "North",
        "location_ids": [
          "1c0533f1-12e6-40d8-99b9-1f123a39ccfe"
        ]
      },
      "relationships": {}
    },
    {
      "id": "4b687d24-796f-4130-9b0c-1db04634e921",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-08-05T09:23:34.508478+00:00",
        "updated_at": "2024-08-05T09:23:34.508478+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "367be396-f1b7-4184-b113-7536970a3dce",
        "app_subscription_id": "fc839b63-5143-44cc-adbc-7cc56bf22f07"
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
    --url 'https://example.booqable.com/api/boomerang/locations/f157d151-f161-4d63-9772-fa08436c78ad' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f157d151-f161-4d63-9772-fa08436c78ad",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "80362842-8797-4fa1-b751-368c5fd42abf",
            "2154d148-5a27-453b-ba4b-10867143c442"
          ],
          "carrier_ids": [
            "28d9466b-5c8d-4b30-b1e7-d2089bbd75ff"
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
    "id": "f157d151-f161-4d63-9772-fa08436c78ad",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-05T09:23:38.213153+00:00",
      "updated_at": "2024-08-05T09:23:38.391726+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000012",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "80362842-8797-4fa1-b751-368c5fd42abf",
        "2154d148-5a27-453b-ba4b-10867143c442"
      ],
      "carrier_ids": [
        "28d9466b-5c8d-4b30-b1e7-d2089bbd75ff"
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
            "id": "80362842-8797-4fa1-b751-368c5fd42abf"
          },
          {
            "type": "clusters",
            "id": "2154d148-5a27-453b-ba4b-10867143c442"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "28d9466b-5c8d-4b30-b1e7-d2089bbd75ff"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "80362842-8797-4fa1-b751-368c5fd42abf",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-08-05T09:23:38.222934+00:00",
        "updated_at": "2024-08-05T09:23:38.222934+00:00",
        "name": "North",
        "location_ids": [
          "f157d151-f161-4d63-9772-fa08436c78ad"
        ]
      },
      "relationships": {}
    },
    {
      "id": "2154d148-5a27-453b-ba4b-10867143c442",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-08-05T09:23:38.228491+00:00",
        "updated_at": "2024-08-05T09:23:38.228491+00:00",
        "name": "Central",
        "location_ids": [
          "f157d151-f161-4d63-9772-fa08436c78ad"
        ]
      },
      "relationships": {}
    },
    {
      "id": "28d9466b-5c8d-4b30-b1e7-d2089bbd75ff",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-08-05T09:23:38.305507+00:00",
        "updated_at": "2024-08-05T09:23:38.305507+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "b0c15c95-cd11-4c21-9598-de4b6d1be76d",
        "app_subscription_id": "512a6ad7-bfd9-4913-8a28-8414fe84f23a"
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
    --url 'https://example.booqable.com/api/boomerang/locations/a95c1ee4-83f3-4d16-81f9-d0bda84412e0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a95c1ee4-83f3-4d16-81f9-d0bda84412e0",
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
            "item_id": "587650c8-d8bd-4240-b3b8-518afef517f9",
            "mutation": 0,
            "order_ids": [
              "45dd2ed7-919c-496f-a4f7-dda20464ee90"
            ],
            "location_id": "a95c1ee4-83f3-4d16-81f9-d0bda84412e0",
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
    --url 'https://example.booqable.com/api/boomerang/locations/e934250b-ffb2-443c-bd19-fcde2acd6777' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e934250b-ffb2-443c-bd19-fcde2acd6777",
    "type": "locations",
    "attributes": {
      "created_at": "2024-08-05T09:23:39.196456+00:00",
      "updated_at": "2024-08-05T09:23:39.233288+00:00",
      "archived": true,
      "archived_at": "2024-08-05T09:23:39.233288+00:00",
      "name": "Warehouse",
      "code": "LOC1000013",
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
    --url 'https://example.booqable.com/api/boomerang/locations/8fcac7e3-5e07-4f74-9e9c-b028be97f192' \
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
          "ea7c35a1-3523-4cc8-a544-c24f1bf88184"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/35aeefb3-ed07-4274-a4ee-6eb38ad0db6c' \
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
          "89db298c-75a8-4c5e-a18a-75f0d4c336dc"
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