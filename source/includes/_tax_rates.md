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
`owner_type` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


## Relationships
A tax rates has the following relationships:

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
      "id": "4897d7ae-643e-4789-97ba-8b539ed65d1a",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-07T08:41:31+00:00",
        "updated_at": "2021-10-07T08:41:31+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8fbf3eb3-51dc-45e6-995b-32e238ab572a",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/8fbf3eb3-51dc-45e6-995b-32e238ab572a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-07T08:41:01Z`
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
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ad032004-5022-4682-9c4f-256cd26c8a49?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ad032004-5022-4682-9c4f-256cd26c8a49",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-07T08:41:31+00:00",
      "updated_at": "2021-10-07T08:41:31+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0e55bb0f-4eee-40af-bdb9-cf7ed2394c70",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/0e55bb0f-4eee-40af-bdb9-cf7ed2394c70"
        },
        "data": {
          "type": "tax_regions",
          "id": "0e55bb0f-4eee-40af-bdb9-cf7ed2394c70"
        }
      }
    }
  },
  "included": [
    {
      "id": "0e55bb0f-4eee-40af-bdb9-cf7ed2394c70",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-07T08:41:31+00:00",
        "updated_at": "2021-10-07T08:41:31+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=0e55bb0f-4eee-40af-bdb9-cf7ed2394c70&filter[owner_type]=TaxRegion"
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
          "owner_id": "076cb3d0-2ea9-489d-8088-2497f029e431",
          "owner_type": "TaxRegion"
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "712f6513-3775-4652-9215-13f44e7e1773",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-07T08:41:31+00:00",
      "updated_at": "2021-10-07T08:41:31+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "076cb3d0-2ea9-489d-8088-2497f029e431",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "076cb3d0-2ea9-489d-8088-2497f029e431"
        }
      }
    }
  },
  "included": [
    {
      "id": "076cb3d0-2ea9-489d-8088-2497f029e431",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-07T08:41:31+00:00",
        "updated_at": "2021-10-07T08:41:31+00:00",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


### Includes

This request accepts the following includes:

`owner`






## Updating a tax rate

> How to update a tax rate:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/bd871287-fca7-46e5-a5a2-bb3ccf23ef6c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bd871287-fca7-46e5-a5a2-bb3ccf23ef6c",
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
    "id": "bd871287-fca7-46e5-a5a2-bb3ccf23ef6c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-07T08:41:31+00:00",
      "updated_at": "2021-10-07T08:41:31+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "b2608ee2-d3e3-4cdf-8cb0-8fe6db65eb9d",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "b2608ee2-d3e3-4cdf-8cb0-8fe6db65eb9d"
        }
      }
    }
  },
  "included": [
    {
      "id": "b2608ee2-d3e3-4cdf-8cb0-8fe6db65eb9d",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-10-07T08:41:31+00:00",
        "updated_at": "2021-10-07T08:41:31+00:00",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner (e.g. `TaxRegion`)


### Includes

This request accepts the following includes:

`owner`






## Deleting a tax rate

> How to delete a tax rate:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/tax_rates/5a937dbe-2d76-49c6-bf2c-e18f1d89dbce' \
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