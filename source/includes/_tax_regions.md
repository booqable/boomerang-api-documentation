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
      "id": "2b4a62e0-6548-4d86-89b7-2816803756db",
      "created_at": "2021-09-17T09:18:11+00:00",
      "updated_at": "2021-09-17T09:18:11+00:00",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-17T09:17:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/31215c12-fece-4a78-a63d-b6c898a79a8e?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "31215c12-fece-4a78-a63d-b6c898a79a8e",
    "created_at": "2021-09-17T09:18:11+00:00",
    "updated_at": "2021-09-17T09:18:11+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "046696fe-7f4f-4c6b-acf6-749e5937f3be",
        "created_at": "2021-09-17T09:18:11+00:00",
        "updated_at": "2021-09-17T09:18:11+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "31215c12-fece-4a78-a63d-b6c898a79a8e",
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
    "id": "a4c02977-d06d-4353-beb2-32bf6595bf05",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-09-17T09:18:11+00:00",
      "updated_at": "2021-09-17T09:18:11+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "c134ef69-c572-4468-90c5-612b3b8d5c92"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c134ef69-c572-4468-90c5-612b3b8d5c92",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-17T09:18:11+00:00",
        "updated_at": "2021-09-17T09:18:11+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "a4c02977-d06d-4353-beb2-32bf6595bf05",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/a8e301a7-db14-447c-90f9-dcf5426d4b0f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a8e301a7-db14-447c-90f9-dcf5426d4b0f",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "568ecc29-e3a8-44e7-9298-ad30d944d53c",
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
    "id": "a8e301a7-db14-447c-90f9-dcf5426d4b0f",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-09-17T09:18:11+00:00",
      "updated_at": "2021-09-17T09:18:12+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "e15d9393-6b63-466b-b59a-869d7fd299ec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e15d9393-6b63-466b-b59a-869d7fd299ec",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-09-17T09:18:12+00:00",
        "updated_at": "2021-09-17T09:18:12+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "a8e301a7-db14-447c-90f9-dcf5426d4b0f",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/3259781d-4716-4410-a798-590d5ad4089b' \
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