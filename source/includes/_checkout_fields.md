# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`DELETE /api/boomerang/checkout_fields/{id}`

`PUT /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields`

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


## Destroying a checkout field



> How to delete a checkout field:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/450183ca-8ee8-488c-89ed-519393337460' \
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
## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/fda607ff-2e11-4e9b-9bf5-e851104511b7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fda607ff-2e11-4e9b-9bf5-e851104511b7",
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
    "id": "fda607ff-2e11-4e9b-9bf5-e851104511b7",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-07T18:41:17+00:00",
      "updated_at": "2023-12-07T18:41:17+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "ba1fc8bb-2d62-4530-8031-c4b6a4e2ab6c"
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
          "default_property_id": "2d32f43b-3da2-493a-9764-6c5b5ab64fae"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dfefb58e-2293-454a-8887-4d0eaef49983",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-07T18:41:18+00:00",
      "updated_at": "2023-12-07T18:41:18+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "2d32f43b-3da2-493a-9764-6c5b5ab64fae"
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






## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/e404702e-dcac-48a5-922a-01f0f2986034?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e404702e-dcac-48a5-922a-01f0f2986034",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2023-12-07T18:41:18+00:00",
      "updated_at": "2023-12-07T18:41:18+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "e5f973c1-bae0-457d-87d5-fcbc9b69d51c"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/e5f973c1-bae0-457d-87d5-fcbc9b69d51c"
        },
        "data": {
          "type": "default_properties",
          "id": "e5f973c1-bae0-457d-87d5-fcbc9b69d51c"
        }
      }
    }
  },
  "included": [
    {
      "id": "e5f973c1-bae0-457d-87d5-fcbc9b69d51c",
      "type": "default_properties",
      "attributes": {
        "created_at": "2023-12-07T18:41:18+00:00",
        "updated_at": "2023-12-07T18:41:18+00:00",
        "name": "Default Property 13",
        "identifier": "default_property_13",
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
      "id": "7cb9a0dd-d5b5-4e10-ba9b-803e12283fa1",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2023-12-07T18:41:19+00:00",
        "updated_at": "2023-12-07T18:41:19+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "a97f6725-a34d-4241-b808-0ca36555d2fa"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/a97f6725-a34d-4241-b808-0ca36555d2fa"
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