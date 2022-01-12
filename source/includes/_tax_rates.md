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
`owner_type` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


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
      "id": "08398538-c221-4ef0-8148-d7c5d176f05e",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-01-12T10:57:06+00:00",
        "updated_at": "2022-01-12T10:57:06+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8db9eba6-5e78-434d-9b04-2b61b4a2350c",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/8db9eba6-5e78-434d-9b04-2b61b4a2350c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T10:54:49Z`
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
`owner_type` | **String**<br>`eq`, `not_eq`


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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/acaf61f6-94fb-4671-b2bb-6a8a3b6c1b11?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "acaf61f6-94fb-4671-b2bb-6a8a3b6c1b11",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-01-12T10:57:06+00:00",
      "updated_at": "2022-01-12T10:57:06+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "88cc24ac-1327-4363-87ff-cfedd0093484",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/88cc24ac-1327-4363-87ff-cfedd0093484"
        },
        "data": {
          "type": "tax_regions",
          "id": "88cc24ac-1327-4363-87ff-cfedd0093484"
        }
      }
    }
  },
  "included": [
    {
      "id": "88cc24ac-1327-4363-87ff-cfedd0093484",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-01-12T10:57:06+00:00",
        "updated_at": "2022-01-12T10:57:06+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=88cc24ac-1327-4363-87ff-cfedd0093484&filter[owner_type]=tax_regions"
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
          "owner_id": "4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9",
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
    "id": "0b0c28ed-1201-4d71-a073-cbe11f693fe4",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-01-12T10:57:06+00:00",
      "updated_at": "2022-01-12T10:57:06+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9"
        }
      }
    }
  },
  "included": [
    {
      "id": "4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-01-12T10:57:06+00:00",
        "updated_at": "2022-01-12T10:57:06+00:00",
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
    "self": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9&data%5Battributes%5D%5Bowner_type%5D=tax_regions&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9&data%5Battributes%5D%5Bowner_type%5D=tax_regions&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=4a281f3b-c4cd-4492-bf8b-beb8de1d3ab9&data%5Battributes%5D%5Bowner_type%5D=tax_regions&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/238ef7b6-86ad-4cb4-81b0-8e5e33ca9aaa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "238ef7b6-86ad-4cb4-81b0-8e5e33ca9aaa",
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
    "id": "238ef7b6-86ad-4cb4-81b0-8e5e33ca9aaa",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-01-12T10:57:07+00:00",
      "updated_at": "2022-01-12T10:57:07+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "c5deffe9-7be4-49ff-aed7-b5006341b54f",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "c5deffe9-7be4-49ff-aed7-b5006341b54f"
        }
      }
    }
  },
  "included": [
    {
      "id": "c5deffe9-7be4-49ff-aed7-b5006341b54f",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-01-12T10:57:07+00:00",
        "updated_at": "2022-01-12T10:57:07+00:00",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f8d92704-f711-403f-abb3-1cae952cf010' \
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