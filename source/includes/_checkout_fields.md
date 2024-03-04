# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`GET /api/boomerang/checkout_fields/{id}`

`PUT /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

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


## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/dab2bb7f-8608-415d-85a5-b4bd4e0d230c?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dab2bb7f-8608-415d-85a5-b4bd4e0d230c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-03-04T09:18:39+00:00",
      "updated_at": "2024-03-04T09:18:39+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "53a83bfb-f0cb-46f3-8313-f872b405cc89"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/53a83bfb-f0cb-46f3-8313-f872b405cc89"
        },
        "data": {
          "type": "default_properties",
          "id": "53a83bfb-f0cb-46f3-8313-f872b405cc89"
        }
      }
    }
  },
  "included": [
    {
      "id": "53a83bfb-f0cb-46f3-8313-f872b405cc89",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-03-04T09:18:39+00:00",
        "updated_at": "2024-03-04T09:18:39+00:00",
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






## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/836de4f7-ec7f-456b-9047-7922d9173de2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "836de4f7-ec7f-456b-9047-7922d9173de2",
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
    "id": "836de4f7-ec7f-456b-9047-7922d9173de2",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-03-04T09:18:39+00:00",
      "updated_at": "2024-03-04T09:18:40+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "110a69b9-b1bf-4e76-82ab-c2219d2f0860"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/73180bf9-f256-42fc-afad-9a6adafbd74c' \
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
          "default_property_id": "635e1718-ba33-4132-9f6f-86ce4daf3862"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "42c1abe3-8252-4e50-8e05-6d150a149afb",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-03-04T09:18:41+00:00",
      "updated_at": "2024-03-04T09:18:41+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "635e1718-ba33-4132-9f6f-86ce4daf3862"
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
      "id": "31276230-a36b-4d36-be0a-e31903d0dce8",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-03-04T09:18:41+00:00",
        "updated_at": "2024-03-04T09:18:41+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "91d0e896-9e2a-4b18-b1eb-c4f94eaf2a7a"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/91d0e896-9e2a-4b18-b1eb-c4f94eaf2a7a"
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