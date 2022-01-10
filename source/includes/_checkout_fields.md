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
`name` | **String**<br>Name of the field, will be shown as a field label in the checkout
`required` | **Boolean**<br>Whether the field required to complete checkout
`position` | **Integer**<br>Used to determine sorting relative to other checkout fields
`default_property_id` | **Uuid**<br>The associated Default property


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
      "id": "4ea6c92c-63d0-430e-bfa4-60b270fd53bd",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-01-05T12:39:15+00:00",
        "updated_at": "2022-01-05T12:39:15+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "f364f130-b78e-4607-8716-260b3fb6f8d0"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/f364f130-b78e-4607-8716-260b3fb6f8d0"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/checkout_fields?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/checkout_fields?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/checkout_fields?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/checkout_fields`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-05T12:38:51Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`required` | **Boolean**<br>`eq`
`default_property_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/e5f62a5f-51ec-4b0c-9d3c-af6124051d19?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e5f62a5f-51ec-4b0c-9d3c-af6124051d19",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-01-05T12:39:16+00:00",
      "updated_at": "2022-01-05T12:39:16+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "9610f8ab-309d-4239-9f3a-83c624731b40"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/9610f8ab-309d-4239-9f3a-83c624731b40"
        },
        "data": {
          "type": "default_properties",
          "id": "9610f8ab-309d-4239-9f3a-83c624731b40"
        }
      }
    }
  },
  "included": [
    {
      "id": "9610f8ab-309d-4239-9f3a-83c624731b40",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-01-05T12:39:16+00:00",
        "updated_at": "2022-01-05T12:39:16+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


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
          "default_property_id": "72451efa-a36b-4ab4-8522-6da1b3c4df17"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5cb79a36-929c-4086-8ac4-54f9c5bf243b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-01-05T12:39:16+00:00",
      "updated_at": "2022-01-05T12:39:16+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "72451efa-a36b-4ab4-8522-6da1b3c4df17"
    },
    "relationships": {
      "default_property": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=72451efa-a36b-4ab4-8522-6da1b3c4df17&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=72451efa-a36b-4ab4-8522-6da1b3c4df17&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=72451efa-a36b-4ab4-8522-6da1b3c4df17&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=72451efa-a36b-4ab4-8522-6da1b3c4df17&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=72451efa-a36b-4ab4-8522-6da1b3c4df17&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=72451efa-a36b-4ab4-8522-6da1b3c4df17&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/checkout_fields`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the field, will be shown as a field label in the checkout
`data[attributes][position]` | **Integer**<br>Used to determine sorting relative to other checkout fields
`data[attributes][default_property_id]` | **Uuid**<br>The associated Default property


### Includes

This request accepts the following includes:

`default_property`






## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/885a3360-2435-46eb-b0f7-bbdafa5c8ca9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "885a3360-2435-46eb-b0f7-bbdafa5c8ca9",
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
    "id": "885a3360-2435-46eb-b0f7-bbdafa5c8ca9",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-01-05T12:39:17+00:00",
      "updated_at": "2022-01-05T12:39:17+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "8e5ed497-1e72-4839-9f84-857d3e08d8f7"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the field, will be shown as a field label in the checkout
`data[attributes][position]` | **Integer**<br>Used to determine sorting relative to other checkout fields
`data[attributes][default_property_id]` | **Uuid**<br>The associated Default property


### Includes

This request accepts the following includes:

`default_property`






## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/64ed2692-fa25-4a5f-a7c6-dce1f4b69238' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`


### Includes

This request does not accept any includes