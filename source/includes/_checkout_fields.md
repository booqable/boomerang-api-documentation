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
      "id": "292cfde8-55cf-4fc2-b51a-188b90fbedda",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-07-22T09:30:15.708218+00:00",
        "updated_at": "2024-07-22T09:30:15.708218+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "8d045bef-a1d4-4a23-992e-d8d31eaa8365"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/438d4e97-de2f-4d62-8e45-81b4359eb5b3?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "438d4e97-de2f-4d62-8e45-81b4359eb5b3",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-22T09:30:17.425930+00:00",
      "updated_at": "2024-07-22T09:30:17.425930+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "751a41a0-6bba-43bb-8151-52c6f23ca4b3"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "751a41a0-6bba-43bb-8151-52c6f23ca4b3"
        }
      }
    }
  },
  "included": [
    {
      "id": "751a41a0-6bba-43bb-8151-52c6f23ca4b3",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-07-22T09:30:17.413990+00:00",
        "updated_at": "2024-07-22T09:30:17.413990+00:00",
        "name": "Default Property 20",
        "identifier": "default_property_20",
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
          "default_property_id": "2e95c86a-8573-4327-8309-04b8f8d544a6"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5bb4448f-c731-4038-8db0-a17351611b8e",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-22T09:30:16.608760+00:00",
      "updated_at": "2024-07-22T09:30:16.608760+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "2e95c86a-8573-4327-8309-04b8f8d544a6"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/01fdf5de-7dbe-477e-921d-f49ab74d299e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "01fdf5de-7dbe-477e-921d-f49ab74d299e",
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
    "id": "01fdf5de-7dbe-477e-921d-f49ab74d299e",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-22T09:30:14.044603+00:00",
      "updated_at": "2024-07-22T09:30:14.130059+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "d0f20cfc-8b31-4c2c-9441-a93679e6fe1d"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/7d34ca79-3bc4-41a9-81a8-525f002a3e86' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d34ca79-3bc4-41a9-81a8-525f002a3e86",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-22T09:30:14.891497+00:00",
      "updated_at": "2024-07-22T09:30:14.891497+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "601c1feb-4a9c-465c-9668-4e9d4b404aec"
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