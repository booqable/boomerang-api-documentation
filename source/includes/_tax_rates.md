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
      "id": "84b9445c-6e56-4973-8a27-f03807fc99ac",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2022-04-08T17:53:39+00:00",
        "updated_at": "2022-04-08T17:53:39+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "51959de5-c64b-449d-a586-9d38f0932a40",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/51959de5-c64b-449d-a586-9d38f0932a40"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/eea4c46d-c0a8-478d-9588-0abccaa1d5d2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eea4c46d-c0a8-478d-9588-0abccaa1d5d2",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-04-08T17:53:39+00:00",
      "updated_at": "2022-04-08T17:53:39+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "37453c65-4043-468f-b5c2-afa64e24c02c",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/37453c65-4043-468f-b5c2-afa64e24c02c"
        },
        "data": {
          "type": "tax_regions",
          "id": "37453c65-4043-468f-b5c2-afa64e24c02c"
        }
      }
    }
  },
  "included": [
    {
      "id": "37453c65-4043-468f-b5c2-afa64e24c02c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-04-08T17:53:39+00:00",
        "updated_at": "2022-04-08T17:53:39+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=37453c65-4043-468f-b5c2-afa64e24c02c&filter[owner_type]=tax_regions"
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
          "owner_id": "0544bb5e-1b11-428b-8c8e-9c44d9e94d86",
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
    "id": "d6f18ca9-c5b3-463c-9c0a-06ec093cbd10",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-04-08T17:53:39+00:00",
      "updated_at": "2022-04-08T17:53:39+00:00",
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "0544bb5e-1b11-428b-8c8e-9c44d9e94d86",
      "owner_type": "tax_regions"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "0544bb5e-1b11-428b-8c8e-9c44d9e94d86"
        }
      }
    }
  },
  "included": [
    {
      "id": "0544bb5e-1b11-428b-8c8e-9c44d9e94d86",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2022-04-08T17:53:39+00:00",
        "updated_at": "2022-04-08T17:53:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/94685fdd-7a96-4e19-b867-c001449cc727' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "94685fdd-7a96-4e19-b867-c001449cc727",
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
    "id": "94685fdd-7a96-4e19-b867-c001449cc727",
    "type": "tax_rates",
    "attributes": {
      "created_at": "2022-04-08T17:53:40+00:00",
      "updated_at": "2022-04-08T17:53:40+00:00",
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "9bb80571-9d02-4081-a164-fc8928ce7953",
      "owner_type": "tax_categories"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "9bb80571-9d02-4081-a164-fc8928ce7953"
        }
      }
    }
  },
  "included": [
    {
      "id": "9bb80571-9d02-4081-a164-fc8928ce7953",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-04-08T17:53:40+00:00",
        "updated_at": "2022-04-08T17:53:40+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/c20805a3-1027-4442-bf9f-8b407b19d8d7' \
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