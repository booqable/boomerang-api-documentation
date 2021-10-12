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
      "id": "f36af625-09ff-466f-a076-f163bda3eb76",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-12T14:54:33+00:00",
        "updated_at": "2021-10-12T14:54:33+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "60a55500-062b-47be-b0e7-20d4d859c688",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/60a55500-062b-47be-b0e7-20d4d859c688"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-12T14:54:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/542ef1c0-2b7c-407b-8e5e-a3eeded0f59a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "542ef1c0-2b7c-407b-8e5e-a3eeded0f59a",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-12T14:54:33+00:00",
      "updated_at": "2021-10-12T14:54:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "782ed9ce-4a6a-4775-9bf3-b10ed800426c",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/782ed9ce-4a6a-4775-9bf3-b10ed800426c"
        },
        "data": {
          "type": "tax_regions",
          "id": "782ed9ce-4a6a-4775-9bf3-b10ed800426c"
        }
      }
    }
  },
  "included": [
    {
      "id": "782ed9ce-4a6a-4775-9bf3-b10ed800426c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-12T14:54:33+00:00",
        "updated_at": "2021-10-12T14:54:33+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=782ed9ce-4a6a-4775-9bf3-b10ed800426c&filter[owner_type]=TaxRegion"
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
          "owner_id": "39b3da88-e66b-4512-a1f0-0dac3bdc72f6",
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
    "id": "389fb2b1-d6da-4111-a69b-b62c683f58f2",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-12T14:54:33+00:00",
      "updated_at": "2021-10-12T14:54:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "39b3da88-e66b-4512-a1f0-0dac3bdc72f6",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "39b3da88-e66b-4512-a1f0-0dac3bdc72f6"
        }
      }
    }
  },
  "included": [
    {
      "id": "39b3da88-e66b-4512-a1f0-0dac3bdc72f6",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-12T14:54:33+00:00",
        "updated_at": "2021-10-12T14:54:33+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/7d1a1c2f-8330-4297-8352-448c887aa5d2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7d1a1c2f-8330-4297-8352-448c887aa5d2",
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
    "id": "7d1a1c2f-8330-4297-8352-448c887aa5d2",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-12T14:54:34+00:00",
      "updated_at": "2021-10-12T14:54:34+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "1a96b6d5-4ad5-422f-80be-37a22302e481",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "1a96b6d5-4ad5-422f-80be-37a22302e481"
        }
      }
    }
  },
  "included": [
    {
      "id": "1a96b6d5-4ad5-422f-80be-37a22302e481",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-10-12T14:54:34+00:00",
        "updated_at": "2021-10-12T14:54:34+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f066d956-4ad3-4680-8ac7-94e99e035a5f' \
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