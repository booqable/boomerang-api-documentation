# Tax rates

Tax rates
## Endpoints
`GET api/boomerang/tax_rates`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

`DELETE /api/boomerang/tax_rates/{id}`

## Fields
Every tax rate has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>The name of the tax rate
`value` | **Float**<br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid**<br>ID of i's owner
`owner_type` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


## Relationships
A tax rates has the following relationships:

Name | Description
- | -
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
      "id": "7e801f3c-9f85-44b0-b456-d6154687d59a",
      "created_at": "2021-08-10T11:21:25+00:00",
      "updated_at": "2021-08-10T11:21:25+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "7abeb460-b242-49dd-b4c7-4f827755f36c",
      "owner_type": "TaxRegion"
    }
  ]
}
```


### HTTP Request

`GET api/boomerang/tax_rates`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-10T11:21:23Z`
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
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate

> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/2f7c6c40-7655-4c0a-a392-ca8da04079f7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2f7c6c40-7655-4c0a-a392-ca8da04079f7",
    "created_at": "2021-08-10T11:21:26+00:00",
    "updated_at": "2021-08-10T11:21:26+00:00",
    "name": "VAT",
    "value": 21.0,
    "position": 1,
    "owner_id": "59d92283-5644-4886-8fe0-f4af3165fd95",
    "owner_type": "TaxRegion",
    "owner": {
      "id": "59d92283-5644-4886-8fe0-f4af3165fd95",
      "created_at": "2021-08-10T11:21:26+00:00",
      "updated_at": "2021-08-10T11:21:26+00:00",
      "name": "Tax region name",
      "strategy": "add_to",
      "default": false
    }
  }
}
```


### HTTP Request

`GET /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


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
          "value": 21
        },
        "relationships": {
          "owner": {
            "data": {
              "id": "db7fea62-855d-4fa3-bfe6-1f252f947a27",
              "type": "tax_regions",
              "method": "update"
            }
          }
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a6d98db9-74d4-495a-b5fc-7a0051ca0bc4",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-08-10T11:21:26+00:00",
      "updated_at": "2021-08-10T11:21:26+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "db7fea62-855d-4fa3-bfe6-1f252f947a27",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "db7fea62-855d-4fa3-bfe6-1f252f947a27"
        }
      }
    }
  },
  "included": [
    {
      "id": "db7fea62-855d-4fa3-bfe6-1f252f947a27",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-08-10T11:21:26+00:00",
        "updated_at": "2021-08-10T11:21:26+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>The name of the tax rate
`data[attributes][value]` | **Float**<br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid**<br>ID of i's owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate

> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5adc647a-1bc3-47fc-a835-5df6f9288c47' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5adc647a-1bc3-47fc-a835-5df6f9288c47",
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
    "id": "5adc647a-1bc3-47fc-a835-5df6f9288c47",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-08-10T11:21:26+00:00",
      "updated_at": "2021-08-10T11:21:26+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "a984ce31-b455-45cb-9736-4d8672688f6b",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "a984ce31-b455-45cb-9736-4d8672688f6b"
        }
      }
    }
  },
  "included": [
    {
      "id": "a984ce31-b455-45cb-9736-4d8672688f6b",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-08-10T11:21:26+00:00",
        "updated_at": "2021-08-10T11:21:26+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>The name of the tax rate
`data[attributes][value]` | **Float**<br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid**<br>ID of i's owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate

> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b5dd3874-6345-4fe2-adbb-f6654d323dd1' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


### HTTP Request

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Includes

This request does not accept any includes