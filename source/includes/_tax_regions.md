# Tax regions

You can create tax regions for specific customers. Booqable's tax system supports adding, replacing and compounding rates.
A regional tax rate can have one of the following rate types:

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
For tax regions you can include the following relationships:

Name | Description
- | -
`tax_rates` | **Tax rates**<br>Associated Tax rates


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
      "id": "af3b4a38-6ce5-45d2-8788-478b0eeb9819",
      "created_at": "2021-08-10T10:19:37+00:00",
      "updated_at": "2021-08-10T10:19:37+00:00",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-10T10:19:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/05271541-b6c5-4d19-b7ea-d8531d5290ea?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "05271541-b6c5-4d19-b7ea-d8531d5290ea",
    "created_at": "2021-08-10T10:19:37+00:00",
    "updated_at": "2021-08-10T10:19:37+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "a7c60999-a9aa-4ef2-8a2e-c7663482c0d0",
        "created_at": "2021-08-10T10:19:37+00:00",
        "updated_at": "2021-08-10T10:19:37+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "05271541-b6c5-4d19-b7ea-d8531d5290ea",
        "owner_type": "TaxRegion"
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
          "strategy": "compound"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "0fb01c1f-11a9-4b86-b3a2-3d38ec2a6a68",
                "type": "tax_rates",
                "method": "create"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "0fb01c1f-11a9-4b86-b3a2-3d38ec2a6a68",
          "type": "tax_rates",
          "attributes": {
            "name": "VAT",
            "value": 21
          }
        }
      ],
      "include": "tax_rates"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "62b4d9e7-96d5-423c-9027-9d0d903d24a4",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-08-10T10:19:38+00:00",
      "updated_at": "2021-08-10T10:19:38+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "0f1c3d24-02c5-4db4-848d-510f1d616e0d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0f1c3d24-02c5-4db4-848d-510f1d616e0d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-10T10:19:38+00:00",
        "updated_at": "2021-08-10T10:19:38+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "62b4d9e7-96d5-423c-9027-9d0d903d24a4",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "0fb01c1f-11a9-4b86-b3a2-3d38ec2a6a68"
    }
  ],
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
`data[attributes][tax_rates_attributes[]]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax region

> How to update a tax region with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/926e6f53-9548-41b7-a6c6-f32cfb7a1efe' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "926e6f53-9548-41b7-a6c6-f32cfb7a1efe",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "188088b6-321b-4c14-8d6f-2a8f242a8a35",
                "type": "tax_rates",
                "method": "create"
              },
              {
                "id": "bbbe3593-4904-4950-a2b7-0c64ae42e172",
                "type": "tax_rates",
                "method": "destroy"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "188088b6-321b-4c14-8d6f-2a8f242a8a35",
          "type": "tax_rates",
          "attributes": {
            "name": "VAT",
            "value": 9
          }
        }
      ],
      "include": "tax_rates"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "926e6f53-9548-41b7-a6c6-f32cfb7a1efe",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-08-10T10:19:38+00:00",
      "updated_at": "2021-08-10T10:19:38+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "624e2147-fbcc-4d88-9b6b-464d49227f22"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "624e2147-fbcc-4d88-9b6b-464d49227f22",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-10T10:19:38+00:00",
        "updated_at": "2021-08-10T10:19:38+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "926e6f53-9548-41b7-a6c6-f32cfb7a1efe",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "188088b6-321b-4c14-8d6f-2a8f242a8a35"
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
`data[attributes][tax_rates_attributes[]]` | **Array**<br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax region

> How to delete a tax region with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/4d2cba10-5b68-4cea-9808-e5c247f6383f' \
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