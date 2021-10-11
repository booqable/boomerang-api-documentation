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
      "id": "613cb1db-9af3-408d-8051-7d4a95c5ce10",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-10-11T12:48:33+00:00",
        "updated_at": "2021-10-11T12:48:33+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "794d0597-571d-4b1c-b827-ff15393e54ef",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/794d0597-571d-4b1c-b827-ff15393e54ef"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-11T12:48:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9d46ff0a-5694-4838-835d-15baa5ec557e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9d46ff0a-5694-4838-835d-15baa5ec557e",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-11T12:48:33+00:00",
      "updated_at": "2021-10-11T12:48:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "3b8bd877-4dbb-4e18-89ba-0594f19acdbf",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/3b8bd877-4dbb-4e18-89ba-0594f19acdbf"
        },
        "data": {
          "type": "tax_regions",
          "id": "3b8bd877-4dbb-4e18-89ba-0594f19acdbf"
        }
      }
    }
  },
  "included": [
    {
      "id": "3b8bd877-4dbb-4e18-89ba-0594f19acdbf",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-11T12:48:33+00:00",
        "updated_at": "2021-10-11T12:48:33+00:00",
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=3b8bd877-4dbb-4e18-89ba-0594f19acdbf&filter[owner_type]=TaxRegion"
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
          "owner_id": "8aa49028-4929-4376-90eb-d8ef2b55d996",
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
    "id": "7d3aa55e-7da1-466d-90f6-0cca0259a2fd",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-11T12:48:33+00:00",
      "updated_at": "2021-10-11T12:48:33+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "8aa49028-4929-4376-90eb-d8ef2b55d996",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "8aa49028-4929-4376-90eb-d8ef2b55d996"
        }
      }
    }
  },
  "included": [
    {
      "id": "8aa49028-4929-4376-90eb-d8ef2b55d996",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2021-10-11T12:48:33+00:00",
        "updated_at": "2021-10-11T12:48:33+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/b89b1cfc-0738-4aeb-a878-ea96b9a9a12c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b89b1cfc-0738-4aeb-a878-ea96b9a9a12c",
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
    "id": "b89b1cfc-0738-4aeb-a878-ea96b9a9a12c",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2021-10-11T12:48:34+00:00",
      "updated_at": "2021-10-11T12:48:34+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "a328960f-f961-4b82-ac81-d6695563babb",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "a328960f-f961-4b82-ac81-d6695563babb"
        }
      }
    }
  },
  "included": [
    {
      "id": "a328960f-f961-4b82-ac81-d6695563babb",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-10-11T12:48:34+00:00",
        "updated_at": "2021-10-11T12:48:34+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9c1b119c-4380-4eaf-a8a2-c4049d548a2e' \
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