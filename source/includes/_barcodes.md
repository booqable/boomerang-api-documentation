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
      "id": "73f882a3-e856-4313-87b7-ee259f4a262b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-06T15:12:43+00:00",
        "updated_at": "2023-01-06T15:12:43+00:00",
        "number": "http://bqbl.it/73f882a3-e856-4313-87b7-ee259f4a262b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7c4a2c54341da2fb8c7d6de098fef415/barcode/image/73f882a3-e856-4313-87b7-ee259f4a262b/5c314f87-3503-4667-9838-afd13445d3e7.svg",
        "owner_id": "38ab9844-0e15-4cff-8c39-8548cd2b8dc6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/38ab9844-0e15-4cff-8c39-8548cd2b8dc6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffe0340b9-de93-4a8f-ac7b-efd3c69fd926&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fe0340b9-de93-4a8f-ac7b-efd3c69fd926",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-06T15:12:43+00:00",
        "updated_at": "2023-01-06T15:12:43+00:00",
        "number": "http://bqbl.it/fe0340b9-de93-4a8f-ac7b-efd3c69fd926",
        "barcode_type": "qr_code",
        "image_url": "/uploads/127b5ebc49c86c625c0f3da60254101d/barcode/image/fe0340b9-de93-4a8f-ac7b-efd3c69fd926/5adfb1f8-2b3a-4974-9d2d-182c2dacc6e3.svg",
        "owner_id": "d59f0c0a-11e4-446c-b62c-7ffad4bbf0af",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d59f0c0a-11e4-446c-b62c-7ffad4bbf0af"
          },
          "data": {
            "type": "customers",
            "id": "d59f0c0a-11e4-446c-b62c-7ffad4bbf0af"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d59f0c0a-11e4-446c-b62c-7ffad4bbf0af",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-06T15:12:43+00:00",
        "updated_at": "2023-01-06T15:12:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d59f0c0a-11e4-446c-b62c-7ffad4bbf0af&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d59f0c0a-11e4-446c-b62c-7ffad4bbf0af&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d59f0c0a-11e4-446c-b62c-7ffad4bbf0af&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGM5MWY4YjktYTRkNS00NzQxLWFlYzUtYWE1ZTdmMWVkMjFj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dc91f8b9-a4d5-4741-aec5-aa5e7f1ed21c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-06T15:12:44+00:00",
        "updated_at": "2023-01-06T15:12:44+00:00",
        "number": "http://bqbl.it/dc91f8b9-a4d5-4741-aec5-aa5e7f1ed21c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e99ee4176dd7a62d1da434a446cf0e39/barcode/image/dc91f8b9-a4d5-4741-aec5-aa5e7f1ed21c/0d16d2ac-9952-48a4-af20-fc6c573008e8.svg",
        "owner_id": "16ee2c40-064a-4e02-a98f-be672e7cfd60",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/16ee2c40-064a-4e02-a98f-be672e7cfd60"
          },
          "data": {
            "type": "customers",
            "id": "16ee2c40-064a-4e02-a98f-be672e7cfd60"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "16ee2c40-064a-4e02-a98f-be672e7cfd60",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-06T15:12:44+00:00",
        "updated_at": "2023-01-06T15:12:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=16ee2c40-064a-4e02-a98f-be672e7cfd60&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=16ee2c40-064a-4e02-a98f-be672e7cfd60&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=16ee2c40-064a-4e02-a98f-be672e7cfd60&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-06T15:12:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fd227435-75e3-4057-b4a2-62ffc74f0940?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fd227435-75e3-4057-b4a2-62ffc74f0940",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-06T15:12:44+00:00",
      "updated_at": "2023-01-06T15:12:44+00:00",
      "number": "http://bqbl.it/fd227435-75e3-4057-b4a2-62ffc74f0940",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a707bef6fecdf762936ee979510ddd58/barcode/image/fd227435-75e3-4057-b4a2-62ffc74f0940/af25b642-1089-4534-8658-1fb3a48d4d1a.svg",
      "owner_id": "88050b2e-aaf6-4719-a35f-88479c8dd410",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/88050b2e-aaf6-4719-a35f-88479c8dd410"
        },
        "data": {
          "type": "customers",
          "id": "88050b2e-aaf6-4719-a35f-88479c8dd410"
        }
      }
    }
  },
  "included": [
    {
      "id": "88050b2e-aaf6-4719-a35f-88479c8dd410",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-06T15:12:44+00:00",
        "updated_at": "2023-01-06T15:12:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=88050b2e-aaf6-4719-a35f-88479c8dd410&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=88050b2e-aaf6-4719-a35f-88479c8dd410&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=88050b2e-aaf6-4719-a35f-88479c8dd410&filter[owner_type]=customers"
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
          "owner_id": "267ebd58-4e7d-4026-8f7d-a1c5de60a8b9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ffd329de-9b14-4fdd-88e9-d68c7cbb56e6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-06T15:12:45+00:00",
      "updated_at": "2023-01-06T15:12:45+00:00",
      "number": "http://bqbl.it/ffd329de-9b14-4fdd-88e9-d68c7cbb56e6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54e55d4c8ccdfb12283b2967b4bdb079/barcode/image/ffd329de-9b14-4fdd-88e9-d68c7cbb56e6/b2febf03-57c0-428e-8dbe-d8272a606189.svg",
      "owner_id": "267ebd58-4e7d-4026-8f7d-a1c5de60a8b9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c5556dc4-6785-40b2-bb48-d078d626eb4d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c5556dc4-6785-40b2-bb48-d078d626eb4d",
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
    "id": "c5556dc4-6785-40b2-bb48-d078d626eb4d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-06T15:12:46+00:00",
      "updated_at": "2023-01-06T15:12:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7a879387bc47e9f9ef1ac2963d508891/barcode/image/c5556dc4-6785-40b2-bb48-d078d626eb4d/a1625bae-302b-4489-bd83-b5a0443d1154.svg",
      "owner_id": "41e3d3c4-f3fa-4a12-9341-8a36c151515b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d86baf3-5b8a-4353-a28a-b5ba05023ec7' \
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