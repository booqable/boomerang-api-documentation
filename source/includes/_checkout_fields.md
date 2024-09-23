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
      "id": "e19cffc2-0c4e-45d3-affc-aefc26e5aa5b",
      "type": "checkout_fields",
      "attributes": {
        "created_at": "2024-09-23T09:24:58.130997+00:00",
        "updated_at": "2024-09-23T09:24:58.130997+00:00",
        "name": "Special requests",
        "required": false,
        "position": null,
        "default_property_id": "db070063-1cba-445b-8f1f-b000dca9e037"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/b1f65205-930d-49bd-b5a9-acc5156c1a77?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b1f65205-930d-49bd-b5a9-acc5156c1a77",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-23T09:24:56.721100+00:00",
      "updated_at": "2024-09-23T09:24:56.721100+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "9302e3f7-5497-4a9a-9893-04310bef58a5"
    },
    "relationships": {
      "default_property": {
        "data": {
          "type": "default_properties",
          "id": "9302e3f7-5497-4a9a-9893-04310bef58a5"
        }
      }
    }
  },
  "included": [
    {
      "id": "9302e3f7-5497-4a9a-9893-04310bef58a5",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-09-23T09:24:56.716086+00:00",
        "updated_at": "2024-09-23T09:24:56.716086+00:00",
        "name": "Default Property 14",
        "identifier": "default_property_14",
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
          "default_property_id": "e2fb5543-363c-4795-86f2-da8986902874"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "32071aa8-4e35-4677-93ce-8828a3747ded",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-23T09:24:57.179513+00:00",
      "updated_at": "2024-09-23T09:24:57.179513+00:00",
      "name": "Special requests",
      "required": false,
      "position": null,
      "default_property_id": "e2fb5543-363c-4795-86f2-da8986902874"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/0f77b9b2-f2b9-4854-885f-2956d2898895' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0f77b9b2-f2b9-4854-885f-2956d2898895",
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
    "id": "0f77b9b2-f2b9-4854-885f-2956d2898895",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-23T09:24:57.670185+00:00",
      "updated_at": "2024-09-23T09:24:57.684700+00:00",
      "name": "Additional information",
      "required": false,
      "position": null,
      "default_property_id": "86b1a9af-b1ca-4e38-8aa1-993c434a64ae"
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
    --url 'https://example.booqable.com/api/boomerang/checkout_fields/aa358e67-0243-4de8-a033-69fe4be2cf96' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aa358e67-0243-4de8-a033-69fe4be2cf96",
    "type": "checkout_fields",
    "attributes": {
      "created_at": "2024-09-23T09:24:58.650243+00:00",
      "updated_at": "2024-09-23T09:24:58.650243+00:00",
      "name": "Custom Field 2",
      "required": false,
      "position": null,
      "default_property_id": "c10946f7-29c1-4f79-a1ed-9e4536d7840f"
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