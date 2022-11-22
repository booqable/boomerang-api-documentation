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
      "id": "9b410fe5-1215-45ee-b6a4-0a8cea139aa9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:45:41+00:00",
        "updated_at": "2022-11-22T16:45:41+00:00",
        "number": "http://bqbl.it/9b410fe5-1215-45ee-b6a4-0a8cea139aa9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a9155d9f10ebe74f3c3a3d00a8fa6c09/barcode/image/9b410fe5-1215-45ee-b6a4-0a8cea139aa9/8dec8c51-25c7-4e74-9233-28ddd98b1dbb.svg",
        "owner_id": "182a2ea9-1d31-4ea4-ba22-2eb5736ca729",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/182a2ea9-1d31-4ea4-ba22-2eb5736ca729"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F47b5ffea-ccd2-403f-b3bf-25a80583de99&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "47b5ffea-ccd2-403f-b3bf-25a80583de99",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:45:42+00:00",
        "updated_at": "2022-11-22T16:45:42+00:00",
        "number": "http://bqbl.it/47b5ffea-ccd2-403f-b3bf-25a80583de99",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7f972a70aead5cc38b9ba41e99335305/barcode/image/47b5ffea-ccd2-403f-b3bf-25a80583de99/53d766e6-cf6f-4707-b1c9-bc0b90fceff3.svg",
        "owner_id": "701ae16e-bf97-4f9e-96cb-639d5da62265",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/701ae16e-bf97-4f9e-96cb-639d5da62265"
          },
          "data": {
            "type": "customers",
            "id": "701ae16e-bf97-4f9e-96cb-639d5da62265"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "701ae16e-bf97-4f9e-96cb-639d5da62265",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:45:42+00:00",
        "updated_at": "2022-11-22T16:45:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=701ae16e-bf97-4f9e-96cb-639d5da62265&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=701ae16e-bf97-4f9e-96cb-639d5da62265&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=701ae16e-bf97-4f9e-96cb-639d5da62265&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzJjY2Y2NTctMzhmYi00ZjIwLTljMjYtM2UzMzFjMjA0ZGJj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "72ccf657-38fb-4f20-9c26-3e331c204dbc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:45:42+00:00",
        "updated_at": "2022-11-22T16:45:42+00:00",
        "number": "http://bqbl.it/72ccf657-38fb-4f20-9c26-3e331c204dbc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/69b37c2e86f5cb26b2c3d97d3817815c/barcode/image/72ccf657-38fb-4f20-9c26-3e331c204dbc/8ebdca86-1374-4ddf-86ec-7bec72299737.svg",
        "owner_id": "2947da58-1543-4692-a46c-9a403a52535f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2947da58-1543-4692-a46c-9a403a52535f"
          },
          "data": {
            "type": "customers",
            "id": "2947da58-1543-4692-a46c-9a403a52535f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2947da58-1543-4692-a46c-9a403a52535f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:45:42+00:00",
        "updated_at": "2022-11-22T16:45:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2947da58-1543-4692-a46c-9a403a52535f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2947da58-1543-4692-a46c-9a403a52535f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2947da58-1543-4692-a46c-9a403a52535f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:45:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b3475d96-d7de-4756-9216-fa9df5b6c008?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b3475d96-d7de-4756-9216-fa9df5b6c008",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:45:42+00:00",
      "updated_at": "2022-11-22T16:45:42+00:00",
      "number": "http://bqbl.it/b3475d96-d7de-4756-9216-fa9df5b6c008",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8a0591d16b1ef3ceb9a1797a59e60e49/barcode/image/b3475d96-d7de-4756-9216-fa9df5b6c008/7b1f0bd9-c039-4a16-b58c-4ab484c9efb4.svg",
      "owner_id": "36115c5a-02ed-4b2e-a9cc-0f214ee1d128",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/36115c5a-02ed-4b2e-a9cc-0f214ee1d128"
        },
        "data": {
          "type": "customers",
          "id": "36115c5a-02ed-4b2e-a9cc-0f214ee1d128"
        }
      }
    }
  },
  "included": [
    {
      "id": "36115c5a-02ed-4b2e-a9cc-0f214ee1d128",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:45:42+00:00",
        "updated_at": "2022-11-22T16:45:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=36115c5a-02ed-4b2e-a9cc-0f214ee1d128&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=36115c5a-02ed-4b2e-a9cc-0f214ee1d128&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=36115c5a-02ed-4b2e-a9cc-0f214ee1d128&filter[owner_type]=customers"
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
          "owner_id": "e914fec8-37a9-4a0c-afae-4d6513eb1734",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8f652ba4-0461-4dda-b014-fb40a2e439ce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:45:43+00:00",
      "updated_at": "2022-11-22T16:45:43+00:00",
      "number": "http://bqbl.it/8f652ba4-0461-4dda-b014-fb40a2e439ce",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8a060dd2daf45517b095765f46a75dd1/barcode/image/8f652ba4-0461-4dda-b014-fb40a2e439ce/b3c74f43-2cea-4097-95f0-05f7f1e4f261.svg",
      "owner_id": "e914fec8-37a9-4a0c-afae-4d6513eb1734",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e98ba100-bb6c-4545-bd5c-ebb0434248b9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e98ba100-bb6c-4545-bd5c-ebb0434248b9",
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
    "id": "e98ba100-bb6c-4545-bd5c-ebb0434248b9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:45:44+00:00",
      "updated_at": "2022-11-22T16:45:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e306aa21abecad9b64736b76ef018add/barcode/image/e98ba100-bb6c-4545-bd5c-ebb0434248b9/51b7bba8-23fc-4e25-b28b-93456f57bfc4.svg",
      "owner_id": "539c1f45-0f26-4f44-9adf-fa3437a48e05",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c072605b-7eb3-42ce-927c-0952862434a0' \
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