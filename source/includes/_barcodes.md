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
      "id": "4361cd0d-c5cd-42d0-9e6a-38fe861f0a31",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-16T09:27:55.938519+00:00",
        "updated_at": "2024-09-16T09:27:55.938519+00:00",
        "number": "http://bqbl.it/4361cd0d-c5cd-42d0-9e6a-38fe861f0a31",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-291.lvh.me:/barcodes/4361cd0d-c5cd-42d0-9e6a-38fe861f0a31/image",
        "owner_id": "9efa309f-a881-4814-b3c8-41ce4932b4c0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F84dc224b-7419-498e-a1c7-6798f3433279&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "84dc224b-7419-498e-a1c7-6798f3433279",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-16T09:27:56.524775+00:00",
        "updated_at": "2024-09-16T09:27:56.524775+00:00",
        "number": "http://bqbl.it/84dc224b-7419-498e-a1c7-6798f3433279",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-292.lvh.me:/barcodes/84dc224b-7419-498e-a1c7-6798f3433279/image",
        "owner_id": "6d6bc732-2a8b-4574-b5a4-6c45f792a407",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "6d6bc732-2a8b-4574-b5a4-6c45f792a407"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6d6bc732-2a8b-4574-b5a4-6c45f792a407",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-16T09:27:56.481352+00:00",
        "updated_at": "2024-09-16T09:27:56.526530+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-81@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzlkZDIyZjctNmQxZS00M2VlLWI0MmQtOTRmMTkxOTkyMWZh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c9dd22f7-6d1e-43ee-b42d-94f1919921fa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-16T09:27:55.345878+00:00",
        "updated_at": "2024-09-16T09:27:55.345878+00:00",
        "number": "http://bqbl.it/c9dd22f7-6d1e-43ee-b42d-94f1919921fa",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-290.lvh.me:/barcodes/c9dd22f7-6d1e-43ee-b42d-94f1919921fa/image",
        "owner_id": "66199a24-652d-4b0e-ae5a-d210171f7f3a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "66199a24-652d-4b0e-ae5a-d210171f7f3a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "66199a24-652d-4b0e-ae5a-d210171f7f3a",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-16T09:27:55.308352+00:00",
        "updated_at": "2024-09-16T09:27:55.347929+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-79@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/34b2581b-8b03-48af-b7f3-ba272589b232?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "34b2581b-8b03-48af-b7f3-ba272589b232",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-16T09:27:54.691285+00:00",
      "updated_at": "2024-09-16T09:27:54.691285+00:00",
      "number": "http://bqbl.it/34b2581b-8b03-48af-b7f3-ba272589b232",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-289.lvh.me:/barcodes/34b2581b-8b03-48af-b7f3-ba272589b232/image",
      "owner_id": "568557fa-b47d-438d-b59d-b05cff22baf3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "568557fa-b47d-438d-b59d-b05cff22baf3"
        }
      }
    }
  },
  "included": [
    {
      "id": "568557fa-b47d-438d-b59d-b05cff22baf3",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-16T09:27:54.649128+00:00",
        "updated_at": "2024-09-16T09:27:54.693439+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-77@doe.test",
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
          "owner_id": "53579095-02b2-4d7c-b6d3-39709a23b898",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9f4bf2c1-2072-4815-a6b2-2b07800e2e4f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-16T09:27:52.981117+00:00",
      "updated_at": "2024-09-16T09:27:52.981117+00:00",
      "number": "http://bqbl.it/9f4bf2c1-2072-4815-a6b2-2b07800e2e4f",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-286.lvh.me:/barcodes/9f4bf2c1-2072-4815-a6b2-2b07800e2e4f/image",
      "owner_id": "53579095-02b2-4d7c-b6d3-39709a23b898",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5f5dc63a-02a5-437c-bca5-32ac010ef47d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5f5dc63a-02a5-437c-bca5-32ac010ef47d",
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
    "id": "5f5dc63a-02a5-437c-bca5-32ac010ef47d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-16T09:27:53.516438+00:00",
      "updated_at": "2024-09-16T09:27:53.591835+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-287.lvh.me:/barcodes/5f5dc63a-02a5-437c-bca5-32ac010ef47d/image",
      "owner_id": "2e47c07b-5234-4869-93cd-d1df32fd4732",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e83fe911-fa29-498a-b887-76badc5e6436' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e83fe911-fa29-498a-b887-76badc5e6436",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-16T09:27:54.097394+00:00",
      "updated_at": "2024-09-16T09:27:54.097394+00:00",
      "number": "http://bqbl.it/e83fe911-fa29-498a-b887-76badc5e6436",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-288.lvh.me:/barcodes/e83fe911-fa29-498a-b887-76badc5e6436/image",
      "owner_id": "fe829c2b-fc5b-41bb-9ad8-64b58acd9581",
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









