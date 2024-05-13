# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`PUT /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields/{id}`

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


## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/f7d2e0a9-ad20-4837-92e6-b79f42994f0a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f7d2e0a9-ad20-4837-92e6-b79f42994f0a",
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
    "id": "f7d2e0a9-ad20-4837-92e6-b79f42994f0a",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-13T09:26:47+00:00",
      "updated_at": "2024-05-13T09:26:47+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "7c5465c3-63fc-477e-87b1-1be728d756fa"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/52a209ab-9604-421a-9b83-58e2b035fcd0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "52a209ab-9604-421a-9b83-58e2b035fcd0",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-13T09:26:47+00:00",
      "updated_at": "2024-05-13T09:26:47+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "5b7ee086-6d86-4741-a953-86d7d00b45ea"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/5b7ee086-6d86-4741-a953-86d7d00b45ea"
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
          "default_property_id": "92829071-86e8-4685-a6da-e2f0d96d5e14"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f9229e00-f73a-4d91-aaa0-70e38f8c2e90",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-13T09:26:48+00:00",
      "updated_at": "2024-05-13T09:26:48+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "92829071-86e8-4685-a6da-e2f0d96d5e14"
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
      "id": "422471cf-1ba9-4c52-8eaf-219f2c076559",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-05-13T09:26:49+00:00",
        "updated_at": "2024-05-13T09:26:49+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "923d6662-5eb3-48b7-9e69-c893893e6d9b"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/923d6662-5eb3-48b7-9e69-c893893e6d9b"
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
## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/237dc308-8f8b-4f5a-9803-daf600e84893?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "237dc308-8f8b-4f5a-9803-daf600e84893",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-13T09:26:50+00:00",
      "updated_at": "2024-05-13T09:26:50+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "f6154994-124b-4c10-91c9-bd2f36efa35b"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/f6154994-124b-4c10-91c9-bd2f36efa35b"
        },
        "data": {
          "type": "default_properties",
          "id": "f6154994-124b-4c10-91c9-bd2f36efa35b"
        }
      }
    }
  },
  "included": [
    {
      "id": "f6154994-124b-4c10-91c9-bd2f36efa35b",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-05-13T09:26:50+00:00",
        "updated_at": "2024-05-13T09:26:50+00:00",
        "name": "Default Property 12",
        "identifier": "default_property_12",
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





