# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields`

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
          "default_property_id": "6cfd44d4-5953-4df8-80f0-a252b3d53ce3"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2ed5b0e1-2245-4f10-9c0b-ed76ab18ed32",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-20T09:26:15+00:00",
      "updated_at": "2024-05-20T09:26:15+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "6cfd44d4-5953-4df8-80f0-a252b3d53ce3"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/de63d6fa-2dbe-412d-8d21-b80f33b1948b?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "de63d6fa-2dbe-412d-8d21-b80f33b1948b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-20T09:26:15+00:00",
      "updated_at": "2024-05-20T09:26:15+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "a632f96f-ef92-4383-bc23-a2ef56a165ff"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/a632f96f-ef92-4383-bc23-a2ef56a165ff"
        },
        "data": {
          "type": "default_properties",
          "id": "a632f96f-ef92-4383-bc23-a2ef56a165ff"
        }
      }
    }
  },
  "included": [
    {
      "id": "a632f96f-ef92-4383-bc23-a2ef56a165ff",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-05-20T09:26:15+00:00",
        "updated_at": "2024-05-20T09:26:15+00:00",
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
      "id": "00ae57cf-fe45-4dd3-a534-5ff0719b50f9",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-05-20T09:26:16+00:00",
        "updated_at": "2024-05-20T09:26:16+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "0f769ece-7299-4cb9-afad-fe0d1f09036f"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/0f769ece-7299-4cb9-afad-fe0d1f09036f"
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
## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1a6969ee-aa98-4c45-8afb-037a5d3b8963' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1a6969ee-aa98-4c45-8afb-037a5d3b8963",
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
    "id": "1a6969ee-aa98-4c45-8afb-037a5d3b8963",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-20T09:26:17+00:00",
      "updated_at": "2024-05-20T09:26:17+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "49778911-4c9c-41d4-ae6f-5e6a4aa645b3"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/0be0e791-9016-4b31-943f-4a551ecc0328' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0be0e791-9016-4b31-943f-4a551ecc0328",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-20T09:26:17+00:00",
      "updated_at": "2024-05-20T09:26:17+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "7a0b5f58-2cc0-4842-aa4d-848ad4db7d15"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/7a0b5f58-2cc0-4842-aa4d-848ad4db7d15"
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