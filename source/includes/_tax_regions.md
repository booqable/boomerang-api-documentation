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
      "id": "5d535a98-a9c1-48bd-8b58-64d61fe51551",
      "created_at": "2022-01-12T10:57:07+00:00",
      "updated_at": "2022-01-12T10:57:07+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/81a3d051-6164-4737-9c94-027327fda8bd?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "81a3d051-6164-4737-9c94-027327fda8bd",
    "created_at": "2022-01-12T10:57:07+00:00",
    "updated_at": "2022-01-12T10:57:07+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "8c5b67b4-0e95-4994-8c71-3f80f802b9b4",
        "created_at": "2022-01-12T10:57:07+00:00",
        "updated_at": "2022-01-12T10:57:07+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "81a3d051-6164-4737-9c94-027327fda8bd",
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
    "id": "84972cd8-27a1-44fa-b4a1-e1d6bafcf57e",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2022-01-12T10:57:08+00:00",
      "updated_at": "2022-01-12T10:57:08+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "af8dac3f-e56e-4d99-9b84-9055b1113ea3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "af8dac3f-e56e-4d99-9b84-9055b1113ea3",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-01-12T10:57:08+00:00",
        "updated_at": "2022-01-12T10:57:08+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "84972cd8-27a1-44fa-b4a1-e1d6bafcf57e",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/a866069a-eff7-47c9-9c52-02c696745554' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a866069a-eff7-47c9-9c52-02c696745554",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "cecfe478-e4ca-4f0c-ac94-93a241cd86c2",
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
    "id": "a866069a-eff7-47c9-9c52-02c696745554",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2022-01-12T10:57:08+00:00",
      "updated_at": "2022-01-12T10:57:08+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "5ca7ad36-7547-4cb6-9aec-47d5e2b60b58"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5ca7ad36-7547-4cb6-9aec-47d5e2b60b58",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-01-12T10:57:08+00:00",
        "updated_at": "2022-01-12T10:57:08+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "a866069a-eff7-47c9-9c52-02c696745554",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/a7f6f4c3-8dd0-422e-a992-48d6eb87b0e1' \
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