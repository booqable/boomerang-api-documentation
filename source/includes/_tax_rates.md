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
      "id": "7f1fc8c1-4f0b-4f35-8b78-acda8e869db5",
      "type": "tax_rates",
      "attributes": {
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "21e2c817-38e7-4fd6-8077-78304dc0fe87",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/21e2c817-38e7-4fd6-8077-78304dc0fe87"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-26T09:51:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f768fc1d-fb76-4ac0-adef-ad8bd78b3b3f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f768fc1d-fb76-4ac0-adef-ad8bd78b3b3f",
    "type": "tax_rates",
    "attributes": {
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "e0fca5b2-8013-4a2e-a901-406ca3d50b1c",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/e0fca5b2-8013-4a2e-a901-406ca3d50b1c"
        },
        "data": {
          "type": "tax_regions",
          "id": "e0fca5b2-8013-4a2e-a901-406ca3d50b1c"
        }
      }
    }
  },
  "included": [
    {
      "id": "e0fca5b2-8013-4a2e-a901-406ca3d50b1c",
      "type": "tax_regions",
      "attributes": {
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=e0fca5b2-8013-4a2e-a901-406ca3d50b1c&filter[owner_type]=TaxRegion"
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
          "owner_id": "aa787f7d-76d1-410f-81de-f6207ac96044",
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
    "id": "f2b50038-fc55-4c7a-ac63-642e63e66e96",
    "type": "tax_rates",
    "attributes": {
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "aa787f7d-76d1-410f-81de-f6207ac96044",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "aa787f7d-76d1-410f-81de-f6207ac96044"
        }
      }
    }
  },
  "included": [
    {
      "id": "aa787f7d-76d1-410f-81de-f6207ac96044",
      "type": "tax_regions",
      "attributes": {
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
    "self": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=aa787f7d-76d1-410f-81de-f6207ac96044&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=aa787f7d-76d1-410f-81de-f6207ac96044&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=aa787f7d-76d1-410f-81de-f6207ac96044&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/074dafee-01c3-4b8e-a533-556159a5b778' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "074dafee-01c3-4b8e-a533-556159a5b778",
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
    "id": "074dafee-01c3-4b8e-a533-556159a5b778",
    "type": "tax_rates",
    "attributes": {
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "6d0fa4f8-f0c8-43ec-9db6-4030b2f91845",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "6d0fa4f8-f0c8-43ec-9db6-4030b2f91845"
        }
      }
    }
  },
  "included": [
    {
      "id": "6d0fa4f8-f0c8-43ec-9db6-4030b2f91845",
      "type": "tax_categories",
      "attributes": {
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/11a6e102-5146-4384-a244-45167a706933' \
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