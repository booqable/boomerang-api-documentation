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
      "id": "07b6dd74-beea-4c4b-b00f-a059b15c4305",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T09:38:30+00:00",
        "updated_at": "2021-09-29T09:38:30+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "901747f1-affd-4fd1-bd3d-81909d97c1eb",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/901747f1-affd-4fd1-bd3d-81909d97c1eb"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-29T09:38:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b77fcda0-7e80-4590-bd41-9b4288fce93e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b77fcda0-7e80-4590-bd41-9b4288fce93e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-09-29T09:38:30+00:00",
      "updated_at": "2021-09-29T09:38:30+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "a56c1e37-e1e2-45db-a4e5-49932dc0d8ff",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/a56c1e37-e1e2-45db-a4e5-49932dc0d8ff"
        },
        "data": {
          "type": "tax_regions",
          "id": "a56c1e37-e1e2-45db-a4e5-49932dc0d8ff"
        }
      }
    }
  },
  "included": [
    {
      "id": "a56c1e37-e1e2-45db-a4e5-49932dc0d8ff",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-09-29T09:38:30+00:00",
        "updated_at": "2021-09-29T09:38:30+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=a56c1e37-e1e2-45db-a4e5-49932dc0d8ff&filter[owner_type]=TaxRegion"
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
          "owner_id": "bbd41dde-70b3-4715-a116-e0e3952d6965",
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
    "id": "f13b4a8e-5749-4e4b-8e2a-f81042e938b3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-09-29T09:38:31+00:00",
      "updated_at": "2021-09-29T09:38:31+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "bbd41dde-70b3-4715-a116-e0e3952d6965",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "bbd41dde-70b3-4715-a116-e0e3952d6965"
        }
      }
    }
  },
  "included": [
    {
      "id": "bbd41dde-70b3-4715-a116-e0e3952d6965",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-09-29T09:38:31+00:00",
        "updated_at": "2021-09-29T09:38:31+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/896b4640-ddf3-45f3-849f-45a7a93ae717' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "896b4640-ddf3-45f3-849f-45a7a93ae717",
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
    "id": "896b4640-ddf3-45f3-849f-45a7a93ae717",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-09-29T09:38:31+00:00",
      "updated_at": "2021-09-29T09:38:31+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "fb717e9a-3fde-498f-8042-c6e6c57a0439",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "fb717e9a-3fde-498f-8042-c6e6c57a0439"
        }
      }
    }
  },
  "included": [
    {
      "id": "fb717e9a-3fde-498f-8042-c6e6c57a0439",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-09-29T09:38:31+00:00",
        "updated_at": "2021-09-29T09:38:31+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/cd44aecd-c94b-45be-91a0-9c5e016dccaa' \
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