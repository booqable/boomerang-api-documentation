# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`PUT /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

## Fields
Every checkout field has the following fields:

Name | Description
-- | --
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
-- | --
`default_property` | **Default properties** `readonly`<br>Associated Default property


## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/65f29a2c-1a65-4a56-a3f3-f5e37ff22366' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "65f29a2c-1a65-4a56-a3f3-f5e37ff22366",
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
    "id": "65f29a2c-1a65-4a56-a3f3-f5e37ff22366",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-18T09:14:35+00:00",
      "updated_at": "2023-12-18T09:14:35+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "0227c491-141f-4a79-9b36-bbbb87818d77"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the field, will be shown as a field label in the checkout
`data[attributes][position]` | **Integer** <br>Used to determine sorting relative to other checkout fields
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property


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
          "default_property_id": "f5acd61e-80fd-4782-8b87-cfde7588c6b3"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fe48ab2c-d7e8-4d26-afdb-bd8d4034208d",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-18T09:14:36+00:00",
      "updated_at": "2023-12-18T09:14:36+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "f5acd61e-80fd-4782-8b87-cfde7588c6b3"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the field, will be shown as a field label in the checkout
`data[attributes][position]` | **Integer** <br>Used to determine sorting relative to other checkout fields
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property


### Includes

This request accepts the following includes:

`default_property`






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
      "id": "3dddc0ac-22ed-4b2d-a3db-b502142707a7",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-12-18T09:14:37+00:00",
        "updated_at": "2023-12-18T09:14:37+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "b4e77d21-7f4e-4571-8deb-874f0fbf5a84"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/b4e77d21-7f4e-4571-8deb-874f0fbf5a84"
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`required` | **Boolean** <br>`eq`
`default_property_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/ad610d7c-b981-494d-b107-2edb6fbeaea5?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ad610d7c-b981-494d-b107-2edb6fbeaea5",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-18T09:14:38+00:00",
      "updated_at": "2023-12-18T09:14:38+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "add46568-958e-4de7-aafc-6920f0ea7dab"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/add46568-958e-4de7-aafc-6920f0ea7dab"
        },
        "data": {
          "type": "default_properties",
          "id": "add46568-958e-4de7-aafc-6920f0ea7dab"
        }
      }
    }
  },
  "included": [
    {
      "id": "add46568-958e-4de7-aafc-6920f0ea7dab",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-12-18T09:14:38+00:00",
        "updated_at": "2023-12-18T09:14:38+00:00",
        "name": "Default Property 8",
        "identifier": "default_property_8",
        "position": 1,
        "property_type": "text_field",
        "show_on": [],
        "validation_required": false,
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`default_property`






## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/7cf16592-c57c-4c2d-add7-29513e4391f1' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


### Includes

This request does not accept any includes