# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`POST /api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

`GET /api/boomerang/tax_rates/{id}`

`DELETE /api/boomerang/tax_rates/{id}`

## Fields
Every tax rate has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>The name of the tax rate
`value` | **Float** <br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


## Relationships
Tax rates have the following relationships:

Name | Description
-- | --
`owner` | **Tax category, Tax region**<br>Associated Owner


## Listing tax rates



> How to fetch a list of tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c0308640-535b-40b2-bb8a-7963c0c72a16",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-04-09T07:41:29+00:00",
        "updated_at": "2024-04-09T07:41:29+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "97582aee-0128-4243-8716-06fe57658630",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/97582aee-0128-4243-8716-06fe57658630"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Creating a tax rate



> How to create a tax rate and associate it with an owner:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/tax_rates' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "tax_rates",
        "attributes": {
          "name": "VAT",
          "value": 21,
          "owner_id": "1d544302-4321-4bf1-80ff-627ec5e6ecf3",
          "owner_type": "tax_regions"
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "45ce1f3f-ce96-4401-b43e-78aaa119c619",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-09T07:41:30+00:00",
      "updated_at": "2024-04-09T07:41:30+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1d544302-4321-4bf1-80ff-627ec5e6ecf3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "1d544302-4321-4bf1-80ff-627ec5e6ecf3"
        }
      }
    }
  },
  "included": [
    {
      "id": "1d544302-4321-4bf1-80ff-627ec5e6ecf3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-09T07:41:30+00:00",
        "updated_at": "2024-04-09T07:41:30+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
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

`POST /api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>The name of the tax rate
`data[attributes][value]` | **Float** <br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5c19459b-46d2-43f2-a844-87def8d009d8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5c19459b-46d2-43f2-a844-87def8d009d8",
        "type": "tax_rates",
        "attributes": {
          "value": 9
        }
      },
      "include": "owner"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5c19459b-46d2-43f2-a844-87def8d009d8",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-09T07:41:31+00:00",
      "updated_at": "2024-04-09T07:41:31+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "b4d04bc3-4d66-4db9-88e3-043f881573d7",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "b4d04bc3-4d66-4db9-88e3-043f881573d7"
        }
      }
    }
  },
  "included": [
    {
      "id": "b4d04bc3-4d66-4db9-88e3-043f881573d7",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-04-09T07:41:31+00:00",
        "updated_at": "2024-04-09T07:41:31+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
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

`PUT /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>The name of the tax rate
`data[attributes][value]` | **Float** <br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a43b6aca-be80-4756-94c1-e9ada5d7b3d4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a43b6aca-be80-4756-94c1-e9ada5d7b3d4",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-09T07:41:31+00:00",
      "updated_at": "2024-04-09T07:41:31+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b7641f24-ff10-4efd-8a65-4a40946dccc8",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/b7641f24-ff10-4efd-8a65-4a40946dccc8"
        },
        "data": {
          "type": "tax_regions",
          "id": "b7641f24-ff10-4efd-8a65-4a40946dccc8"
        }
      }
    }
  },
  "included": [
    {
      "id": "b7641f24-ff10-4efd-8a65-4a40946dccc8",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-04-09T07:41:31+00:00",
        "updated_at": "2024-04-09T07:41:31+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=b7641f24-ff10-4efd-8a65-4a40946dccc8&filter[owner_type]=tax_regions"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/57f0b260-51c5-45a0-949e-6fde9d9a2134' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "57f0b260-51c5-45a0-949e-6fde9d9a2134",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-04-09T07:41:32+00:00",
      "updated_at": "2024-04-09T07:41:32+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "e3a14a75-5d42-4531-9ee3-ca1f7b2f78a9",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request does not accept any includes