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
      "id": "0f119cdc-aa94-45f7-867a-24375c48d486",
      "type": "locations",
      "attributes": {
        "created_at": "2021-10-12T14:54:28+00:00",
        "updated_at": "2021-10-12T14:54:28+00:00",
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
            "related": "api/boomerang/clusters?filter[location_id]=0f119cdc-aa94-45f7-867a-24375c48d486"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-12T14:54:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/32a9186a-c4b9-458b-bce2-76f22786ab10' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "32a9186a-c4b9-458b-bce2-76f22786ab10",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-12T14:54:28+00:00",
      "updated_at": "2021-10-12T14:54:28+00:00",
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
          "related": "api/boomerang/clusters?filter[location_id]=32a9186a-c4b9-458b-bce2-76f22786ab10"
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
            "a3036a36-12b5-41be-bf6e-c8553e31509f"
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
    "id": "6bcc30a8-9df0-41ae-9384-55fc0caadf72",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-12T14:54:28+00:00",
      "updated_at": "2021-10-12T14:54:28+00:00",
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
        "a3036a36-12b5-41be-bf6e-c8553e31509f"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "a3036a36-12b5-41be-bf6e-c8553e31509f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a3036a36-12b5-41be-bf6e-c8553e31509f",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-12T14:54:28+00:00",
        "updated_at": "2021-10-12T14:54:28+00:00",
        "name": "North",
        "location_ids": [
          "6bcc30a8-9df0-41ae-9384-55fc0caadf72"
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
    --url 'https://example.booqable.com/api/boomerang/locations/b57b0b23-74f3-44ca-bca7-3c4bb2551e5d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b57b0b23-74f3-44ca-bca7-3c4bb2551e5d",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "d9625e12-93b3-40c4-a2c9-e5a3524cf628",
            "d7a74e24-d874-4a3b-9641-41361f1e2b34"
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
    "id": "b57b0b23-74f3-44ca-bca7-3c4bb2551e5d",
    "type": "locations",
    "attributes": {
      "created_at": "2021-10-12T14:54:29+00:00",
      "updated_at": "2021-10-12T14:54:29+00:00",
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
        "d9625e12-93b3-40c4-a2c9-e5a3524cf628",
        "d7a74e24-d874-4a3b-9641-41361f1e2b34"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "d9625e12-93b3-40c4-a2c9-e5a3524cf628"
          },
          {
            "type": "clusters",
            "id": "d7a74e24-d874-4a3b-9641-41361f1e2b34"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d9625e12-93b3-40c4-a2c9-e5a3524cf628",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-12T14:54:29+00:00",
        "updated_at": "2021-10-12T14:54:29+00:00",
        "name": "North",
        "location_ids": [
          "b57b0b23-74f3-44ca-bca7-3c4bb2551e5d"
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
      "id": "d7a74e24-d874-4a3b-9641-41361f1e2b34",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-10-12T14:54:29+00:00",
        "updated_at": "2021-10-12T14:54:29+00:00",
        "name": "Central",
        "location_ids": [
          "b57b0b23-74f3-44ca-bca7-3c4bb2551e5d"
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
    --url 'https://example.booqable.com/api/boomerang/locations/dc24ffcf-b4ad-423c-989c-dc44c36300f6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dc24ffcf-b4ad-423c-989c-dc44c36300f6",
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
            "item_id": "0b6016d7-c08d-491c-84ef-7e039153bd0f",
            "mutation": 0,
            "location_id": "dc24ffcf-b4ad-423c-989c-dc44c36300f6",
            "from": "2031-10-12T14:45:00.000Z",
            "till": "2031-10-15T14:45:00.000Z",
            "company_id": "0d80eead-e10b-4ad3-9108-8975b52b35f7",
            "order_ids": [
              "422fb3d9-c6e3-4180-a10b-80c8b071148c"
            ],
            "planning_ids": [
              "b81fac3a-c598-45f2-b6b6-6b0fccb1111e"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "422fb3d9-c6e3-4180-a10b-80c8b071148c"
            ],
            "cluster_planning_ids": [
              "b81fac3a-c598-45f2-b6b6-6b0fccb1111e"
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
    --url 'https://example.booqable.com/api/boomerang/locations/cd14b558-a32c-4f7a-afe9-4607f199d96e' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/41237612-2abf-4a08-9e79-4c8784fadd54' \
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
          "6e6426c6-cd78-40d4-a5fd-322620e88a83"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/8b51dfc4-f00a-48d5-ace9-83a54395c679' \
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
          "b57dce7c-3ab3-4eb3-923b-af4b6d262053"
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