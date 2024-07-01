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
      "id": "044cce0c-e7d8-4d0c-adbf-a091e5bdc175",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-07-01T09:29:20.544295+00:00",
        "updated_at": "2024-07-01T09:29:20.544295+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "df9ea221-363b-4db2-8207-d11aa6b8250b"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/40a26ce2-f401-4220-a676-dedfa4bf9565?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "40a26ce2-f401-4220-a676-dedfa4bf9565",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-01T09:29:21.182914+00:00",
      "updated_at": "2024-07-01T09:29:21.182914+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "3b80c4fb-16be-47c7-8cd2-6d7f02ffb214"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "3b80c4fb-16be-47c7-8cd2-6d7f02ffb214"
        }
      }
    }
  },
  "included": [
    {
      "id": "3b80c4fb-16be-47c7-8cd2-6d7f02ffb214",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-07-01T09:29:21.172534+00:00",
        "updated_at": "2024-07-01T09:29:21.172534+00:00",
        "name": "Default Property 17",
        "identifier": "default_property_17",
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
          "default_property_id": "64e9f546-316e-439f-a6f2-178d4647e1ef"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "491d016e-824e-46de-a22e-d90e388c7042",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-01T09:29:19.476075+00:00",
      "updated_at": "2024-07-01T09:29:19.476075+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "64e9f546-316e-439f-a6f2-178d4647e1ef"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/89843931-0ff4-449b-83a2-506f24f12b24' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "89843931-0ff4-449b-83a2-506f24f12b24",
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
    "id": "89843931-0ff4-449b-83a2-506f24f12b24",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-01T09:29:21.860866+00:00",
      "updated_at": "2024-07-01T09:29:21.905715+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "2e45683c-ddfe-49bf-8b80-8d3d6a4b9427"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/36ce465e-f38e-44bc-9f6d-4f484cbb6c4b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "36ce465e-f38e-44bc-9f6d-4f484cbb6c4b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-01T09:29:19.960913+00:00",
      "updated_at": "2024-07-01T09:29:19.960913+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "32a1f67f-155d-49b2-a846-c48a7efa3067"
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