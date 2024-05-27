# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`DELETE /api/boomerang/checkout_fields/{id}`

`PUT /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields/{id}`

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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/d4cf906c-82f7-4e7d-8cee-c16c5d440571' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d4cf906c-82f7-4e7d-8cee-c16c5d440571",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-27T09:24:35.073366+00:00",
      "updated_at": "2024-05-27T09:24:35.073366+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "49850b00-2e25-42a4-ae43-543bde114376"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/49850b00-2e25-42a4-ae43-543bde114376"
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
## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/39ace77a-f246-4f1f-813c-16ca31705ba1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "39ace77a-f246-4f1f-813c-16ca31705ba1",
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
    "id": "39ace77a-f246-4f1f-813c-16ca31705ba1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-27T09:24:35.731124+00:00",
      "updated_at": "2024-05-27T09:24:35.774671+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "6bd445b9-830b-4480-88f6-1680cc0f703a"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/fa2dcf60-e66e-4ec1-996c-2204e7a84f05?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fa2dcf60-e66e-4ec1-996c-2204e7a84f05",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-27T09:24:36.501026+00:00",
      "updated_at": "2024-05-27T09:24:36.501026+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "e86d3eb6-993c-404a-af34-984ed2be7bf7"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/e86d3eb6-993c-404a-af34-984ed2be7bf7"
        },
        "data": {
          "type": "default_properties",
          "id": "e86d3eb6-993c-404a-af34-984ed2be7bf7"
        }
      }
    }
  },
  "included": [
    {
      "id": "e86d3eb6-993c-404a-af34-984ed2be7bf7",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-05-27T09:24:36.484292+00:00",
        "updated_at": "2024-05-27T09:24:36.484292+00:00",
        "name": "Default Property 3",
        "identifier": "default_property_3",
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
      "id": "787ae7f0-b3ff-4f42-95b7-f583ec237fa4",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-05-27T09:24:37.177219+00:00",
        "updated_at": "2024-05-27T09:24:37.177219+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "e5c997c5-d4f8-44f9-9185-412fa828f2af"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/e5c997c5-d4f8-44f9-9185-412fa828f2af"
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
          "default_property_id": "06403364-8821-4875-b5df-a36b62ab01b7"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "26fe328b-5ddc-440f-a908-fbc31dbe2e86",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-27T09:24:37.885353+00:00",
      "updated_at": "2024-05-27T09:24:37.885353+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "06403364-8821-4875-b5df-a36b62ab01b7"
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





