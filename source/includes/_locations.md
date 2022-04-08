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
      "id": "6f600c0b-5c30-44c8-9a91-0af1aa7a63e3",
      "type": "locations",
      "attributes": {
        "created_at": "2022-04-08T18:20:28+00:00",
        "updated_at": "2022-04-08T18:20:28+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC18",
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
            "related": "api/boomerang/clusters?filter[location_id]=6f600c0b-5c30-44c8-9a91-0af1aa7a63e3"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/fe41b8a3-0706-4c9b-89eb-e744a1906de0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fe41b8a3-0706-4c9b-89eb-e744a1906de0",
    "type": "locations",
    "attributes": {
      "created_at": "2022-04-08T18:20:28+00:00",
      "updated_at": "2022-04-08T18:20:28+00:00",
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
          "related": "api/boomerang/clusters?filter[location_id]=fe41b8a3-0706-4c9b-89eb-e744a1906de0"
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
            "01d8f13a-05e1-4589-b7a1-98b75c35f25c"
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
    "id": "414a77c3-841c-408c-a003-d5e1b58b6713",
    "type": "locations",
    "attributes": {
      "created_at": "2022-04-08T18:20:29+00:00",
      "updated_at": "2022-04-08T18:20:29+00:00",
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
        "01d8f13a-05e1-4589-b7a1-98b75c35f25c"
      ]
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "01d8f13a-05e1-4589-b7a1-98b75c35f25c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "01d8f13a-05e1-4589-b7a1-98b75c35f25c",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-04-08T18:20:29+00:00",
        "updated_at": "2022-04-08T18:20:29+00:00",
        "name": "North",
        "location_ids": [
          "414a77c3-841c-408c-a003-d5e1b58b6713"
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
    --url 'https://example.booqable.com/api/boomerang/locations/eed49bc4-16c6-4211-a186-a68bbf3f2f35' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eed49bc4-16c6-4211-a186-a68bbf3f2f35",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "3548424f-48d8-46c2-a499-dd0acd38068d",
            "93f34b7d-9fcd-4c8e-8487-2d6a925284ab"
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
    "id": "eed49bc4-16c6-4211-a186-a68bbf3f2f35",
    "type": "locations",
    "attributes": {
      "created_at": "2022-04-08T18:20:29+00:00",
      "updated_at": "2022-04-08T18:20:29+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Old warehouse",
      "code": "LOC21",
      "location_type": "rental",
      "address_line_1": "Blokhuisplein 40",
      "address_line_2": "Department II",
      "zipcode": "8911LJ",
      "city": "Leeuwarden",
      "region": "Friesland",
      "country": "Netherlands",
      "cluster_ids": [
        "3548424f-48d8-46c2-a499-dd0acd38068d",
        "93f34b7d-9fcd-4c8e-8487-2d6a925284ab"
      ]
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "3548424f-48d8-46c2-a499-dd0acd38068d"
          },
          {
            "type": "clusters",
            "id": "93f34b7d-9fcd-4c8e-8487-2d6a925284ab"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3548424f-48d8-46c2-a499-dd0acd38068d",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-04-08T18:20:29+00:00",
        "updated_at": "2022-04-08T18:20:29+00:00",
        "name": "North",
        "location_ids": [
          "eed49bc4-16c6-4211-a186-a68bbf3f2f35"
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
      "id": "93f34b7d-9fcd-4c8e-8487-2d6a925284ab",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-04-08T18:20:29+00:00",
        "updated_at": "2022-04-08T18:20:29+00:00",
        "name": "Central",
        "location_ids": [
          "eed49bc4-16c6-4211-a186-a68bbf3f2f35"
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
    --url 'https://example.booqable.com/api/boomerang/locations/0f3328ef-2f4c-452b-9d75-34e913bdf1d1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0f3328ef-2f4c-452b-9d75-34e913bdf1d1",
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
            "item_id": "57e4d996-71a3-4194-9b5a-bfed261ccd93",
            "mutation": 0,
            "order_ids": [
              "1165ce2b-6d2d-42b0-83f5-8f6b38f171ee"
            ],
            "location_id": "0f3328ef-2f4c-452b-9d75-34e913bdf1d1",
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
    --url 'https://example.booqable.com/api/boomerang/locations/822c6392-215c-4520-a9fd-49fdf804058b' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/dc68fe78-54d7-4751-9b0e-921b20863914' \
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
          "8316fc4b-3fae-4185-bbec-0adf726f41ab"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/bbb4a7bf-ba42-4d52-b6b6-812410940752' \
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
          "d02de1f5-c644-4a80-b15a-4217295cf807"
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