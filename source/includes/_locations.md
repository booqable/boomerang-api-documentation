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
      "id": "5974732f-2a1d-4ec7-96af-f13af6fc5732",
      "type": "locations",
      "attributes": {
        "created_at": "2024-07-22T09:23:07.384664+00:00",
        "updated_at": "2024-07-22T09:23:07.390889+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000009",
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
    --url 'https://example.booqable.com/api/boomerang/locations/09219fa3-b094-4d6e-9eb0-2a8a6279a488' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "09219fa3-b094-4d6e-9eb0-2a8a6279a488",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-22T09:22:53.712075+00:00",
      "updated_at": "2024-07-22T09:22:53.907016+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000000",
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
            "f6872829-e4ac-4164-8c38-707169299cda"
          ],
          "carrier_ids": [
            "a7c25780-ccd2-414b-b999-86df7560b92f"
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
    "id": "ce9def44-9ab2-490e-9c09-9c7a94cf1351",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-22T09:22:56.687591+00:00",
      "updated_at": "2024-07-22T09:22:56.722027+00:00",
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
        "f6872829-e4ac-4164-8c38-707169299cda"
      ],
      "carrier_ids": [
        "a7c25780-ccd2-414b-b999-86df7560b92f"
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
            "id": "f6872829-e4ac-4164-8c38-707169299cda"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "a7c25780-ccd2-414b-b999-86df7560b92f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f6872829-e4ac-4164-8c38-707169299cda",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-22T09:22:56.182595+00:00",
        "updated_at": "2024-07-22T09:22:56.182595+00:00",
        "name": "North",
        "location_ids": [
          "ce9def44-9ab2-490e-9c09-9c7a94cf1351"
        ]
      },
      "relationships": {}
    },
    {
      "id": "a7c25780-ccd2-414b-b999-86df7560b92f",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-07-22T09:22:56.380109+00:00",
        "updated_at": "2024-07-22T09:22:56.380109+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "6a787f91-9885-48d0-9c9c-de473867aafb",
        "app_subscription_id": "c7f0c723-1de2-4ec7-b2dc-051583bd8312"
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
    --url 'https://example.booqable.com/api/boomerang/locations/f3639081-de17-467e-aafc-c6e00693e8c8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3639081-de17-467e-aafc-c6e00693e8c8",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "fb54ce98-aa8b-4e4d-97a0-cf9ac016e59d",
            "c93ba77a-bbbc-42fa-9667-07926267ab97"
          ],
          "carrier_ids": [
            "07aeb0ae-8e2b-467f-883b-cb86390e0f68"
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
    "id": "f3639081-de17-467e-aafc-c6e00693e8c8",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-22T09:23:01.287738+00:00",
      "updated_at": "2024-07-22T09:23:01.580995+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000006",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "fb54ce98-aa8b-4e4d-97a0-cf9ac016e59d",
        "c93ba77a-bbbc-42fa-9667-07926267ab97"
      ],
      "carrier_ids": [
        "07aeb0ae-8e2b-467f-883b-cb86390e0f68"
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
            "id": "fb54ce98-aa8b-4e4d-97a0-cf9ac016e59d"
          },
          {
            "type": "clusters",
            "id": "c93ba77a-bbbc-42fa-9667-07926267ab97"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "07aeb0ae-8e2b-467f-883b-cb86390e0f68"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb54ce98-aa8b-4e4d-97a0-cf9ac016e59d",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-22T09:23:01.306309+00:00",
        "updated_at": "2024-07-22T09:23:01.306309+00:00",
        "name": "North",
        "location_ids": [
          "f3639081-de17-467e-aafc-c6e00693e8c8"
        ]
      },
      "relationships": {}
    },
    {
      "id": "c93ba77a-bbbc-42fa-9667-07926267ab97",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-22T09:23:01.315125+00:00",
        "updated_at": "2024-07-22T09:23:01.315125+00:00",
        "name": "Central",
        "location_ids": [
          "f3639081-de17-467e-aafc-c6e00693e8c8"
        ]
      },
      "relationships": {}
    },
    {
      "id": "07aeb0ae-8e2b-467f-883b-cb86390e0f68",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-07-22T09:23:01.407291+00:00",
        "updated_at": "2024-07-22T09:23:01.407291+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "ddd30e79-5e58-46c1-9bd1-65a60729ef83",
        "app_subscription_id": "ede87abb-1929-4b70-aa4d-6884d1d98de0"
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
    --url 'https://example.booqable.com/api/boomerang/locations/50dde5c1-3d89-4b77-80d6-193168f9c50f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "50dde5c1-3d89-4b77-80d6-193168f9c50f",
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
            "item_id": "26462dbd-45b0-45a8-a72b-ddda147171b1",
            "mutation": 0,
            "order_ids": [
              "c32ece59-1bc2-4887-acde-b35fc611e3b9"
            ],
            "location_id": "50dde5c1-3d89-4b77-80d6-193168f9c50f",
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
    --url 'https://example.booqable.com/api/boomerang/locations/16a5504e-182c-40c7-9cc5-a888d0583c2d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "16a5504e-182c-40c7-9cc5-a888d0583c2d",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-22T09:22:58.866548+00:00",
      "updated_at": "2024-07-22T09:22:58.949018+00:00",
      "archived": true,
      "archived_at": "2024-07-22T09:22:58.949018+00:00",
      "name": "Warehouse",
      "code": "LOC1000003",
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
    --url 'https://example.booqable.com/api/boomerang/locations/3cfd33a7-ee98-4c0e-84c0-16ac86a4f940' \
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
          "295e21ad-9a16-4687-bf47-827dde081e3c"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/5d58c101-d6f7-48a0-9147-005a9740105c' \
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
          "71d9b3eb-65c1-47f5-afc4-36e980a15e43"
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