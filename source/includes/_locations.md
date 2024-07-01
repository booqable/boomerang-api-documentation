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
`main_address` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


## Relationships
Locations have the following relationships:

Name | Description
-- | --
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
      "id": "80c0a5e1-1d6d-4964-8770-1d6b8d188fa6",
      "type": "locations",
      "attributes": {
        "created_at": "2024-07-01T09:31:01.600677+00:00",
        "updated_at": "2024-07-01T09:31:01.608863+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000091",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "cluster_ids": [],
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
`include` | **String** <br>List of comma seperated relationships `?include=clusters`
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

`clusters`






## Fetching a location



> How to fetch a single location:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/locations/6b76f603-6b14-4ccb-96b9-cd556c97d125' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b76f603-6b14-4ccb-96b9-cd556c97d125",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-01T09:31:03.192096+00:00",
      "updated_at": "2024-07-01T09:31:03.199792+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC1000093",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
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
`include` | **String** <br>List of comma seperated relationships `?include=clusters,main_address`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`clusters`


`main_address`






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
            "f280e726-bcdb-4916-8594-f54d21bf3c44"
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
    "id": "ed67da95-c91a-491d-9eb3-3007c492d9c7",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-01T09:31:02.511554+00:00",
      "updated_at": "2024-07-01T09:31:02.528335+00:00",
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
        "f280e726-bcdb-4916-8594-f54d21bf3c44"
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
            "id": "f280e726-bcdb-4916-8594-f54d21bf3c44"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f280e726-bcdb-4916-8594-f54d21bf3c44",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-01T09:31:02.405062+00:00",
        "updated_at": "2024-07-01T09:31:02.405062+00:00",
        "name": "North",
        "location_ids": [
          "ed67da95-c91a-491d-9eb3-3007c492d9c7"
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
`include` | **String** <br>List of comma seperated relationships `?include=clusters,main_address`
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
`data[attributes][main_address]` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


### Includes

This request accepts the following includes:

`clusters`


`main_address`






## Updating a location

Note that disassociating clusters may result in a shortage error.


> How to update a location and assign it to multiple clusters:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/23db05f4-d879-493e-b76f-16baac7bb4df' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "23db05f4-d879-493e-b76f-16baac7bb4df",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "cd547511-f5bb-4607-9c8a-294f1e088fd8",
            "22af6a6f-c5ff-4247-9874-00385db46d08"
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
    "id": "23db05f4-d879-493e-b76f-16baac7bb4df",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-01T09:31:07.097373+00:00",
      "updated_at": "2024-07-01T09:31:07.190459+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC1000096",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "cd547511-f5bb-4607-9c8a-294f1e088fd8",
        "22af6a6f-c5ff-4247-9874-00385db46d08"
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
            "id": "cd547511-f5bb-4607-9c8a-294f1e088fd8"
          },
          {
            "type": "clusters",
            "id": "22af6a6f-c5ff-4247-9874-00385db46d08"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cd547511-f5bb-4607-9c8a-294f1e088fd8",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-01T09:31:07.113020+00:00",
        "updated_at": "2024-07-01T09:31:07.113020+00:00",
        "name": "North",
        "location_ids": [
          "23db05f4-d879-493e-b76f-16baac7bb4df"
        ]
      },
      "relationships": {}
    },
    {
      "id": "22af6a6f-c5ff-4247-9874-00385db46d08",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-07-01T09:31:07.121535+00:00",
        "updated_at": "2024-07-01T09:31:07.121535+00:00",
        "name": "Central",
        "location_ids": [
          "23db05f4-d879-493e-b76f-16baac7bb4df"
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
    --url 'https://example.booqable.com/api/boomerang/locations/fa317ffb-2686-4cba-931d-d66900ddbe83' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fa317ffb-2686-4cba-931d-d66900ddbe83",
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
            "item_id": "592db326-11e6-46da-9901-7c5a6edad484",
            "mutation": 0,
            "order_ids": [
              "98cdd1ef-51f2-4923-bbc3-f95e3beb0b7e"
            ],
            "location_id": "fa317ffb-2686-4cba-931d-d66900ddbe83",
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
`include` | **String** <br>List of comma seperated relationships `?include=clusters,main_address`
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
`data[attributes][main_address]` | **Hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information


### Includes

This request accepts the following includes:

`clusters`


`main_address`






## Archiving a location

To archive a location make sure that:

- There is no active stock at the location
- There are no running or future orders for this location
- This is not the last active location


> How to archive a location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/fbda3196-cc4b-4f3f-85ce-c012e4f73a0a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fbda3196-cc4b-4f3f-85ce-c012e4f73a0a",
    "type": "locations",
    "attributes": {
      "created_at": "2024-07-01T09:30:56.993225+00:00",
      "updated_at": "2024-07-01T09:30:57.057399+00:00",
      "archived": true,
      "archived_at": "2024-07-01T09:30:57.057399+00:00",
      "name": "Warehouse",
      "code": "LOC1000087",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
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
    --url 'https://example.booqable.com/api/boomerang/locations/4f415a93-3e06-452e-be9a-64310d998833' \
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
          "5065338e-2b93-491d-a740-7407c75e7ed9"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/944f3711-cbf3-4a82-b66f-2a9d41ebfe99' \
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
          "8e15158c-fe3a-4ae8-97be-c0e891092253"
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