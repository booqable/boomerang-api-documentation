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
      "id": "452a5dac-41cf-4c98-838b-9ed7f58b9b3c",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-02-24T09:46:52+00:00",
        "updated_at": "2023-02-24T09:46:52+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "1a0e2509-c16f-4191-b801-aeb737f3dd79"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/1a0e2509-c16f-4191-b801-aeb737f3dd79"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/3d65e4ec-6115-409c-9576-3e61a5312fe3?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3d65e4ec-6115-409c-9576-3e61a5312fe3",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-02-24T09:46:52+00:00",
      "updated_at": "2023-02-24T09:46:52+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "6af4e753-1abf-4faf-a3d5-e55153890396"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/6af4e753-1abf-4faf-a3d5-e55153890396"
        },
        "data": {
          "type": "default_properties",
          "id": "6af4e753-1abf-4faf-a3d5-e55153890396"
        }
      }
    }
  },
  "included": [
    {
      "id": "6af4e753-1abf-4faf-a3d5-e55153890396",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-02-24T09:46:52+00:00",
        "updated_at": "2023-02-24T09:46:52+00:00",
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
          "default_property_id": "3b76288b-aad9-4242-b5e6-550582830946"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8e50b44e-7f37-4eac-ab43-d350f38eb5f4",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-02-24T09:46:53+00:00",
      "updated_at": "2023-02-24T09:46:53+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "3b76288b-aad9-4242-b5e6-550582830946"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/129906c9-6543-4304-8ad6-34738703aa12' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "129906c9-6543-4304-8ad6-34738703aa12",
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
    "id": "129906c9-6543-4304-8ad6-34738703aa12",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-02-24T09:46:53+00:00",
      "updated_at": "2023-02-24T09:46:53+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "1a44aa8e-4a38-4522-9451-a93dede09581"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/3a83cb59-294f-419a-bdbc-64967e803e94' \
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