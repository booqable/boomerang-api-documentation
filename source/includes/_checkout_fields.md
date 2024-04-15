# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields/{id}`

`PUT /api/boomerang/checkout_fields/{id}`

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
          "default_property_id": "5164fce8-8e3a-42d6-b1d7-d8e79d0009c5"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a186d51a-cd92-4d6c-935a-87648b042424",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-15T09:27:43+00:00",
      "updated_at": "2024-04-15T09:27:43+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "5164fce8-8e3a-42d6-b1d7-d8e79d0009c5"
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






## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/19f3af40-8f6e-472d-93f6-24979c0df22b?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "19f3af40-8f6e-472d-93f6-24979c0df22b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-15T09:27:46+00:00",
      "updated_at": "2024-04-15T09:27:46+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "67217a2b-e16a-440c-8a98-9a09f46cec16"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/67217a2b-e16a-440c-8a98-9a09f46cec16"
        },
        "data": {
          "type": "default_properties",
          "id": "67217a2b-e16a-440c-8a98-9a09f46cec16"
        }
      }
    }
  },
  "included": [
    {
      "id": "67217a2b-e16a-440c-8a98-9a09f46cec16",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-04-15T09:27:46+00:00",
        "updated_at": "2024-04-15T09:27:46+00:00",
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






## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c3324075-51a3-449f-842f-2c9d17497653' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c3324075-51a3-449f-842f-2c9d17497653",
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
    "id": "c3324075-51a3-449f-842f-2c9d17497653",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-15T09:27:47+00:00",
      "updated_at": "2024-04-15T09:27:48+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "406728fe-8a66-4d23-8567-a8516b000829"
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






## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/fdcf30b7-de45-4fee-9d79-24a5e4b7402a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fdcf30b7-de45-4fee-9d79-24a5e4b7402a",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-15T09:27:49+00:00",
      "updated_at": "2024-04-15T09:27:49+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "ee17918b-7af3-4559-ba7a-da258a93d021"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/ee17918b-7af3-4559-ba7a-da258a93d021"
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
      "id": "aa720da4-71e2-4b01-ac4a-d82defe62be8",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-04-15T09:27:51+00:00",
        "updated_at": "2024-04-15T09:27:51+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "4f1ec083-dfcf-4ce1-bd95-eac52b97ed8e"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/4f1ec083-dfcf-4ce1-bd95-eac52b97ed8e"
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