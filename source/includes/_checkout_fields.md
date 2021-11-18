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
      "id": "b447fd54-fd1a-4a57-8701-a5c8e321f66d",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2021-11-18T15:31:48+00:00",
        "updated_at": "2021-11-18T15:31:48+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "7e42a8f8-8c02-44d8-85b8-1dab8b88f5ac"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/7e42a8f8-8c02-44d8-85b8-1dab8b88f5ac"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-18T15:31:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/2bc1875a-57f1-45be-bc08-7be189508a3c?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2bc1875a-57f1-45be-bc08-7be189508a3c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2021-11-18T15:31:48+00:00",
      "updated_at": "2021-11-18T15:31:48+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "2d03c830-eba9-4a4b-9eef-21dbb9cd1b7d"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/2d03c830-eba9-4a4b-9eef-21dbb9cd1b7d"
        },
        "data": {
          "type": "default_properties",
          "id": "2d03c830-eba9-4a4b-9eef-21dbb9cd1b7d"
        }
      }
    }
  },
  "included": [
    {
      "id": "2d03c830-eba9-4a4b-9eef-21dbb9cd1b7d",
      "type": "default_properties",
      "attributes": {
        "created_at": "2021-11-18T15:31:48+00:00",
        "updated_at": "2021-11-18T15:31:48+00:00",
        "name": "Default Property 2",
        "identifier": "default_property_2",
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
          "default_property_id": "c394e573-1e56-4312-9d77-4754dca9a7e6"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "82f6fd17-432f-43a2-b82c-fab4c70ca534",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2021-11-18T15:31:49+00:00",
      "updated_at": "2021-11-18T15:31:49+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "c394e573-1e56-4312-9d77-4754dca9a7e6"
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
    "self": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=c394e573-1e56-4312-9d77-4754dca9a7e6&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=c394e573-1e56-4312-9d77-4754dca9a7e6&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=c394e573-1e56-4312-9d77-4754dca9a7e6&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=c394e573-1e56-4312-9d77-4754dca9a7e6&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=c394e573-1e56-4312-9d77-4754dca9a7e6&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=c394e573-1e56-4312-9d77-4754dca9a7e6&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/fe954e41-9db2-4d8b-972c-83f88a555690' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fe954e41-9db2-4d8b-972c-83f88a555690",
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
    "id": "fe954e41-9db2-4d8b-972c-83f88a555690",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2021-11-18T15:31:49+00:00",
      "updated_at": "2021-11-18T15:31:49+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "29b4ad51-6554-4c12-8a54-a06d66aaf74f"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/1c4ef651-cf69-4828-9856-11b29506c3c0' \
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