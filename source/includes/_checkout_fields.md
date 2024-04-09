# Checkout fields

Checkout fields allow collecting additional information from the checkout.

## Endpoints
`GET /api/boomerang/checkout_fields/{id}`

`POST /api/boomerang/checkout_fields`

`GET /api/boomerang/checkout_fields`

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


## Fetching a checkout field



> How to fetch a checkout field:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c1520efb-aad1-44f4-a2dc-9e577679a499?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c1520efb-aad1-44f4-a2dc-9e577679a499",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-09T07:38:59+00:00",
      "updated_at": "2024-04-09T07:38:59+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "e3c04059-e4e0-4ab1-bcd5-02c686d74287"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/e3c04059-e4e0-4ab1-bcd5-02c686d74287"
        },
        "data": {
          "type": "default_properties",
          "id": "e3c04059-e4e0-4ab1-bcd5-02c686d74287"
        }
      }
    }
  },
  "included": [
    {
      "id": "e3c04059-e4e0-4ab1-bcd5-02c686d74287",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-04-09T07:38:59+00:00",
        "updated_at": "2024-04-09T07:38:59+00:00",
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
          "default_property_id": "4aa3b522-3fc4-446d-b1aa-e742f500bd56"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b393deeb-0f4a-4d35-8dc8-5408b087acf5",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-09T07:39:00+00:00",
      "updated_at": "2024-04-09T07:39:00+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "4aa3b522-3fc4-446d-b1aa-e742f500bd56"
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
      "id": "73876600-2a22-45b9-a96c-8f4fc60cf5a2",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-04-09T07:39:00+00:00",
        "updated_at": "2024-04-09T07:39:00+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "17658740-f3d8-4a19-96bc-42e6cd2724a1"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/17658740-f3d8-4a19-96bc-42e6cd2724a1"
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
## Updating a checkout field



> How to update a custom field:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/2f610473-ca5d-411b-8e36-e263f60edf6a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2f610473-ca5d-411b-8e36-e263f60edf6a",
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
    "id": "2f610473-ca5d-411b-8e36-e263f60edf6a",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-09T07:39:01+00:00",
      "updated_at": "2024-04-09T07:39:01+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "7dc94747-03a5-45bb-8231-563c8f565ced"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/66ba220e-1094-49fe-a988-6a976720dd1e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "66ba220e-1094-49fe-a988-6a976720dd1e",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-04-09T07:39:01+00:00",
      "updated_at": "2024-04-09T07:39:01+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "4b4810c8-3b4f-470f-b67e-2d897b3c4991"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/4b4810c8-3b4f-470f-b67e-2d897b3c4991"
        }
      }
    }
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