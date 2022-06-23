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
      "id": "e377a768-f658-4151-bbbb-578ac5d4b8b0",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-06-23T19:01:06+00:00",
        "updated_at": "2022-06-23T19:01:06+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "a8c5c19c-f068-42b4-ab3a-068103f55041"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/a8c5c19c-f068-42b4-ab3a-068103f55041"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[checkout_fields]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/685f12e3-b615-4cb5-9531-ca3a333b4afa?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "685f12e3-b615-4cb5-9531-ca3a333b4afa",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-06-23T19:01:06+00:00",
      "updated_at": "2022-06-23T19:01:06+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "086e3f55-fe29-4cd8-afcd-4acea894fd6e"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/086e3f55-fe29-4cd8-afcd-4acea894fd6e"
        },
        "data": {
          "type": "default_properties",
          "id": "086e3f55-fe29-4cd8-afcd-4acea894fd6e"
        }
      }
    }
  },
  "included": [
    {
      "id": "086e3f55-fe29-4cd8-afcd-4acea894fd6e",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-06-23T19:01:06+00:00",
        "updated_at": "2022-06-23T19:01:06+00:00",
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
          "default_property_id": "a9cce707-ea32-4b9a-bb8a-a6792f8d6753"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a5cc6593-dcc5-41b8-b8a3-3a7c8a169b75",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-06-23T19:01:07+00:00",
      "updated_at": "2022-06-23T19:01:07+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "a9cce707-ea32-4b9a-bb8a-a6792f8d6753"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/10f7b60a-4533-4869-8478-ffa778cffe00' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "10f7b60a-4533-4869-8478-ffa778cffe00",
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
    "id": "10f7b60a-4533-4869-8478-ffa778cffe00",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-06-23T19:01:07+00:00",
      "updated_at": "2022-06-23T19:01:07+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "090811bb-50ad-4d3d-a35e-312343936432"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/ad9e0545-2808-4772-96ca-465969ade8dc' \
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