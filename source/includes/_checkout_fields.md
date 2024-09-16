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
      "id": "b32a2a9d-cd4d-42af-9c2d-5eb64aae12a2",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-09-16T09:26:28.208502+00:00",
        "updated_at": "2024-09-16T09:26:28.208502+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "78b1bb87-badc-47ee-ab14-a90393f3effe"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1f221bcf-6b71-4b89-8bf2-12161c80be26?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1f221bcf-6b71-4b89-8bf2-12161c80be26",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-16T09:26:27.322807+00:00",
      "updated_at": "2024-09-16T09:26:27.322807+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "1a0ce2c0-a29f-445a-8f86-db4b8dcc4922"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "1a0ce2c0-a29f-445a-8f86-db4b8dcc4922"
        }
      }
    }
  },
  "included": [
    {
      "id": "1a0ce2c0-a29f-445a-8f86-db4b8dcc4922",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-09-16T09:26:27.317559+00:00",
        "updated_at": "2024-09-16T09:26:27.317559+00:00",
        "name": "Default Property 15",
        "identifier": "default_property_15",
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
          "default_property_id": "ea3d6a28-a11c-4ce5-925c-6d53a33ad005"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3f563d01-55bf-4151-90a5-886dc621067f",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-16T09:26:27.791072+00:00",
      "updated_at": "2024-09-16T09:26:27.791072+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "ea3d6a28-a11c-4ce5-925c-6d53a33ad005"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/0a79f854-8013-4ff7-9b6b-a38cb4a057cb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0a79f854-8013-4ff7-9b6b-a38cb4a057cb",
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
    "id": "0a79f854-8013-4ff7-9b6b-a38cb4a057cb",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-16T09:26:29.078092+00:00",
      "updated_at": "2024-09-16T09:26:29.094549+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "7fbba6ba-56f2-4406-b31d-c0da40a187a5"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/49d127d2-fadc-407d-a5c8-9c5ee466806a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "49d127d2-fadc-407d-a5c8-9c5ee466806a",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-16T09:26:28.648608+00:00",
      "updated_at": "2024-09-16T09:26:28.648608+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "df306f5d-49b5-4b98-a1b2-183277ed6014"
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