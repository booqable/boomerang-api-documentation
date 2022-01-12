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
      "id": "6d885f35-31ff-426f-9ed2-b5c177cbd40a",
      "type": "locations",
      "attributes": {
        "created_at": "2022-01-12T14:03:14+00:00",
        "updated_at": "2022-01-12T14:03:14+00:00",
        "name": "Warehouse",
        "code": "LOC14",
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
            "related": "api/boomerang/clusters?filter[location_id]=6d885f35-31ff-426f-9ed2-b5c177cbd40a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T14:02:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/08e95942-143d-4922-9c70-edd4fd2c55b1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "08e95942-143d-4922-9c70-edd4fd2c55b1",
    "type": "locations",
    "attributes": {
      "created_at": "2022-01-12T14:03:15+00:00",
      "updated_at": "2022-01-12T14:03:15+00:00",
      "name": "Warehouse",
      "code": "LOC15",
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
          "related": "api/boomerang/clusters?filter[location_id]=08e95942-143d-4922-9c70-edd4fd2c55b1"
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
            "6ca7a543-cd98-4d60-bd4f-f01630b792ec"
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
    "id": "652cd2f8-47e8-4613-8aeb-a7932a618bbc",
    "type": "locations",
    "attributes": {
      "created_at": "2022-01-12T14:03:15+00:00",
      "updated_at": "2022-01-12T14:03:15+00:00",
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
        "6ca7a543-cd98-4d60-bd4f-f01630b792ec"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "6ca7a543-cd98-4d60-bd4f-f01630b792ec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6ca7a543-cd98-4d60-bd4f-f01630b792ec",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-01-12T14:03:15+00:00",
        "updated_at": "2022-01-12T14:03:15+00:00",
        "name": "North",
        "location_ids": [
          "652cd2f8-47e8-4613-8aeb-a7932a618bbc"
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
    "self": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=6ca7a543-cd98-4d60-bd4f-f01630b792ec&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=6ca7a543-cd98-4d60-bd4f-f01630b792ec&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=6ca7a543-cd98-4d60-bd4f-f01630b792ec&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/locations/b495f88e-6974-4c60-a290-2218c7d93559' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b495f88e-6974-4c60-a290-2218c7d93559",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "e81af9fe-6009-47f7-8068-61f9e2c8ea0e",
            "d3cc9743-5a15-4ff6-ad7e-3c665fcc012e"
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
    "id": "b495f88e-6974-4c60-a290-2218c7d93559",
    "type": "locations",
    "attributes": {
      "created_at": "2022-01-12T14:03:15+00:00",
      "updated_at": "2022-01-12T14:03:15+00:00",
      "name": "Old warehouse",
      "code": "LOC17",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "e81af9fe-6009-47f7-8068-61f9e2c8ea0e",
        "d3cc9743-5a15-4ff6-ad7e-3c665fcc012e"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "e81af9fe-6009-47f7-8068-61f9e2c8ea0e"
          },
          {
            "type": "clusters",
            "id": "d3cc9743-5a15-4ff6-ad7e-3c665fcc012e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e81af9fe-6009-47f7-8068-61f9e2c8ea0e",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-01-12T14:03:15+00:00",
        "updated_at": "2022-01-12T14:03:15+00:00",
        "name": "North",
        "location_ids": [
          "b495f88e-6974-4c60-a290-2218c7d93559"
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
      "id": "d3cc9743-5a15-4ff6-ad7e-3c665fcc012e",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-01-12T14:03:15+00:00",
        "updated_at": "2022-01-12T14:03:15+00:00",
        "name": "Central",
        "location_ids": [
          "b495f88e-6974-4c60-a290-2218c7d93559"
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
    --url 'https://example.booqable.com/api/boomerang/locations/8f44fad6-f8b6-4154-8aea-7f3462574bf0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8f44fad6-f8b6-4154-8aea-7f3462574bf0",
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
            "item_id": "3b7abb91-b6f3-44f7-bb21-9d17e88ba923",
            "mutation": 0,
            "order_ids": [
              "2451b3b0-3f69-4318-959c-f0ca7a9f888f"
            ],
            "location_id": "8f44fad6-f8b6-4154-8aea-7f3462574bf0",
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
    --url 'https://example.booqable.com/api/boomerang/locations/c337e393-049c-4155-886a-2f6bbc8c61b9' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/72742194-ec13-427c-b91a-e657d8997954' \
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
          "ed7024be-68db-43b0-85e9-0c1d2eee5be6"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/feeaeba2-dca9-44b8-9c76-23b9d377ddba' \
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
          "cf1c8025-b446-470b-9821-f45402d89918"
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