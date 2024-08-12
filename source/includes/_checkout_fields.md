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
      "id": "1095a5a2-f61c-4c25-8e80-24f6f893f1ec",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-08-12T09:23:46.302990+00:00",
        "updated_at": "2024-08-12T09:23:46.302990+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "b197d053-a965-4440-a149-aa54b2eebe30"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/678d36d9-aeaf-4f68-87ed-65412e4aa0dc?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "678d36d9-aeaf-4f68-87ed-65412e4aa0dc",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-12T09:23:46.923569+00:00",
      "updated_at": "2024-08-12T09:23:46.923569+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "5a4491d0-8867-49f1-a46d-6a42c7d895fe"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "5a4491d0-8867-49f1-a46d-6a42c7d895fe"
        }
      }
    }
  },
  "included": [
    {
      "id": "5a4491d0-8867-49f1-a46d-6a42c7d895fe",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-08-12T09:23:46.916041+00:00",
        "updated_at": "2024-08-12T09:23:46.916041+00:00",
        "name": "Default Property 6",
        "identifier": "default_property_6",
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
          "default_property_id": "a2482ff2-67d6-439a-a6b5-94dd3ee8776f"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c09bec97-885a-4cd7-8677-0fcdd509d69d",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-12T09:23:45.717813+00:00",
      "updated_at": "2024-08-12T09:23:45.717813+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "a2482ff2-67d6-439a-a6b5-94dd3ee8776f"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/dbae880e-cef0-42fa-8fbd-8d44f3b38fb1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dbae880e-cef0-42fa-8fbd-8d44f3b38fb1",
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
    "id": "dbae880e-cef0-42fa-8fbd-8d44f3b38fb1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-12T09:23:47.505763+00:00",
      "updated_at": "2024-08-12T09:23:47.530146+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "d86c8774-abc2-49da-8646-e2c34876a681"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/b444ff48-f2bb-40d5-a093-4db05df4f8b5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b444ff48-f2bb-40d5-a093-4db05df4f8b5",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-12T09:23:48.107912+00:00",
      "updated_at": "2024-08-12T09:23:48.107912+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "ce711367-59cc-438a-aa4f-8d64afd0a68f"
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