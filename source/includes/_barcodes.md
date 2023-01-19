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
      "id": "08550772-71e2-4391-858b-15ae6455a545",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-19T10:27:38+00:00",
        "updated_at": "2023-01-19T10:27:38+00:00",
        "number": "http://bqbl.it/08550772-71e2-4391-858b-15ae6455a545",
        "barcode_type": "qr_code",
        "image_url": "/uploads/81b244893c0e6755f2358daa29cc1215/barcode/image/08550772-71e2-4391-858b-15ae6455a545/540ea2b0-9614-4503-a7a2-5559711d0149.svg",
        "owner_id": "45b332c7-814e-46c4-af36-a87f591ff283",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/45b332c7-814e-46c4-af36-a87f591ff283"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2ae3ca71-d0ac-4bea-adf4-9219e833ee6c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2ae3ca71-d0ac-4bea-adf4-9219e833ee6c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-19T10:27:39+00:00",
        "updated_at": "2023-01-19T10:27:39+00:00",
        "number": "http://bqbl.it/2ae3ca71-d0ac-4bea-adf4-9219e833ee6c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bf8a1f716be775fd2115ae914b60ead4/barcode/image/2ae3ca71-d0ac-4bea-adf4-9219e833ee6c/d5078ebd-6f3f-48f8-a205-f27b0c7ca76a.svg",
        "owner_id": "285e48a3-ba92-47c4-8ba5-345fea2a46bf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/285e48a3-ba92-47c4-8ba5-345fea2a46bf"
          },
          "data": {
            "type": "customers",
            "id": "285e48a3-ba92-47c4-8ba5-345fea2a46bf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "285e48a3-ba92-47c4-8ba5-345fea2a46bf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-19T10:27:39+00:00",
        "updated_at": "2023-01-19T10:27:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=285e48a3-ba92-47c4-8ba5-345fea2a46bf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=285e48a3-ba92-47c4-8ba5-345fea2a46bf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=285e48a3-ba92-47c4-8ba5-345fea2a46bf&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzUwZjAwNDItZmNjNC00ZTVlLTgxMDUtYTM5NGM5MTUzZjQx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "350f0042-fcc4-4e5e-8105-a394c9153f41",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-19T10:27:39+00:00",
        "updated_at": "2023-01-19T10:27:39+00:00",
        "number": "http://bqbl.it/350f0042-fcc4-4e5e-8105-a394c9153f41",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a1b949e741bdc5fae68fab0685079f4c/barcode/image/350f0042-fcc4-4e5e-8105-a394c9153f41/c9e41d9c-cb45-4ce2-a327-b9383dedc031.svg",
        "owner_id": "f1546678-b2d1-4576-859c-00f5244bf215",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f1546678-b2d1-4576-859c-00f5244bf215"
          },
          "data": {
            "type": "customers",
            "id": "f1546678-b2d1-4576-859c-00f5244bf215"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f1546678-b2d1-4576-859c-00f5244bf215",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-19T10:27:39+00:00",
        "updated_at": "2023-01-19T10:27:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f1546678-b2d1-4576-859c-00f5244bf215&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1546678-b2d1-4576-859c-00f5244bf215&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1546678-b2d1-4576-859c-00f5244bf215&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:27:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1974cee0-4f5b-4f3e-b8f1-02cafa70e669?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1974cee0-4f5b-4f3e-b8f1-02cafa70e669",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-19T10:27:40+00:00",
      "updated_at": "2023-01-19T10:27:40+00:00",
      "number": "http://bqbl.it/1974cee0-4f5b-4f3e-b8f1-02cafa70e669",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e98cfedbcecdb2cd9854b05d3ba139ad/barcode/image/1974cee0-4f5b-4f3e-b8f1-02cafa70e669/667ad3c3-aa4d-426b-b705-fade7188fe9f.svg",
      "owner_id": "3b5f3ba9-4c08-4f0d-8885-4e83197ec848",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3b5f3ba9-4c08-4f0d-8885-4e83197ec848"
        },
        "data": {
          "type": "customers",
          "id": "3b5f3ba9-4c08-4f0d-8885-4e83197ec848"
        }
      }
    }
  },
  "included": [
    {
      "id": "3b5f3ba9-4c08-4f0d-8885-4e83197ec848",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-19T10:27:40+00:00",
        "updated_at": "2023-01-19T10:27:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3b5f3ba9-4c08-4f0d-8885-4e83197ec848&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3b5f3ba9-4c08-4f0d-8885-4e83197ec848&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3b5f3ba9-4c08-4f0d-8885-4e83197ec848&filter[owner_type]=customers"
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
          "owner_id": "ea2f02b1-2a14-44cf-b2c3-aeb738ca45ee",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0bebf4a4-589a-4251-9d6d-0e1c87459ab4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-19T10:27:41+00:00",
      "updated_at": "2023-01-19T10:27:41+00:00",
      "number": "http://bqbl.it/0bebf4a4-589a-4251-9d6d-0e1c87459ab4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8f1203cc171960692886161fc5120d6a/barcode/image/0bebf4a4-589a-4251-9d6d-0e1c87459ab4/d348ff84-2196-4472-965c-d8f80c94a8ab.svg",
      "owner_id": "ea2f02b1-2a14-44cf-b2c3-aeb738ca45ee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7765f33f-3cbf-4aa8-a349-855b401145c4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7765f33f-3cbf-4aa8-a349-855b401145c4",
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
    "id": "7765f33f-3cbf-4aa8-a349-855b401145c4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-19T10:27:41+00:00",
      "updated_at": "2023-01-19T10:27:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6632a926d364ae6245236ccc544a600c/barcode/image/7765f33f-3cbf-4aa8-a349-855b401145c4/24cdc180-683f-4bd1-bee2-9da65b7fdeff.svg",
      "owner_id": "1c7f4f63-78bf-4b34-a31d-444ab183b446",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a48e2cd5-702c-4959-9865-b91eb1645600' \
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