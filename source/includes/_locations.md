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
`pickup_enabled` | **Boolean** <br>Whether the location supports pickup
`fulfillment_capabilities` | **Array** `readonly`<br>An array of fulfillment capabilities (available values: `pickup`, `delivery`)
`confirm_has_orders` | **Boolean** `writeonly`<br>A flag to confirm an address update when the location has orders
`main_address` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


## Relationships
Locations have the following relationships:

Name | Description
-- | --
`carriers` | **Carriers** `readonly`<br>Associated Carriers
`clusters` | **Clusters** `readonly`<br>Associated Clusters


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
      "id": "864a9155-e0a2-4c44-9c4a-0d86cb0cb0a8",
      "type": "locations",
      "attributes": {
        "created_at": "2024-10-21T09:24:53.571578+00:00",
        "updated_at": "2024-10-21T09:24:53.575424+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000052",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "cluster_ids": [],
        "pickup_enabled": true,
        "fulfillment_capabilities": [
          "pickup"
        ],
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
    --url 'https://example.booqable.com/api/boomerang/locations/210564c4-1f51-4aca-97be-63fe682b62d1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "210564c4-1f51-4aca-97be-63fe682b62d1",
    "type": "locations",
    "attributes": {
      "created_at": "2024-10-21T09:24:54.240694+00:00",
      "updated_at": "2024-10-21T09:24:54.245022+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000053",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
      "pickup_enabled": true,
      "fulfillment_capabilities": [
        "pickup"
      ],
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
            "adb8d42c-e23f-4242-ae00-34881a54e7b3"
          ]
        }
      },
      "include": "clusters"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c0aa508a-219b-4e4e-8e26-d39d79062594",
    "type": "locations",
    "attributes": {
      "created_at": "2024-10-21T09:24:49.453883+00:00",
      "updated_at": "2024-10-21T09:24:49.463796+00:00",
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
        "adb8d42c-e23f-4242-ae00-34881a54e7b3"
      ],
      "pickup_enabled": true,
      "fulfillment_capabilities": [
        "pickup"
      ],
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
            "id": "adb8d42c-e23f-4242-ae00-34881a54e7b3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "adb8d42c-e23f-4242-ae00-34881a54e7b3",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-10-21T09:24:49.392228+00:00",
        "updated_at": "2024-10-21T09:24:49.392228+00:00",
        "name": "North",
        "location_ids": [
          "c0aa508a-219b-4e4e-8e26-d39d79062594"
        ]
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
`data[attributes][pickup_enabled]` | **Boolean** <br>Whether the location supports pickup
`data[attributes][confirm_has_orders]` | **Boolean** <br>A flag to confirm an address update when the location has orders
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
    --url 'https://example.booqable.com/api/boomerang/locations/a25b739c-0446-461a-b920-82535db7eafe' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a25b739c-0446-461a-b920-82535db7eafe",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "a8224098-16aa-4014-afab-8aa3febba92c",
            "5de78d5b-ee8c-4021-a05f-827fa161911b"
          ]
        }
      },
      "include": "clusters"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a25b739c-0446-461a-b920-82535db7eafe",
    "type": "locations",
    "attributes": {
      "created_at": "2024-10-21T09:24:52.884336+00:00",
      "updated_at": "2024-10-21T09:24:52.955153+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000051",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "a8224098-16aa-4014-afab-8aa3febba92c",
        "5de78d5b-ee8c-4021-a05f-827fa161911b"
      ],
      "pickup_enabled": true,
      "fulfillment_capabilities": [
        "pickup"
      ],
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
            "id": "a8224098-16aa-4014-afab-8aa3febba92c"
          },
          {
            "type": "clusters",
            "id": "5de78d5b-ee8c-4021-a05f-827fa161911b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a8224098-16aa-4014-afab-8aa3febba92c",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-10-21T09:24:52.894175+00:00",
        "updated_at": "2024-10-21T09:24:52.894175+00:00",
        "name": "North",
        "location_ids": [
          "a25b739c-0446-461a-b920-82535db7eafe"
        ]
      },
      "relationships": {}
    },
    {
      "id": "5de78d5b-ee8c-4021-a05f-827fa161911b",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-10-21T09:24:52.899283+00:00",
        "updated_at": "2024-10-21T09:24:52.899283+00:00",
        "name": "Central",
        "location_ids": [
          "a25b739c-0446-461a-b920-82535db7eafe"
        ]
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
    --url 'https://example.booqable.com/api/boomerang/locations/fde48dc4-6e44-43b6-bb70-060a6b1f0bb7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fde48dc4-6e44-43b6-bb70-060a6b1f0bb7",
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
            "item_id": "567212fc-66c5-4736-8c8c-08264ccb22ba",
            "mutation": 0,
            "order_ids": [
              "f2eb76f1-6f2a-45a7-8218-b72dc7f0c261"
            ],
            "location_id": "fde48dc4-6e44-43b6-bb70-060a6b1f0bb7",
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
`data[attributes][pickup_enabled]` | **Boolean** <br>Whether the location supports pickup
`data[attributes][confirm_has_orders]` | **Boolean** <br>A flag to confirm an address update when the location has orders
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
    --url 'https://example.booqable.com/api/boomerang/locations/291d8fd9-34de-42c1-91ae-07a4152f0f51' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "291d8fd9-34de-42c1-91ae-07a4152f0f51",
    "type": "locations",
    "attributes": {
      "created_at": "2024-10-21T09:24:56.505174+00:00",
      "updated_at": "2024-10-21T09:24:56.556292+00:00",
      "archived": true,
      "archived_at": "2024-10-21T09:24:56.556292+00:00",
      "name": "Warehouse",
      "code": "LOC1000056",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
      "pickup_enabled": true,
      "fulfillment_capabilities": [
        "pickup"
      ],
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
    --url 'https://example.booqable.com/api/boomerang/locations/407d7453-9c88-46e1-927d-72829d3c9053' \
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
          "0d886f93-3801-4ae4-90d1-30f55c59bed9"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/ebd9d3ae-0572-4e45-b1c1-1ac607315883' \
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
          "75cc2e05-57fa-4524-ae3c-056ece1e2f82"
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