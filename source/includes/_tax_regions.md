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
      "id": "ec096dc1-4ab9-4f7d-89b4-de34377bb411",
      "created_at": "2024-09-23T09:22:54.115968+00:00",
      "updated_at": "2024-09-23T09:22:54.119961+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/8e9a79a3-ef69-453c-8e63-ffb953028c7b?include=tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8e9a79a3-ef69-453c-8e63-ffb953028c7b",
    "created_at": "2024-09-23T09:22:55.004607+00:00",
    "updated_at": "2024-09-23T09:22:55.008049+00:00",
    "archived": false,
    "archived_at": null,
    "name": "Sales Tax",
    "strategy": "add_to",
    "default": false,
    "tax_rates": [
      {
        "id": "bffd1de6-e0c0-41f1-af29-e2c45412697c",
        "created_at": "2024-09-23T09:22:55.006605+00:00",
        "updated_at": "2024-09-23T09:22:55.006605+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8e9a79a3-ef69-453c-8e63-ffb953028c7b",
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
    "id": "aa7083d8-cdc1-4f7a-942e-666504c6858f",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-09-23T09:22:54.568922+00:00",
      "updated_at": "2024-09-23T09:22:54.571687+00:00",
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
            "id": "3d872701-8a5d-4710-9a12-c43cd543d779"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3d872701-8a5d-4710-9a12-c43cd543d779",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-23T09:22:54.570365+00:00",
        "updated_at": "2024-09-23T09:22:54.570365+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "aa7083d8-cdc1-4f7a-942e-666504c6858f",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/67ce91d9-51ea-4003-9054-895a291f11db' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "67ce91d9-51ea-4003-9054-895a291f11db",
        "type": "tax_regions",
        "attributes": {
          "name": "State Tax",
          "tax_rates_attributes": [
            {
              "name": "VAT",
              "value": 9
            },
            {
              "id": "1426346e-ce32-4c9c-911a-de1490e911a1",
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
    "id": "67ce91d9-51ea-4003-9054-895a291f11db",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-09-23T09:22:53.642762+00:00",
      "updated_at": "2024-09-23T09:22:53.683581+00:00",
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
            "id": "fb7f63d5-f2f9-4bbb-8f73-2839f38ec57a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb7f63d5-f2f9-4bbb-8f73-2839f38ec57a",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-09-23T09:22:53.682200+00:00",
        "updated_at": "2024-09-23T09:22:53.682200+00:00",
        "name": "VAT",
        "value": 9.0,
        "position": 2,
        "owner_id": "67ce91d9-51ea-4003-9054-895a291f11db",
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
    --url 'https://example.booqable.com/api/boomerang/tax_regions/0b604086-8409-43ee-8900-4fc9549aecb8' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0b604086-8409-43ee-8900-4fc9549aecb8",
    "type": "tax_regions",
    "attributes": {
      "created_at": "2024-09-23T09:22:55.441845+00:00",
      "updated_at": "2024-09-23T09:22:55.458072+00:00",
      "archived": true,
      "archived_at": "2024-09-23T09:22:55.458072+00:00",
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