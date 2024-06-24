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
      "id": "7d2ea898-4bf6-4dd9-94c3-71d082cdcc31",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-06-24T09:55:45.573389+00:00",
        "updated_at": "2024-06-24T09:55:45.573389+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "5e90620f-c5e1-4b3d-b804-c553ed86f4e0"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/5e90620f-c5e1-4b3d-b804-c553ed86f4e0"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/be09f59a-050c-450d-8218-d5775f55a304?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be09f59a-050c-450d-8218-d5775f55a304",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-24T09:55:43.974733+00:00",
      "updated_at": "2024-06-24T09:55:43.974733+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "abcd4540-b1cd-481a-87db-b0f4042a2562"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/abcd4540-b1cd-481a-87db-b0f4042a2562"
        },
        "data": {
          "type": "default_properties",
          "id": "abcd4540-b1cd-481a-87db-b0f4042a2562"
        }
      }
    }
  },
  "included": [
    {
      "id": "abcd4540-b1cd-481a-87db-b0f4042a2562",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-06-24T09:55:43.964929+00:00",
        "updated_at": "2024-06-24T09:55:43.964929+00:00",
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
          "default_property_id": "a1bc147d-26a6-4907-aa47-26cd87099081"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "00afa20a-e7f1-4dc5-9841-1926f45230c1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-24T09:55:46.279044+00:00",
      "updated_at": "2024-06-24T09:55:46.279044+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "a1bc147d-26a6-4907-aa47-26cd87099081"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/b0ce8db1-6f24-425a-b8e1-a2855b7f5915' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b0ce8db1-6f24-425a-b8e1-a2855b7f5915",
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
    "id": "b0ce8db1-6f24-425a-b8e1-a2855b7f5915",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-24T09:55:44.545104+00:00",
      "updated_at": "2024-06-24T09:55:44.577375+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "0a2a3ddb-120f-49b3-aa65-ec615422bab9"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/13934506-c3b0-4832-a4c9-4c4cd4046638' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13934506-c3b0-4832-a4c9-4c4cd4046638",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-24T09:55:43.278141+00:00",
      "updated_at": "2024-06-24T09:55:43.278141+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "0f200202-24e9-4b9d-9fb2-018e479f56c6"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/0f200202-24e9-4b9d-9fb2-018e479f56c6"
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