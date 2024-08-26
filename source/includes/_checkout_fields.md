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
      "id": "87149cd9-a288-44cf-bcff-12c06c583445",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-08-26T09:26:30.463332+00:00",
        "updated_at": "2024-08-26T09:26:30.463332+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "ef5645bf-25d0-4bf1-89ad-32f120742d97"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1bf2d99a-e198-44ec-bbf1-8d83ea3f6e7b?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1bf2d99a-e198-44ec-bbf1-8d83ea3f6e7b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-26T09:26:28.240483+00:00",
      "updated_at": "2024-08-26T09:26:28.240483+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "3160c2b1-ec1d-4173-8fd4-aa7994a39a44"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "3160c2b1-ec1d-4173-8fd4-aa7994a39a44"
        }
      }
    }
  },
  "included": [
    {
      "id": "3160c2b1-ec1d-4173-8fd4-aa7994a39a44",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-08-26T09:26:28.228920+00:00",
        "updated_at": "2024-08-26T09:26:28.228920+00:00",
        "name": "Default Property 7",
        "identifier": "default_property_7",
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
          "default_property_id": "3e697bcb-1abd-4113-9977-370ef607f499"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b9b1517b-b8e1-4f35-8010-2abe55896fd0",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-26T09:26:29.419082+00:00",
      "updated_at": "2024-08-26T09:26:29.419082+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "3e697bcb-1abd-4113-9977-370ef607f499"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/f812509e-09d2-4aeb-92ee-5e02de96882f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f812509e-09d2-4aeb-92ee-5e02de96882f",
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
    "id": "f812509e-09d2-4aeb-92ee-5e02de96882f",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-26T09:26:29.949882+00:00",
      "updated_at": "2024-08-26T09:26:29.972086+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "96b40e09-befa-4152-b598-af2237a5b905"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1038f2ec-85f3-4581-bdef-930a2a80fe6a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1038f2ec-85f3-4581-bdef-930a2a80fe6a",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-26T09:26:28.818772+00:00",
      "updated_at": "2024-08-26T09:26:28.818772+00:00",
      "name": "Custom Field 1",
      "required": false,
      "position": null,
      "default_property_id": "2e062204-c89e-425c-96d8-a642b9bfa257"
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