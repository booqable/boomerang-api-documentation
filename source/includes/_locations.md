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
      "id": "50dcbfb6-d43e-40ff-9046-1295eb9f07ec",
      "type": "locations",
      "attributes": {
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
            "related": "api/boomerang/clusters?filter[location_id]=50dcbfb6-d43e-40ff-9046-1295eb9f07ec"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-02T11:56:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/e741f166-f618-4f16-b307-ecfd113a20b6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e741f166-f618-4f16-b307-ecfd113a20b6",
    "type": "locations",
    "attributes": {
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
          "related": "api/boomerang/clusters?filter[location_id]=e741f166-f618-4f16-b307-ecfd113a20b6"
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
            "cbd75023-3105-4114-a8e4-c5b0be922cf5"
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
    "id": "16b893ec-b897-4bf0-a163-81524d7c37a1",
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
        "cbd75023-3105-4114-a8e4-c5b0be922cf5"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "cbd75023-3105-4114-a8e4-c5b0be922cf5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cbd75023-3105-4114-a8e4-c5b0be922cf5",
      "type": "clusters",
      "attributes": {
        "name": "North",
        "location_ids": [
          "16b893ec-b897-4bf0-a163-81524d7c37a1"
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
    "self": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=cbd75023-3105-4114-a8e4-c5b0be922cf5&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=cbd75023-3105-4114-a8e4-c5b0be922cf5&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=cbd75023-3105-4114-a8e4-c5b0be922cf5&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/locations/01b57e89-b994-41e7-b575-5d5f2602d0f5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "01b57e89-b994-41e7-b575-5d5f2602d0f5",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "80f77d30-aaa2-4232-8c6e-2e0e8016f569",
            "57b0abe5-d7b8-49e2-96ae-54e49f88e173"
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
    "id": "01b57e89-b994-41e7-b575-5d5f2602d0f5",
    "type": "locations",
    "attributes": {
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
        "80f77d30-aaa2-4232-8c6e-2e0e8016f569",
        "57b0abe5-d7b8-49e2-96ae-54e49f88e173"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "80f77d30-aaa2-4232-8c6e-2e0e8016f569"
          },
          {
            "type": "clusters",
            "id": "57b0abe5-d7b8-49e2-96ae-54e49f88e173"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "80f77d30-aaa2-4232-8c6e-2e0e8016f569",
      "type": "clusters",
      "attributes": {
        "name": "North",
        "location_ids": [
          "01b57e89-b994-41e7-b575-5d5f2602d0f5"
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
      "id": "57b0abe5-d7b8-49e2-96ae-54e49f88e173",
      "type": "clusters",
      "attributes": {
        "name": "Central",
        "location_ids": [
          "01b57e89-b994-41e7-b575-5d5f2602d0f5"
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
    --url 'https://example.booqable.com/api/boomerang/locations/9cede66c-0d38-45ce-ba8a-cb7c6191fc0f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9cede66c-0d38-45ce-ba8a-cb7c6191fc0f",
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
            "item_id": "97964bd6-09dc-4839-8320-9788e42a29bb",
            "mutation": 0,
            "location_id": "9cede66c-0d38-45ce-ba8a-cb7c6191fc0f",
            "from": "2031-11-02T11:45:00.000Z",
            "till": "2031-11-05T11:45:00.000Z",
            "company_id": "3000b127-19e8-4895-ac4a-15404959f8e6",
            "order_ids": [
              "c3654886-1c3d-4ea7-80d1-dca94d3d81b3"
            ],
            "planning_ids": [
              "ad3f686b-d4df-4bca-a9ae-dc154b8377d0"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "c3654886-1c3d-4ea7-80d1-dca94d3d81b3"
            ],
            "cluster_planning_ids": [
              "ad3f686b-d4df-4bca-a9ae-dc154b8377d0"
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
    --url 'https://example.booqable.com/api/boomerang/locations/947451d8-9832-4058-b01c-49a5c1b195b3' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/bd4bf17e-5839-498d-9d07-1602749c4376' \
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
          "d33dc2d2-89c8-423a-904b-7c0a30608638"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/9e1f94d2-f52f-46ce-9ce3-41347fee42b9' \
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
          "091ae1e8-eef7-46e1-a438-cf6cdddf685b"
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