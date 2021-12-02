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
      "id": "8a86c34e-23a4-4ce1-b1e9-c3ff1d34ee7c",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-12-02T15:13:04+00:00",
        "updated_at": "2021-12-02T15:13:04+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "0776e21d-0b06-482a-adfe-095d73d29bb1",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/0776e21d-0b06-482a-adfe-095d73d29bb1"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T15:10:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c762be30-353a-4f95-a0fa-6cf99a8a19ee?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c762be30-353a-4f95-a0fa-6cf99a8a19ee",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-12-02T15:13:05+00:00",
      "updated_at": "2021-12-02T15:13:05+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "df77ae4f-1722-4c15-afdd-27e8d57cedf6",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/df77ae4f-1722-4c15-afdd-27e8d57cedf6"
        },
        "data": {
          "type": "tax_regions",
          "id": "df77ae4f-1722-4c15-afdd-27e8d57cedf6"
        }
      }
    }
  },
  "included": [
    {
      "id": "df77ae4f-1722-4c15-afdd-27e8d57cedf6",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-12-02T15:13:05+00:00",
        "updated_at": "2021-12-02T15:13:05+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=df77ae4f-1722-4c15-afdd-27e8d57cedf6&filter[owner_type]=tax_regions"
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
          "owner_id": "b50e4f7a-2788-4745-965f-07a4c330b0a7",
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
    "id": "5751282c-05c6-47d6-8246-a9df1d6af991",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-12-02T15:13:05+00:00",
      "updated_at": "2021-12-02T15:13:05+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "b50e4f7a-2788-4745-965f-07a4c330b0a7",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "b50e4f7a-2788-4745-965f-07a4c330b0a7"
        }
      }
    }
  },
  "included": [
    {
      "id": "b50e4f7a-2788-4745-965f-07a4c330b0a7",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-12-02T15:13:05+00:00",
        "updated_at": "2021-12-02T15:13:05+00:00",
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
    "self": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=b50e4f7a-2788-4745-965f-07a4c330b0a7&data%5Battributes%5D%5Bowner_type%5D=tax_regions&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=b50e4f7a-2788-4745-965f-07a4c330b0a7&data%5Battributes%5D%5Bowner_type%5D=tax_regions&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=b50e4f7a-2788-4745-965f-07a4c330b0a7&data%5Battributes%5D%5Bowner_type%5D=tax_regions&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/3cb2e6ea-a5f4-4c1f-a4c3-f9b235383dc3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3cb2e6ea-a5f4-4c1f-a4c3-f9b235383dc3",
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
    "id": "3cb2e6ea-a5f4-4c1f-a4c3-f9b235383dc3",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-12-02T15:13:05+00:00",
      "updated_at": "2021-12-02T15:13:05+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "f62d2e14-5e62-4662-9f8a-f02251efe643",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "f62d2e14-5e62-4662-9f8a-f02251efe643"
        }
      }
    }
  },
  "included": [
    {
      "id": "f62d2e14-5e62-4662-9f8a-f02251efe643",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-12-02T15:13:05+00:00",
        "updated_at": "2021-12-02T15:13:05+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/f65bf13d-10cc-4d38-8e88-784c93ecd626' \
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