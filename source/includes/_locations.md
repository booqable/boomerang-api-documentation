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
      "id": "bbf14117-42d4-450c-a0ae-0bdf892d104e",
      "type": "locations",
      "attributes": {
        "created_at": "2024-07-15T09:26:20.053505+00:00",
        "updated_at": "2024-07-15T09:26:20.060687+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000060",
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
    --url 'https://example.booqable.com/api/boomerang/locations/6c168ffe-6635-4112-a721-8ce19361f913' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6c168ffe-6635-4112-a721-8ce19361f913",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-15T09:26:19.397656+00:00",
      "updated_at": "2024-07-15T09:26:19.404028+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000059",
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
            "8bfa3bf5-5e14-4027-b9bc-d3c7ecd26f9e"
          ],
          "carrier_ids": [
            "02e621e5-54e9-4fed-b922-40cc9733cedf"
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
    "id": "746b5b4f-1a29-459f-8d05-3089e63bc92f",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-15T09:26:23.492891+00:00",
      "updated_at": "2024-07-15T09:26:23.537888+00:00",
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
        "8bfa3bf5-5e14-4027-b9bc-d3c7ecd26f9e"
      ],
      "carrier_ids": [
        "02e621e5-54e9-4fed-b922-40cc9733cedf"
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
            "id": "8bfa3bf5-5e14-4027-b9bc-d3c7ecd26f9e"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "02e621e5-54e9-4fed-b922-40cc9733cedf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8bfa3bf5-5e14-4027-b9bc-d3c7ecd26f9e",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-15T09:26:23.266684+00:00",
        "updated_at": "2024-07-15T09:26:23.266684+00:00",
        "name": "North",
        "location_ids": [
          "746b5b4f-1a29-459f-8d05-3089e63bc92f"
        ]
      },
      "relationships": {}
    },
    {
      "id": "02e621e5-54e9-4fed-b922-40cc9733cedf",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-07-15T09:26:23.392784+00:00",
        "updated_at": "2024-07-15T09:26:23.392784+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "95178e8d-3641-4963-8a6d-4bb37bebaf77",
        "app_subscription_id": "e0f32c8a-9b6f-401d-87a0-1171dd8e9253"
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
    --url 'https://example.booqable.com/api/boomerang/locations/8df3437c-0edd-4a57-822b-06b54ac48316' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8df3437c-0edd-4a57-822b-06b54ac48316",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "6cb2ae08-c01a-4c30-96cc-d40c3ff48797",
            "7ba6ea9a-6b97-4989-9070-279b848d23e6"
          ],
          "carrier_ids": [
            "63af7c29-7205-442f-87e8-8f8385e9bf46"
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
    "id": "8df3437c-0edd-4a57-822b-06b54ac48316",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-15T09:26:15.017199+00:00",
      "updated_at": "2024-07-15T09:26:15.360057+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000056",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "6cb2ae08-c01a-4c30-96cc-d40c3ff48797",
        "7ba6ea9a-6b97-4989-9070-279b848d23e6"
      ],
      "carrier_ids": [
        "63af7c29-7205-442f-87e8-8f8385e9bf46"
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
            "id": "6cb2ae08-c01a-4c30-96cc-d40c3ff48797"
          },
          {
            "type": "clusters",
            "id": "7ba6ea9a-6b97-4989-9070-279b848d23e6"
          }
        ]
      },
      "carriers": {
        "data": [
          {
            "type": "carriers",
            "id": "63af7c29-7205-442f-87e8-8f8385e9bf46"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6cb2ae08-c01a-4c30-96cc-d40c3ff48797",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-15T09:26:15.044552+00:00",
        "updated_at": "2024-07-15T09:26:15.044552+00:00",
        "name": "North",
        "location_ids": [
          "8df3437c-0edd-4a57-822b-06b54ac48316"
        ]
      },
      "relationships": {}
    },
    {
      "id": "7ba6ea9a-6b97-4989-9070-279b848d23e6",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-15T09:26:15.056184+00:00",
        "updated_at": "2024-07-15T09:26:15.056184+00:00",
        "name": "Central",
        "location_ids": [
          "8df3437c-0edd-4a57-822b-06b54ac48316"
        ]
      },
      "relationships": {}
    },
    {
      "id": "63af7c29-7205-442f-87e8-8f8385e9bf46",
      "type": "carriers",
      "attributes": {
        "created_at": "2024-07-15T09:26:15.207763+00:00",
        "updated_at": "2024-07-15T09:26:15.207763+00:00",
        "identifier": "FedEx",
        "rates_url": "https://www.example.com",
        "tax_category_id": "db42b7de-048e-40ca-8fe5-b685166f0a7b",
        "app_subscription_id": "77a1236d-c7d3-4dff-bd65-bf8c0d1cb2a0"
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
    --url 'https://example.booqable.com/api/boomerang/locations/affc7b03-5bd6-47ed-a4bc-82f1324343f0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "affc7b03-5bd6-47ed-a4bc-82f1324343f0",
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
            "item_id": "9c6637f9-55d1-47cd-9604-f6f03cce7ebc",
            "mutation": 0,
            "order_ids": [
              "86b22b4e-357f-4cc6-8831-ca717a0b3e94"
            ],
            "location_id": "affc7b03-5bd6-47ed-a4bc-82f1324343f0",
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
    --url 'https://example.booqable.com/api/boomerang/locations/34ff7b31-e77b-4dbe-a5bb-d9568e281dd7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "34ff7b31-e77b-4dbe-a5bb-d9568e281dd7",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-15T09:26:21.793586+00:00",
      "updated_at": "2024-07-15T09:26:21.873301+00:00",
      "archived": true,
      "archived_at": "2024-07-15T09:26:21.873301+00:00",
      "name": "Warehouse",
      "code": "LOC1000062",
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
    --url 'https://example.booqable.com/api/boomerang/locations/21a590a2-20ad-49ec-9a6e-7719e1937fa6' \
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
          "9086459a-2e9e-4ea2-888e-25e3efce1864"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/72d29bb7-4ebf-4e2b-a6cf-39b545d71210' \
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
          "33bab0b8-f912-4cdd-a348-5472be3c65ae"
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