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
      "id": "5e1b53aa-6b4a-44e8-8241-b7b3ad4b207c",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-05-19T14:22:38+00:00",
        "updated_at": "2022-05-19T14:22:38+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "51186d2e-ec26-422b-9fcf-94e86e808e37"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/51186d2e-ec26-422b-9fcf-94e86e808e37"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T14:22:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/74d15640-64ac-4573-bdfc-5bea73f8d913?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "74d15640-64ac-4573-bdfc-5bea73f8d913",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-05-19T14:22:38+00:00",
      "updated_at": "2022-05-19T14:22:38+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "896f4148-a400-4f45-866a-25133ceab451"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/896f4148-a400-4f45-866a-25133ceab451"
        },
        "data": {
          "type": "default_properties",
          "id": "896f4148-a400-4f45-866a-25133ceab451"
        }
      }
    }
  },
  "included": [
    {
      "id": "896f4148-a400-4f45-866a-25133ceab451",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-05-19T14:22:38+00:00",
        "updated_at": "2022-05-19T14:22:38+00:00",
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
          "default_property_id": "889fc60c-d2ac-4031-9fdf-5b12d880e7d2"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f1129684-5f81-46e4-84c0-a5dd50df63c1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-05-19T14:22:38+00:00",
      "updated_at": "2022-05-19T14:22:38+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "889fc60c-d2ac-4031-9fdf-5b12d880e7d2"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/92e2eda6-b76a-43c4-b60e-26af2129636e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "92e2eda6-b76a-43c4-b60e-26af2129636e",
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
    "id": "92e2eda6-b76a-43c4-b60e-26af2129636e",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-05-19T14:22:38+00:00",
      "updated_at": "2022-05-19T14:22:38+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "8d763e7d-c125-4acb-b778-da65cdf64918"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/7b883fc5-e6a4-4707-af48-ca450250dfe8' \
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