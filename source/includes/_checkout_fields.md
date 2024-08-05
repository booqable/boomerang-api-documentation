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
      "id": "a43d134a-e563-4157-9ff9-f32607fcd694",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-08-05T09:22:24.490447+00:00",
        "updated_at": "2024-08-05T09:22:24.490447+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "85383d95-fb3e-4ace-b410-d7aee4d6228f"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/eb22d1bd-5075-40a3-953b-bbdddfb3ebda?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eb22d1bd-5075-40a3-953b-bbdddfb3ebda",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-05T09:22:23.877357+00:00",
      "updated_at": "2024-08-05T09:22:23.877357+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "2b7fa35e-cfa4-468e-bdb9-5c12fa5af15c"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "2b7fa35e-cfa4-468e-bdb9-5c12fa5af15c"
        }
      }
    }
  },
  "included": [
    {
      "id": "2b7fa35e-cfa4-468e-bdb9-5c12fa5af15c",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-08-05T09:22:23.871623+00:00",
        "updated_at": "2024-08-05T09:22:23.871623+00:00",
        "name": "Default Property 2",
        "identifier": "default_property_2",
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
          "default_property_id": "db7887b2-58cb-47e5-9d6d-089952ff7638"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "93f97b01-220f-4641-bc2d-1f19f59726f2",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-05T09:22:25.003752+00:00",
      "updated_at": "2024-08-05T09:22:25.003752+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "db7887b2-58cb-47e5-9d6d-089952ff7638"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/e5e5329f-3a6f-48f1-9e9b-b1b1622804b0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e5e5329f-3a6f-48f1-9e9b-b1b1622804b0",
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
    "id": "e5e5329f-3a6f-48f1-9e9b-b1b1622804b0",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-05T09:22:23.350537+00:00",
      "updated_at": "2024-08-05T09:22:23.378851+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "c7743f99-717d-4310-a08c-c8df77baa370"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c2912a3e-0538-434f-91ad-69f8fe1d5747' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c2912a3e-0538-434f-91ad-69f8fe1d5747",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-08-05T09:22:25.477870+00:00",
      "updated_at": "2024-08-05T09:22:25.477870+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "73c1af11-dc95-4ba3-9be6-7dab3618be71"
    },
    "relationships": {}
  },
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