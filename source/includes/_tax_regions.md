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
      "id": "4b13d094-741d-4ac4-94ea-4829113bf386",
      "created_at": "2024-06-24T09:25:02.334925+00:00",
      "updated_at": "2024-06-24T09:25:02.343317+00:00",
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






## Fetching a tax region



> How to fetch a tax regions with it's tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/bdfdcbcd-e3c7-46ba-83c7-2b5d0761ed30?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bdfdcbcd-e3c7-46ba-83c7-2b5d0761ed30",
    "created_at": "2024-06-24T09:25:02.934845+00:00",
    "updated_at": "2024-06-24T09:25:02.945177+00:00",
    "archived": false,
    "archived_at": null,
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "a58c1e97-9186-4401-a608-f693358b43ac",
        "created_at": "2024-06-24T09:25:02.939277+00:00",
        "updated_at": "2024-06-24T09:25:02.939277+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "bdfdcbcd-e3c7-46ba-83c7-2b5d0761ed30",
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
    "id": "9cfef3a8-21f5-479d-9c2c-908b06f7bc1a",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-06-24T09:25:03.662437+00:00",
      "updated_at": "2024-06-24T09:25:03.673856+00:00",
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
            "id": "033997cc-90d4-4c4f-9513-ae8b0c581278"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "033997cc-90d4-4c4f-9513-ae8b0c581278",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-24T09:25:03.667506+00:00",
        "updated_at": "2024-06-24T09:25:03.667506+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "9cfef3a8-21f5-479d-9c2c-908b06f7bc1a",
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






## Updating a tax region



> How to update a tax region with tax rates:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/a59e2dbf-de84-4727-913a-ad7802eaecf3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a59e2dbf-de84-4727-913a-ad7802eaecf3",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "de733449-a0c3-43c6-8765-10a99149e90c",
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
    "id": "a59e2dbf-de84-4727-913a-ad7802eaecf3",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-06-24T09:25:01.176592+00:00",
      "updated_at": "2024-06-24T09:25:01.258357+00:00",
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
            "id": "79be78eb-39b4-47d2-914e-b41f41ec84cd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "79be78eb-39b4-47d2-914e-b41f41ec84cd",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-06-24T09:25:01.254447+00:00",
        "updated_at": "2024-06-24T09:25:01.254447+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "a59e2dbf-de84-4727-913a-ad7802eaecf3",
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






## Deleting a tax region



> How to delete a tax region with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_regions/4cc4c810-95de-48a0-831c-ebc89539bb73' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4cc4c810-95de-48a0-831c-ebc89539bb73",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-06-24T09:25:01.803997+00:00",
      "updated_at": "2024-06-24T09:25:01.850224+00:00",
      "archived": true,
      "archived_at": "2024-06-24T09:25:01.850224+00:00",
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