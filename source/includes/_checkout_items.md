# Checkout items

Checkout items allow collecting additional information from the checkout.

## Endpoints
`GET /api/boomerang/checkout_items/{id}`

`POST /api/boomerang/checkout_items`

`GET /api/boomerang/checkout_items`

`DELETE /api/boomerang/checkout_items/{id}`

`PUT /api/boomerang/checkout_items/{id}`

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


## Fetching a checkout item



> How to fetch a checkout item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/c3a067c7-3a6c-4e99-b9a3-f74fbf428a93?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c3a067c7-3a6c-4e99-b9a3-f74fbf428a93",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2023-12-07T14:01:04+00:00",
      "updated_at": "2023-12-07T14:01:04+00:00",
      "name": "Checkout item 1",
      "item_type": "field",
      "default_property_id": "e91d4c16-b48a-420b-939f-b65bcd6317d1",
      "tooltip": null,
      "required": false,
      "position": null,
      "content": null,
      "image_alt_text": null,
      "image_url": null,
      "system": false
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": "api/boomerang/default_properties/e91d4c16-b48a-420b-939f-b65bcd6317d1"
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
          "default_property_id": "78550a45-6833-44a1-afa9-eabc5597e00a"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4a8a1d24-540c-4b88-a8cf-b057e77c5c5b",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2023-12-07T14:01:05+00:00",
      "updated_at": "2023-12-07T14:01:05+00:00",
      "name": "Mobile number",
      "item_type": "field",
      "default_property_id": "78550a45-6833-44a1-afa9-eabc5597e00a",
      "tooltip": null,
      "required": false,
      "position": null,
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
      "id": "95201e29-c1f5-4ea5-a821-dfc433b140ff",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2023-12-07T14:01:06+00:00",
        "updated_at": "2023-12-07T14:01:06+00:00",
        "name": "Checkout item 3",
        "item_type": "field",
        "default_property_id": "4b7583cc-9036-4eea-8e24-4d49ddc4ff23",
        "tooltip": null,
        "required": false,
        "position": null,
        "content": null,
        "image_alt_text": null,
        "image_url": null,
        "system": false
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": "api/boomerang/default_properties/4b7583cc-9036-4eea-8e24-4d49ddc4ff23"
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
## Destroying a checkout item



> How to delete a checkout item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/checkout_items/79294a39-0ae0-44d9-aa43-63ae50781f21' \
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/624b1812-7e8e-4cd4-8b66-b2dec46ec672' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "624b1812-7e8e-4cd4-8b66-b2dec46ec672",
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
    "id": "624b1812-7e8e-4cd4-8b66-b2dec46ec672",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2023-12-07T14:01:07+00:00",
      "updated_at": "2023-12-07T14:01:07+00:00",
      "name": "Additional information",
      "item_type": "field",
      "default_property_id": "bb5c347a-4354-472f-aa14-62ae3ce0b355",
      "tooltip": null,
      "required": false,
      "position": null,
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