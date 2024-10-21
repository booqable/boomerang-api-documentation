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
      "id": "c7baf930-3c64-4887-9aeb-08c6032e2d47",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:44.289986+00:00",
        "updated_at": "2024-10-21T09:22:44.289986+00:00",
        "name": "Checkout item 3",
        "item_type": "field",
        "default_property_id": "9b52acf9-fa30-478f-b1ab-1a01f10d0cf7",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/9ce60d40-7cdf-4ff3-bb48-24b40840bd62?include=default_property' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9ce60d40-7cdf-4ff3-bb48-24b40840bd62",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-21T09:22:43.195104+00:00",
      "updated_at": "2024-10-21T09:22:43.195104+00:00",
      "name": "Checkout item 1",
      "item_type": "field",
      "default_property_id": "00d83b2a-451b-4502-bb5f-a783ffe1d732",
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
          "default_property_id": "6b92ac9b-4aba-43f1-b597-01e9bbf2dad8"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bdbb9ed8-b01a-4902-89d7-e865b663f94f",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-21T09:22:45.380869+00:00",
      "updated_at": "2024-10-21T09:22:45.380869+00:00",
      "name": "Mobile number",
      "item_type": "field",
      "default_property_id": "6b92ac9b-4aba-43f1-b597-01e9bbf2dad8",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/b52d29b6-9a48-4b98-ae59-b5574312a7f6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b52d29b6-9a48-4b98-ae59-b5574312a7f6",
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
    "id": "b52d29b6-9a48-4b98-ae59-b5574312a7f6",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-21T09:22:43.618834+00:00",
      "updated_at": "2024-10-21T09:22:43.637829+00:00",
      "name": "Additional information",
      "item_type": "field",
      "default_property_id": "a04cbe8f-e6e6-4fee-8b80-0abc10268590",
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
    --url 'https://example.booqable.com/api/boomerang/checkout_items/a2b9b46b-03db-4c0d-890e-c0b89fe053a3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a2b9b46b-03db-4c0d-890e-c0b89fe053a3",
    "type": "checkout_items",
    "attributes": {
      "created_at": "2024-10-21T09:22:44.749710+00:00",
      "updated_at": "2024-10-21T09:22:44.749710+00:00",
      "name": "Checkout item 4",
      "item_type": "field",
      "default_property_id": "c6d8bec4-79b1-46d9-b4a9-cac77e7e39f2",
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