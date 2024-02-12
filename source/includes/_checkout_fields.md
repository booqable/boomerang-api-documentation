# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`POST /api/boomerang/checkout_fields`

`PUT /api/boomerang/checkout_fields/{id}`

`GET /api/boomerang/checkout_fields/{id}`

`DELETE /api/boomerang/checkout_fields/{id}`

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
          "default_property_id": "38214385-503b-468c-925a-f975395ae120"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2b18a897-f3d3-498b-8d40-b44c0753947b",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-02-12T09:15:37+00:00",
      "updated_at": "2024-02-12T09:15:37+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "38214385-503b-468c-925a-f975395ae120"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/929f49f3-39d3-4456-9365-9e7a1eb38217' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "929f49f3-39d3-4456-9365-9e7a1eb38217",
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
    "id": "929f49f3-39d3-4456-9365-9e7a1eb38217",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-02-12T09:15:38+00:00",
      "updated_at": "2024-02-12T09:15:38+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "1d8e7e12-3d2b-4705-aca6-70c36e196c55"
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






## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c8adfb4e-d75c-4e91-9840-47f0171e1aa2?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c8adfb4e-d75c-4e91-9840-47f0171e1aa2",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-02-12T09:15:39+00:00",
      "updated_at": "2024-02-12T09:15:39+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "439259b6-d5b1-4a1b-a40e-e450c1ede0ff"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/439259b6-d5b1-4a1b-a40e-e450c1ede0ff"
        },
        "data": {
          "type": "default_properties",
          "id": "439259b6-d5b1-4a1b-a40e-e450c1ede0ff"
        }
      }
    }
  },
  "included": [
    {
      "id": "439259b6-d5b1-4a1b-a40e-e450c1ede0ff",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-02-12T09:15:39+00:00",
        "updated_at": "2024-02-12T09:15:39+00:00",
        "name": "Default Property 11",
        "identifier": "default_property_11",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/707f3413-c184-4122-89a4-8a062dfda539' \
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
      "id": "c55143c5-7931-4f01-a0aa-5bd932ceb27f",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-02-12T09:15:40+00:00",
        "updated_at": "2024-02-12T09:15:40+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "987aae8b-34c6-44db-9acc-8f782ae3fa03"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/987aae8b-34c6-44db-9acc-8f782ae3fa03"
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