# Tax regions

You can create tax regions for specific customers. Booqable's tax system supports adding, replacing and compounding rates.
A tax region can have one of the following strategies:

- **Add to**: Each tax rate is calculated over the order total and individually added or substracted to/from the order total.
- **Compound**: The tax is calculated over the order total, including product taxes (tax over tax). This method is used in some countries like Canada.
- **Replace**: Removes product taxes and calculates tax over the order total.

## Endpoints
`GET /api/boomerang/tax_regions/{id}`

`POST /api/boomerang/tax_regions`

`GET /api/boomerang/tax_regions`

`DELETE /api/boomerang/tax_regions/{id}`

`PUT /api/boomerang/tax_regions/{id}`

## Fields
Every tax region has the following fields:

Name | Description
-- | --
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
-- | --
`tax_rates` | **Tax rates** `readonly`<br>Associated Tax rates


## Fetching a tax region



> How to fetch a tax regions with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/152efadb-eca3-48da-844a-693d7f316e51?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "152efadb-eca3-48da-844a-693d7f316e51",
    "created_at": "2024-05-27T09:30:19.452189+00:00",
    "updated_at": "2024-05-27T09:30:19.459723+00:00",
    "archived": false,
    "archived_at": null,
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "4e1af776-817b-4a9b-8e4f-dce5b6bd45eb",
        "created_at": "2024-05-27T09:30:19.455768+00:00",
        "updated_at": "2024-05-27T09:30:19.455768+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "152efadb-eca3-48da-844a-693d7f316e51",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`


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
    "id": "89e9cddd-498b-4830-92b8-06de78684b79",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-05-27T09:30:20.233971+00:00",
      "updated_at": "2024-05-27T09:30:20.244305+00:00",
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
            "id": "206a72d9-80bd-4e04-83f1-c08d0438f386"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "206a72d9-80bd-4e04-83f1-c08d0438f386",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-27T09:30:20.238573+00:00",
        "updated_at": "2024-05-27T09:30:20.238573+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "89e9cddd-498b-4830-92b8-06de78684b79",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the tax region
`data[attributes][strategy]` | **String** <br>The strategy to apply. One of `add_to`, `replace`, `compound`
`data[attributes][default]` | **Boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`data[attributes][tax_rates_attributes][]` | **Array** <br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`






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
      "id": "44e1d16a-663a-4d1f-9d46-e5775efdb285",
      "created_at": "2024-05-27T09:30:21.225174+00:00",
      "updated_at": "2024-05-27T09:30:21.233604+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`strategy` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax region



> How to delete a tax region with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/25416cbb-03d4-4002-8999-4b2aad165d40' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "25416cbb-03d4-4002-8999-4b2aad165d40",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-05-27T09:30:21.892041+00:00",
      "updated_at": "2024-05-27T09:30:21.938300+00:00",
      "archived": true,
      "archived_at": "2024-05-27T09:30:21.938300+00:00",
      "name": "Sales Tax (Deleted)",
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
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
## Updating a tax region



> How to update a tax region with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/a77aeafc-3a7d-4488-a9a6-6c61e6895e9a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a77aeafc-3a7d-4488-a9a6-6c61e6895e9a",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "38c5de22-3032-44bd-9b0e-7abdb60f4e56",
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
    "id": "a77aeafc-3a7d-4488-a9a6-6c61e6895e9a",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-05-27T09:30:22.709885+00:00",
      "updated_at": "2024-05-27T09:30:22.796051+00:00",
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
            "id": "1f53bb56-7791-402b-a1c4-33f50ae91053"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1f53bb56-7791-402b-a1c4-33f50ae91053",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-05-27T09:30:22.791754+00:00",
        "updated_at": "2024-05-27T09:30:22.791754+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "a77aeafc-3a7d-4488-a9a6-6c61e6895e9a",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=tax_rates`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the tax region
`data[attributes][strategy]` | **String** <br>The strategy to apply. One of `add_to`, `replace`, `compound`
`data[attributes][default]` | **Boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`
`data[attributes][tax_rates_attributes][]` | **Array** <br>The tax rates to associate


### Includes

This request accepts the following includes:

`tax_rates`





