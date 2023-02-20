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
      "id": "55b86973-3ef5-4a87-84b8-8e51b51ac93d",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-02-20T11:45:50+00:00",
        "updated_at": "2023-02-20T11:45:50+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "a5f194f4-395b-49f8-b2b5-9df70bf6ecfe"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/a5f194f4-395b-49f8-b2b5-9df70bf6ecfe"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/a5228ef0-a0cd-4e61-a905-96d1ed90f3e4?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a5228ef0-a0cd-4e61-a905-96d1ed90f3e4",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-02-20T11:45:50+00:00",
      "updated_at": "2023-02-20T11:45:50+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "fd11a10a-11a9-4aa1-a822-d0936c40d883"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/fd11a10a-11a9-4aa1-a822-d0936c40d883"
        },
        "data": {
          "type": "default_properties",
          "id": "fd11a10a-11a9-4aa1-a822-d0936c40d883"
        }
      }
    }
  },
  "included": [
    {
      "id": "fd11a10a-11a9-4aa1-a822-d0936c40d883",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-02-20T11:45:50+00:00",
        "updated_at": "2023-02-20T11:45:50+00:00",
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
          "default_property_id": "51b90ff1-4352-487b-8380-554c9daec551"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e736f4d7-442c-498c-9845-35b7bd7fb340",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-02-20T11:45:51+00:00",
      "updated_at": "2023-02-20T11:45:51+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "51b90ff1-4352-487b-8380-554c9daec551"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/b83a9875-0423-4b06-8432-bdec2e37af7f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b83a9875-0423-4b06-8432-bdec2e37af7f",
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
    "id": "b83a9875-0423-4b06-8432-bdec2e37af7f",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-02-20T11:45:51+00:00",
      "updated_at": "2023-02-20T11:45:51+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "7d0b399e-f35a-47c4-a94d-de43b3a10e8d"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/5e36dafb-ee77-4664-b4e4-bb314de72e6b' \
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