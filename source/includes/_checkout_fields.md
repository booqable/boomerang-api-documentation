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
      "id": "adb42742-79c5-415f-a39d-51cbc94aff26",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-07-29T09:28:51.518491+00:00",
        "updated_at": "2024-07-29T09:28:51.518491+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "edd38c0f-21c4-44d7-8278-639de56ae85f"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c8980026-0dbd-4bc9-8c00-c24c1f76a631?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c8980026-0dbd-4bc9-8c00-c24c1f76a631",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-29T09:28:50.926047+00:00",
      "updated_at": "2024-07-29T09:28:50.926047+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "fb304ff8-9460-4763-997b-613167a964fc"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "fb304ff8-9460-4763-997b-613167a964fc"
        }
      }
    }
  },
  "included": [
    {
      "id": "fb304ff8-9460-4763-997b-613167a964fc",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-07-29T09:28:50.919648+00:00",
        "updated_at": "2024-07-29T09:28:50.919648+00:00",
        "name": "Default Property 16",
        "identifier": "default_property_16",
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
          "default_property_id": "22c87975-18ff-4542-81be-5734fbed0c67"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8caf7424-e7f0-4ff2-b3a2-4d3b3d23b20b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-29T09:28:50.408899+00:00",
      "updated_at": "2024-07-29T09:28:50.408899+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "22c87975-18ff-4542-81be-5734fbed0c67"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/33d64682-2d43-4fac-8292-116d778823a4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "33d64682-2d43-4fac-8292-116d778823a4",
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
    "id": "33d64682-2d43-4fac-8292-116d778823a4",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-29T09:28:52.059266+00:00",
      "updated_at": "2024-07-29T09:28:52.090848+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "4febfba6-d274-4584-9991-c137e2a98ebf"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/dff8cea7-563f-4565-98b2-044a5a7abef0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dff8cea7-563f-4565-98b2-044a5a7abef0",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-29T09:28:52.609111+00:00",
      "updated_at": "2024-07-29T09:28:52.609111+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "affd1316-bd65-4da0-8f1a-40e652cbc962"
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