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
      "id": "8cdf23af-0cdc-4a99-be59-10c939fcea2b",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-07-10T09:16:03+00:00",
        "updated_at": "2023-07-10T09:16:03+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "0d6674ab-552b-443e-99bf-dc60ae44706b"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/0d6674ab-552b-443e-99bf-dc60ae44706b"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/800f0b68-888b-462b-8055-dbcce2432f93?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "800f0b68-888b-462b-8055-dbcce2432f93",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-07-10T09:16:04+00:00",
      "updated_at": "2023-07-10T09:16:04+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "7d60b0a3-c974-4cb4-978a-43650a5cb4a0"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/7d60b0a3-c974-4cb4-978a-43650a5cb4a0"
        },
        "data": {
          "type": "default_properties",
          "id": "7d60b0a3-c974-4cb4-978a-43650a5cb4a0"
        }
      }
    }
  },
  "included": [
    {
      "id": "7d60b0a3-c974-4cb4-978a-43650a5cb4a0",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-07-10T09:16:04+00:00",
        "updated_at": "2023-07-10T09:16:04+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=default_property`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_fields]=created_at,updated_at,name`


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
          "default_property_id": "2e5af312-814b-4acc-8e72-9b323b1ef3dc"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b1faed85-c147-440b-aa7e-4d3d50f61ec5",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-07-10T09:16:04+00:00",
      "updated_at": "2023-07-10T09:16:04+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "2e5af312-814b-4acc-8e72-9b323b1ef3dc"
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






## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/7f5c35eb-59cb-4dae-a0d4-a6e2d40b4699' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7f5c35eb-59cb-4dae-a0d4-a6e2d40b4699",
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
    "id": "7f5c35eb-59cb-4dae-a0d4-a6e2d40b4699",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-07-10T09:16:04+00:00",
      "updated_at": "2023-07-10T09:16:04+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "0b0eeaf1-b30a-4301-95cc-7a9679448dbb"
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






## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/68079cfc-9b08-4259-a2c8-d8ba833a628d' \
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