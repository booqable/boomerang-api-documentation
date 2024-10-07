# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`GET /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

`PUT /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

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
      "id": "4627bf5b-4bf6-4062-a684-2d523bed85eb",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-10-07T09:33:34.499233+00:00",
        "updated_at": "2024-10-07T09:33:34.499233+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "d11f5f32-d4e0-4eff-b6d8-3854baf07e98"
      },
      "relationships": {}
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
## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/db1d6e63-9d5c-45c3-904d-31efaed291e1?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "db1d6e63-9d5c-45c3-904d-31efaed291e1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-07T09:33:32.604067+00:00",
      "updated_at": "2024-10-07T09:33:32.604067+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "5bf08ffd-4aff-439e-a2ec-13645f4c5166"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "5bf08ffd-4aff-439e-a2ec-13645f4c5166"
        }
      }
    }
  },
  "included": [
    {
      "id": "5bf08ffd-4aff-439e-a2ec-13645f4c5166",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-10-07T09:33:32.596407+00:00",
        "updated_at": "2024-10-07T09:33:32.596407+00:00",
        "name": "Default Property 15",
        "identifier": "default_property_15",
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
          "default_property_id": "1f0725cd-0c11-4b24-a1f5-d93a0da09464"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a695f40c-f46a-4676-89ad-040628da8d2c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-07T09:33:33.297543+00:00",
      "updated_at": "2024-10-07T09:33:33.297543+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "1f0725cd-0c11-4b24-a1f5-d93a0da09464"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/d3e80534-1042-4071-8d8e-65c60c9e131d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d3e80534-1042-4071-8d8e-65c60c9e131d",
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
    "id": "d3e80534-1042-4071-8d8e-65c60c9e131d",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-07T09:33:33.883580+00:00",
      "updated_at": "2024-10-07T09:33:33.903720+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "33d91d56-3c6c-4288-ac94-6e587680fb2c"
    },
    "relationships": {}
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






## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/a4a2fe65-266b-4bdb-aaac-51a25f1566f8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a4a2fe65-266b-4bdb-aaac-51a25f1566f8",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-07T09:33:31.996818+00:00",
      "updated_at": "2024-10-07T09:33:31.996818+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "4b47fca0-b0a5-4d20-b275-2301f4d065c8"
    },
    "relationships": {}
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