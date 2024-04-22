# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields`

`DELETE /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields/{id}`

`PUT /api/boomerang/checkout_fields/{id}`

## Fields
Every checkout field has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the field, will be shown as a field label in the checkout
`required` | **Boolean** <br>Whether the field required to complete checkout
`position` | **Integer** <br>Used to determine sorting relative to other checkout fields
`default_property_id` | **Uuid** <br>The associated Default property


## Relationships
Checkout fields have the following relationships:

Name | Description
-- | --
`default_property` | **Default properties** `readonly`<br>Associated Default property


## Creating a checkout field



> How to create a checkout field:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "checkout_fields",
        "attributes": {
          "name": "Special requests",
          "default_property_id": "95c5265c-e59a-4b86-a997-0577b0aa1c87"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "01ea9315-720b-45de-8c89-c7c950422e9b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-22T09:24:16+00:00",
      "updated_at": "2024-04-22T09:24:16+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "95c5265c-e59a-4b86-a997-0577b0aa1c87"
    },
    "relationships": {
      "default_property": {
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

`POST /api/boomerang/checkout_fields`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the field, will be shown as a field label in the checkout
`data[attributes][position]` | **Integer** <br>Used to determine sorting relative to other checkout fields
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property


### Includes

This request accepts the following includes:

`default_property`






## Listing checkout fields



> How to fetch a list of checkout fields:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4792ae9b-998b-4a65-a5da-b8c46db0117e",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-04-22T09:24:17+00:00",
        "updated_at": "2024-04-22T09:24:17+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "42b2e0da-07d1-4295-9962-bc8eaf65ff7a"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/42b2e0da-07d1-4295-9962-bc8eaf65ff7a"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/checkout_fields`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`
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
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`required` | **Boolean** <br>`eq`
`default_property_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/4bb04ef3-065a-4a03-839e-1a74a0f4b470' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4bb04ef3-065a-4a03-839e-1a74a0f4b470",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-22T09:24:17+00:00",
      "updated_at": "2024-04-22T09:24:17+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "5e6f2474-6144-4076-a8be-61fb506fda29"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/5e6f2474-6144-4076-a8be-61fb506fda29"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/checkout_fields/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/a07a74de-96ed-4810-ba65-c810c5175e8d?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a07a74de-96ed-4810-ba65-c810c5175e8d",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-22T09:24:18+00:00",
      "updated_at": "2024-04-22T09:24:18+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "efd00a89-0c67-4d59-b5c5-133eb3909075"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/efd00a89-0c67-4d59-b5c5-133eb3909075"
        },
        "data": {
          "type": "default_properties",
          "id": "efd00a89-0c67-4d59-b5c5-133eb3909075"
        }
      }
    }
  },
  "included": [
    {
      "id": "efd00a89-0c67-4d59-b5c5-133eb3909075",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-04-22T09:24:18+00:00",
        "updated_at": "2024-04-22T09:24:18+00:00",
        "name": "Default Property 5",
        "identifier": "default_property_5",
        "position": 1,
        "property_type": "text_field",
        "show_on": [],
        "validation_required": false,
        "owner_type": "orders",
        "select_options": [],
        "editable": true
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/checkout_fields/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`default_property`






## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/b3473866-8784-4be2-87ff-0a775af2c49c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b3473866-8784-4be2-87ff-0a775af2c49c",
        "type": "checkout_fields",
        "attributes": {
          "name": "Additional information"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b3473866-8784-4be2-87ff-0a775af2c49c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-22T09:24:18+00:00",
      "updated_at": "2024-04-22T09:24:18+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "132cee6c-b5e8-42b7-ae75-cb9cfa82c132"
    },
    "relationships": {
      "default_property": {
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

`PUT /api/boomerang/checkout_fields/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the field, will be shown as a field label in the checkout
`data[attributes][position]` | **Integer** <br>Used to determine sorting relative to other checkout fields
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property


### Includes

This request accepts the following includes:

`default_property`





