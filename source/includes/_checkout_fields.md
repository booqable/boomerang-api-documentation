# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`DELETE /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields/{id}`

`PUT /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields`

`POST /api/boomerang/checkout_fields`

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


## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/4b89c99e-763d-469b-adc6-2d5e2358c708' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4b89c99e-763d-469b-adc6-2d5e2358c708",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-03T09:26:47.892417+00:00",
      "updated_at": "2024-06-03T09:26:47.892417+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "209e09ae-7e12-4355-9c10-a712801a9820"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/209e09ae-7e12-4355-9c10-a712801a9820"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/7f8341df-14e9-45ee-9d3c-b2fe1e2f2456?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7f8341df-14e9-45ee-9d3c-b2fe1e2f2456",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-03T09:26:48.593387+00:00",
      "updated_at": "2024-06-03T09:26:48.593387+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "27067630-8ed5-4763-aa7b-5327f2e8604f"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/27067630-8ed5-4763-aa7b-5327f2e8604f"
        },
        "data": {
          "type": "default_properties",
          "id": "27067630-8ed5-4763-aa7b-5327f2e8604f"
        }
      }
    }
  },
  "included": [
    {
      "id": "27067630-8ed5-4763-aa7b-5327f2e8604f",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-06-03T09:26:48.583619+00:00",
        "updated_at": "2024-06-03T09:26:48.583619+00:00",
        "name": "Default Property 9",
        "identifier": "default_property_9",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/b90050d6-6b0e-4cb6-a8d7-9a5a7aa75c67' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b90050d6-6b0e-4cb6-a8d7-9a5a7aa75c67",
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
    "id": "b90050d6-6b0e-4cb6-a8d7-9a5a7aa75c67",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-03T09:26:49.307840+00:00",
      "updated_at": "2024-06-03T09:26:49.365223+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "36356797-527c-44e6-acbf-93e9deff8338"
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
      "id": "81f290b0-e558-4576-bfaf-2ac6ce2eaa79",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-06-03T09:26:50.055981+00:00",
        "updated_at": "2024-06-03T09:26:50.055981+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "aab10b2f-eef4-418f-a3c8-ba8b4f6dffc0"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/aab10b2f-eef4-418f-a3c8-ba8b4f6dffc0"
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
          "default_property_id": "dbf9e294-79fd-4053-90d9-f0cfe4c36ad3"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "68a912f2-c3ec-49b4-8995-2e6994df5d8f",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-03T09:26:50.734478+00:00",
      "updated_at": "2024-06-03T09:26:50.734478+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "dbf9e294-79fd-4053-90d9-f0cfe4c36ad3"
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





