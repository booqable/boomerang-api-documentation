# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

Note that when using URLs as numbers, it's advised to base64 encode the number before filtering.

## Endpoints
`GET /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
-- | --
`owner` | **Customer, Product, Order, Stock item** <br>Associated Owner


## Listing barcodes



> How to fetch a list of barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8b486788-b05a-4cdf-a8b8-047ebf4f5964",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-02T09:25:49.250905+00:00",
        "updated_at": "2024-09-02T09:25:49.250905+00:00",
        "number": "http://bqbl.it/8b486788-b05a-4cdf-a8b8-047ebf4f5964",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-116.lvh.me:/barcodes/8b486788-b05a-4cdf-a8b8-047ebf4f5964/image",
        "owner_id": "8d0a64e7-67e0-4313-ac46-8076646712d4",
        "owner_type": "customers"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbbd18387-d18e-4e24-ab85-09eef91a5e96&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bbd18387-d18e-4e24-ab85-09eef91a5e96",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-02T09:25:48.585656+00:00",
        "updated_at": "2024-09-02T09:25:48.585656+00:00",
        "number": "http://bqbl.it/bbd18387-d18e-4e24-ab85-09eef91a5e96",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-115.lvh.me:/barcodes/bbd18387-d18e-4e24-ab85-09eef91a5e96/image",
        "owner_id": "98696e68-39aa-4207-b86e-af860c4f50d5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "98696e68-39aa-4207-b86e-af860c4f50d5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "98696e68-39aa-4207-b86e-af860c4f50d5",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-02T09:25:48.542657+00:00",
        "updated_at": "2024-09-02T09:25:48.587525+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-22@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDBmOTFjNmYtNzc3Mi00NmM2LWEwMmUtNTI0OGY1MjUyNjBm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "00f91c6f-7772-46c6-a02e-5248f525260f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-02T09:25:50.063299+00:00",
        "updated_at": "2024-09-02T09:25:50.063299+00:00",
        "number": "http://bqbl.it/00f91c6f-7772-46c6-a02e-5248f525260f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-117.lvh.me:/barcodes/00f91c6f-7772-46c6-a02e-5248f525260f/image",
        "owner_id": "5dabc986-a541-43b4-a7bc-d03437327a28",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "5dabc986-a541-43b4-a7bc-d03437327a28"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5dabc986-a541-43b4-a7bc-d03437327a28",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-02T09:25:50.015853+00:00",
        "updated_at": "2024-09-02T09:25:50.065550+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-25@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
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
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a8ece10f-66b1-4850-85bb-f2c23b7b3d37?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a8ece10f-66b1-4850-85bb-f2c23b7b3d37",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-02T09:25:50.828937+00:00",
      "updated_at": "2024-09-02T09:25:50.828937+00:00",
      "number": "http://bqbl.it/a8ece10f-66b1-4850-85bb-f2c23b7b3d37",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-118.lvh.me:/barcodes/a8ece10f-66b1-4850-85bb-f2c23b7b3d37/image",
      "owner_id": "f3fe12c7-b79c-42a0-9e72-e1ae0a684ea5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "f3fe12c7-b79c-42a0-9e72-e1ae0a684ea5"
        }
      }
    }
  },
  "included": [
    {
      "id": "f3fe12c7-b79c-42a0-9e72-e1ae0a684ea5",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-02T09:25:50.764076+00:00",
        "updated_at": "2024-09-02T09:25:50.830905+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-26@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Creating a barcode



> How to create a barcode:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/barcodes' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "barcodes",
        "attributes": {
          "barcode_type": "qr_code",
          "owner_id": "aad76cf7-6e42-447c-875b-82b648f783b0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "11c14e61-1080-4038-b157-4eeac1dd598e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-02T09:25:52.388251+00:00",
      "updated_at": "2024-09-02T09:25:52.388251+00:00",
      "number": "http://bqbl.it/11c14e61-1080-4038-b157-4eeac1dd598e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-120.lvh.me:/barcodes/11c14e61-1080-4038-b157-4eeac1dd598e/image",
      "owner_id": "aad76cf7-6e42-447c-875b-82b648f783b0",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/7de4bde7-2418-47ae-a5cc-7f59ce56f4ce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7de4bde7-2418-47ae-a5cc-7f59ce56f4ce",
        "type": "barcodes",
        "attributes": {
          "number": "https://myfancysite.com"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7de4bde7-2418-47ae-a5cc-7f59ce56f4ce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-02T09:25:51.587615+00:00",
      "updated_at": "2024-09-02T09:25:51.681975+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-119.lvh.me:/barcodes/7de4bde7-2418-47ae-a5cc-7f59ce56f4ce/image",
      "owner_id": "de7ecdf3-cde0-4adc-9498-dde61b549093",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f48464e-ccd3-4c17-b595-9167e500621a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9f48464e-ccd3-4c17-b595-9167e500621a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-02T09:25:52.983199+00:00",
      "updated_at": "2024-09-02T09:25:52.983199+00:00",
      "number": "http://bqbl.it/9f48464e-ccd3-4c17-b595-9167e500621a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-121.lvh.me:/barcodes/9f48464e-ccd3-4c17-b595-9167e500621a/image",
      "owner_id": "1e6cd281-ad3b-410b-8e61-3d6b8108de9e",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`









