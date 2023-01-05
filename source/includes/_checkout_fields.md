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
- | -
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
- | -
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
      "id": "dca14b8c-2c27-48bf-b78c-fdd3732d6a1a",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-01-05T13:42:41+00:00",
        "updated_at": "2023-01-05T13:42:41+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "2d475282-3ee6-4615-87e7-9628451c853a"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/2d475282-3ee6-4615-87e7-9628451c853a"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:08Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`required` | **Boolean** <br>`eq`
`default_property_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/2079e817-9ac9-4234-a40e-834130994da1?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2079e817-9ac9-4234-a40e-834130994da1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-01-05T13:42:41+00:00",
      "updated_at": "2023-01-05T13:42:41+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "9fdecfa8-5625-4c9d-a1e7-253dc949a6b8"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/9fdecfa8-5625-4c9d-a1e7-253dc949a6b8"
        },
        "data": {
          "type": "default_properties",
          "id": "9fdecfa8-5625-4c9d-a1e7-253dc949a6b8"
        }
      }
    }
  },
  "included": [
    {
      "id": "9fdecfa8-5625-4c9d-a1e7-253dc949a6b8",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-01-05T13:42:41+00:00",
        "updated_at": "2023-01-05T13:42:41+00:00",
        "name": "Default Property 4",
        "identifier": "default_property_4",
        "position": 1,
        "property_type": "text_field",
        "show_on": [],
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


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
          "default_property_id": "48ef7cee-c54d-4c34-bc01-a234b8342e0b"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7c7beb0e-1279-4d79-8313-cfb5a1ffa169",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-01-05T13:42:42+00:00",
      "updated_at": "2023-01-05T13:42:42+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "48ef7cee-c54d-4c34-bc01-a234b8342e0b"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/99f0ca8d-cefa-4d5a-a74b-c09f30f0badf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "99f0ca8d-cefa-4d5a-a74b-c09f30f0badf",
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
    "id": "99f0ca8d-cefa-4d5a-a74b-c09f30f0badf",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-01-05T13:42:42+00:00",
      "updated_at": "2023-01-05T13:42:42+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "e238a25c-1276-4715-93ff-30f632a70dbe"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/db501dac-fc97-4f1b-902f-d48af512ac2f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/checkout_fields/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


### Includes

This request does not accept any includes