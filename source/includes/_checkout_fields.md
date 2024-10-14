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
      "id": "7ebb2d78-90ab-4611-988c-905b99625091",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-10-14T09:26:09.257091+00:00",
        "updated_at": "2024-10-14T09:26:09.257091+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "b8a1c578-c882-4742-a30d-849ce77aaecc"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c5028cf6-201e-4245-9933-1ad6da3074f2?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c5028cf6-201e-4245-9933-1ad6da3074f2",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-14T09:26:09.684793+00:00",
      "updated_at": "2024-10-14T09:26:09.684793+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "f374490f-c46a-4c37-9a8c-e0964f50dfcf"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "f374490f-c46a-4c37-9a8c-e0964f50dfcf"
        }
      }
    }
  },
  "included": [
    {
      "id": "f374490f-c46a-4c37-9a8c-e0964f50dfcf",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-10-14T09:26:09.680183+00:00",
        "updated_at": "2024-10-14T09:26:09.680183+00:00",
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
          "default_property_id": "c4aa4ca4-5f3e-45df-8403-bf649fc92239"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "44363793-3691-402b-9837-ebde1deff75b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-14T09:26:10.597531+00:00",
      "updated_at": "2024-10-14T09:26:10.597531+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "c4aa4ca4-5f3e-45df-8403-bf649fc92239"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/0cd0257d-70f0-4133-aeb2-ba9dc7cf7979' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0cd0257d-70f0-4133-aeb2-ba9dc7cf7979",
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
    "id": "0cd0257d-70f0-4133-aeb2-ba9dc7cf7979",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-14T09:26:10.092232+00:00",
      "updated_at": "2024-10-14T09:26:10.107016+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "cee057e9-2d07-4acf-b4dc-c57e8ba44562"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/5d54c798-63be-4bd4-b54e-26e60e7d9786' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5d54c798-63be-4bd4-b54e-26e60e7d9786",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-10-14T09:26:11.015552+00:00",
      "updated_at": "2024-10-14T09:26:11.015552+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "a56f6d8f-c55a-45cb-9d4a-6d89ab1b4072"
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