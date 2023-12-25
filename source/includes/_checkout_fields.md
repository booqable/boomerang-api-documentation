# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`POST /api/boomerang/checkout_fields`

`PUT /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields`

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
          "default_property_id": "8b6a2ac4-5d5e-4bd8-9c2d-460e7c119741"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "427b1721-f9e9-4374-9ae9-390179a177f7",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-25T09:14:04+00:00",
      "updated_at": "2023-12-25T09:14:04+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "8b6a2ac4-5d5e-4bd8-9c2d-460e7c119741"
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






## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/fb450a4b-5bdd-4746-8ffd-a484930b5a55' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fb450a4b-5bdd-4746-8ffd-a484930b5a55",
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
    "id": "fb450a4b-5bdd-4746-8ffd-a484930b5a55",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-25T09:14:05+00:00",
      "updated_at": "2023-12-25T09:14:05+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "584ff8ed-64af-408c-89b4-fcb31a6cbd27"
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






## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/349b4466-9f2a-4c49-b25c-5ecc6f4dc3d4?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "349b4466-9f2a-4c49-b25c-5ecc6f4dc3d4",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-25T09:14:05+00:00",
      "updated_at": "2023-12-25T09:14:05+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "94782704-e61b-4be3-b54c-5debcb0c73b4"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/94782704-e61b-4be3-b54c-5debcb0c73b4"
        },
        "data": {
          "type": "default_properties",
          "id": "94782704-e61b-4be3-b54c-5debcb0c73b4"
        }
      }
    }
  },
  "included": [
    {
      "id": "94782704-e61b-4be3-b54c-5debcb0c73b4",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-12-25T09:14:05+00:00",
        "updated_at": "2023-12-25T09:14:05+00:00",
        "name": "Default Property 10",
        "identifier": "default_property_10",
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






## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/97d044ac-753e-48bf-9c01-e05e9ac76635' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
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
      "id": "4c604855-bb2c-40c8-8846-2f8bc49b9557",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-12-25T09:14:06+00:00",
        "updated_at": "2023-12-25T09:14:06+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "e22d31bb-a12f-4e2f-986e-2a0d9c13475f"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/e22d31bb-a12f-4e2f-986e-2a0d9c13475f"
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