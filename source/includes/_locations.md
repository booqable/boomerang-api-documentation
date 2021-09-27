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
      "id": "6ef177f6-f758-42f2-a652-d59a5111c5e7",
      "created_at": "2021-09-27T13:17:24+00:00",
      "updated_at": "2021-09-27T13:17:24+00:00",
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
    }
  ]
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-27T13:17:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/1483439e-082d-473b-9633-e9528d32ceab' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1483439e-082d-473b-9633-e9528d32ceab",
    "created_at": "2021-09-27T13:17:24+00:00",
    "updated_at": "2021-09-27T13:17:24+00:00",
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
  }
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
            "3de29c75-db82-4d3a-bcd9-1d9c7e9502fc"
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
    "id": "ed3fff3e-8837-432e-b946-9e9661aac903",
    "type": "locations",
    "attributes": {
      "created_at": "2021-09-27T13:17:25+00:00",
      "updated_at": "2021-09-27T13:17:25+00:00",
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
        "3de29c75-db82-4d3a-bcd9-1d9c7e9502fc"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "3de29c75-db82-4d3a-bcd9-1d9c7e9502fc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3de29c75-db82-4d3a-bcd9-1d9c7e9502fc",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-09-27T13:17:25+00:00",
        "updated_at": "2021-09-27T13:17:25+00:00",
        "name": "North",
        "location_ids": [
          "ed3fff3e-8837-432e-b946-9e9661aac903"
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
    --url 'https://example.booqable.com/api/boomerang/locations/d91c8b78-c309-4bc8-a39d-08ed2804439b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d91c8b78-c309-4bc8-a39d-08ed2804439b",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "b9503ea7-4af8-4a22-8aec-44a47c2703b7",
            "4700f6dc-7718-46d0-ae75-e53dba546997"
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
    "id": "d91c8b78-c309-4bc8-a39d-08ed2804439b",
    "type": "locations",
    "attributes": {
      "created_at": "2021-09-27T13:17:25+00:00",
      "updated_at": "2021-09-27T13:17:25+00:00",
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
        "b9503ea7-4af8-4a22-8aec-44a47c2703b7",
        "4700f6dc-7718-46d0-ae75-e53dba546997"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "b9503ea7-4af8-4a22-8aec-44a47c2703b7"
          },
          {
            "type": "clusters",
            "id": "4700f6dc-7718-46d0-ae75-e53dba546997"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b9503ea7-4af8-4a22-8aec-44a47c2703b7",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-09-27T13:17:25+00:00",
        "updated_at": "2021-09-27T13:17:25+00:00",
        "name": "North",
        "location_ids": [
          "d91c8b78-c309-4bc8-a39d-08ed2804439b"
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
      "id": "4700f6dc-7718-46d0-ae75-e53dba546997",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-09-27T13:17:25+00:00",
        "updated_at": "2021-09-27T13:17:25+00:00",
        "name": "Central",
        "location_ids": [
          "d91c8b78-c309-4bc8-a39d-08ed2804439b"
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
    --url 'https://example.booqable.com/api/boomerang/locations/5e624e32-9d05-4b36-8c86-b0b869442375' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5e624e32-9d05-4b36-8c86-b0b869442375",
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
            "item_id": "40ca020d-e44b-415b-a691-71b5e283aaef",
            "mutation": 0,
            "location_id": "5e624e32-9d05-4b36-8c86-b0b869442375",
            "from": "2031-09-27T13:15:00.000Z",
            "till": "2031-09-30T13:15:00.000Z",
            "company_id": "7791024d-269e-46e4-ab5c-c4531f324660",
            "order_ids": [
              "bad16ead-1dd6-4b25-b75f-77b03854f6f4"
            ],
            "planning_ids": [
              "981a5b0a-715e-4faf-a543-8e841d038998"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "bad16ead-1dd6-4b25-b75f-77b03854f6f4"
            ],
            "cluster_planning_ids": [
              "981a5b0a-715e-4faf-a543-8e841d038998"
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
    --url 'https://example.booqable.com/api/boomerang/locations/02753e46-9758-4bdc-8e46-89b3bed68971' \
    --header 'content-type: application/json' \
    --data '{}'
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
    --url 'https://example.booqable.com/api/boomerang/locations/3f586f0c-1ed0-4c38-9c87-f67f424ab4a7' \
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
          "66b43311-e3c3-4c1f-a723-a2a09c750d3a"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/30a7aef3-58da-4b72-9a47-2970536fa43b' \
    --header 'content-type: application/json' \
    --data '{}'
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
          "8e3e3d6c-173d-4839-a940-3ccc228888f7"
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