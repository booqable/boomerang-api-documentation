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
`archived` | **Boolean** `readonly`<br>Whether tax region is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the tax region was archived
`name` | **String** <br>Name of the tax region
`strategy` | **String** <br>The strategy to apply. One of `add_to`, `replace`, `compound`
`default` | **Boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
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
      "id": "4c9e4237-5d98-4ec6-8837-88585a95e41b",
      "created_at": "2023-02-24T09:51:22+00:00",
      "updated_at": "2023-02-24T09:51:22+00:00",
      "archived": false,
      "archived_at": null,
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:21Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`strategy` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax region



> How to fetch a tax regions with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/0d42280e-c465-4da8-b050-d02be2072192?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0d42280e-c465-4da8-b050-d02be2072192",
    "created_at": "2023-02-24T09:51:22+00:00",
    "updated_at": "2023-02-24T09:51:22+00:00",
    "archived": false,
    "archived_at": null,
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "1f79055d-005c-46e1-be6d-34495b03ae42",
        "created_at": "2023-02-24T09:51:22+00:00",
        "updated_at": "2023-02-24T09:51:22+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "0d42280e-c465-4da8-b050-d02be2072192",
        "owner_type": "tax_regions"
      }
    ]
  }
}
```

### HTTP Request

`GET /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


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
    "id": "97c76026-c834-4fd9-8bd6-58d6c1643eaa",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2023-02-24T09:51:22+00:00",
      "updated_at": "2023-02-24T09:51:22+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "fe09de20-971b-449b-93cf-86ceb74c0f8f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fe09de20-971b-449b-93cf-86ceb74c0f8f",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-24T09:51:22+00:00",
        "updated_at": "2023-02-24T09:51:22+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "97c76026-c834-4fd9-8bd6-58d6c1643eaa",
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

`POST /api/boomerang/tax_regions`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the tax region
`data[attributes][strategy]` | **String** <br>The strategy to apply. One of `add_to`, `replace`, `compound`
`data[attributes][default]` | **Boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`data[attributes][tax_rates_attributes][]` | **Array** <br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax region



> How to update a tax region with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/4fd1c4d4-f7c5-4eb5-9370-6ac10d6c891f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4fd1c4d4-f7c5-4eb5-9370-6ac10d6c891f",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "2fe48ece-5ff8-4ed8-a9dc-b86029ed5521",
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
    "id": "4fd1c4d4-f7c5-4eb5-9370-6ac10d6c891f",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2023-02-24T09:51:23+00:00",
      "updated_at": "2023-02-24T09:51:23+00:00",
      "archived": false,
      "archived_at": null,
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "f142247f-4547-4ecd-9166-2d8c5f321a02"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f142247f-4547-4ecd-9166-2d8c5f321a02",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2023-02-24T09:51:23+00:00",
        "updated_at": "2023-02-24T09:51:23+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "4fd1c4d4-f7c5-4eb5-9370-6ac10d6c891f",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the tax region
`data[attributes][strategy]` | **String** <br>The strategy to apply. One of `add_to`, `replace`, `compound`
`data[attributes][default]` | **Boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`data[attributes][tax_rates_attributes][]` | **Array** <br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax region



> How to delete a tax region with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/746a9696-b657-4f97-a7c5-0280393e9994' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=id,created_at,updated_at`


### Includes

This request does not accept any includes