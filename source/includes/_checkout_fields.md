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
      "id": "d350a4e8-7978-4fbc-8a65-5220692cbf7d",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-07-15T09:25:45.180036+00:00",
        "updated_at": "2024-07-15T09:25:45.180036+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "39ea3fbb-22fe-4e31-a460-e6803f377a7c"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/05d6b880-9833-4068-b428-934cc43f5c78?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "05d6b880-9833-4068-b428-934cc43f5c78",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-15T09:25:44.032163+00:00",
      "updated_at": "2024-07-15T09:25:44.032163+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "43ad10b7-a6bd-4a1e-9012-c879ca4f5796"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "43ad10b7-a6bd-4a1e-9012-c879ca4f5796"
        }
      }
    }
  },
  "included": [
    {
      "id": "43ad10b7-a6bd-4a1e-9012-c879ca4f5796",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-07-15T09:25:44.022704+00:00",
        "updated_at": "2024-07-15T09:25:44.022704+00:00",
        "name": "Default Property 6",
        "identifier": "default_property_6",
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
          "default_property_id": "dfaa98ea-72c5-476f-ae4b-a074639fa5d0"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5095438a-bc09-4fa2-9a8c-cc3cd0f10b24",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-15T09:25:44.667570+00:00",
      "updated_at": "2024-07-15T09:25:44.667570+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "dfaa98ea-72c5-476f-ae4b-a074639fa5d0"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/f680bbe3-c215-44a7-bf67-8984001fc492' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f680bbe3-c215-44a7-bf67-8984001fc492",
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
    "id": "f680bbe3-c215-44a7-bf67-8984001fc492",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-15T09:25:45.716965+00:00",
      "updated_at": "2024-07-15T09:25:45.747897+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "c1ad2f44-d8f3-41ed-b6e8-b76840daaef5"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/4eb77d56-e29f-42da-8f21-d735fd7f4b14' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4eb77d56-e29f-42da-8f21-d735fd7f4b14",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-07-15T09:25:46.280362+00:00",
      "updated_at": "2024-07-15T09:25:46.280362+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "d03ad671-4346-403f-89d7-51ae2c003f75"
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