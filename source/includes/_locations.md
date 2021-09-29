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
      "id": "eb8944ad-664c-4d31-9b86-c92dad2118bd",
      "type": "locations",
      "attributes": {
        "created_at": "2021-09-29T09:38:25+00:00",
        "updated_at": "2021-09-29T09:38:25+00:00",
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
            "related": "api/boomerang/clusters?filter[location_id]=eb8944ad-664c-4d31-9b86-c92dad2118bd"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-29T09:38:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/2042d148-9bf4-40b5-9fc4-23b63379de54' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2042d148-9bf4-40b5-9fc4-23b63379de54",
    "type": "locations",
    "attributes": {
      "created_at": "2021-09-29T09:38:25+00:00",
      "updated_at": "2021-09-29T09:38:25+00:00",
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
          "related": "api/boomerang/clusters?filter[location_id]=2042d148-9bf4-40b5-9fc4-23b63379de54"
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
            "a2d21c81-a909-4e63-81d6-bcf72f8021ea"
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
    "id": "c1bbffd2-7f48-4ec3-ad0f-6e2bca375cf6",
    "type": "locations",
    "attributes": {
      "created_at": "2021-09-29T09:38:25+00:00",
      "updated_at": "2021-09-29T09:38:25+00:00",
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
        "a2d21c81-a909-4e63-81d6-bcf72f8021ea"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "a2d21c81-a909-4e63-81d6-bcf72f8021ea"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a2d21c81-a909-4e63-81d6-bcf72f8021ea",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-09-29T09:38:25+00:00",
        "updated_at": "2021-09-29T09:38:25+00:00",
        "name": "North",
        "location_ids": [
          "c1bbffd2-7f48-4ec3-ad0f-6e2bca375cf6"
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
    --url 'https://example.booqable.com/api/boomerang/locations/0424c5bd-aea9-4bfa-95ed-146bea667ce5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0424c5bd-aea9-4bfa-95ed-146bea667ce5",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "47c4aa2a-e841-4745-9b27-1124566ccc5d",
            "93853a69-8060-4c0a-ace2-78c931376d3a"
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
    "id": "0424c5bd-aea9-4bfa-95ed-146bea667ce5",
    "type": "locations",
    "attributes": {
      "created_at": "2021-09-29T09:38:26+00:00",
      "updated_at": "2021-09-29T09:38:26+00:00",
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
        "47c4aa2a-e841-4745-9b27-1124566ccc5d",
        "93853a69-8060-4c0a-ace2-78c931376d3a"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "47c4aa2a-e841-4745-9b27-1124566ccc5d"
          },
          {
            "type": "clusters",
            "id": "93853a69-8060-4c0a-ace2-78c931376d3a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "47c4aa2a-e841-4745-9b27-1124566ccc5d",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-09-29T09:38:26+00:00",
        "updated_at": "2021-09-29T09:38:26+00:00",
        "name": "North",
        "location_ids": [
          "0424c5bd-aea9-4bfa-95ed-146bea667ce5"
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
      "id": "93853a69-8060-4c0a-ace2-78c931376d3a",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-09-29T09:38:26+00:00",
        "updated_at": "2021-09-29T09:38:26+00:00",
        "name": "Central",
        "location_ids": [
          "0424c5bd-aea9-4bfa-95ed-146bea667ce5"
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
    --url 'https://example.booqable.com/api/boomerang/locations/7a5a7795-d3bb-47c1-977d-bd6b08946f29' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7a5a7795-d3bb-47c1-977d-bd6b08946f29",
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
            "item_id": "1589ffc8-21a1-4701-b178-52a00fd4e801",
            "mutation": 0,
            "location_id": "7a5a7795-d3bb-47c1-977d-bd6b08946f29",
            "from": "2031-09-29T09:30:00.000Z",
            "till": "2031-10-02T09:30:00.000Z",
            "company_id": "98dc0850-5fcb-4ecc-ad6c-fa7d4f0a040f",
            "order_ids": [
              "a997520a-ee8e-4f55-92fe-5722169fd75e"
            ],
            "planning_ids": [
              "8186ba1e-e781-4bd5-aa22-f93524f5b5c2"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "a997520a-ee8e-4f55-92fe-5722169fd75e"
            ],
            "cluster_planning_ids": [
              "8186ba1e-e781-4bd5-aa22-f93524f5b5c2"
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
    --url 'https://example.booqable.com/api/boomerang/locations/32696bbd-93ed-40fe-8af1-48cf91662260' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/0ba56405-e6a5-4736-9a7a-aafd25ee20d4' \
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
          "d7d14e82-9a57-4515-8659-45a87837ac48"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/5cddfc6e-6f14-4341-a76c-2e3c1df31a6f' \
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
          "67bd6c75-67b5-4f45-a256-359daa56ebd7"
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