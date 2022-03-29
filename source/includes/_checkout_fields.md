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
      "id": "d83ee79c-bd64-4c2c-8a3f-257c15cde093",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-03-29T09:19:41+00:00",
        "updated_at": "2022-03-29T09:19:41+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "d347f0d2-8e3d-4bc1-b31d-55e8ddcdfde0"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/d347f0d2-8e3d-4bc1-b31d-55e8ddcdfde0"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-29T09:19:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/f8bef724-d9cc-460a-a190-2d321b54edfc?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f8bef724-d9cc-460a-a190-2d321b54edfc",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-03-29T09:19:41+00:00",
      "updated_at": "2022-03-29T09:19:41+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "8d511002-c624-41a5-9e39-8f6b432f8338"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/8d511002-c624-41a5-9e39-8f6b432f8338"
        },
        "data": {
          "type": "default_properties",
          "id": "8d511002-c624-41a5-9e39-8f6b432f8338"
        }
      }
    }
  },
  "included": [
    {
      "id": "8d511002-c624-41a5-9e39-8f6b432f8338",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-03-29T09:19:41+00:00",
        "updated_at": "2022-03-29T09:19:41+00:00",
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
          "default_property_id": "5ef32a38-a2ad-44ca-b6d2-a90263ceae9b"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7f44d1e5-7a83-47da-9d50-d31120e18266",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-03-29T09:19:42+00:00",
      "updated_at": "2022-03-29T09:19:42+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "5ef32a38-a2ad-44ca-b6d2-a90263ceae9b"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c3878b4e-f7f1-4fea-a985-fbb4ec414502' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c3878b4e-f7f1-4fea-a985-fbb4ec414502",
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
    "id": "c3878b4e-f7f1-4fea-a985-fbb4ec414502",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-03-29T09:19:42+00:00",
      "updated_at": "2022-03-29T09:19:42+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "37870899-322b-4bfe-9b2d-d6db5956c8ed"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/4260e98c-4d56-40d4-abf1-6585a3d01b72' \
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