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
      "id": "df0cb803-534b-43d6-95a4-26d7a01b4d7b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T15:59:33+00:00",
        "updated_at": "2023-02-13T15:59:33+00:00",
        "number": "http://bqbl.it/df0cb803-534b-43d6-95a4-26d7a01b4d7b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8b37c119f48d4949ebab67f268294fce/barcode/image/df0cb803-534b-43d6-95a4-26d7a01b4d7b/334bbbef-67f2-4fc8-95ed-1366c72503fc.svg",
        "owner_id": "f6112ff8-74d8-4f16-a003-a500ad14426a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f6112ff8-74d8-4f16-a003-a500ad14426a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F63d68460-de3b-4f62-af06-4480aae7ce37&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "63d68460-de3b-4f62-af06-4480aae7ce37",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T15:59:34+00:00",
        "updated_at": "2023-02-13T15:59:34+00:00",
        "number": "http://bqbl.it/63d68460-de3b-4f62-af06-4480aae7ce37",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f1420738fc68ab1ea3b819857bc2b74a/barcode/image/63d68460-de3b-4f62-af06-4480aae7ce37/cf701868-2c69-41f4-9177-1ffbf5369ea4.svg",
        "owner_id": "f3a34218-56c9-49bb-9f3f-fc52e42b43b4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f3a34218-56c9-49bb-9f3f-fc52e42b43b4"
          },
          "data": {
            "type": "customers",
            "id": "f3a34218-56c9-49bb-9f3f-fc52e42b43b4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f3a34218-56c9-49bb-9f3f-fc52e42b43b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T15:59:34+00:00",
        "updated_at": "2023-02-13T15:59:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f3a34218-56c9-49bb-9f3f-fc52e42b43b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f3a34218-56c9-49bb-9f3f-fc52e42b43b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f3a34218-56c9-49bb-9f3f-fc52e42b43b4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMGQzZmM4YzMtOTE1ZS00NThhLTg5OTgtY2Q2Mzk2ZjM2MWQw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0d3fc8c3-915e-458a-8998-cd6396f361d0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T15:59:34+00:00",
        "updated_at": "2023-02-13T15:59:34+00:00",
        "number": "http://bqbl.it/0d3fc8c3-915e-458a-8998-cd6396f361d0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4643ea0092c27fefe9b145fe34538f1c/barcode/image/0d3fc8c3-915e-458a-8998-cd6396f361d0/f2f2b9e7-82a6-4125-8c39-7d1e4620140b.svg",
        "owner_id": "3ce13bcb-be99-4f7c-ba85-ab56beed4db3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3ce13bcb-be99-4f7c-ba85-ab56beed4db3"
          },
          "data": {
            "type": "customers",
            "id": "3ce13bcb-be99-4f7c-ba85-ab56beed4db3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3ce13bcb-be99-4f7c-ba85-ab56beed4db3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T15:59:34+00:00",
        "updated_at": "2023-02-13T15:59:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3ce13bcb-be99-4f7c-ba85-ab56beed4db3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3ce13bcb-be99-4f7c-ba85-ab56beed4db3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3ce13bcb-be99-4f7c-ba85-ab56beed4db3&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T15:59:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/44ff58c0-c1c9-4a6e-b905-8f5492324a57?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44ff58c0-c1c9-4a6e-b905-8f5492324a57",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T15:59:34+00:00",
      "updated_at": "2023-02-13T15:59:34+00:00",
      "number": "http://bqbl.it/44ff58c0-c1c9-4a6e-b905-8f5492324a57",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ae288c1a13d8094b665d8971486565e4/barcode/image/44ff58c0-c1c9-4a6e-b905-8f5492324a57/bb003bfd-eb09-42ff-9e00-b9c9fa6852cf.svg",
      "owner_id": "1f067659-2d4d-4395-8a99-3b5644c09c8c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1f067659-2d4d-4395-8a99-3b5644c09c8c"
        },
        "data": {
          "type": "customers",
          "id": "1f067659-2d4d-4395-8a99-3b5644c09c8c"
        }
      }
    }
  },
  "included": [
    {
      "id": "1f067659-2d4d-4395-8a99-3b5644c09c8c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T15:59:34+00:00",
        "updated_at": "2023-02-13T15:59:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1f067659-2d4d-4395-8a99-3b5644c09c8c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1f067659-2d4d-4395-8a99-3b5644c09c8c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1f067659-2d4d-4395-8a99-3b5644c09c8c&filter[owner_type]=customers"
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
          "owner_id": "8f0335c6-c492-46ad-afc4-00983da3a0c7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c988a52c-b14e-4eeb-b730-ccf5a77dc2a9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T15:59:35+00:00",
      "updated_at": "2023-02-13T15:59:35+00:00",
      "number": "http://bqbl.it/c988a52c-b14e-4eeb-b730-ccf5a77dc2a9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/efdbc1234ac85b5a89d3486c46a5d422/barcode/image/c988a52c-b14e-4eeb-b730-ccf5a77dc2a9/8032448e-fc6b-4c3b-adcc-04ebb33db341.svg",
      "owner_id": "8f0335c6-c492-46ad-afc4-00983da3a0c7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7cdae201-f1e3-4bbd-9dbd-91cbc565062c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7cdae201-f1e3-4bbd-9dbd-91cbc565062c",
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
    "id": "7cdae201-f1e3-4bbd-9dbd-91cbc565062c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T15:59:35+00:00",
      "updated_at": "2023-02-13T15:59:35+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8ab919a37b1680804e079004d7d02bf7/barcode/image/7cdae201-f1e3-4bbd-9dbd-91cbc565062c/e0113a20-d10d-4d1e-b156-0c74d260a3f6.svg",
      "owner_id": "96c5537f-7e09-4b0a-977f-f707744dedd9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/feb51d42-8ea6-4d07-8726-687f1798b40a' \
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