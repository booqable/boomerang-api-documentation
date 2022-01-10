# Tax regions

You can create tax regions for specific customers. Booqable's tax system supports adding, replacing and compounding rates.
A tax region can have one of the following strategies:

- **Add to**: Each tax rate is calculated over the order total and individually added or substracted to/from the order total.
- **Compound**: The tax is calculated over the order total, including product taxes (tax over tax). This method is used in some countries like Canada.
- **Replace**: Removes product taxes and calculates tax over the order total.

## Endpoints
`GET /api/boomerang/tax_regions`

`GET /api/boomerang/tax_regions/{id}`

`POST /api/boomerang/tax_regions`

`PUT /api/boomerang/tax_regions/{id}`

`DELETE /api/boomerang/tax_regions/{id}`

## Fields
Every tax region has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the tax region
`strategy` | **String**<br>The strategy to apply. One of `add_to`, `replace`, `compound`
`default` | **Boolean**<br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`tax_rates_attributes` | **Array** `writeonly`<br>The tax rates to associate


## Relationships
Tax regions have the following relationships:

Name | Description
- | -
`tax_rates` | **Tax rates** `readonly`<br>Associated Tax rates


## Listing tax regions



> How to fetch a list of tax regions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_regions' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5291c50a-36b3-4c51-aad6-e51cf123c7e3",
      "created_at": "2022-01-05T12:41:18+00:00",
      "updated_at": "2022-01-05T12:41:18+00:00",
      "name": "Sales Tax",
      "strategy": "add_to",
      "default": false
    }
  ]
}
```

### HTTP Request

`GET /api/boomerang/tax_regions`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-05T12:38:51Z`
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
`strategy` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax region



> How to fetch a tax regions with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/8a9de9df-273c-4ae8-a1fd-dcc6d0a58662?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8a9de9df-273c-4ae8-a1fd-dcc6d0a58662",
    "created_at": "2022-01-05T12:41:19+00:00",
    "updated_at": "2022-01-05T12:41:19+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "d5d63bca-c468-4612-b432-8c3aa2013071",
        "created_at": "2022-01-05T12:41:19+00:00",
        "updated_at": "2022-01-05T12:41:19+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8a9de9df-273c-4ae8-a1fd-dcc6d0a58662",
        "owner_type": "tax_regions"
      }
    ]
  }
}
```

### HTTP Request

`GET /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_rates`






## Creating a tax region



> How to create a tax region with tax rates:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/tax_regions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "tax_regions",
        "attributes": {
          "name": "Sales Tax",
          "strategy": "compound",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 21
            }
          ]
        }
      },
      "include": "tax_rates"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b8c2d95e-1b2e-4508-a4c1-d5413612fb6b",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2022-01-05T12:41:19+00:00",
      "updated_at": "2022-01-05T12:41:19+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "1f2d7d17-7f6e-4f02-a01e-575c6c4c6eec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1f2d7d17-7f6e-4f02-a01e-575c6c4c6eec",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-01-05T12:41:19+00:00",
        "updated_at": "2022-01-05T12:41:19+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "b8c2d95e-1b2e-4508-a4c1-d5413612fb6b",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/tax_regions?data%5Battributes%5D%5Bname%5D=Sales+Tax&data%5Battributes%5D%5Bstrategy%5D=compound&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bname%5D=VAT&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bvalue%5D=21&data%5Btype%5D=tax_regions&include=tax_rates&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_regions?data%5Battributes%5D%5Bname%5D=Sales+Tax&data%5Battributes%5D%5Bstrategy%5D=compound&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bname%5D=VAT&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bvalue%5D=21&data%5Btype%5D=tax_regions&include=tax_rates&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_regions?data%5Battributes%5D%5Bname%5D=Sales+Tax&data%5Battributes%5D%5Bstrategy%5D=compound&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bname%5D=VAT&data%5Battributes%5D%5Btax_rates_attributes%5D%5B%5D%5Bvalue%5D=21&data%5Btype%5D=tax_regions&include=tax_rates&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/tax_regions`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tax region
`data[attributes][strategy]` | **String**<br>The strategy to apply. One of `add_to`, `replace`, `compound`
`data[attributes][default]` | **Boolean**<br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`data[attributes][tax_rates_attributes][]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax region



> How to update a tax region with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/ff5ac7f7-f729-4fdb-bc1a-4e403481a2b5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ff5ac7f7-f729-4fdb-bc1a-4e403481a2b5",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "7e07321b-de52-4b12-828a-4d3012924d40",
              "_destroy": true
            }
          ]
        }
      },
      "include": "tax_rates"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ff5ac7f7-f729-4fdb-bc1a-4e403481a2b5",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2022-01-05T12:41:19+00:00",
      "updated_at": "2022-01-05T12:41:19+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "f134061f-f588-4c86-800c-dc71cf38706e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f134061f-f588-4c86-800c-dc71cf38706e",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-01-05T12:41:19+00:00",
        "updated_at": "2022-01-05T12:41:19+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "ff5ac7f7-f729-4fdb-bc1a-4e403481a2b5",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
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

`PUT /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tax region
`data[attributes][strategy]` | **String**<br>The strategy to apply. One of `add_to`, `replace`, `compound`
`data[attributes][default]` | **Boolean**<br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`data[attributes][tax_rates_attributes][]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax region



> How to delete a tax region with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/25e066c7-da3c-4e3c-9645-6f7864ac2240' \
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

`DELETE /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Includes

This request does not accept any includes