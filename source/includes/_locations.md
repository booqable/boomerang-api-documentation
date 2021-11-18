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
      "id": "c8a74d21-b5f5-41fc-b47f-42b8874ea670",
      "type": "locations",
      "attributes": {
        "created_at": "2021-11-18T15:15:07+00:00",
        "updated_at": "2021-11-18T15:15:07+00:00",
        "name": "Warehouse",
        "code": "LOC12",
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
            "related": "api/boomerang/clusters?filter[location_id]=c8a74d21-b5f5-41fc-b47f-42b8874ea670"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/locations?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/locations?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/locations?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-18T15:14:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/9912d0a5-5558-42e1-a4c9-c89fa7e46afc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9912d0a5-5558-42e1-a4c9-c89fa7e46afc",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-18T15:15:07+00:00",
      "updated_at": "2021-11-18T15:15:07+00:00",
      "name": "Warehouse",
      "code": "LOC13",
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
          "related": "api/boomerang/clusters?filter[location_id]=9912d0a5-5558-42e1-a4c9-c89fa7e46afc"
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
            "56c62b67-23e7-42dc-aed5-04f4ed849b59"
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
    "id": "e04c5fa8-bdc9-43b1-b754-c185d8c5cecb",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-18T15:15:08+00:00",
      "updated_at": "2021-11-18T15:15:08+00:00",
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
        "56c62b67-23e7-42dc-aed5-04f4ed849b59"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "56c62b67-23e7-42dc-aed5-04f4ed849b59"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "56c62b67-23e7-42dc-aed5-04f4ed849b59",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-18T15:15:08+00:00",
        "updated_at": "2021-11-18T15:15:08+00:00",
        "name": "North",
        "location_ids": [
          "e04c5fa8-bdc9-43b1-b754-c185d8c5cecb"
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
  "links": {
    "self": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=56c62b67-23e7-42dc-aed5-04f4ed849b59&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=56c62b67-23e7-42dc-aed5-04f4ed849b59&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=56c62b67-23e7-42dc-aed5-04f4ed849b59&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
    --url 'https://example.booqable.com/api/boomerang/locations/1745147b-c7a1-4b10-91af-2781c8edfa1c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1745147b-c7a1-4b10-91af-2781c8edfa1c",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "61fe0d4e-150d-4679-b144-32f0130c0fad",
            "0d3ec396-a43d-4caf-b310-85b6fb68947b"
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
    "id": "1745147b-c7a1-4b10-91af-2781c8edfa1c",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-18T15:15:08+00:00",
      "updated_at": "2021-11-18T15:15:08+00:00",
      "name": "Old warehouse",
      "code": "LOC15",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "61fe0d4e-150d-4679-b144-32f0130c0fad",
        "0d3ec396-a43d-4caf-b310-85b6fb68947b"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "61fe0d4e-150d-4679-b144-32f0130c0fad"
          },
          {
            "type": "clusters",
            "id": "0d3ec396-a43d-4caf-b310-85b6fb68947b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "61fe0d4e-150d-4679-b144-32f0130c0fad",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-18T15:15:08+00:00",
        "updated_at": "2021-11-18T15:15:08+00:00",
        "name": "North",
        "location_ids": [
          "1745147b-c7a1-4b10-91af-2781c8edfa1c"
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
      "id": "0d3ec396-a43d-4caf-b310-85b6fb68947b",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-18T15:15:08+00:00",
        "updated_at": "2021-11-18T15:15:08+00:00",
        "name": "Central",
        "location_ids": [
          "1745147b-c7a1-4b10-91af-2781c8edfa1c"
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
    --url 'https://example.booqable.com/api/boomerang/locations/3cfb46ae-2dc9-4103-849a-904390135d5f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3cfb46ae-2dc9-4103-849a-904390135d5f",
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
            "item_id": "5f4ec023-bf64-42e5-9cb9-d2ec38d64eeb",
            "mutation": 0,
            "location_id": "3cfb46ae-2dc9-4103-849a-904390135d5f",
            "from": "2031-11-18T15:15:00.000Z",
            "till": "2031-11-21T15:15:00.000Z",
            "company_id": "60cfadac-0ff5-48f1-a934-9084e88e50de",
            "order_ids": [
              "785f68f2-8e91-42c5-bd38-96a7bcb445c0"
            ],
            "planning_ids": [
              "6144ae81-79a1-4695-b353-6966c99df84a"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "785f68f2-8e91-42c5-bd38-96a7bcb445c0"
            ],
            "cluster_planning_ids": [
              "6144ae81-79a1-4695-b353-6966c99df84a"
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
    --url 'https://example.booqable.com/api/boomerang/locations/6b7bc7d0-8e34-47b9-8005-2e7d50f3a956' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/cf31830f-c293-4e93-84f5-8d31c702bbf3' \
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
          "6e0eff44-cec7-49e7-a204-ea70f5a31cfb"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/99d14d4b-3b62-4412-a792-884ec1733648' \
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
          "c554f68f-f5b8-4dc5-b6a9-757645e85f2f"
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