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
Tax rates have the following relationships:

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
      "id": "dd07509d-5a84-4a90-9ae4-704f06f60719",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-11-15T07:46:54+00:00",
        "updated_at": "2021-11-15T07:46:54+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "73ebe197-9aec-45aa-ac52-b8d3f0b6f7ce",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/73ebe197-9aec-45aa-ac52-b8d3f0b6f7ce"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/tax_rates?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-15T07:45:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/7cbcc6dd-e802-4126-b40a-a43feca57cdd?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7cbcc6dd-e802-4126-b40a-a43feca57cdd",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-11-15T07:46:54+00:00",
      "updated_at": "2021-11-15T07:46:54+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "38a158b0-7106-4e55-a512-10b233da0ac5",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/38a158b0-7106-4e55-a512-10b233da0ac5"
        },
        "data": {
          "type": "tax_regions",
          "id": "38a158b0-7106-4e55-a512-10b233da0ac5"
        }
      }
    }
  },
  "included": [
    {
      "id": "38a158b0-7106-4e55-a512-10b233da0ac5",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-11-15T07:46:54+00:00",
        "updated_at": "2021-11-15T07:46:54+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=38a158b0-7106-4e55-a512-10b233da0ac5&filter[owner_type]=TaxRegion"
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
          "owner_id": "0fb98cde-f184-40c5-8c3a-11fdbf45ddf8",
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
    "id": "0fb23cf4-2b36-422f-8068-f067a5bf53a0",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-11-15T07:46:55+00:00",
      "updated_at": "2021-11-15T07:46:55+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0fb98cde-f184-40c5-8c3a-11fdbf45ddf8",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0fb98cde-f184-40c5-8c3a-11fdbf45ddf8"
        }
      }
    }
  },
  "included": [
    {
      "id": "0fb98cde-f184-40c5-8c3a-11fdbf45ddf8",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-11-15T07:46:55+00:00",
        "updated_at": "2021-11-15T07:46:55+00:00",
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
  "links": {
    "self": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=0fb98cde-f184-40c5-8c3a-11fdbf45ddf8&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=0fb98cde-f184-40c5-8c3a-11fdbf45ddf8&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=0fb98cde-f184-40c5-8c3a-11fdbf45ddf8&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/8f6190bc-50c8-40e0-99fa-fd8a1bf231af' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8f6190bc-50c8-40e0-99fa-fd8a1bf231af",
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
    "id": "8f6190bc-50c8-40e0-99fa-fd8a1bf231af",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-11-15T07:46:55+00:00",
      "updated_at": "2021-11-15T07:46:55+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "06eedcf6-aa30-4072-ae65-b9d79dd85ab1",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "06eedcf6-aa30-4072-ae65-b9d79dd85ab1"
        }
      }
    }
  },
  "included": [
    {
      "id": "06eedcf6-aa30-4072-ae65-b9d79dd85ab1",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-11-15T07:46:55+00:00",
        "updated_at": "2021-11-15T07:46:55+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/eecd572e-e3f7-4fdb-a2ca-d25edc1d153e' \
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