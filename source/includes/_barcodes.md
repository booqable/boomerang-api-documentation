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
      "id": "8372f1b0-3697-4417-abbe-5da84d3173df",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-20T11:45:39+00:00",
        "updated_at": "2023-02-20T11:45:39+00:00",
        "number": "http://bqbl.it/8372f1b0-3697-4417-abbe-5da84d3173df",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fd5482c0766f68ebe39163df77036612/barcode/image/8372f1b0-3697-4417-abbe-5da84d3173df/f73caa0f-0b11-4dca-b584-09596a1edf26.svg",
        "owner_id": "1d0cf83a-8326-4c6a-a281-e4f0b1bfca7b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1d0cf83a-8326-4c6a-a281-e4f0b1bfca7b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbcdbdfb6-79ef-41e4-a6d4-cc4fbcedb047&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bcdbdfb6-79ef-41e4-a6d4-cc4fbcedb047",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-20T11:45:39+00:00",
        "updated_at": "2023-02-20T11:45:39+00:00",
        "number": "http://bqbl.it/bcdbdfb6-79ef-41e4-a6d4-cc4fbcedb047",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e7033a5aecc7e95774d8d084f839f639/barcode/image/bcdbdfb6-79ef-41e4-a6d4-cc4fbcedb047/9ccb5de6-a14a-423b-b5ac-a10918f06212.svg",
        "owner_id": "dcfb045a-45cd-4272-8efe-e73261b00ef0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dcfb045a-45cd-4272-8efe-e73261b00ef0"
          },
          "data": {
            "type": "customers",
            "id": "dcfb045a-45cd-4272-8efe-e73261b00ef0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dcfb045a-45cd-4272-8efe-e73261b00ef0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-20T11:45:39+00:00",
        "updated_at": "2023-02-20T11:45:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=dcfb045a-45cd-4272-8efe-e73261b00ef0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dcfb045a-45cd-4272-8efe-e73261b00ef0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dcfb045a-45cd-4272-8efe-e73261b00ef0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTRkNzQ1YmQtOTJmMy00ZDM0LTg0MzgtOTgzNjJiMzhhNDg4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "14d745bd-92f3-4d34-8438-98362b38a488",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-20T11:45:40+00:00",
        "updated_at": "2023-02-20T11:45:40+00:00",
        "number": "http://bqbl.it/14d745bd-92f3-4d34-8438-98362b38a488",
        "barcode_type": "qr_code",
        "image_url": "/uploads/484c3e725208a42083b03b2d91708f8b/barcode/image/14d745bd-92f3-4d34-8438-98362b38a488/bd0212b3-62b2-4aa2-aa22-a602ac8ce155.svg",
        "owner_id": "2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3"
          },
          "data": {
            "type": "customers",
            "id": "2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-20T11:45:39+00:00",
        "updated_at": "2023-02-20T11:45:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2d7c1c65-06ec-4927-bf5b-31ef9bd48ec3&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ecfeefbc-19cb-4e03-abfc-eb6bc35c2071?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ecfeefbc-19cb-4e03-abfc-eb6bc35c2071",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-20T11:45:40+00:00",
      "updated_at": "2023-02-20T11:45:40+00:00",
      "number": "http://bqbl.it/ecfeefbc-19cb-4e03-abfc-eb6bc35c2071",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0266d908e00805dac3ec679e609b7005/barcode/image/ecfeefbc-19cb-4e03-abfc-eb6bc35c2071/446db819-9c65-4663-b151-c7e4e1db93d7.svg",
      "owner_id": "a46d3422-ba0c-4aaa-b1e5-381fdaa17f87",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a46d3422-ba0c-4aaa-b1e5-381fdaa17f87"
        },
        "data": {
          "type": "customers",
          "id": "a46d3422-ba0c-4aaa-b1e5-381fdaa17f87"
        }
      }
    }
  },
  "included": [
    {
      "id": "a46d3422-ba0c-4aaa-b1e5-381fdaa17f87",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-20T11:45:40+00:00",
        "updated_at": "2023-02-20T11:45:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a46d3422-ba0c-4aaa-b1e5-381fdaa17f87&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a46d3422-ba0c-4aaa-b1e5-381fdaa17f87&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a46d3422-ba0c-4aaa-b1e5-381fdaa17f87&filter[owner_type]=customers"
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
          "owner_id": "6d4bef89-fcb2-43ea-89c7-410d05417cd1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6161f40d-bb97-482c-95e1-e3e047bc46d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-20T11:45:41+00:00",
      "updated_at": "2023-02-20T11:45:41+00:00",
      "number": "http://bqbl.it/6161f40d-bb97-482c-95e1-e3e047bc46d2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ab699011ddfa80f8dc604720ed2c76a1/barcode/image/6161f40d-bb97-482c-95e1-e3e047bc46d2/0049d191-1a6e-4526-af95-1f2d1aec7898.svg",
      "owner_id": "6d4bef89-fcb2-43ea-89c7-410d05417cd1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d027c210-5fc1-48fa-a7b9-570bc88577ab' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d027c210-5fc1-48fa-a7b9-570bc88577ab",
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
    "id": "d027c210-5fc1-48fa-a7b9-570bc88577ab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-20T11:45:41+00:00",
      "updated_at": "2023-02-20T11:45:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/989b6dfb861353b54a8eba2fcd5f9435/barcode/image/d027c210-5fc1-48fa-a7b9-570bc88577ab/13953879-1cb0-4081-8110-8e755e7cee2c.svg",
      "owner_id": "c85e5697-bbf9-40f2-a8eb-1569a3840fdb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0b08d1bc-07b5-433c-816b-01c1f5ba1c8e' \
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