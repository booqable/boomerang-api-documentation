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
      "id": "78473024-e421-4ae0-aba7-2f0b566dfb97",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-06-17T09:25:20.301695+00:00",
        "updated_at": "2024-06-17T09:25:20.301695+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "655a5b93-b078-4cc5-b094-d2fefc13fb4d"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/655a5b93-b078-4cc5-b094-d2fefc13fb4d"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/5a7b6c9c-2cd9-43fc-92e5-a7dfea160601?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5a7b6c9c-2cd9-43fc-92e5-a7dfea160601",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-17T09:25:17.908578+00:00",
      "updated_at": "2024-06-17T09:25:17.908578+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "164414ae-71c8-4a13-8fbe-67a80eb6e664"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/164414ae-71c8-4a13-8fbe-67a80eb6e664"
        },
        "data": {
          "type": "default_properties",
          "id": "164414ae-71c8-4a13-8fbe-67a80eb6e664"
        }
      }
    }
  },
  "included": [
    {
      "id": "164414ae-71c8-4a13-8fbe-67a80eb6e664",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-06-17T09:25:17.891785+00:00",
        "updated_at": "2024-06-17T09:25:17.891785+00:00",
        "name": "Default Property 1",
        "identifier": "default_property_1",
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
          "default_property_id": "904f0daa-036e-4f27-a39c-f44058849540"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1387760f-425b-47b3-a2b8-8d65b15685f4",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-17T09:25:19.245618+00:00",
      "updated_at": "2024-06-17T09:25:19.245618+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "904f0daa-036e-4f27-a39c-f44058849540"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/c07fff4b-e29f-4502-9bef-ed2b913e1cd7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c07fff4b-e29f-4502-9bef-ed2b913e1cd7",
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
    "id": "c07fff4b-e29f-4502-9bef-ed2b913e1cd7",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-17T09:25:18.529468+00:00",
      "updated_at": "2024-06-17T09:25:18.569286+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "f7125c8a-0222-4094-a6e7-523018af40cd"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/bd1fa986-1290-4eba-a113-c5c0ea6237ef' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bd1fa986-1290-4eba-a113-c5c0ea6237ef",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-06-17T09:25:19.779584+00:00",
      "updated_at": "2024-06-17T09:25:19.779584+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "3808ad72-344d-4781-871e-41ddf496f337"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/3808ad72-344d-4781-871e-41ddf496f337"
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