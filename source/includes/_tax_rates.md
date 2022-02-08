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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>The name of the tax rate
`value` | **Float**<br>The percentage value of the rate
`position` | **Integer** `readonly`<br>Position of the tax rate
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


## Relationships
Tax rates have the following relationships:

Name | Description
- | -
`owner` | **Tax category, Tax region**<br>Associated Owner


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
      "id": "80c5ba5c-18af-4e1f-b762-329b218c50ad",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-02-08T09:14:52+00:00",
        "updated_at": "2022-02-08T09:14:52+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "50f7dd0e-0d33-4e2f-bd5f-941d19efd13d",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/50f7dd0e-0d33-4e2f-bd5f-941d19efd13d"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/tax_rates`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a tax rate



> How to fetch a tax rate:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/91e0dd97-4df5-411c-b7d5-d699ec3e2f97?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "91e0dd97-4df5-411c-b7d5-d699ec3e2f97",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-02-08T09:14:52+00:00",
      "updated_at": "2022-02-08T09:14:52+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "fb39e7e9-1fec-4e73-b547-24c69eb519da",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/fb39e7e9-1fec-4e73-b547-24c69eb519da"
        },
        "data": {
          "type": "tax_regions",
          "id": "fb39e7e9-1fec-4e73-b547-24c69eb519da"
        }
      }
    }
  },
  "included": [
    {
      "id": "fb39e7e9-1fec-4e73-b547-24c69eb519da",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-02-08T09:14:52+00:00",
        "updated_at": "2022-02-08T09:14:52+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=fb39e7e9-1fec-4e73-b547-24c69eb519da&filter[owner_type]=tax_regions"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


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
          "owner_id": "af58dec0-644b-41bc-8853-db42befd39e8",
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
    "id": "305d1277-60ea-4138-8e45-214dca403175",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-02-08T09:14:53+00:00",
      "updated_at": "2022-02-08T09:14:53+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "af58dec0-644b-41bc-8853-db42befd39e8",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "af58dec0-644b-41bc-8853-db42befd39e8"
        }
      }
    }
  },
  "included": [
    {
      "id": "af58dec0-644b-41bc-8853-db42befd39e8",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-02-08T09:14:53+00:00",
        "updated_at": "2022-02-08T09:14:53+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
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
    }
  ],
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/tax_rates`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>The name of the tax rate
`data[attributes][value]` | **Float**<br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate



> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/219ffb93-ba59-48a3-8089-9051bac235ce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "219ffb93-ba59-48a3-8089-9051bac235ce",
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
    "id": "219ffb93-ba59-48a3-8089-9051bac235ce",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-02-08T09:14:53+00:00",
      "updated_at": "2022-02-08T09:14:53+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "41f53c6e-4f3c-4521-a2fc-3eea39f24ac6",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "41f53c6e-4f3c-4521-a2fc-3eea39f24ac6"
        }
      }
    }
  },
  "included": [
    {
      "id": "41f53c6e-4f3c-4521-a2fc-3eea39f24ac6",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-02-08T09:14:53+00:00",
        "updated_at": "2022-02-08T09:14:53+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
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

`PUT /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>The name of the tax rate
`data[attributes][value]` | **Float**<br>The percentage value of the rate
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `tax_regions`, `tax_categories`


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate



> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ec8cdd6f-b96f-4c13-a6b9-b5d0570e0777' \
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

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_rates]=id,created_at,updated_at`


### Includes

This request does not accept any includes