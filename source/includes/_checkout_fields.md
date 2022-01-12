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
      "id": "0b7651fd-de80-47bd-8517-e50de77e5920",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-01-12T10:55:11+00:00",
        "updated_at": "2022-01-12T10:55:11+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "d1676b11-b67d-47fb-b5ea-a2a13f6c23ac"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/d1676b11-b67d-47fb-b5ea-a2a13f6c23ac"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T10:54:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/810a491d-6d17-4095-b5de-75902912ad1c?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "810a491d-6d17-4095-b5de-75902912ad1c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-01-12T10:55:11+00:00",
      "updated_at": "2022-01-12T10:55:11+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "93382efe-58d9-4e11-8fae-bef3a19f5755"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/93382efe-58d9-4e11-8fae-bef3a19f5755"
        },
        "data": {
          "type": "default_properties",
          "id": "93382efe-58d9-4e11-8fae-bef3a19f5755"
        }
      }
    }
  },
  "included": [
    {
      "id": "93382efe-58d9-4e11-8fae-bef3a19f5755",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-01-12T10:55:11+00:00",
        "updated_at": "2022-01-12T10:55:11+00:00",
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
          "default_property_id": "398ba875-c97a-4a54-b3fe-ea554701b4ed"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8ce5830c-2640-4324-b5a7-29dfd659c8d6",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-01-12T10:55:11+00:00",
      "updated_at": "2022-01-12T10:55:11+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "398ba875-c97a-4a54-b3fe-ea554701b4ed"
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
    "self": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=398ba875-c97a-4a54-b3fe-ea554701b4ed&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=398ba875-c97a-4a54-b3fe-ea554701b4ed&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=398ba875-c97a-4a54-b3fe-ea554701b4ed&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=398ba875-c97a-4a54-b3fe-ea554701b4ed&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/checkout_fields?checkout_field%5Bdata%5D%5Battributes%5D%5Bdefault_property_id%5D=398ba875-c97a-4a54-b3fe-ea554701b4ed&checkout_field%5Bdata%5D%5Battributes%5D%5Bname%5D=Special+requests&checkout_field%5Bdata%5D%5Btype%5D=checkout_fields&data%5Battributes%5D%5Bdefault_property_id%5D=398ba875-c97a-4a54-b3fe-ea554701b4ed&data%5Battributes%5D%5Bname%5D=Special+requests&data%5Btype%5D=checkout_fields&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/cd25e122-866f-42d0-96ad-d0d88364c50f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cd25e122-866f-42d0-96ad-d0d88364c50f",
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
    "id": "cd25e122-866f-42d0-96ad-d0d88364c50f",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-01-12T10:55:11+00:00",
      "updated_at": "2022-01-12T10:55:11+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "17a3de85-a0f5-47ae-9942-22f2c8678e74"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/d8dc655a-2c79-46c6-962d-0d1908a6f9fd' \
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