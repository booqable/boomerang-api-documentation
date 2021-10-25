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
      "id": "85d6e6df-13a9-4496-a003-b4a8b182462b",
      "type": "tax_rates",
      "attributes": {
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "e827e449-62f4-48ba-931a-91be8b16ff45",
        "owner_type": "TaxRegion"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/tax_regions/e827e449-62f4-48ba-931a-91be8b16ff45"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/tax_rates?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-21T11:39:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/ee12bd6b-ada3-49cd-9cb5-455a510bee80?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ee12bd6b-ada3-49cd-9cb5-455a510bee80",
    "type": "tax_rates",
    "attributes": {
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "ce5f8e5e-779e-4010-b4f8-3274b7aa5a24",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/tax_regions/ce5f8e5e-779e-4010-b4f8-3274b7aa5a24"
        },
        "data": {
          "type": "tax_regions",
          "id": "ce5f8e5e-779e-4010-b4f8-3274b7aa5a24"
        }
      }
    }
  },
  "included": [
    {
      "id": "ce5f8e5e-779e-4010-b4f8-3274b7aa5a24",
      "type": "tax_regions",
      "attributes": {
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "links": {
            "related": "api/boomerang/tax_rates?filter[owner_id]=ce5f8e5e-779e-4010-b4f8-3274b7aa5a24&filter[owner_type]=TaxRegion"
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
          "owner_id": "5a39c6f6-02d5-4260-bf2d-876a3e0c8c05",
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
    "id": "dbc88c43-8807-4e09-b9a5-9de648acf9ec",
    "type": "tax_rates",
    "attributes": {
      "name": "VAT",
      "value": 21.0,
      "position": 1,
      "owner_id": "5a39c6f6-02d5-4260-bf2d-876a3e0c8c05",
      "owner_type": "TaxRegion"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_regions",
          "id": "5a39c6f6-02d5-4260-bf2d-876a3e0c8c05"
        }
      }
    }
  },
  "included": [
    {
      "id": "5a39c6f6-02d5-4260-bf2d-876a3e0c8c05",
      "type": "tax_regions",
      "attributes": {
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
  "links": {
    "self": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=5a39c6f6-02d5-4260-bf2d-876a3e0c8c05&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=5a39c6f6-02d5-4260-bf2d-876a3e0c8c05&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_rates?data%5Battributes%5D%5Bname%5D=VAT&data%5Battributes%5D%5Bowner_id%5D=5a39c6f6-02d5-4260-bf2d-876a3e0c8c05&data%5Battributes%5D%5Bowner_type%5D=TaxRegion&data%5Battributes%5D%5Bvalue%5D=21&data%5Btype%5D=tax_rates&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/9feb6803-8e48-4322-9302-b8a429b51936' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9feb6803-8e48-4322-9302-b8a429b51936",
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
    "id": "9feb6803-8e48-4322-9302-b8a429b51936",
    "type": "tax_rates",
    "attributes": {
      "name": "Vat",
      "value": 9.0,
      "position": 1,
      "owner_id": "6da73f3e-d250-40c1-8c27-46b672691560",
      "owner_type": "TaxCategory"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "tax_categories",
          "id": "6da73f3e-d250-40c1-8c27-46b672691560"
        }
      }
    }
  },
  "included": [
    {
      "id": "6da73f3e-d250-40c1-8c27-46b672691560",
      "type": "tax_categories",
      "attributes": {
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
    --url 'https://example.booqable.com/api/boomerang/tax_rates/be91c4b4-de13-4ded-88b0-07a8a5e61ed8' \
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