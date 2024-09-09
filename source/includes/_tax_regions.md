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
      "id": "4f7b9ea9-0f5a-45f3-8e3e-0fae918abbbc",
      "created_at": "2024-09-09T09:25:07.248365+00:00",
      "updated_at": "2024-09-09T09:25:07.251334+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/7287b2ae-9786-40ac-b37c-bde85d1fe6e1?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7287b2ae-9786-40ac-b37c-bde85d1fe6e1",
    "created_at": "2024-09-09T09:25:06.815900+00:00",
    "updated_at": "2024-09-09T09:25:06.818887+00:00",
    "archived": false,
    "archived_at": null,
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "41d0bd0e-fc0e-4eca-b96a-f6535b0d75bb",
        "created_at": "2024-09-09T09:25:06.817549+00:00",
        "updated_at": "2024-09-09T09:25:06.817549+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "7287b2ae-9786-40ac-b37c-bde85d1fe6e1",
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
    "id": "be067aef-0527-407f-92b6-ba2c2b64aa3d",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-09-09T09:25:05.943473+00:00",
      "updated_at": "2024-09-09T09:25:05.946170+00:00",
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
            "id": "e37ab35b-dc2d-48da-b70c-1e34787f04a0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e37ab35b-dc2d-48da-b70c-1e34787f04a0",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-09T09:25:05.944901+00:00",
        "updated_at": "2024-09-09T09:25:05.944901+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "be067aef-0527-407f-92b6-ba2c2b64aa3d",
        "owner_type": "tax_regions"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/fb38c48c-a3a1-4ece-8c1b-c4721c4d747f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fb38c48c-a3a1-4ece-8c1b-c4721c4d747f",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "b0664e86-b13a-4cdb-8d04-006e8c47af97",
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
    "id": "fb38c48c-a3a1-4ece-8c1b-c4721c4d747f",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-09-09T09:25:05.421898+00:00",
      "updated_at": "2024-09-09T09:25:05.458295+00:00",
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
            "id": "8ee23b7b-c4b6-4f33-a6f0-0a8a5d65bd0b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8ee23b7b-c4b6-4f33-a6f0-0a8a5d65bd0b",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-09T09:25:05.456995+00:00",
        "updated_at": "2024-09-09T09:25:05.456995+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "fb38c48c-a3a1-4ece-8c1b-c4721c4d747f",
        "owner_type": "tax_regions"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/cd09ec99-665c-4f14-a6be-2e20149ca2eb' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cd09ec99-665c-4f14-a6be-2e20149ca2eb",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-09-09T09:25:06.383248+00:00",
      "updated_at": "2024-09-09T09:25:06.397283+00:00",
      "archived": true,
      "archived_at": "2024-09-09T09:25:06.397283+00:00",
      "name": "Sales Tax (Deleted)",
      "strategy": "add_to",
      "default": false
    },
    "relationships": {}
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