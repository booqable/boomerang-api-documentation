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


## Relationships
Locations have the following relationships:

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
      "id": "2cdb68bc-c0f6-483c-9354-8819eaed7652",
      "type": "locations",
      "attributes": {
        "created_at": "2022-06-23T19:02:18+00:00",
        "updated_at": "2022-06-23T19:02:18+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC19",
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
            "related": "api/boomerang/clusters?filter[location_id]=2cdb68bc-c0f6-483c-9354-8819eaed7652"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
    --url 'https://example.booqable.com/api/boomerang/locations/157d7cde-c610-478d-aeca-97e8a376f4ee' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "157d7cde-c610-478d-aeca-97e8a376f4ee",
    "type": "locations",
    "attributes": {
      "created_at": "2022-06-23T19:02:19+00:00",
      "updated_at": "2022-06-23T19:02:19+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Warehouse",
      "code": "LOC20",
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
          "related": "api/boomerang/clusters?filter[location_id]=157d7cde-c610-478d-aeca-97e8a376f4ee"
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
            "02008c40-5d23-466f-9da1-b2a2fdad6cee"
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
    "id": "0e7c80af-3995-43c0-8dc0-f81abce7399b",
    "type": "locations",
    "attributes": {
      "created_at": "2022-06-23T19:02:19+00:00",
      "updated_at": "2022-06-23T19:02:19+00:00",
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
        "02008c40-5d23-466f-9da1-b2a2fdad6cee"
      ]
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "02008c40-5d23-466f-9da1-b2a2fdad6cee"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "02008c40-5d23-466f-9da1-b2a2fdad6cee",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-06-23T19:02:19+00:00",
        "updated_at": "2022-06-23T19:02:19+00:00",
        "name": "North",
        "location_ids": [
          "0e7c80af-3995-43c0-8dc0-f81abce7399b"
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

Note that disassociating clusters may result in a shortage error.


> How to update a location and assign it to multiple clusters:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/locations/1f3f2358-cac6-48b4-a06d-3a9ac897e3c1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1f3f2358-cac6-48b4-a06d-3a9ac897e3c1",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "dc54f161-201d-465c-8d31-ca072d10e1ad",
            "53bbf2fd-5d5a-445c-b171-3b8cfad76fae"
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
    "id": "1f3f2358-cac6-48b4-a06d-3a9ac897e3c1",
    "type": "locations",
    "attributes": {
      "created_at": "2022-06-23T19:02:20+00:00",
      "updated_at": "2022-06-23T19:02:20+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC22",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "dc54f161-201d-465c-8d31-ca072d10e1ad",
        "53bbf2fd-5d5a-445c-b171-3b8cfad76fae"
      ]
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "dc54f161-201d-465c-8d31-ca072d10e1ad"
          },
          {
            "type": "clusters",
            "id": "53bbf2fd-5d5a-445c-b171-3b8cfad76fae"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dc54f161-201d-465c-8d31-ca072d10e1ad",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-06-23T19:02:20+00:00",
        "updated_at": "2022-06-23T19:02:20+00:00",
        "name": "North",
        "location_ids": [
          "1f3f2358-cac6-48b4-a06d-3a9ac897e3c1"
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
      "id": "53bbf2fd-5d5a-445c-b171-3b8cfad76fae",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-06-23T19:02:20+00:00",
        "updated_at": "2022-06-23T19:02:20+00:00",
        "name": "Central",
        "location_ids": [
          "1f3f2358-cac6-48b4-a06d-3a9ac897e3c1"
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
    --url 'https://example.booqable.com/api/boomerang/locations/d976ad1c-5882-4405-8651-bf1a4e22a8fe' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d976ad1c-5882-4405-8651-bf1a4e22a8fe",
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
            "item_id": "a97c7dd2-565b-40ab-b9c7-a939b04022d9",
            "mutation": 0,
            "order_ids": [
              "4beaa6ed-8a4c-4817-bff0-399c0963e59c"
            ],
            "location_id": "d976ad1c-5882-4405-8651-bf1a4e22a8fe",
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

To archive a location make sure that:

- There is no active stock at the location
- There are no running or future orders for this location


> How to archive a location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/aeb034d7-7fa4-48d4-a11f-8793466ef58e' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/d03e685a-b49c-4728-8c5c-6ab8f23e7da7' \
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
          "a6050981-b87d-4293-9f0d-6aaaeb903c75"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/00821386-f2bf-4899-a623-e66225242b33' \
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
          "8dc2ed25-6f2c-4ef7-9d13-7f7b3b7980d2"
        ]
      }
    }
  ]
}
```

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