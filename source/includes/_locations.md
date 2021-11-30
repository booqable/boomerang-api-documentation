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
      "id": "1af04b39-08fb-4a77-81e2-981c4e3cdde6",
      "type": "locations",
      "attributes": {
        "created_at": "2021-11-30T12:55:55+00:00",
        "updated_at": "2021-11-30T12:55:55+00:00",
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
            "related": "api/boomerang/clusters?filter[location_id]=1af04b39-08fb-4a77-81e2-981c4e3cdde6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-30T12:55:00Z`
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
    --url 'https://example.booqable.com/api/boomerang/locations/6b9eec45-b8a2-4042-ba43-032f730e43f5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b9eec45-b8a2-4042-ba43-032f730e43f5",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-30T12:55:55+00:00",
      "updated_at": "2021-11-30T12:55:55+00:00",
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
          "related": "api/boomerang/clusters?filter[location_id]=6b9eec45-b8a2-4042-ba43-032f730e43f5"
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
            "215d0769-56fc-4f64-9e54-e061474a5cdf"
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
    "id": "581f8667-05e0-49ae-9243-4913b712c368",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-30T12:55:55+00:00",
      "updated_at": "2021-11-30T12:55:55+00:00",
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
        "215d0769-56fc-4f64-9e54-e061474a5cdf"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "215d0769-56fc-4f64-9e54-e061474a5cdf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "215d0769-56fc-4f64-9e54-e061474a5cdf",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-30T12:55:55+00:00",
        "updated_at": "2021-11-30T12:55:55+00:00",
        "name": "North",
        "location_ids": [
          "581f8667-05e0-49ae-9243-4913b712c368"
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
    "self": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=215d0769-56fc-4f64-9e54-e061474a5cdf&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=215d0769-56fc-4f64-9e54-e061474a5cdf&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/locations?data%5Battributes%5D%5Baddress_line_1%5D=Blokhuisplein+40&data%5Battributes%5D%5Baddress_line_2%5D=Department+II&data%5Battributes%5D%5Bcity%5D=Leeuwarden&data%5Battributes%5D%5Bcluster_ids%5D%5B%5D=215d0769-56fc-4f64-9e54-e061474a5cdf&data%5Battributes%5D%5Bcode%5D=STR&data%5Battributes%5D%5Bcountry%5D=Netherlands&data%5Battributes%5D%5Blocation_type%5D=rental&data%5Battributes%5D%5Bname%5D=Store&data%5Battributes%5D%5Bregion%5D=Friesland&data%5Battributes%5D%5Bzipcode%5D=8911LJ&data%5Btype%5D=locations&include=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/locations/b509464d-b208-4523-99c5-c4cfdeae239f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b509464d-b208-4523-99c5-c4cfdeae239f",
        "type": "locations",
        "attributes": {
          "name": "Old warehouse",
          "cluster_ids": [
            "0e213014-e649-44c5-8569-a0ba86588ef4",
            "924da087-3eab-416e-a145-1a187af8a998"
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
    "id": "b509464d-b208-4523-99c5-c4cfdeae239f",
    "type": "locations",
    "attributes": {
      "created_at": "2021-11-30T12:55:56+00:00",
      "updated_at": "2021-11-30T12:55:56+00:00",
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
        "0e213014-e649-44c5-8569-a0ba86588ef4",
        "924da087-3eab-416e-a145-1a187af8a998"
      ],
      "archived": false
    },
    "relationships": {
      "clusters": {
        "data": [
          {
            "type": "clusters",
            "id": "0e213014-e649-44c5-8569-a0ba86588ef4"
          },
          {
            "type": "clusters",
            "id": "924da087-3eab-416e-a145-1a187af8a998"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0e213014-e649-44c5-8569-a0ba86588ef4",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-30T12:55:56+00:00",
        "updated_at": "2021-11-30T12:55:56+00:00",
        "name": "North",
        "location_ids": [
          "b509464d-b208-4523-99c5-c4cfdeae239f"
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
      "id": "924da087-3eab-416e-a145-1a187af8a998",
      "type": "clusters",
      "attributes": {
        "created_at": "2021-11-30T12:55:56+00:00",
        "updated_at": "2021-11-30T12:55:56+00:00",
        "name": "Central",
        "location_ids": [
          "b509464d-b208-4523-99c5-c4cfdeae239f"
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
    --url 'https://example.booqable.com/api/boomerang/locations/7b4a2af2-6347-412c-af14-fa00d1cb376e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7b4a2af2-6347-412c-af14-fa00d1cb376e",
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
            "item_id": "5ececd08-bde8-42b8-a487-eec0c0e0f22a",
            "mutation": 0,
            "location_id": "7b4a2af2-6347-412c-af14-fa00d1cb376e",
            "from": "2031-11-30T12:45:00.000Z",
            "till": "2031-12-03T12:45:00.000Z",
            "company_id": "218bf874-8281-4559-a7c5-ee4a829bb037",
            "order_ids": [
              "91b4469c-294f-4801-a465-ead578259ccc"
            ],
            "planning_ids": [
              "1e16ab50-6e81-4d6b-8a07-c16e2333019b"
            ],
            "planned": 2,
            "needed": 2,
            "stock_count": 0,
            "available": -2,
            "cluster_order_ids": [
              "91b4469c-294f-4801-a465-ead578259ccc"
            ],
            "cluster_planning_ids": [
              "1e16ab50-6e81-4d6b-8a07-c16e2333019b"
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
    --url 'https://example.booqable.com/api/boomerang/locations/f365d11a-4246-42e5-bda9-84f12eacff37' \
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
    --url 'https://example.booqable.com/api/boomerang/locations/52a9ae1c-7c40-4d25-85bf-9cd349b5d175' \
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
          "ed4919c8-82a5-4312-bd93-87d846a0dd67"
        ]
      }
    }
  ]
}
```


> Failure due to active stock at location:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/locations/8f2c63a1-389f-4212-8ffe-0c9b397c82f0' \
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
          "389185aa-8356-4e29-b917-e2cb7267b048"
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