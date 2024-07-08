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
      "id": "4e7bd55a-63ad-4d98-9b78-17e12bb96c07",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-07-08T09:25:49.676508+00:00",
        "updated_at": "2024-07-08T09:25:49.676508+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "4f56c729-8391-470b-8acf-ea66fa2fed3f"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/0c8407d9-54de-46c9-9efb-bae4d76f3d96?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c8407d9-54de-46c9-9efb-bae4d76f3d96",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-08T09:25:48.534052+00:00",
      "updated_at": "2024-07-08T09:25:48.534052+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "d3d22a2e-3243-48aa-a067-67f0d0a0b2ec"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "d3d22a2e-3243-48aa-a067-67f0d0a0b2ec"
        }
      }
    }
  },
  "included": [
    {
      "id": "d3d22a2e-3243-48aa-a067-67f0d0a0b2ec",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-07-08T09:25:48.518833+00:00",
        "updated_at": "2024-07-08T09:25:48.518833+00:00",
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
          "default_property_id": "127109d2-2245-4a1e-96cb-ea9b66200321"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "687ad96c-c161-4961-8528-18ecaf2b23c5",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-08T09:25:47.986753+00:00",
      "updated_at": "2024-07-08T09:25:47.986753+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "127109d2-2245-4a1e-96cb-ea9b66200321"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/aebea808-1595-4f73-91db-2f3525f5a746' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aebea808-1595-4f73-91db-2f3525f5a746",
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
    "id": "aebea808-1595-4f73-91db-2f3525f5a746",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-08T09:25:49.085601+00:00",
      "updated_at": "2024-07-08T09:25:49.124482+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "d07ed381-3639-4a55-baaf-1f65bb61917e"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/7e0c86cd-ebba-4491-b8ab-2c8a0c9cc3e9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7e0c86cd-ebba-4491-b8ab-2c8a0c9cc3e9",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-08T09:25:50.201116+00:00",
      "updated_at": "2024-07-08T09:25:50.201116+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "dcb3a27a-963a-4013-8f1c-101a90597348"
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