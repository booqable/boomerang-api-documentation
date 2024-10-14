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
      "id": "ab2d8e6d-23a1-4e02-bb96-182b57bbd46b",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:37.895817+00:00",
        "updated_at": "2024-10-14T09:25:37.895817+00:00",
        "name": "Checkout item 2",
        "item_type": "field",
        "default_property_id": "9212482a-b320-4541-8f79-27073d60716d",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/df5871b8-5f93-44c5-9f37-e9a1c1391217?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df5871b8-5f93-44c5-9f37-e9a1c1391217",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-14T09:25:37.440909+00:00",
      "updated_at": "2024-10-14T09:25:37.440909+00:00",
      "name": "Checkout item 1",
      "item_type": "field",
      "default_property_id": "69030af2-c7ac-4226-bf06-c86c2ccaebd5",
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
          "default_property_id": "48fd08e3-daf0-46e0-81f7-571c5f55e47f"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1e228eac-498e-4f34-95a1-a5eaed9a762c",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-14T09:25:38.367483+00:00",
      "updated_at": "2024-10-14T09:25:38.367483+00:00",
      "name": "Mobile number",
      "item_type": "field",
      "default_property_id": "48fd08e3-daf0-46e0-81f7-571c5f55e47f",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/1b30d217-9e9b-44d1-bad1-4a76a0d5e84f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1b30d217-9e9b-44d1-bad1-4a76a0d5e84f",
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
    "id": "1b30d217-9e9b-44d1-bad1-4a76a0d5e84f",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-14T09:25:39.183972+00:00",
      "updated_at": "2024-10-14T09:25:39.200982+00:00",
      "name": "Additional information",
      "item_type": "field",
      "default_property_id": "aae2c94a-6845-4593-9353-1db730f2b213",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/116b60f1-d901-4ac6-ac06-0bead3df1ae4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "116b60f1-d901-4ac6-ac06-0bead3df1ae4",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-14T09:25:38.770985+00:00",
      "updated_at": "2024-10-14T09:25:38.770985+00:00",
      "name": "Checkout item 4",
      "item_type": "field",
      "default_property_id": "87132c82-10cd-431b-91b2-5cc61f06ad25",
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