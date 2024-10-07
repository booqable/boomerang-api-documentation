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
      "id": "3069d4c2-2df8-4cb5-bf43-755ae66df2ef",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-10-07T09:34:11.781941+00:00",
        "updated_at": "2024-10-07T09:34:11.781941+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "21f41dfa-fa08-4016-86f9-13f0745fd078",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/e52ce68d-8d0e-42bc-bcdf-56a26b886cc9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e52ce68d-8d0e-42bc-bcdf-56a26b886cc9",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-07T09:34:11.002997+00:00",
      "updated_at": "2024-10-07T09:34:11.002997+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1cb345e3-a1c5-40a5-9845-e857ca09f1f8",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "1cb345e3-a1c5-40a5-9845-e857ca09f1f8"
        }
      }
    }
  },
  "included": [
    {
      "id": "1cb345e3-a1c5-40a5-9845-e857ca09f1f8",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-07T09:34:10.992897+00:00",
        "updated_at": "2024-10-07T09:34:11.006170+00:00",
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
          "owner_id": "029955d2-ecff-4edd-8ac7-6808a848b159",
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
    "id": "e3041b0c-5f52-4d4e-9563-347fd0f952d8",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-07T09:34:09.359629+00:00",
      "updated_at": "2024-10-07T09:34:09.359629+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "029955d2-ecff-4edd-8ac7-6808a848b159",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "029955d2-ecff-4edd-8ac7-6808a848b159"
        }
      }
    }
  },
  "included": [
    {
      "id": "029955d2-ecff-4edd-8ac7-6808a848b159",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-07T09:34:09.335001+00:00",
        "updated_at": "2024-10-07T09:34:09.361374+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f05dc455-11be-4724-a5dd-0993a4fc2316' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f05dc455-11be-4724-a5dd-0993a4fc2316",
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
    "id": "f05dc455-11be-4724-a5dd-0993a4fc2316",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-07T09:34:13.111762+00:00",
      "updated_at": "2024-10-07T09:34:13.137036+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "cffbe489-ef60-49c4-ba0b-fa36dbf52a47",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "cffbe489-ef60-49c4-ba0b-fa36dbf52a47"
        }
      }
    }
  },
  "included": [
    {
      "id": "cffbe489-ef60-49c4-ba0b-fa36dbf52a47",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-10-07T09:34:13.098516+00:00",
        "updated_at": "2024-10-07T09:34:13.138878+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/43affb2c-a65b-4815-addd-a2864bf46130' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "43affb2c-a65b-4815-addd-a2864bf46130",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-07T09:34:10.463947+00:00",
      "updated_at": "2024-10-07T09:34:10.463947+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "bc1ebdee-0d09-420b-ab54-13f1afc6ef8d",
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