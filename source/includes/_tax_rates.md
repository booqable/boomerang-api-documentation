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
      "id": "f770319a-9c3b-4823-bac9-712876927607",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-12T15:27:42+00:00",
        "updated_at": "2021-10-12T15:27:42+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "50d6d5af-6fd3-41f3-94e4-546633d5b28d",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/50d6d5af-6fd3-41f3-94e4-546633d5b28d"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-12T15:27:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/8669a822-daa0-4228-abc7-d47e9a7307db?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8669a822-daa0-4228-abc7-d47e9a7307db",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-12T15:27:42+00:00",
      "updated_at": "2021-10-12T15:27:42+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "e202a97e-ecd3-4a2f-9469-594525c2dc6d",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/e202a97e-ecd3-4a2f-9469-594525c2dc6d"
        },
        "data": {
          "type": "tax_regions",
          "id": "e202a97e-ecd3-4a2f-9469-594525c2dc6d"
        }
      }
    }
  },
  "included": [
    {
      "id": "e202a97e-ecd3-4a2f-9469-594525c2dc6d",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-12T15:27:42+00:00",
        "updated_at": "2021-10-12T15:27:42+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=e202a97e-ecd3-4a2f-9469-594525c2dc6d&filter[owner_type]=TaxRegion"
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
          "value": 21,
          "owner_id": "c1cb3fb7-7ca4-4fe2-a910-55d3702ebedc",
          "owner_type": "TaxRegion"
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7a913ffe-ef18-4758-9267-c0a366a7fd21",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-12T15:27:42+00:00",
      "updated_at": "2021-10-12T15:27:42+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "c1cb3fb7-7ca4-4fe2-a910-55d3702ebedc",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "c1cb3fb7-7ca4-4fe2-a910-55d3702ebedc"
        }
      }
    }
  },
  "included": [
    {
      "id": "c1cb3fb7-7ca4-4fe2-a910-55d3702ebedc",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-12T15:27:42+00:00",
        "updated_at": "2021-10-12T15:27:42+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/19967357-8776-4e8e-97e3-4e260ae2c49b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "19967357-8776-4e8e-97e3-4e260ae2c49b",
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
    "id": "19967357-8776-4e8e-97e3-4e260ae2c49b",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-12T15:27:43+00:00",
      "updated_at": "2021-10-12T15:27:43+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "a9e7b11c-a19a-45fa-9b76-3028ffce29c9",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "a9e7b11c-a19a-45fa-9b76-3028ffce29c9"
        }
      }
    }
  },
  "included": [
    {
      "id": "a9e7b11c-a19a-45fa-9b76-3028ffce29c9",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-10-12T15:27:43+00:00",
        "updated_at": "2021-10-12T15:27:43+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f146fb85-b13b-4fd1-873a-3c1f104379ae' \
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