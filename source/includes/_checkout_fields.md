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
      "id": "20604ced-acd2-4eea-b314-1e8011da887e",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-10-25T17:51:28+00:00",
        "updated_at": "2022-10-25T17:51:28+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "d2b2e7ca-d921-4e16-bed5-614ccab4b7c5"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/d2b2e7ca-d921-4e16-bed5-614ccab4b7c5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/de937b2b-0fbf-447b-a144-d82ff33362df?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "de937b2b-0fbf-447b-a144-d82ff33362df",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-10-25T17:51:28+00:00",
      "updated_at": "2022-10-25T17:51:28+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "78c2ff28-6446-4d0b-a54f-46c70a9a27f8"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/78c2ff28-6446-4d0b-a54f-46c70a9a27f8"
        },
        "data": {
          "type": "default_properties",
          "id": "78c2ff28-6446-4d0b-a54f-46c70a9a27f8"
        }
      }
    }
  },
  "included": [
    {
      "id": "78c2ff28-6446-4d0b-a54f-46c70a9a27f8",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-10-25T17:51:28+00:00",
        "updated_at": "2022-10-25T17:51:28+00:00",
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
          "default_property_id": "12f95261-10d0-423b-89c2-38a20de31c3e"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3a5d0470-f31d-485f-8f24-0ff7beaac8bc",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-10-25T17:51:28+00:00",
      "updated_at": "2022-10-25T17:51:28+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "12f95261-10d0-423b-89c2-38a20de31c3e"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/d9ed3c2f-db97-4110-bd0c-ef850c3722a5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d9ed3c2f-db97-4110-bd0c-ef850c3722a5",
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
    "id": "d9ed3c2f-db97-4110-bd0c-ef850c3722a5",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-10-25T17:51:28+00:00",
      "updated_at": "2022-10-25T17:51:29+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "1d6b9bc4-af9d-4c6c-8ae1-27980ba0c5bf"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/ab7fff08-8ab7-44fe-a70c-537d48d40cd9' \
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