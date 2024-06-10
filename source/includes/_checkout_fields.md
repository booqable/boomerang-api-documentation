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
      "id": "3c622104-12cc-4bf3-bb06-1736e01de149",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-06-10T09:22:36.231450+00:00",
        "updated_at": "2024-06-10T09:22:36.231450+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "488f67e2-e365-49a7-bf4f-49c7cf2c62df"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/488f67e2-e365-49a7-bf4f-49c7cf2c62df"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/72fdf107-cdec-4f94-b534-99aae4600a9c?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "72fdf107-cdec-4f94-b534-99aae4600a9c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-10T09:22:35.004160+00:00",
      "updated_at": "2024-06-10T09:22:35.004160+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "534f0901-bad5-4c64-94a9-1d3428cc9a32"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/534f0901-bad5-4c64-94a9-1d3428cc9a32"
        },
        "data": {
          "type": "default_properties",
          "id": "534f0901-bad5-4c64-94a9-1d3428cc9a32"
        }
      }
    }
  },
  "included": [
    {
      "id": "534f0901-bad5-4c64-94a9-1d3428cc9a32",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-06-10T09:22:34.994057+00:00",
        "updated_at": "2024-06-10T09:22:34.994057+00:00",
        "name": "Default Property 4",
        "identifier": "default_property_4",
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
          "default_property_id": "004ab9f8-c59e-42dd-ba7a-4fcbaf0de578"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bbee88ff-cc38-44f8-b454-b183dd1cb0f3",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-10T09:22:34.459459+00:00",
      "updated_at": "2024-06-10T09:22:34.459459+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "004ab9f8-c59e-42dd-ba7a-4fcbaf0de578"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/4b52d334-4dcc-4bfd-a24e-5d18a0daf946' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4b52d334-4dcc-4bfd-a24e-5d18a0daf946",
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
    "id": "4b52d334-4dcc-4bfd-a24e-5d18a0daf946",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-10T09:22:33.740450+00:00",
      "updated_at": "2024-06-10T09:22:33.783896+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "96a03d76-eb51-42ae-87cf-b201c931c456"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/824f0364-c732-4718-86ad-44fcd5d434d0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "824f0364-c732-4718-86ad-44fcd5d434d0",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-10T09:22:35.624346+00:00",
      "updated_at": "2024-06-10T09:22:35.624346+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "700328a9-dfb4-4f09-9d6a-35a5fb56cefa"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/700328a9-dfb4-4f09-9d6a-35a5fb56cefa"
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