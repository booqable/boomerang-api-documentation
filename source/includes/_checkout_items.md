# Checkout items

Checkout items allow collecting additional information from the checkout.

## Endpoints
`GET /api/boomerang/checkout_items`

`GET /api/boomerang/checkout_items/{id}`

`POST /api/boomerang/checkout_items`

`PUT /api/boomerang/checkout_items/{id}`

`DELETE /api/boomerang/checkout_items/{id}`

## Fields
Every checkout item has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the field, will be shown as a field label in the checkout
`item_type` | **String** <br>What kind of input will be presented to the customer during checkout
`default_property_id` | **Uuid** <br>The associated Default property
`tooltip` | **String** <br>Tooltip for the checkout item
`required` | **Boolean** <br>Whether the item is required to complete checkout
`position` | **Integer** <br>Used to determine sorting relative to other checkout items
`content` | **String** <br>Text content of the checkout item
`image_base64` | **String** `writeonly`<br>Base64 encoded image file, only for upload
`remove_image` | **Boolean** `writeonly`<br>Set to true to remove existing image from checkout item
`image_alt_text` | **String** <br>Alternative text for the image checkout item
`pickup_requires_billing_address` | **Boolean** <br>Whether the billing address is required for pickup checkout item
`image_url` | **String** `readonly`<br>Image URL of the checkout item
`system` | **Boolean** `readonly`<br>System checkout item name can not be changed or deleted
`deletable` | **Boolean** `readonly`<br>Whether the checkout item can be deleted


## Relationships
Checkout items have the following relationships:

Name | Description
-- | --
`default_property` | **Default properties** `readonly`<br>Associated Default property


## Listing checkout items



> How to fetch a list of checkout items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7f89774d-0ffd-4b52-985d-be9d4d54b3e3",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2024-09-23T09:22:47.109763+00:00",
        "updated_at": "2024-09-23T09:22:47.109763+00:00",
        "name": "Checkout item 4",
        "item_type": "field",
        "default_property_id": "823ca911-b0df-4360-9a5f-ae0b7de1fab1",
        "tooltip": null,
        "required": false,
        "position": 1,
        "content": null,
        "image_alt_text": null,
        "pickup_requires_billing_address": null,
        "image_url": null,
        "system": false,
        "deletable": true
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/checkout_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_items]=created_at,updated_at,name`
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
`item_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default_property_id` | **Uuid** <br>`eq`, `not_eq`
`tooltip` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`required` | **Boolean** <br>`eq`
`content` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`image_alt_text` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`pickup_requires_billing_address` | **Boolean** <br>`eq`
`system` | **Boolean** <br>`eq`
`deletable` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a checkout item



> How to fetch a checkout item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/0539f8d1-98c0-45dc-a692-254afbd6e359?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0539f8d1-98c0-45dc-a692-254afbd6e359",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-09-23T09:22:47.556245+00:00",
      "updated_at": "2024-09-23T09:22:47.556245+00:00",
      "name": "Checkout item 5",
      "item_type": "field",
      "default_property_id": "3d69ab5a-f76d-4ae0-8ef4-de89a0768bd1",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "pickup_requires_billing_address": null,
      "image_url": null,
      "system": false,
      "deletable": true
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/checkout_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_items]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Creating a checkout item



> How to create a checkout item:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/checkout_items' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "checkout_items",
        "attributes": {
          "name": "Mobile number",
          "item_type": "field",
          "default_property_id": "3b677a59-01e0-4d93-a9e2-48d5be2c3c01"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7ada7c9b-647f-4aaa-b141-2648c34616ef",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-09-23T09:22:45.795212+00:00",
      "updated_at": "2024-09-23T09:22:45.795212+00:00",
      "name": "Mobile number",
      "item_type": "field",
      "default_property_id": "3b677a59-01e0-4d93-a9e2-48d5be2c3c01",
      "tooltip": null,
      "required": false,
      "position": 2,
      "content": null,
      "image_alt_text": null,
      "pickup_requires_billing_address": null,
      "image_url": null,
      "system": false,
      "deletable": true
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/checkout_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_items]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the field, will be shown as a field label in the checkout
`data[attributes][item_type]` | **String** <br>What kind of input will be presented to the customer during checkout
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][tooltip]` | **String** <br>Tooltip for the checkout item
`data[attributes][position]` | **Integer** <br>Used to determine sorting relative to other checkout items
`data[attributes][content]` | **String** <br>Text content of the checkout item
`data[attributes][image_base64]` | **String** <br>Base64 encoded image file, only for upload
`data[attributes][remove_image]` | **Boolean** <br>Set to true to remove existing image from checkout item
`data[attributes][image_alt_text]` | **String** <br>Alternative text for the image checkout item
`data[attributes][pickup_requires_billing_address]` | **Boolean** <br>Whether the billing address is required for pickup checkout item


### Includes

This request does not accept any includes
## Updating a checkout item



> How to update a checkout item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/ddc59a37-6ab0-424b-8c67-6f517721cf50' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ddc59a37-6ab0-424b-8c67-6f517721cf50",
        "type": "checkout_items",
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
    "id": "ddc59a37-6ab0-424b-8c67-6f517721cf50",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-09-23T09:22:46.220994+00:00",
      "updated_at": "2024-09-23T09:22:46.239469+00:00",
      "name": "Additional information",
      "item_type": "field",
      "default_property_id": "f5e1a02e-07a4-4d88-899f-22d368bc2f26",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "pickup_requires_billing_address": null,
      "image_url": null,
      "system": false,
      "deletable": true
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/checkout_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_items]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the field, will be shown as a field label in the checkout
`data[attributes][item_type]` | **String** <br>What kind of input will be presented to the customer during checkout
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][tooltip]` | **String** <br>Tooltip for the checkout item
`data[attributes][position]` | **Integer** <br>Used to determine sorting relative to other checkout items
`data[attributes][content]` | **String** <br>Text content of the checkout item
`data[attributes][image_base64]` | **String** <br>Base64 encoded image file, only for upload
`data[attributes][remove_image]` | **Boolean** <br>Set to true to remove existing image from checkout item
`data[attributes][image_alt_text]` | **String** <br>Alternative text for the image checkout item
`data[attributes][pickup_requires_billing_address]` | **Boolean** <br>Whether the billing address is required for pickup checkout item


### Includes

This request does not accept any includes
## Destroying a checkout item



> How to delete a checkout item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/8a1bbd34-f484-42f0-a477-7f4893ef2bff' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8a1bbd34-f484-42f0-a477-7f4893ef2bff",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-09-23T09:22:46.660298+00:00",
      "updated_at": "2024-09-23T09:22:46.660298+00:00",
      "name": "Checkout item 3",
      "item_type": "field",
      "default_property_id": "63649186-e55a-497f-a1ce-6419acc7e6f5",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "pickup_requires_billing_address": null,
      "image_url": null,
      "system": false,
      "deletable": true
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/checkout_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[checkout_items]=created_at,updated_at,name`


### Includes

This request does not accept any includes