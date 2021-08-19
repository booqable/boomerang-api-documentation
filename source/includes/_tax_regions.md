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
      "id": "9ef6f29d-5cda-43f8-8bb3-987ef87632ec",
      "created_at": "2021-08-19T12:09:27+00:00",
      "updated_at": "2021-08-19T12:09:27+00:00",
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-19T12:09:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/eb8bbd3c-fae8-4062-b2a9-f558cf95c564?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eb8bbd3c-fae8-4062-b2a9-f558cf95c564",
    "created_at": "2021-08-19T12:09:27+00:00",
    "updated_at": "2021-08-19T12:09:27+00:00",
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "6984cf18-f456-4a61-9c03-e78b0b739175",
        "created_at": "2021-08-19T12:09:27+00:00",
        "updated_at": "2021-08-19T12:09:27+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "eb8bbd3c-fae8-4062-b2a9-f558cf95c564",
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
                "temp-id": "84b65be1-d41c-4462-8ca6-bb91ddf41ad3",
                "type": "tax_rates",
                "method": "create"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "84b65be1-d41c-4462-8ca6-bb91ddf41ad3",
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
    "id": "6d59d4ff-11c2-42f4-8095-e912110b9ad0",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-08-19T12:09:27+00:00",
      "updated_at": "2021-08-19T12:09:27+00:00",
      "name": "Sales Tax",
      "strategy": "compound",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "21ff42cc-1310-4516-918c-e323a0d84c38"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "21ff42cc-1310-4516-918c-e323a0d84c38",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-19T12:09:27+00:00",
        "updated_at": "2021-08-19T12:09:27+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "6d59d4ff-11c2-42f4-8095-e912110b9ad0",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "84b65be1-d41c-4462-8ca6-bb91ddf41ad3"
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/0b635199-39d3-4216-b8f0-f160458cbb4b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0b635199-39d3-4216-b8f0-f160458cbb4b",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax"
        },
        "relationships": {
          "tax_rates": {
            "data": [
              {
                "temp-id": "737d339b-2948-4a48-bcaf-455981ee5be9",
                "type": "tax_rates",
                "method": "create"
              },
              {
                "id": "9786ccb5-e747-4643-8410-b9f759a6ac9e",
                "type": "tax_rates",
                "method": "destroy"
              }
            ]
          }
        }
      },
      "included": [
        {
          "temp-id": "737d339b-2948-4a48-bcaf-455981ee5be9",
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
    "id": "0b635199-39d3-4216-b8f0-f160458cbb4b",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2021-08-19T12:09:27+00:00",
      "updated_at": "2021-08-19T12:09:27+00:00",
      "name": "State Tax",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {
      "tax_rates": {
        "data": [
          {
            "type": "tax_rates",
            "id": "d54dc1fb-9718-4f78-b975-792ee438cf8c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d54dc1fb-9718-4f78-b975-792ee438cf8c",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-08-19T12:09:27+00:00",
        "updated_at": "2021-08-19T12:09:27+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "0b635199-39d3-4216-b8f0-f160458cbb4b",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "meta": {
            "included": false
          }
        }
      },
      "temp-id": "737d339b-2948-4a48-bcaf-455981ee5be9"
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/de8f0a11-c325-4ff6-8dd8-f46d750274b0' \
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