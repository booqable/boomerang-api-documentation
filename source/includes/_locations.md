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
      "id": "86484dc3-8462-4ee5-b012-44ada6ec1d85",
      "type": "locations",
      "attributes": {
        "created_at": "2021-10-07T08:41:24+00:00",
        "updated_at": "2021-10-07T08:41:24+00:00",
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
            "related": "api/boomerang/clusters?filter[location_id]=86484dc3-8462-4ee5-b012-44ada6ec1d85"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-07T08:41:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/b8f4a438-a01c-440e-af3b-81ba6d3d7de6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b8f4a438-a01c-440e-af3b-81ba6d3d7de6",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-07T08:41:25+00:00",
      "updated_at": "2021-10-07T08:41:25+00:00",
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
          "related": "api/boomerang/clusters?filter[location_id]=b8f4a438-a01c-440e-af3b-81ba6d3d7de6"
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
            "38406161-603e-4a72-bada-fe0d9a663d3b"
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
    "id": "ca82c1a5-cb4b-483e-8987-8bc6a4617cc1",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-07T08:41:25+00:00",
      "updated_at": "2021-10-07T08:41:25+00:00",
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
        "38406161-603e-4a72-bada-fe0d9a663d3b"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "38406161-603e-4a72-bada-fe0d9a663d3b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "38406161-603e-4a72-bada-fe0d9a663d3b",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-07T08:41:25+00:00",
        "updated_at": "2021-10-07T08:41:25+00:00",
        "name": "North",
        "location_ids": [
          "ca82c1a5-cb4b-483e-8987-8bc6a4617cc1"
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
    --url 'https://example.booqable.com/api/boomerang/locations/91262332-a40a-4382-8a6c-ec935786d8fa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "91262332-a40a-4382-8a6c-ec935786d8fa",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "02a3f70c-e4de-44f9-8713-18c7c4663e74",
            "cca3d133-eb25-42e2-82f4-29c88a1c2c70"
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
    "id": "91262332-a40a-4382-8a6c-ec935786d8fa",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-07T08:41:25+00:00",
      "updated_at": "2021-10-07T08:41:25+00:00",
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
        "02a3f70c-e4de-44f9-8713-18c7c4663e74",
        "cca3d133-eb25-42e2-82f4-29c88a1c2c70"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "02a3f70c-e4de-44f9-8713-18c7c4663e74"
          },
          {
            "type": "clusters",
            "id": "cca3d133-eb25-42e2-82f4-29c88a1c2c70"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "02a3f70c-e4de-44f9-8713-18c7c4663e74",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-07T08:41:25+00:00",
        "updated_at": "2021-10-07T08:41:25+00:00",
        "name": "North",
        "location_ids": [
          "91262332-a40a-4382-8a6c-ec935786d8fa"
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
      "id": "cca3d133-eb25-42e2-82f4-29c88a1c2c70",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-07T08:41:25+00:00",
        "updated_at": "2021-10-07T08:41:25+00:00",
        "name": "Central",
        "location_ids": [
          "91262332-a40a-4382-8a6c-ec935786d8fa"
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
    --url 'https://example.booqable.com/api/boomerang/locations/a23c9eca-162c-4255-aaae-b225dd73d2d6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a23c9eca-162c-4255-aaae-b225dd73d2d6",
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
            "item_id": "f5600053-3034-489a-b65a-201fb6085067",
            "mutation": 0,
            "location_id": "a23c9eca-162c-4255-aaae-b225dd73d2d6",
            "from": "2031-10-07T08:30:00.000Z",
            "till": "2031-10-10T08:30:00.000Z",
            "company_id": "3a8fb01a-2e6e-4923-94f1-bdfa137439b8",
            "order_ids": [
              "f0c3dacb-fe5d-477a-8ae8-f5f42b23d1a3"
            ],
            "planning_ids": [
              "9a5d9848-afc7-4ac0-b76e-3284d108cc37"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "f0c3dacb-fe5d-477a-8ae8-f5f42b23d1a3"
            ],
            "cluster_planning_ids": [
              "9a5d9848-afc7-4ac0-b76e-3284d108cc37"
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
    --url 'https://example.booqable.com/api/boomerang/locations/419c0703-888d-4562-9bae-ec17b0a91ddf' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/1c1b38a2-3579-414a-9516-d1ee1a99015b' \
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
          "7a04c524-b05a-4dca-91dd-dbb48e1d27f1"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/8e6c3a53-3444-4a56-b935-0af58f4d5d9f' \
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
          "5fb1d4ec-d0ae-4963-bbb0-f01fd87ad844"
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