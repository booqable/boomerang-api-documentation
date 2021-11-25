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
      "id": "15c06d2a-ccff-4cff-93b7-0e8d258b57c3",
      "type": "locations",
      "attributes": {
        "created_at": "2021-11-23T12:48:24+00:00",
        "updated_at": "2021-11-23T12:48:24+00:00",
        "name": "Warehouse",
        "code": "LOC9",
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
            "related": "api/boomerang/clusters?filter[location_id]=15c06d2a-ccff-4cff-93b7-0e8d258b57c3"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-23T12:47:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/8c2ae7bd-da96-4c1f-891e-5d5efd9a02d1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8c2ae7bd-da96-4c1f-891e-5d5efd9a02d1",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-23T12:48:25+00:00",
      "updated_at": "2021-11-23T12:48:25+00:00",
      "name": "Warehouse",
      "code": "LOC10",
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
          "related": "api/boomerang/clusters?filter[location_id]=8c2ae7bd-da96-4c1f-891e-5d5efd9a02d1"
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
            "51352aee-c047-4d24-add9-d0e469767c02"
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
    "id": "c0e611ff-3e03-4d32-8d54-1fd91e9c37bd",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-23T12:48:25+00:00",
      "updated_at": "2021-11-23T12:48:25+00:00",
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
        "51352aee-c047-4d24-add9-d0e469767c02"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "51352aee-c047-4d24-add9-d0e469767c02"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "51352aee-c047-4d24-add9-d0e469767c02",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-23T12:48:25+00:00",
        "updated_at": "2021-11-23T12:48:25+00:00",
        "name": "North",
        "location_ids": [
          "c0e611ff-3e03-4d32-8d54-1fd91e9c37bd"
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
    "self": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=51352aee-c047-4d24-add9-d0e469767c02&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=51352aee-c047-4d24-add9-d0e469767c02&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=51352aee-c047-4d24-add9-d0e469767c02&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/locations/d22f0739-9c5d-41b1-ae87-7a9d738f290c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d22f0739-9c5d-41b1-ae87-7a9d738f290c",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "e617720b-a58a-4b8d-ad9f-70502d053859",
            "82cc690d-4ca2-4b4e-b151-0e1f88de6250"
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
    "id": "d22f0739-9c5d-41b1-ae87-7a9d738f290c",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-23T12:48:25+00:00",
      "updated_at": "2021-11-23T12:48:25+00:00",
      "name": "Old warehouse",
      "code": "LOC12",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "e617720b-a58a-4b8d-ad9f-70502d053859",
        "82cc690d-4ca2-4b4e-b151-0e1f88de6250"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "e617720b-a58a-4b8d-ad9f-70502d053859"
          },
          {
            "type": "clusters",
            "id": "82cc690d-4ca2-4b4e-b151-0e1f88de6250"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e617720b-a58a-4b8d-ad9f-70502d053859",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-23T12:48:25+00:00",
        "updated_at": "2021-11-23T12:48:25+00:00",
        "name": "North",
        "location_ids": [
          "d22f0739-9c5d-41b1-ae87-7a9d738f290c"
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
      "id": "82cc690d-4ca2-4b4e-b151-0e1f88de6250",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-23T12:48:25+00:00",
        "updated_at": "2021-11-23T12:48:25+00:00",
        "name": "Central",
        "location_ids": [
          "d22f0739-9c5d-41b1-ae87-7a9d738f290c"
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
    --url 'https://example.booqable.com/api/boomerang/locations/049c746e-ca53-4292-afa4-a5ce4c0331ae' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "049c746e-ca53-4292-afa4-a5ce4c0331ae",
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
            "item_id": "f9247fa0-980b-4f68-9c0d-06738a7c3b09",
            "mutation": 0,
            "location_id": "049c746e-ca53-4292-afa4-a5ce4c0331ae",
            "from": "2031-11-23T12:45:00.000Z",
            "till": "2031-11-26T12:45:00.000Z",
            "company_id": "00a91ec7-d2eb-4233-8461-14f419d91b14",
            "order_ids": [
              "a813fcb2-f7b4-4eaf-8517-9a20330f5edb"
            ],
            "planning_ids": [
              "4111d4b4-9902-479b-979f-171a540163fd"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "a813fcb2-f7b4-4eaf-8517-9a20330f5edb"
            ],
            "cluster_planning_ids": [
              "4111d4b4-9902-479b-979f-171a540163fd"
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
    --url 'https://example.booqable.com/api/boomerang/locations/0346c7cc-f7a1-45a0-8280-be2239bee176' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/ddf4a929-9bf0-4776-bad8-21104f46a84d' \
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
          "0eb47cf4-a9e8-4142-a99f-78aeb67a7aa3"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/08a76607-8bbe-4149-8468-3a6605ab21ba' \
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
          "67776b64-be8f-432f-8433-350783a417c5"
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