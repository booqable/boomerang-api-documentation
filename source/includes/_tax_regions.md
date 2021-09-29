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
A tax regions has the following relationships:

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
      "id": "ecd09cb9-72c7-4952-a62b-426bc23ca189",
      "created_at": "2021-09-29T09:38:32+00:00",
      "updated_at": "2021-09-29T09:38:32+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/8d6e8b6d-fe17-4777-aa71-d8c381842b92?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8d6e8b6d-fe17-4777-aa71-d8c381842b92",
    "created_at": "2021-09-29T09:38:32+00:00",
    "updated_at": "2021-09-29T09:38:32+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "11db8062-2716-4d64-8501-4c52517c3327",
        "created_at": "2021-09-29T09:38:32+00:00",
        "updated_at": "2021-09-29T09:38:32+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8d6e8b6d-fe17-4777-aa71-d8c381842b92",
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
    "id": "f4c4b505-215c-4752-8d0d-e97783b48a46",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-09-29T09:38:32+00:00",
      "updated_at": "2021-09-29T09:38:32+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "fb6b8444-ac7b-4d8e-9f03-8c0ae350aefd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb6b8444-ac7b-4d8e-9f03-8c0ae350aefd",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T09:38:32+00:00",
        "updated_at": "2021-09-29T09:38:32+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "f4c4b505-215c-4752-8d0d-e97783b48a46",
        "owner_type": "TaxRegion"
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/f5dc750c-b4d1-47ac-a495-39df3d0545ff' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f5dc750c-b4d1-47ac-a495-39df3d0545ff",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "4ad25447-e1c8-4b74-8e25-287454b1ce42",
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
    "id": "f5dc750c-b4d1-47ac-a495-39df3d0545ff",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-09-29T09:38:33+00:00",
      "updated_at": "2021-09-29T09:38:33+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "a2d60ec5-3ab0-48f2-b739-7c8fe4ce5588"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a2d60ec5-3ab0-48f2-b739-7c8fe4ce5588",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T09:38:33+00:00",
        "updated_at": "2021-09-29T09:38:33+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "f5dc750c-b4d1-47ac-a495-39df3d0545ff",
        "owner_type": "TaxRegion"
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/3ecf66ab-6786-4664-aaed-8a688f70f785' \
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