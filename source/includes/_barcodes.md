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
      "id": "2bebb230-3665-4a80-aa45-d9a7a3b571cb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-30T09:29:30.724393+00:00",
        "updated_at": "2024-09-30T09:29:30.724393+00:00",
        "number": "http://bqbl.it/2bebb230-3665-4a80-aa45-d9a7a3b571cb",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-284.lvh.me:/barcodes/2bebb230-3665-4a80-aa45-d9a7a3b571cb/image",
        "owner_id": "a507a1fc-433b-433a-9a79-db0c7ceb5996",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbbf256d7-a28a-48d0-92eb-f42398951c6b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bbf256d7-a28a-48d0-92eb-f42398951c6b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-30T09:29:31.380154+00:00",
        "updated_at": "2024-09-30T09:29:31.380154+00:00",
        "number": "http://bqbl.it/bbf256d7-a28a-48d0-92eb-f42398951c6b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-285.lvh.me:/barcodes/bbf256d7-a28a-48d0-92eb-f42398951c6b/image",
        "owner_id": "24b091cf-73bf-4b92-a786-51152386a240",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "24b091cf-73bf-4b92-a786-51152386a240"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "24b091cf-73bf-4b92-a786-51152386a240",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-30T09:29:31.328043+00:00",
        "updated_at": "2024-09-30T09:29:31.382077+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-84@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjE2MGE3MmEtMWVkNC00MTkxLWFjZGEtZGM2MGJmNTA5ODgz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6160a72a-1ed4-4191-acda-dc60bf509883",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-30T09:29:30.141784+00:00",
        "updated_at": "2024-09-30T09:29:30.141784+00:00",
        "number": "http://bqbl.it/6160a72a-1ed4-4191-acda-dc60bf509883",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-283.lvh.me:/barcodes/6160a72a-1ed4-4191-acda-dc60bf509883/image",
        "owner_id": "95638f66-86c9-4460-8c61-266bc140359b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "95638f66-86c9-4460-8c61-266bc140359b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "95638f66-86c9-4460-8c61-266bc140359b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-30T09:29:30.097956+00:00",
        "updated_at": "2024-09-30T09:29:30.143872+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-82@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/70b5308b-1300-4c06-a015-cc9bed779abd?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "70b5308b-1300-4c06-a015-cc9bed779abd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-30T09:29:28.104181+00:00",
      "updated_at": "2024-09-30T09:29:28.104181+00:00",
      "number": "http://bqbl.it/70b5308b-1300-4c06-a015-cc9bed779abd",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-280.lvh.me:/barcodes/70b5308b-1300-4c06-a015-cc9bed779abd/image",
      "owner_id": "26fed2a8-de83-484f-975e-82e6abfe2772",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "26fed2a8-de83-484f-975e-82e6abfe2772"
        }
      }
    }
  },
  "included": [
    {
      "id": "26fed2a8-de83-484f-975e-82e6abfe2772",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-30T09:29:28.056359+00:00",
        "updated_at": "2024-09-30T09:29:28.106351+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-78@doe.test",
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
          "owner_id": "e00a5801-28b8-4789-a2a8-2f13d0e31a8c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ad11fb6a-d98e-4ad4-949f-8a1e17f165ab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-30T09:29:32.186519+00:00",
      "updated_at": "2024-09-30T09:29:32.186519+00:00",
      "number": "http://bqbl.it/ad11fb6a-d98e-4ad4-949f-8a1e17f165ab",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-286.lvh.me:/barcodes/ad11fb6a-d98e-4ad4-949f-8a1e17f165ab/image",
      "owner_id": "e00a5801-28b8-4789-a2a8-2f13d0e31a8c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/075fd9c4-c8d9-44b8-9184-67100e92ce60' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "075fd9c4-c8d9-44b8-9184-67100e92ce60",
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
    "id": "075fd9c4-c8d9-44b8-9184-67100e92ce60",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-30T09:29:28.731046+00:00",
      "updated_at": "2024-09-30T09:29:28.801079+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-281.lvh.me:/barcodes/075fd9c4-c8d9-44b8-9184-67100e92ce60/image",
      "owner_id": "095fcacb-49ea-4667-adff-70416da9edd9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4919f616-b617-4c9a-bea2-9d4182bb2e6b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4919f616-b617-4c9a-bea2-9d4182bb2e6b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-30T09:29:29.335524+00:00",
      "updated_at": "2024-09-30T09:29:29.335524+00:00",
      "number": "http://bqbl.it/4919f616-b617-4c9a-bea2-9d4182bb2e6b",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-282.lvh.me:/barcodes/4919f616-b617-4c9a-bea2-9d4182bb2e6b/image",
      "owner_id": "c9010af9-6c3d-422f-95f7-7b5724fce58a",
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









