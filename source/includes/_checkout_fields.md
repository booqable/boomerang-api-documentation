# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`PUT /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

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


## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/04650869-3a43-44d4-ae6b-4a334565111f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "04650869-3a43-44d4-ae6b-4a334565111f",
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
    "id": "04650869-3a43-44d4-ae6b-4a334565111f",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-06T09:22:22+00:00",
      "updated_at": "2024-05-06T09:22:22+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "d81e3ecb-df63-4bd3-9bb3-4dc6166696e6"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/fc07309f-0e1c-4c47-9c91-0678c0c16b53' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fc07309f-0e1c-4c47-9c91-0678c0c16b53",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-06T09:22:22+00:00",
      "updated_at": "2024-05-06T09:22:22+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "3b314006-86a3-4058-bd37-0d3f8f581fb9"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/3b314006-86a3-4058-bd37-0d3f8f581fb9"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/6b77d6a2-449f-4d89-9e0f-212b72943370?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b77d6a2-449f-4d89-9e0f-212b72943370",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-06T09:22:23+00:00",
      "updated_at": "2024-05-06T09:22:23+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "5df1f8a0-8964-45dd-a178-19bc0b936ecb"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/5df1f8a0-8964-45dd-a178-19bc0b936ecb"
        },
        "data": {
          "type": "default_properties",
          "id": "5df1f8a0-8964-45dd-a178-19bc0b936ecb"
        }
      }
    }
  },
  "included": [
    {
      "id": "5df1f8a0-8964-45dd-a178-19bc0b936ecb",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-05-06T09:22:23+00:00",
        "updated_at": "2024-05-06T09:22:23+00:00",
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
          "default_property_id": "8bfbeab2-8490-466b-9019-be8caa7b822c"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "eda5e2fd-2d2c-4a56-b025-d8057df53531",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-05-06T09:22:23+00:00",
      "updated_at": "2024-05-06T09:22:23+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "8bfbeab2-8490-466b-9019-be8caa7b822c"
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
      "id": "4c246551-5692-4bdb-993b-55805e92cd58",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-05-06T09:22:24+00:00",
        "updated_at": "2024-05-06T09:22:24+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "9cbcf9b9-abc5-4144-be70-98106dcf5b4c"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/9cbcf9b9-abc5-4144-be70-98106dcf5b4c"
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