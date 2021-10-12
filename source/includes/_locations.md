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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the location
`code` | **String**<br>Code used to identify the location
`location_type` | **String**<br>Determines if the location can be seen in the online webshop. One of `rental`, `internal`
`address_line_1` | **String**<br>First address line
`address_line_2` | **String**<br>Second address line
`zipcode` | **String**<br>Address zipcode
`city` | **String**<br>Address city
`region` | **String**<br>Address region
`country` | **String**<br>Address country
`cluster_ids` | **Array**<br>Clusters this location belongs to
`archived` | **Boolean** `readonly`<br>Whether location is archived


## Relationships
A locations has the following relationships:

Name | Description
- | -
`clusters` | **Clusters** `readonly`<br>Associated Clusters


## Listing locations

> How to fetch locations

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
      "id": "6af73b3f-9078-4e15-8bf3-26d36c343668",
      "type": "locations",
      "attributes": {
        "created_at": "2021-10-12T15:27:35+00:00",
        "updated_at": "2021-10-12T15:27:35+00:00",
        "name": "Warehouse",
        "code": "LOC4",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "cluster_ids": [],
        "archived": false
      },
      "relationships": {
        "clusters": {
          "links": {
            "related": "api/boomerang/clusters?filter[location_id]=6af73b3f-9078-4e15-8bf3-26d36c343668"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/locations`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-12T15:27:12Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`code` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`cluster_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`clusters`






## Fetching a location

> How to fetch a single location:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/locations/3ba537de-897f-4a21-83a6-94ba09d94017' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3ba537de-897f-4a21-83a6-94ba09d94017",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-12T15:27:36+00:00",
      "updated_at": "2021-10-12T15:27:36+00:00",
      "name": "Warehouse",
      "code": "LOC5",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "links": {
          "related": "api/boomerang/clusters?filter[location_id]=3ba537de-897f-4a21-83a6-94ba09d94017"
        }
      }
    }
  },
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/locations/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`clusters`






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
            "6ed4eb03-9f48-4d25-83dd-796f59978d19"
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
    "id": "42bf5955-e053-431c-952d-ad2c542665b9",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-12T15:27:36+00:00",
      "updated_at": "2021-10-12T15:27:36+00:00",
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
        "6ed4eb03-9f48-4d25-83dd-796f59978d19"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "6ed4eb03-9f48-4d25-83dd-796f59978d19"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6ed4eb03-9f48-4d25-83dd-796f59978d19",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-12T15:27:36+00:00",
        "updated_at": "2021-10-12T15:27:36+00:00",
        "name": "North",
        "location_ids": [
          "42bf5955-e053-431c-952d-ad2c542665b9"
        ]
      },
      "relationships": {
        "locations": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`POST /api/boomerang/locations`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the location
`data[attributes][code]` | **String**<br>Code used to identify the location
`data[attributes][location_type]` | **String**<br>Determines if the location can be seen in the online webshop. One of `rental`, `internal`
`data[attributes][address_line_1]` | **String**<br>First address line
`data[attributes][address_line_2]` | **String**<br>Second address line
`data[attributes][zipcode]` | **String**<br>Address zipcode
`data[attributes][city]` | **String**<br>Address city
`data[attributes][region]` | **String**<br>Address region
`data[attributes][country]` | **String**<br>Address country
`data[attributes][cluster_ids][]` | **Array**<br>Clusters this location belongs to


### Includes

This request accepts the following includes:

`clusters`






## Updating a location

> How to update a location and assign it to multiple clusters:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/713159c3-f339-473f-a354-b19c7c6f2d15' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "713159c3-f339-473f-a354-b19c7c6f2d15",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "ba0a2c8f-1e17-4b1a-91a9-265b0723bd1a",
            "60308aff-1b55-498b-8f78-5901ed39be0f"
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
    "id": "713159c3-f339-473f-a354-b19c7c6f2d15",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-12T15:27:36+00:00",
      "updated_at": "2021-10-12T15:27:36+00:00",
      "name": "Old warehouse",
      "code": "LOC7",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "ba0a2c8f-1e17-4b1a-91a9-265b0723bd1a",
        "60308aff-1b55-498b-8f78-5901ed39be0f"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "ba0a2c8f-1e17-4b1a-91a9-265b0723bd1a"
          },
          {
            "type": "clusters",
            "id": "60308aff-1b55-498b-8f78-5901ed39be0f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ba0a2c8f-1e17-4b1a-91a9-265b0723bd1a",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-12T15:27:36+00:00",
        "updated_at": "2021-10-12T15:27:36+00:00",
        "name": "North",
        "location_ids": [
          "713159c3-f339-473f-a354-b19c7c6f2d15"
        ]
      },
      "relationships": {
        "locations": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "60308aff-1b55-498b-8f78-5901ed39be0f",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-12T15:27:36+00:00",
        "updated_at": "2021-10-12T15:27:36+00:00",
        "name": "Central",
        "location_ids": [
          "713159c3-f339-473f-a354-b19c7c6f2d15"
        ]
      },
      "relationships": {
        "locations": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> Disassociating cluster resulting in shortage error:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/e4c7432f-e4a5-4f2e-8a72-a1056d27b1d1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e4c7432f-e4a5-4f2e-8a72-a1056d27b1d1",
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
            "item_id": "1b641dcd-83df-4b92-b1ee-ecad1beee859",
            "mutation": 0,
            "location_id": "e4c7432f-e4a5-4f2e-8a72-a1056d27b1d1",
            "from": "2031-10-12T15:15:00.000Z",
            "till": "2031-10-15T15:15:00.000Z",
            "company_id": "211b6656-8117-4713-a257-e3184d2d274e",
            "order_ids": [
              "222ad526-65c4-4d7d-ad2b-0915abc5eda4"
            ],
            "planning_ids": [
              "9280d4af-4385-4e41-b71d-29c6712599c0"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "222ad526-65c4-4d7d-ad2b-0915abc5eda4"
            ],
            "cluster_planning_ids": [
              "9280d4af-4385-4e41-b71d-29c6712599c0"
            ],
            "cluster_planned": 2,
            "cluster_needed": 2,
            "cluster_stock_count": 0,
            "cluster_available": -2
          }
        ]
      }
    }
  ]
}
```

Note that disassociating clusters may result in a shortage error.

### HTTP Request

`PUT /api/boomerang/locations/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the location
`data[attributes][code]` | **String**<br>Code used to identify the location
`data[attributes][location_type]` | **String**<br>Determines if the location can be seen in the online webshop. One of `rental`, `internal`
`data[attributes][address_line_1]` | **String**<br>First address line
`data[attributes][address_line_2]` | **String**<br>Second address line
`data[attributes][zipcode]` | **String**<br>Address zipcode
`data[attributes][city]` | **String**<br>Address city
`data[attributes][region]` | **String**<br>Address region
`data[attributes][country]` | **String**<br>Address country
`data[attributes][cluster_ids][]` | **Array**<br>Clusters this location belongs to


### Includes

This request accepts the following includes:

`clusters`






## Archiving a location

> How to archive a location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/81d3d3d9-0969-4fe0-9cf1-87c12aa570be' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


> Failure due to a future order:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/b37c9042-f2e7-4860-bbab-a968dfdfb287' \
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
          "e6ef11d3-c054-4b85-8586-3d3bae9dfaee"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/cb67bf3b-e20f-457a-ad9a-1c560ac5f5b2' \
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
          "36a7f041-62df-48ce-b9fe-cbbeb3fdc663"
        ]
      }
    }
  ]
}
```

To archive a location make sure that:

- There is no active stock at the location
- There are no running or future orders for this location

### HTTP Request

`DELETE /api/boomerang/locations/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Includes

This request does not accept any includes