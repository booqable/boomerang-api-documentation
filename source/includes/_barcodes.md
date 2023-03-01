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
      "id": "d4dd697c-072a-47c2-b84e-812261c3ca66",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T10:30:30+00:00",
        "updated_at": "2023-03-01T10:30:30+00:00",
        "number": "http://bqbl.it/d4dd697c-072a-47c2-b84e-812261c3ca66",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3b9ec3e6ec5c8499809aad186cadd1cd/barcode/image/d4dd697c-072a-47c2-b84e-812261c3ca66/f9200378-273c-4889-9699-5ef20d43d0c9.svg",
        "owner_id": "a50d7ed8-95ef-4b26-a18a-ebf0cf5e4018",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a50d7ed8-95ef-4b26-a18a-ebf0cf5e4018"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa31ee351-dd29-431d-8fef-e68b460184c2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a31ee351-dd29-431d-8fef-e68b460184c2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T10:30:31+00:00",
        "updated_at": "2023-03-01T10:30:31+00:00",
        "number": "http://bqbl.it/a31ee351-dd29-431d-8fef-e68b460184c2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e88e71e7c1b77186a745feaedadf93f7/barcode/image/a31ee351-dd29-431d-8fef-e68b460184c2/f73cdcf5-7ba4-474a-b4c6-a32b81593d2d.svg",
        "owner_id": "c89244c1-e643-431c-a97e-55b9403975d0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c89244c1-e643-431c-a97e-55b9403975d0"
          },
          "data": {
            "type": "customers",
            "id": "c89244c1-e643-431c-a97e-55b9403975d0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c89244c1-e643-431c-a97e-55b9403975d0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T10:30:30+00:00",
        "updated_at": "2023-03-01T10:30:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c89244c1-e643-431c-a97e-55b9403975d0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c89244c1-e643-431c-a97e-55b9403975d0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c89244c1-e643-431c-a97e-55b9403975d0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTU5ZGEwYzEtNGY3Zi00YWQ4LWI1MzktZTUwODE2ODY2MzBi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "159da0c1-4f7f-4ad8-b539-e5081686630b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T10:30:31+00:00",
        "updated_at": "2023-03-01T10:30:31+00:00",
        "number": "http://bqbl.it/159da0c1-4f7f-4ad8-b539-e5081686630b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/53b75c6942a0945fc16d1a46689ea25f/barcode/image/159da0c1-4f7f-4ad8-b539-e5081686630b/c39c1145-bd47-40bc-a157-ee58aa5980b2.svg",
        "owner_id": "b71964cf-d5e2-4d6e-a946-803469e2c55f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b71964cf-d5e2-4d6e-a946-803469e2c55f"
          },
          "data": {
            "type": "customers",
            "id": "b71964cf-d5e2-4d6e-a946-803469e2c55f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b71964cf-d5e2-4d6e-a946-803469e2c55f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T10:30:31+00:00",
        "updated_at": "2023-03-01T10:30:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b71964cf-d5e2-4d6e-a946-803469e2c55f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b71964cf-d5e2-4d6e-a946-803469e2c55f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b71964cf-d5e2-4d6e-a946-803469e2c55f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T10:30:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9c60b7cc-3457-4907-acd1-b11584c43733?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9c60b7cc-3457-4907-acd1-b11584c43733",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T10:30:32+00:00",
      "updated_at": "2023-03-01T10:30:32+00:00",
      "number": "http://bqbl.it/9c60b7cc-3457-4907-acd1-b11584c43733",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6b501578abd3d433708eab54fe3798fc/barcode/image/9c60b7cc-3457-4907-acd1-b11584c43733/5ed0d9bd-9d01-44a5-9d14-f795e1166ab8.svg",
      "owner_id": "0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9"
        },
        "data": {
          "type": "customers",
          "id": "0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9"
        }
      }
    }
  },
  "included": [
    {
      "id": "0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T10:30:32+00:00",
        "updated_at": "2023-03-01T10:30:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d1a83d7-2da0-4b51-8e6f-9aba766cbcb9&filter[owner_type]=customers"
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
          "owner_id": "40eb4966-f6b6-4b9a-be10-2af11bd09daa",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5c623d3c-9656-4da1-ac39-2f7dd88c545b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T10:30:32+00:00",
      "updated_at": "2023-03-01T10:30:32+00:00",
      "number": "http://bqbl.it/5c623d3c-9656-4da1-ac39-2f7dd88c545b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7c1eed1fee24be8b8dabef50cdb672f2/barcode/image/5c623d3c-9656-4da1-ac39-2f7dd88c545b/57be8e81-b7f4-40cd-a7e9-6ecc68382689.svg",
      "owner_id": "40eb4966-f6b6-4b9a-be10-2af11bd09daa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b3ffae40-baff-4402-8dcf-137aa8224373' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b3ffae40-baff-4402-8dcf-137aa8224373",
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
    "id": "b3ffae40-baff-4402-8dcf-137aa8224373",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T10:30:33+00:00",
      "updated_at": "2023-03-01T10:30:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d856ee604dad96463085b3dc49bdc201/barcode/image/b3ffae40-baff-4402-8dcf-137aa8224373/0f020175-14ee-4e42-a0e7-06e3f2364f7c.svg",
      "owner_id": "579c746e-e479-420f-8279-5510b9ef3d09",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6965381d-1cf9-4519-9d6c-a86541831c10' \
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