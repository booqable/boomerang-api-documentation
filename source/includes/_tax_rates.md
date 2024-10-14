# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions) or [TaxCategory](#tax_categories). Tax rates define the individual rates that will be taxed.

## Endpoints
`GET api/boomerang/tax_rates`

`GET /api/boomerang/tax_rates/{id}`

`POST /api/boomerang/tax_rates`

`PUT /api/boomerang/tax_rates/{id}`

`DELETE /api/boomerang/tax_rates/{id}`

## Fields
Every tax rate has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>The name of the tax rate
`value` | **Float** <br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


## Relationships
Tax rates have the following relationships:

Name | Description
-- | --
`owner` | **Tax category, Tax region** <br>Associated Owner


## Listing tax rates



> How to fetch a list of tax rates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67cfbcb5-e4e8-49bc-a478-4f0555d18f65",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2024-10-14T09:26:11.966673+00:00",
        "updated_at": "2024-10-14T09:26:11.966673+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "75b0a02d-8f4f-4bd2-999d-c6de145d5964",
        "owner_type": "tax_regions"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`
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
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/444458f1-e0c2-4e4f-8e3e-a99a31cf3c3a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "444458f1-e0c2-4e4f-8e3e-a99a31cf3c3a",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-14T09:26:13.296469+00:00",
      "updated_at": "2024-10-14T09:26:13.296469+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "765bb8b1-77de-4b03-8997-a2fb7e41c96d",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "765bb8b1-77de-4b03-8997-a2fb7e41c96d"
        }
      }
    }
  },
  "included": [
    {
      "id": "765bb8b1-77de-4b03-8997-a2fb7e41c96d",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-14T09:26:13.290214+00:00",
        "updated_at": "2024-10-14T09:26:13.297768+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`owner`






## Creating a tax rate



> How to create a tax rate and associate it with an owner:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/tax_rates' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "tax_rates",
        "attributes": {
          "name": "VAT",
          "value": 21,
          "owner_id": "625efad9-32bb-4961-a8af-297ce5724014",
          "owner_type": "tax_regions"
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "91c0cfcf-060f-4ce2-89fd-ff23c2d07442",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-14T09:26:12.439931+00:00",
      "updated_at": "2024-10-14T09:26:12.439931+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "625efad9-32bb-4961-a8af-297ce5724014",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "625efad9-32bb-4961-a8af-297ce5724014"
        }
      }
    }
  },
  "included": [
    {
      "id": "625efad9-32bb-4961-a8af-297ce5724014",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2024-10-14T09:26:12.422186+00:00",
        "updated_at": "2024-10-14T09:26:12.441239+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>The name of the tax rate
`data[attributes][value]` | **Float** <br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/2199fa1a-fce0-4efa-b20a-1462c04b75e9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2199fa1a-fce0-4efa-b20a-1462c04b75e9",
        "type": "tax_rates",
        "attributes": {
          "value": 9
        }
      },
      "include": "owner"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2199fa1a-fce0-4efa-b20a-1462c04b75e9",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-14T09:26:12.846911+00:00",
      "updated_at": "2024-10-14T09:26:12.865859+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "7e7a4979-e464-4c31-9995-bca8d2521be4",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "7e7a4979-e464-4c31-9995-bca8d2521be4"
        }
      }
    }
  },
  "included": [
    {
      "id": "7e7a4979-e464-4c31-9995-bca8d2521be4",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2024-10-14T09:26:12.837631+00:00",
        "updated_at": "2024-10-14T09:26:12.867124+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>The name of the tax rate
`data[attributes][value]` | **Float** <br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/d6385205-0cda-4b9c-9ba3-faecee0c633c' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d6385205-0cda-4b9c-9ba3-faecee0c633c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2024-10-14T09:26:11.416283+00:00",
      "updated_at": "2024-10-14T09:26:11.416283+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "c93bf109-6c33-4b97-b8e9-cc34889525ab",
      "owner_type": "tax_regions"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request does not accept any includes