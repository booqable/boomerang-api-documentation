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
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "efdf2687-5163-4769-b14d-ed0780b2634a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T10:47:56+00:00",
        "updated_at": "2023-02-21T10:47:56+00:00",
        "number": "http://bqbl.it/efdf2687-5163-4769-b14d-ed0780b2634a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ffb36320c6286080ffb12a66c0b9e5b4/barcode/image/efdf2687-5163-4769-b14d-ed0780b2634a/833c3c07-b905-4d22-bbc0-a0d02248fcdb.svg",
        "owner_id": "7749669c-063b-4571-8a8d-c92fc50af27d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7749669c-063b-4571-8a8d-c92fc50af27d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4b89495f-7aad-4b58-a8d0-28f780908b17&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4b89495f-7aad-4b58-a8d0-28f780908b17",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T10:47:56+00:00",
        "updated_at": "2023-02-21T10:47:56+00:00",
        "number": "http://bqbl.it/4b89495f-7aad-4b58-a8d0-28f780908b17",
        "barcode_type": "qr_code",
        "image_url": "/uploads/254880957fcd6b49435b0f6e7106c238/barcode/image/4b89495f-7aad-4b58-a8d0-28f780908b17/18c82172-b07f-4020-ad7f-7e4c8697cc14.svg",
        "owner_id": "f81f34b5-f46d-4335-93fa-07aadde562c4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f81f34b5-f46d-4335-93fa-07aadde562c4"
          },
          "data": {
            "type": "customers",
            "id": "f81f34b5-f46d-4335-93fa-07aadde562c4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f81f34b5-f46d-4335-93fa-07aadde562c4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T10:47:56+00:00",
        "updated_at": "2023-02-21T10:47:56+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=f81f34b5-f46d-4335-93fa-07aadde562c4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f81f34b5-f46d-4335-93fa-07aadde562c4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f81f34b5-f46d-4335-93fa-07aadde562c4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzc1ZWNiODgtNzNjNy00NWJlLThmNjYtNzUzZjA1MTQ4MmRm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c75ecb88-73c7-45be-8f66-753f051482df",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T10:47:57+00:00",
        "updated_at": "2023-02-21T10:47:57+00:00",
        "number": "http://bqbl.it/c75ecb88-73c7-45be-8f66-753f051482df",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f4dce2eac1567dbaff64141f1f55b9e5/barcode/image/c75ecb88-73c7-45be-8f66-753f051482df/bd69e9b5-0168-404f-9236-956536a93511.svg",
        "owner_id": "4fce9f36-224e-418f-aa90-ba0512ba880d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4fce9f36-224e-418f-aa90-ba0512ba880d"
          },
          "data": {
            "type": "customers",
            "id": "4fce9f36-224e-418f-aa90-ba0512ba880d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4fce9f36-224e-418f-aa90-ba0512ba880d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T10:47:57+00:00",
        "updated_at": "2023-02-21T10:47:57+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=4fce9f36-224e-418f-aa90-ba0512ba880d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4fce9f36-224e-418f-aa90-ba0512ba880d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4fce9f36-224e-418f-aa90-ba0512ba880d&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:47:37Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/03d6b288-222c-4064-adfe-c0fd3323fe6f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "03d6b288-222c-4064-adfe-c0fd3323fe6f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T10:47:57+00:00",
      "updated_at": "2023-02-21T10:47:57+00:00",
      "number": "http://bqbl.it/03d6b288-222c-4064-adfe-c0fd3323fe6f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bc2f388aa956da652ff7c8879ed4c0d4/barcode/image/03d6b288-222c-4064-adfe-c0fd3323fe6f/41da1265-f573-4c02-a753-a47e7808bb4e.svg",
      "owner_id": "c48d9d56-5f32-40e0-8667-d42125e2bc0c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c48d9d56-5f32-40e0-8667-d42125e2bc0c"
        },
        "data": {
          "type": "customers",
          "id": "c48d9d56-5f32-40e0-8667-d42125e2bc0c"
        }
      }
    }
  },
  "included": [
    {
      "id": "c48d9d56-5f32-40e0-8667-d42125e2bc0c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T10:47:57+00:00",
        "updated_at": "2023-02-21T10:47:57+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-5@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=c48d9d56-5f32-40e0-8667-d42125e2bc0c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c48d9d56-5f32-40e0-8667-d42125e2bc0c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c48d9d56-5f32-40e0-8667-d42125e2bc0c&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "2ea2f3a8-6977-4e1d-ad03-4a786e90736c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "126c26fc-f04c-4aaf-8b02-26ba9820a026",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T10:47:58+00:00",
      "updated_at": "2023-02-21T10:47:58+00:00",
      "number": "http://bqbl.it/126c26fc-f04c-4aaf-8b02-26ba9820a026",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e6cbbbb073059f4e802a3d3ca62bb28b/barcode/image/126c26fc-f04c-4aaf-8b02-26ba9820a026/a6aae958-0d9a-4ed5-8ef1-8eec56789764.svg",
      "owner_id": "2ea2f3a8-6977-4e1d-ad03-4a786e90736c",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/dbe65eb3-43d8-4e8e-8c8e-311d1592ee42' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dbe65eb3-43d8-4e8e-8c8e-311d1592ee42",
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
    "id": "dbe65eb3-43d8-4e8e-8c8e-311d1592ee42",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T10:47:58+00:00",
      "updated_at": "2023-02-21T10:47:58+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ec530eb61d66407ac947f2243c2fb7c2/barcode/image/dbe65eb3-43d8-4e8e-8c8e-311d1592ee42/c3620eed-1d13-4cbb-9f21-f8af7d7321bd.svg",
      "owner_id": "9a0b97ef-6c40-40cf-8111-d6ce369086e8",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/7444041e-8860-47ec-a18c-54f232847528' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes