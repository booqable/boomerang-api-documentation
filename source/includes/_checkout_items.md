# Checkout items

Checkout items allow collecting additional information from the checkout.

## Endpoints
`DELETE /api/boomerang/checkout_items/{id}`

`PUT /api/boomerang/checkout_items/{id}`

`POST /api/boomerang/checkout_items`

`GET /api/boomerang/checkout_items/{id}`

`GET /api/boomerang/checkout_items`

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


## Destroying a checkout item



> How to delete a checkout item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/1a2885e6-b229-4dc4-9001-7a140e65124f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
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
## Updating a checkout item



> How to update a checkout item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/c8f86afd-6f63-4daf-a022-a058b46aa9ae' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c8f86afd-6f63-4daf-a022-a058b46aa9ae",
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
    "id": "c8f86afd-6f63-4daf-a022-a058b46aa9ae",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-03-04T09:16:39+00:00",
      "updated_at": "2024-03-04T09:16:39+00:00",
      "name": "Additional information",
      "item_type": "field",
      "default_property_id": "c26155cb-0a66-47ef-a8c1-047ed4f100c5",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
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
          "default_property_id": "d4842644-3288-47bc-a7dd-8ea4ae013e71"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4b78447c-ebcd-4d86-9343-5ffbde9327af",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-03-04T09:16:39+00:00",
      "updated_at": "2024-03-04T09:16:39+00:00",
      "name": "Mobile number",
      "item_type": "field",
      "default_property_id": "d4842644-3288-47bc-a7dd-8ea4ae013e71",
      "tooltip": null,
      "required": false,
      "position": 2,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
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
## Fetching a checkout item



> How to fetch a checkout item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/b8598144-22e7-42bd-b0e3-2b03cc9e0748?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b8598144-22e7-42bd-b0e3-2b03cc9e0748",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-03-04T09:16:40+00:00",
      "updated_at": "2024-03-04T09:16:40+00:00",
      "name": "Checkout item 4",
      "item_type": "field",
      "default_property_id": "e2503769-b9d8-411e-87fc-529870092e4f",
      "tooltip": null,
      "required": false,
      "position": 1,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/e2503769-b9d8-411e-87fc-529870092e4f"
        }
      }
    }
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
      "id": "1570eb0a-c99e-4b00-ade0-ef9de27845a8",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2024-03-04T09:16:40+00:00",
        "updated_at": "2024-03-04T09:16:40+00:00",
        "name": "Checkout item 5",
        "item_type": "field",
        "default_property_id": "5b612d83-3877-42b8-bd9f-264aebeeaacd",
        "tooltip": null,
        "required": false,
        "position": 1,
        "content": null,
        "image_alt_text": null,
        "image_url": null,
        "system": false
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/5b612d83-3877-42b8-bd9f-264aebeeaacd"
          }
        }
      }
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