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
      "id": "9df92766-fa02-49a5-9762-7178081b0aa0",
      "created_at": "2021-09-29T15:35:40+00:00",
      "updated_at": "2021-09-29T15:35:40+00:00",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-29T15:35:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/60e3a433-6fd2-408b-8245-84b443884529?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "60e3a433-6fd2-408b-8245-84b443884529",
    "created_at": "2021-09-29T15:35:40+00:00",
    "updated_at": "2021-09-29T15:35:40+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "1088f495-b855-4162-a772-5ed8e5bc2ff3",
        "created_at": "2021-09-29T15:35:40+00:00",
        "updated_at": "2021-09-29T15:35:40+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "60e3a433-6fd2-408b-8245-84b443884529",
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
    "id": "bc4a6552-1c23-48dc-9f30-09b4330547e4",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-09-29T15:35:41+00:00",
      "updated_at": "2021-09-29T15:35:41+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "49ba04e0-777f-4fde-b9f0-ed5d5b4ccb8a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "49ba04e0-777f-4fde-b9f0-ed5d5b4ccb8a",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T15:35:41+00:00",
        "updated_at": "2021-09-29T15:35:41+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "bc4a6552-1c23-48dc-9f30-09b4330547e4",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/584ad559-0cd8-486c-8089-d0d6bae14c6b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "584ad559-0cd8-486c-8089-d0d6bae14c6b",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "dbbf8112-c93b-4785-88e3-c3d155f3c187",
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
    "id": "584ad559-0cd8-486c-8089-d0d6bae14c6b",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-09-29T15:35:41+00:00",
      "updated_at": "2021-09-29T15:35:41+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "2d793fe2-358c-4b58-b157-541160b2793d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2d793fe2-358c-4b58-b157-541160b2793d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-29T15:35:41+00:00",
        "updated_at": "2021-09-29T15:35:41+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "584ad559-0cd8-486c-8089-d0d6bae14c6b",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/1e430b15-6f81-48f2-bad6-afcfcccc6184' \
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