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
      "id": "8dfc742f-338f-4ef7-bb93-c21d9ac88dd9",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2022-04-08T17:51:37+00:00",
        "updated_at": "2022-04-08T17:51:37+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "151cb5d0-f834-41be-96d0-b42b230eaa93"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/151cb5d0-f834-41be-96d0-b42b230eaa93"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/691491dc-c561-41e3-a185-d355f276ba91?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "691491dc-c561-41e3-a185-d355f276ba91",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-04-08T17:51:38+00:00",
      "updated_at": "2022-04-08T17:51:38+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "e10dc8d2-b283-4aa2-849e-867d840dff66"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/e10dc8d2-b283-4aa2-849e-867d840dff66"
        },
        "data": {
          "type": "default_properties",
          "id": "e10dc8d2-b283-4aa2-849e-867d840dff66"
        }
      }
    }
  },
  "included": [
    {
      "id": "e10dc8d2-b283-4aa2-849e-867d840dff66",
      "type": "default_properties",
      "attributes": {
        "created_at": "2022-04-08T17:51:38+00:00",
        "updated_at": "2022-04-08T17:51:38+00:00",
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
          "default_property_id": "deec9e8c-eb4e-4e95-b669-16daf1464220"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a9bd24f8-281e-40ee-9396-ca953d6934c1",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-04-08T17:51:38+00:00",
      "updated_at": "2022-04-08T17:51:38+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "deec9e8c-eb4e-4e95-b669-16daf1464220"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/8ac9b2f5-504a-4874-8d72-86937b7a4e0c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8ac9b2f5-504a-4874-8d72-86937b7a4e0c",
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
    "id": "8ac9b2f5-504a-4874-8d72-86937b7a4e0c",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2022-04-08T17:51:38+00:00",
      "updated_at": "2022-04-08T17:51:38+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "ed3c4aff-2e5d-4294-a008-9bdef7e5c79e"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c392e35e-dbbe-4cf1-87af-804d4b5a0289' \
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