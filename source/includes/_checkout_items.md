# Checkout items

Checkout items allow collecting additional information from the checkout.

## Relationships
Name | Description
-- | --
`default_property` | **[Default property](#default-properties)** `optional`<br>When `item_type` is set to `field`, then the collected information will be stored in a customer or order [Property](#properties) linked to this DefaultProperty. 


Check matching attributes under [Fields](#checkout-items-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`content` | **string** <br>Text content of the checkout item. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default_property_id` | **uuid** `nullable`<br>The ID of the default property which will be used to store the collected information. 
`deletable` | **boolean** `readonly`<br>Whether the checkout item can be deleted. 
`id` | **uuid** `readonly`<br>Primary key.
`image_alt_text` | **string** <br>Alternative text for the image checkout item. 
`image_base64` | **string** `writeonly`<br>Base64 encoded image file, only for upload. 
`image_url` | **string** `readonly`<br>Image URL of the checkout item. 
`item_type` | **string** <br>The kind of information or type of input that is presented to the customer during checkout. 
`name` | **string** <br>Name of the field, will be shown as a field label in the checkout. 
`pickup_requires_billing_address` | **boolean** <br>Whether the billing address is required for pickup checkout item. 
`position` | **integer** <br>Used to determine sorting relative to other checkout items. 
`remove_image` | **boolean** `writeonly`<br>Set to true to remove existing image from checkout item. 
`required` | **boolean** <br>Whether the item is required to complete checkout. 
`system` | **boolean** `readonly`<br>System checkout item name cannot be changed or deleted. 
`tooltip` | **string** <br>Tooltip to describe purpose of the field to the user. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List checkout items


> How to fetch a list of checkout items:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/checkout_items'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "47b421ee-aec1-4083-8f56-83fb3c03df4b",
        "type": "checkout_items",
        "attributes": {
          "created_at": "2026-07-08T14:18:00.000000+00:00",
          "updated_at": "2026-07-08T14:18:00.000000+00:00",
          "name": "Checkout item 1",
          "item_type": "field",
          "tooltip": null,
          "required": false,
          "position": 1,
          "content": null,
          "image_alt_text": null,
          "pickup_requires_billing_address": null,
          "image_url": null,
          "system": false,
          "deletable": true,
          "default_property_id": "09ad8c93-c08d-4bcc-8a82-c4d72cfe2130"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[checkout_items]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`content` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default_property_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`image_alt_text` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`item_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`pickup_requires_billing_address` | **boolean** <br>`eq`
`required` | **boolean** <br>`eq`
`tooltip` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a checkout item


> How to fetch a checkout item:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/checkout_items/43d84523-90f9-4381-80f1-9e3503301a03'
       --header 'content-type: application/json'
       --data-urlencode 'include=default_property'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "43d84523-90f9-4381-80f1-9e3503301a03",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2027-10-05T19:41:00.000000+00:00",
        "updated_at": "2027-10-05T19:41:00.000000+00:00",
        "name": "Checkout item 2",
        "item_type": "field",
        "tooltip": null,
        "required": false,
        "position": 1,
        "content": null,
        "image_alt_text": null,
        "pickup_requires_billing_address": null,
        "image_url": null,
        "system": false,
        "deletable": true,
        "default_property_id": "c6e5a814-138a-46fa-89c6-8f85dfa187c7"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[checkout_items]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Create a checkout item


> How to create a checkout item:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/checkout_items'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "checkout_items",
           "attributes": {
             "name": "Mobile number",
             "item_type": "field",
             "default_property_id": "d7f62fec-905e-40be-8929-16eee598f915"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "1d595b96-2e6f-4f1e-8792-d63b6a665c86",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2022-11-25T09:31:00.000000+00:00",
        "updated_at": "2022-11-25T09:31:00.000000+00:00",
        "name": "Mobile number",
        "item_type": "field",
        "tooltip": null,
        "required": false,
        "position": 2,
        "content": null,
        "image_alt_text": null,
        "pickup_requires_billing_address": null,
        "image_url": null,
        "system": false,
        "deletable": true,
        "default_property_id": "d7f62fec-905e-40be-8929-16eee598f915"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[checkout_items]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][content]` | **string** <br>Text content of the checkout item. 
`data[attributes][default_property_id]` | **uuid** <br>The ID of the default property which will be used to store the collected information. 
`data[attributes][image_alt_text]` | **string** <br>Alternative text for the image checkout item. 
`data[attributes][image_base64]` | **string** <br>Base64 encoded image file, only for upload. 
`data[attributes][item_type]` | **string** <br>The kind of information or type of input that is presented to the customer during checkout. 
`data[attributes][name]` | **string** <br>Name of the field, will be shown as a field label in the checkout. 
`data[attributes][pickup_requires_billing_address]` | **boolean** <br>Whether the billing address is required for pickup checkout item. 
`data[attributes][position]` | **integer** <br>Used to determine sorting relative to other checkout items. 
`data[attributes][remove_image]` | **boolean** <br>Set to true to remove existing image from checkout item. 
`data[attributes][tooltip]` | **string** <br>Tooltip to describe purpose of the field to the user. 


### Includes

This request does not accept any includes
## Update a checkout item


> How to update a checkout item:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/checkout_items/4fe050ea-f471-4aaa-8533-5170a76ab162'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "4fe050ea-f471-4aaa-8533-5170a76ab162",
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
      "id": "4fe050ea-f471-4aaa-8533-5170a76ab162",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2023-01-11T00:58:00.000000+00:00",
        "updated_at": "2023-01-11T00:58:00.000000+00:00",
        "name": "Additional information",
        "item_type": "field",
        "tooltip": null,
        "required": false,
        "position": 1,
        "content": null,
        "image_alt_text": null,
        "pickup_requires_billing_address": null,
        "image_url": null,
        "system": false,
        "deletable": true,
        "default_property_id": "67731f77-5baf-44d1-8f82-786f41d95c09"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[checkout_items]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][content]` | **string** <br>Text content of the checkout item. 
`data[attributes][default_property_id]` | **uuid** <br>The ID of the default property which will be used to store the collected information. 
`data[attributes][image_alt_text]` | **string** <br>Alternative text for the image checkout item. 
`data[attributes][image_base64]` | **string** <br>Base64 encoded image file, only for upload. 
`data[attributes][item_type]` | **string** <br>The kind of information or type of input that is presented to the customer during checkout. 
`data[attributes][name]` | **string** <br>Name of the field, will be shown as a field label in the checkout. 
`data[attributes][pickup_requires_billing_address]` | **boolean** <br>Whether the billing address is required for pickup checkout item. 
`data[attributes][position]` | **integer** <br>Used to determine sorting relative to other checkout items. 
`data[attributes][remove_image]` | **boolean** <br>Set to true to remove existing image from checkout item. 
`data[attributes][tooltip]` | **string** <br>Tooltip to describe purpose of the field to the user. 


### Includes

This request does not accept any includes
## Destroy a checkout item


> How to delete a checkout item:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/checkout_items/f91ba73e-38f1-4d23-805e-4a9cc57bada6'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "f91ba73e-38f1-4d23-805e-4a9cc57bada6",
      "type": "checkout_items",
      "attributes": {
        "created_at": "2028-08-11T08:59:02.000000+00:00",
        "updated_at": "2028-08-11T08:59:02.000000+00:00",
        "name": "Checkout item 5",
        "item_type": "field",
        "tooltip": null,
        "required": false,
        "position": 1,
        "content": null,
        "image_alt_text": null,
        "pickup_requires_billing_address": null,
        "image_url": null,
        "system": false,
        "deletable": true,
        "default_property_id": "b3615f04-4496-49c0-857d-c35a37f01b3c"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[checkout_items]=created_at,updated_at,name`


### Includes

This request does not accept any includes