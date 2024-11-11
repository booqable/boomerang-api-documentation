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
`owner` | **Tax category, Tax region** <br>Associated Owner


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
      "id": "9ceef7a5-3891-42a9-aada-0168c626e6f9",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-11-11T09:23:06.152280+00:00",
        "updated_at": "2024-11-11T09:23:06.152280+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "b2a4956f-619f-4c4d-b561-60ff0b4684f4",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/213acf08-1e74-4650-adb8-59859ebb03de?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "213acf08-1e74-4650-adb8-59859ebb03de",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-11T09:23:06.619980+00:00",
      "updated_at": "2024-11-11T09:23:06.619980+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "eb90f791-4afa-42e4-8d67-b726fa9e335a",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "eb90f791-4afa-42e4-8d67-b726fa9e335a"
        }
      }
    }
  },
  "included": [
    {
      "id": "eb90f791-4afa-42e4-8d67-b726fa9e335a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-11T09:23:06.612964+00:00",
        "updated_at": "2024-11-11T09:23:06.621393+00:00",
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
          "owner_id": "3c7cc0c3-f871-40aa-a0a8-b4df71ceac7d",
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
    "id": "64a6df8f-822f-4901-9990-9ea0b2b41ea8",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-11T09:23:08.095808+00:00",
      "updated_at": "2024-11-11T09:23:08.095808+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "3c7cc0c3-f871-40aa-a0a8-b4df71ceac7d",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "3c7cc0c3-f871-40aa-a0a8-b4df71ceac7d"
        }
      }
    }
  },
  "included": [
    {
      "id": "3c7cc0c3-f871-40aa-a0a8-b4df71ceac7d",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-11-11T09:23:08.074310+00:00",
        "updated_at": "2024-11-11T09:23:08.097496+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f477e7ea-59c2-4174-a954-3f733601511e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f477e7ea-59c2-4174-a954-3f733601511e",
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
    "id": "f477e7ea-59c2-4174-a954-3f733601511e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-11T09:23:07.582668+00:00",
      "updated_at": "2024-11-11T09:23:07.606775+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "89d0a269-19e8-4526-b8c8-d82253c6c57b",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "89d0a269-19e8-4526-b8c8-d82253c6c57b"
        }
      }
    }
  },
  "included": [
    {
      "id": "89d0a269-19e8-4526-b8c8-d82253c6c57b",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-11-11T09:23:07.571169+00:00",
        "updated_at": "2024-11-11T09:23:07.608294+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/27fd797e-7087-4113-a097-ee25064d651d' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "27fd797e-7087-4113-a097-ee25064d651d",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-11-11T09:23:07.111074+00:00",
      "updated_at": "2024-11-11T09:23:07.111074+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "a5652e00-5764-46d1-b257-4323b579277f",
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