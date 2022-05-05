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
      "id": "e9a272bf-7a96-4cec-967c-efe6865ce541",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-05-05T09:15:09+00:00",
        "updated_at": "2022-05-05T09:15:09+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "8a5b7807-d45f-4a26-8147-37da2f1e47e9",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/8a5b7807-d45f-4a26-8147-37da2f1e47e9"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/a4faece9-de25-4edd-b602-d487139c7897?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a4faece9-de25-4edd-b602-d487139c7897",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-05-05T09:15:09+00:00",
      "updated_at": "2022-05-05T09:15:09+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "42074073-14c5-4aed-9b88-ebb906a881cd",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/42074073-14c5-4aed-9b88-ebb906a881cd"
        },
        "data": {
          "type": "tax_regions",
          "id": "42074073-14c5-4aed-9b88-ebb906a881cd"
        }
      }
    }
  },
  "included": [
    {
      "id": "42074073-14c5-4aed-9b88-ebb906a881cd",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-05-05T09:15:09+00:00",
        "updated_at": "2022-05-05T09:15:09+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=42074073-14c5-4aed-9b88-ebb906a881cd&filter[owner_type]=tax_regions"
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
          "owner_id": "df6f7de3-e10d-4cbf-868e-e59073650c74",
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
    "id": "71939860-75ff-4c87-b9ec-81739484c38f",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-05-05T09:15:09+00:00",
      "updated_at": "2022-05-05T09:15:09+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "df6f7de3-e10d-4cbf-868e-e59073650c74",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "df6f7de3-e10d-4cbf-868e-e59073650c74"
        }
      }
    }
  },
  "included": [
    {
      "id": "df6f7de3-e10d-4cbf-868e-e59073650c74",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-05-05T09:15:09+00:00",
        "updated_at": "2022-05-05T09:15:09+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/bad5ba22-139f-4262-868f-8070f5929089' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bad5ba22-139f-4262-868f-8070f5929089",
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
    "id": "bad5ba22-139f-4262-868f-8070f5929089",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-05-05T09:15:09+00:00",
      "updated_at": "2022-05-05T09:15:09+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "429e5a6a-fd4d-4e54-88ed-a22a72fc15e2",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "429e5a6a-fd4d-4e54-88ed-a22a72fc15e2"
        }
      }
    }
  },
  "included": [
    {
      "id": "429e5a6a-fd4d-4e54-88ed-a22a72fc15e2",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-05-05T09:15:09+00:00",
        "updated_at": "2022-05-05T09:15:09+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/376a44a7-1c6c-4522-b6d2-650b1f51413b' \
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