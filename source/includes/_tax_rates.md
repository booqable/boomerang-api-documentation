# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

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
      "id": "a74847ed-19e4-45e1-805e-ae318a13fc4f",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-07-08T09:28:10.666160+00:00",
        "updated_at": "2024-07-08T09:28:10.666160+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "ba22f3cb-5b4f-474c-9993-d23783d20f52",
        "owner_type": "tax_regions"
      },
      "relationships": {}
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






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/6e3e5da5-dba6-45dd-9d30-f8cd64624a22?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6e3e5da5-dba6-45dd-9d30-f8cd64624a22",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-08T09:28:11.467827+00:00",
      "updated_at": "2024-07-08T09:28:11.467827+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "3af31a2c-6e9c-418e-8d4c-1f1f2bddcaa3",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "3af31a2c-6e9c-418e-8d4c-1f1f2bddcaa3"
        }
      }
    }
  },
  "included": [
    {
      "id": "3af31a2c-6e9c-418e-8d4c-1f1f2bddcaa3",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-08T09:28:11.454067+00:00",
        "updated_at": "2024-07-08T09:28:11.471237+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
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
          "owner_id": "d3332717-119c-4ad7-8e04-cda2fc00f835",
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
    "id": "1ebd9ab7-7eb1-475c-89b7-81c0d230b537",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-08T09:28:09.509866+00:00",
      "updated_at": "2024-07-08T09:28:09.509866+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "d3332717-119c-4ad7-8e04-cda2fc00f835",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "d3332717-119c-4ad7-8e04-cda2fc00f835"
        }
      }
    }
  },
  "included": [
    {
      "id": "d3332717-119c-4ad7-8e04-cda2fc00f835",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-07-08T09:28:09.471394+00:00",
        "updated_at": "2024-07-08T09:28:09.513860+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/43cf6b44-3563-4b61-9e0a-c36187045c27' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "43cf6b44-3563-4b61-9e0a-c36187045c27",
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
    "id": "43cf6b44-3563-4b61-9e0a-c36187045c27",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-08T09:28:10.028596+00:00",
      "updated_at": "2024-07-08T09:28:10.097263+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "8bfad734-b798-46cf-9673-297e51a90c81",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "8bfad734-b798-46cf-9673-297e51a90c81"
        }
      }
    }
  },
  "included": [
    {
      "id": "8bfad734-b798-46cf-9673-297e51a90c81",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-07-08T09:28:10.002651+00:00",
        "updated_at": "2024-07-08T09:28:10.102607+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {}
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






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/3da64dbc-8d99-455f-ad5c-061aaed078ea' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3da64dbc-8d99-455f-ad5c-061aaed078ea",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-07-08T09:28:11.955941+00:00",
      "updated_at": "2024-07-08T09:28:11.955941+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b15b6f70-7fee-467b-a87e-f94d5bc2631b",
      "owner_type": "tax_regions"
    },
    "relationships": {}
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