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
`image_url` | **String** `readonly`<br>Image URL of the checkout item
`system` | **Boolean** `readonly`<br>System checkout item name can not be changed or deleted


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
      "id": "e0297981-241a-4137-a7b9-0846e45392bb",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2024-08-05T09:26:25.639603+00:00",
        "updated_at": "2024-08-05T09:26:25.639603+00:00",
        "name": "Checkout item 3",
        "item_type": "field",
        "default_property_id": "271ef1e0-3996-43a2-9da9-065d4731da09",
        "tooltip": null,
        "required": false,
        "position": 1,
        "content": null,
        "image_alt_text": null,
        "image_url": null,
        "system": false
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
`system` | **Boolean** <br>`eq`


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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/a1b8f32a-eaaa-4e23-bcb1-1812444875ad?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a1b8f32a-eaaa-4e23-bcb1-1812444875ad",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-08-05T09:26:26.945819+00:00",
      "updated_at": "2024-08-05T09:26:26.945819+00:00",
      "name": "Checkout item 5",
      "item_type": "field",
      "default_property_id": "3dd70003-a00e-473b-8a73-38690ddebcb6",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
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
          "default_property_id": "61181c9f-a579-4520-95e1-e813b7120c83"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "92cf4eef-1343-4aa4-9217-cf585a8ef4fa",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-08-05T09:26:24.565056+00:00",
      "updated_at": "2024-08-05T09:26:24.565056+00:00",
      "name": "Mobile number",
      "item_type": "field",
      "default_property_id": "61181c9f-a579-4520-95e1-e813b7120c83",
      "tooltip": null,
      "required": false,
      "position": 2,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
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


### Includes

This request does not accept any includes
## Updating a checkout item



> How to update a checkout item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/ccf20e17-9895-4c8a-a02d-020d8fe7398d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ccf20e17-9895-4c8a-a02d-020d8fe7398d",
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
    "id": "ccf20e17-9895-4c8a-a02d-020d8fe7398d",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-08-05T09:26:25.070197+00:00",
      "updated_at": "2024-08-05T09:26:25.094580+00:00",
      "name": "Additional information",
      "item_type": "field",
      "default_property_id": "bb98ca0f-519f-494f-a35f-3d7627a30a4b",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
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


### Includes

This request does not accept any includes
## Destroying a checkout item



> How to delete a checkout item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/bbebe2aa-7808-4da2-a7d7-c7d5dfe79fa7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bbebe2aa-7808-4da2-a7d7-c7d5dfe79fa7",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-08-05T09:26:26.429320+00:00",
      "updated_at": "2024-08-05T09:26:26.429320+00:00",
      "name": "Checkout item 4",
      "item_type": "field",
      "default_property_id": "7d8b50cc-6f7d-483c-a9f5-ae24293e7c78",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
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