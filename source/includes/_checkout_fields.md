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
      "id": "169e6f5c-aac7-488b-b3be-6f46a59c32c8",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-09-09T09:23:24.383965+00:00",
        "updated_at": "2024-09-09T09:23:24.383965+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "79190aa0-ec3a-42e7-9ca2-1de566c83151"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1941174d-9d26-43db-84ad-b0d21d910aba?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1941174d-9d26-43db-84ad-b0d21d910aba",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-09T09:23:22.749939+00:00",
      "updated_at": "2024-09-09T09:23:22.749939+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "716e41ea-0882-4bc0-9570-4c0572560d4c"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "716e41ea-0882-4bc0-9570-4c0572560d4c"
        }
      }
    }
  },
  "included": [
    {
      "id": "716e41ea-0882-4bc0-9570-4c0572560d4c",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-09-09T09:23:22.745097+00:00",
        "updated_at": "2024-09-09T09:23:22.745097+00:00",
        "name": "Default Property 1",
        "identifier": "default_property_1",
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
          "default_property_id": "f04c14c9-a834-429c-9c69-535be021c4eb"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cdd485c7-b862-4323-a23d-2c60904d8aa6",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-09T09:23:23.994025+00:00",
      "updated_at": "2024-09-09T09:23:23.994025+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "f04c14c9-a834-429c-9c69-535be021c4eb"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1ecfd66f-4846-4d1b-9a64-498089ec945d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1ecfd66f-4846-4d1b-9a64-498089ec945d",
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
    "id": "1ecfd66f-4846-4d1b-9a64-498089ec945d",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-09T09:23:23.153488+00:00",
      "updated_at": "2024-09-09T09:23:23.167299+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "6a86f07d-2b62-4982-9a72-819b8a0cb5ed"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/9bb5bb09-d412-4bc4-9519-153b21216042' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9bb5bb09-d412-4bc4-9519-153b21216042",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-09T09:23:23.554765+00:00",
      "updated_at": "2024-09-09T09:23:23.554765+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "2c5d45f9-f653-4223-83c4-bbc8ab3618ea"
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