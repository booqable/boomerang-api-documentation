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


## Relationships
Locations have the following relationships:

Name | Description
- | -
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
      "id": "cb6ba967-8bfb-4b06-8526-492ebbc78e64",
      "type": "locations",
      "attributes": {
        "created_at": "2023-02-21T08:20:07+00:00",
        "updated_at": "2023-02-21T08:20:07+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC23",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "cluster_ids": []
      },
      "relationships": {
        "clusters": {
          "links": {
            "related": "api/boomerang/clusters?filter[location_id]=cb6ba967-8bfb-4b06-8526-492ebbc78e64"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T08:18:43Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`code` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`cluster_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`clusters`






## Fetching a location



> How to fetch a single location:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/locations/ef539ed5-dccb-4570-8bea-5a10b6d66234' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ef539ed5-dccb-4570-8bea-5a10b6d66234",
    "type": "locations",
    "attributes": {
      "created_at": "2023-02-21T08:20:07+00:00",
      "updated_at": "2023-02-21T08:20:07+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC24",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": []
    },
    "relationships": {
      "clusters": {
        "links": {
          "related": "api/boomerang/clusters?filter[location_id]=ef539ed5-dccb-4570-8bea-5a10b6d66234"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


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
            "83e5c106-b7d2-4a5b-a16b-b9011567f128"
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
    "id": "dfb2d464-d1fd-4468-9098-3c88b7bcba3c",
    "type": "locations",
    "attributes": {
      "created_at": "2023-02-21T08:20:08+00:00",
      "updated_at": "2023-02-21T08:20:08+00:00",
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
        "83e5c106-b7d2-4a5b-a16b-b9011567f128"
      ]
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "83e5c106-b7d2-4a5b-a16b-b9011567f128"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "83e5c106-b7d2-4a5b-a16b-b9011567f128",
      "type": "clusters",
      "attributes": {
        "created_at": "2023-02-21T08:20:08+00:00",
        "updated_at": "2023-02-21T08:20:08+00:00",
        "name": "North",
        "location_ids": [
          "dfb2d464-d1fd-4468-9098-3c88b7bcba3c"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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


### Includes

This request accepts the following includes:

`clusters`






## Updating a location

Note that disassociating clusters may result in a shortage error.


> How to update a location and assign it to multiple clusters:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/de8c3d72-96c8-4e44-8077-d6d72586941a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "de8c3d72-96c8-4e44-8077-d6d72586941a",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "d9b87002-98ae-4b29-a5cd-0651b6f442e5",
            "b93cbf2e-65d1-4e2b-8576-98894ecdab22"
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
    "id": "de8c3d72-96c8-4e44-8077-d6d72586941a",
    "type": "locations",
    "attributes": {
      "created_at": "2023-02-21T08:20:08+00:00",
      "updated_at": "2023-02-21T08:20:08+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC26",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "d9b87002-98ae-4b29-a5cd-0651b6f442e5",
        "b93cbf2e-65d1-4e2b-8576-98894ecdab22"
      ]
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "d9b87002-98ae-4b29-a5cd-0651b6f442e5"
          },
          {
            "type": "clusters",
            "id": "b93cbf2e-65d1-4e2b-8576-98894ecdab22"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d9b87002-98ae-4b29-a5cd-0651b6f442e5",
      "type": "clusters",
      "attributes": {
        "created_at": "2023-02-21T08:20:08+00:00",
        "updated_at": "2023-02-21T08:20:08+00:00",
        "name": "North",
        "location_ids": [
          "de8c3d72-96c8-4e44-8077-d6d72586941a"
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
      "id": "b93cbf2e-65d1-4e2b-8576-98894ecdab22",
      "type": "clusters",
      "attributes": {
        "created_at": "2023-02-21T08:20:08+00:00",
        "updated_at": "2023-02-21T08:20:08+00:00",
        "name": "Central",
        "location_ids": [
          "de8c3d72-96c8-4e44-8077-d6d72586941a"
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
    --url 'https://example.booqable.com/api/boomerang/locations/20a3a446-deb8-43c7-a383-c59a47deed79' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "20a3a446-deb8-43c7-a383-c59a47deed79",
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
            "item_id": "6a5fc930-ed4a-42fa-bbe9-40fb41f7907b",
            "mutation": 0,
            "order_ids": [
              "984099d0-8a29-4971-9127-c2600cdb5d6b"
            ],
            "location_id": "20a3a446-deb8-43c7-a383-c59a47deed79",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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


### Includes

This request accepts the following includes:

`clusters`






## Archiving a location

To archive a location make sure that:

- There is no active stock at the location
- There are no running or future orders for this location


> How to archive a location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/981c5f71-7250-44e8-a69b-f62ac95b64f4' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/e16c8fb9-dc1f-43ec-80af-15f47afdfb35' \
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
          "73864008-4b3c-43c0-81f3-e9c0ad6a3fae"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/03e5fb5f-2ae5-46c4-9e76-54c534c84449' \
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
          "25b6ec59-7c74-4947-8ca7-ca9cfe175eb9"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=clusters`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[locations]=id,created_at,updated_at`


### Includes

This request does not accept any includes