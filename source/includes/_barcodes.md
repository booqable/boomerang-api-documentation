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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "a7d4b8b4-9d58-4737-92a3-26f5acf3b110",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-12T06:33:38+00:00",
        "updated_at": "2022-05-12T06:33:38+00:00",
        "number": "http://bqbl.it/a7d4b8b4-9d58-4737-92a3-26f5acf3b110",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fad4043e83fc5537c3aea1c62c17f7c0/barcode/image/a7d4b8b4-9d58-4737-92a3-26f5acf3b110/d0ee40d2-3b44-4cb8-ac3d-ec463bb96e75.svg",
        "owner_id": "49ef7a65-4810-47b0-a0e8-5f5e0ddf1543",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/49ef7a65-4810-47b0-a0e8-5f5e0ddf1543"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2b8e36f2-da60-4238-bbff-d12372ef4e1c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2b8e36f2-da60-4238-bbff-d12372ef4e1c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-12T06:33:38+00:00",
        "updated_at": "2022-05-12T06:33:38+00:00",
        "number": "http://bqbl.it/2b8e36f2-da60-4238-bbff-d12372ef4e1c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8821e8ab2c8eb5e7d543bda7b2c851fc/barcode/image/2b8e36f2-da60-4238-bbff-d12372ef4e1c/ffb09bc0-2d37-4518-98dc-76ef9b38fc5f.svg",
        "owner_id": "6adbc2ae-3d04-4a81-aa2a-4921389aab9b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6adbc2ae-3d04-4a81-aa2a-4921389aab9b"
          },
          "data": {
            "type": "customers",
            "id": "6adbc2ae-3d04-4a81-aa2a-4921389aab9b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6adbc2ae-3d04-4a81-aa2a-4921389aab9b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-12T06:33:38+00:00",
        "updated_at": "2022-05-12T06:33:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Harvey-Altenwerth",
        "email": "altenwerth_harvey@will-berge.info",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=6adbc2ae-3d04-4a81-aa2a-4921389aab9b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6adbc2ae-3d04-4a81-aa2a-4921389aab9b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6adbc2ae-3d04-4a81-aa2a-4921389aab9b&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTRlMGRmM2YtYTM5Ni00MGI1LWJhNmMtN2IyZjM1ZTliODcx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "54e0df3f-a396-40b5-ba6c-7b2f35e9b871",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-12T06:33:39+00:00",
        "updated_at": "2022-05-12T06:33:39+00:00",
        "number": "http://bqbl.it/54e0df3f-a396-40b5-ba6c-7b2f35e9b871",
        "barcode_type": "qr_code",
        "image_url": "/uploads/879d462d95e0f3bdb0008e25f0cf0204/barcode/image/54e0df3f-a396-40b5-ba6c-7b2f35e9b871/f3ba010f-b15c-4b35-b948-7533d45f0762.svg",
        "owner_id": "56a8db71-50ab-4273-ac8d-6ac4e7ae6c32",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/56a8db71-50ab-4273-ac8d-6ac4e7ae6c32"
          },
          "data": {
            "type": "customers",
            "id": "56a8db71-50ab-4273-ac8d-6ac4e7ae6c32"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "56a8db71-50ab-4273-ac8d-6ac4e7ae6c32",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-12T06:33:39+00:00",
        "updated_at": "2022-05-12T06:33:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Price-Thompson",
        "email": "thompson.price@weissnat.io",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=56a8db71-50ab-4273-ac8d-6ac4e7ae6c32&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=56a8db71-50ab-4273-ac8d-6ac4e7ae6c32&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=56a8db71-50ab-4273-ac8d-6ac4e7ae6c32&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-12T06:33:25Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/0f65de08-111e-4a6a-beb3-1b19585ffaa9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0f65de08-111e-4a6a-beb3-1b19585ffaa9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-12T06:33:39+00:00",
      "updated_at": "2022-05-12T06:33:39+00:00",
      "number": "http://bqbl.it/0f65de08-111e-4a6a-beb3-1b19585ffaa9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b3effa0b665790cf22374dc9475f42be/barcode/image/0f65de08-111e-4a6a-beb3-1b19585ffaa9/c3bfd85d-d429-4452-9b23-f41b5637f91c.svg",
      "owner_id": "716372e6-30e8-4dbf-93f2-3f5503a9c9e7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/716372e6-30e8-4dbf-93f2-3f5503a9c9e7"
        },
        "data": {
          "type": "customers",
          "id": "716372e6-30e8-4dbf-93f2-3f5503a9c9e7"
        }
      }
    }
  },
  "included": [
    {
      "id": "716372e6-30e8-4dbf-93f2-3f5503a9c9e7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-12T06:33:39+00:00",
        "updated_at": "2022-05-12T06:33:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Mitchell Inc",
        "email": "inc_mitchell@rice.co",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=716372e6-30e8-4dbf-93f2-3f5503a9c9e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=716372e6-30e8-4dbf-93f2-3f5503a9c9e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=716372e6-30e8-4dbf-93f2-3f5503a9c9e7&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`owner`






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
          "owner_id": "ffab0cac-b153-46fe-b488-9b03dd2d8877",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4ac8f484-6b55-410e-9233-1f92a4c3ed24",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-12T06:33:40+00:00",
      "updated_at": "2022-05-12T06:33:40+00:00",
      "number": "http://bqbl.it/4ac8f484-6b55-410e-9233-1f92a4c3ed24",
      "barcode_type": "qr_code",
      "image_url": "/uploads/55e3cb53397e3cf24c90b0b86b988c1c/barcode/image/4ac8f484-6b55-410e-9233-1f92a4c3ed24/a816d002-ebe2-4ecb-942a-e1c57f26e9b4.svg",
      "owner_id": "ffab0cac-b153-46fe-b488-9b03dd2d8877",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
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

`POST /api/boomerang/barcodes`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e73adcd0-b0de-41e2-a728-e242afe23495' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e73adcd0-b0de-41e2-a728-e242afe23495",
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
    "id": "e73adcd0-b0de-41e2-a728-e242afe23495",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-12T06:33:41+00:00",
      "updated_at": "2022-05-12T06:33:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/51a202e77b826f7a35c365feb870c175/barcode/image/e73adcd0-b0de-41e2-a728-e242afe23495/f047172a-a08a-47e2-b002-ebba99bb42e3.svg",
      "owner_id": "e8964b21-d896-412d-8a68-f56928f2ecd6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
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

`PUT /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/27ce2bbf-5c84-4390-bc0a-2ef0c99b07d7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes