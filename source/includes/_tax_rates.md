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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>The name of the tax rate
`value` | **Float**<br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid**<br>ID of its owner
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
      "id": "39844a21-d187-4e9e-bd3b-3c958ce1c08e",
      "created_at": "2021-08-24T12:40:58+00:00",
      "updated_at": "2021-08-24T12:40:58+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "9600367c-5e3c-4acb-b3a6-0565a445ae81",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-24T12:40:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/534b842d-c15f-4e83-b73e-88ee6976f47f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "534b842d-c15f-4e83-b73e-88ee6976f47f",
    "created_at": "2021-08-24T12:40:58+00:00",
    "updated_at": "2021-08-24T12:40:58+00:00",
    "name": "VAT",
    "value": 21.0,
    "position": 1,
    "owner_id": "08938961-056d-46f5-8b57-ef7cf5008ba8",
    "owner_type": "TaxRegion",
    "owner": {
      "id": "08938961-056d-46f5-8b57-ef7cf5008ba8",
      "created_at": "2021-08-24T12:40:58+00:00",
      "updated_at": "2021-08-24T12:40:58+00:00",
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
              "id": "1b4fc9f0-62b2-49af-893a-1a7d0752443a",
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
    "id": "4bfff51c-d09f-4e04-9d7d-a63e1aeb6cd1",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-08-24T12:40:58+00:00",
      "updated_at": "2021-08-24T12:40:58+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "1b4fc9f0-62b2-49af-893a-1a7d0752443a",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "1b4fc9f0-62b2-49af-893a-1a7d0752443a"
        }
      }
    }
  },
  "included": [
    {
      "id": "1b4fc9f0-62b2-49af-893a-1a7d0752443a",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-08-24T12:40:58+00:00",
        "updated_at": "2021-08-24T12:40:58+00:00",
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
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate

> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9c501619-2994-43ae-9bc5-c0caf8b412bf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9c501619-2994-43ae-9bc5-c0caf8b412bf",
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
    "id": "9c501619-2994-43ae-9bc5-c0caf8b412bf",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-08-24T12:40:59+00:00",
      "updated_at": "2021-08-24T12:40:59+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "6628e87a-79c1-4d15-b9cd-dc311a177177",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "6628e87a-79c1-4d15-b9cd-dc311a177177"
        }
      }
    }
  },
  "included": [
    {
      "id": "6628e87a-79c1-4d15-b9cd-dc311a177177",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-08-24T12:40:58+00:00",
        "updated_at": "2021-08-24T12:40:59+00:00",
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
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate

> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/6ffb1e8c-3d26-41f9-8c6c-fc7b34f8b8f9' \
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