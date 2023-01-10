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
      "id": "d8a9799a-2a87-491c-b293-2bf4cb85aeb5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-10T14:05:16+00:00",
        "updated_at": "2023-01-10T14:05:16+00:00",
        "number": "http://bqbl.it/d8a9799a-2a87-491c-b293-2bf4cb85aeb5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b73afc6ad5765dc2804415bd9adb2411/barcode/image/d8a9799a-2a87-491c-b293-2bf4cb85aeb5/7c92ca5f-e9f8-4e2c-b037-ab322bcfa917.svg",
        "owner_id": "87be8f1e-c21a-42af-8cb5-d8babdc61431",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87be8f1e-c21a-42af-8cb5-d8babdc61431"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F84b21d12-6196-4dbd-993b-baf48cfa8a96&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "84b21d12-6196-4dbd-993b-baf48cfa8a96",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-10T14:05:16+00:00",
        "updated_at": "2023-01-10T14:05:16+00:00",
        "number": "http://bqbl.it/84b21d12-6196-4dbd-993b-baf48cfa8a96",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4c12f0e0563c2b9b678d9c0edd540949/barcode/image/84b21d12-6196-4dbd-993b-baf48cfa8a96/fcf1434d-6753-49a0-8f2d-40fcb94ef7b6.svg",
        "owner_id": "e8c50e18-4fb2-4343-b7ca-c60ebca14362",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e8c50e18-4fb2-4343-b7ca-c60ebca14362"
          },
          "data": {
            "type": "customers",
            "id": "e8c50e18-4fb2-4343-b7ca-c60ebca14362"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e8c50e18-4fb2-4343-b7ca-c60ebca14362",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-10T14:05:16+00:00",
        "updated_at": "2023-01-10T14:05:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e8c50e18-4fb2-4343-b7ca-c60ebca14362&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e8c50e18-4fb2-4343-b7ca-c60ebca14362&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e8c50e18-4fb2-4343-b7ca-c60ebca14362&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzc2MDQxNGItMGU5YS00ZDU3LThlYTEtMTEwODE3MjJjYzJk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c760414b-0e9a-4d57-8ea1-11081722cc2d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-10T14:05:17+00:00",
        "updated_at": "2023-01-10T14:05:17+00:00",
        "number": "http://bqbl.it/c760414b-0e9a-4d57-8ea1-11081722cc2d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b6df48ff70bc6e98a2d1b22a24c4ca1b/barcode/image/c760414b-0e9a-4d57-8ea1-11081722cc2d/c6d1ed4a-443a-44b0-896c-17606baeca7a.svg",
        "owner_id": "d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170"
          },
          "data": {
            "type": "customers",
            "id": "d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-10T14:05:17+00:00",
        "updated_at": "2023-01-10T14:05:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d23e7f7c-6153-4d5e-ac2a-ff5b24cf6170&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-10T14:04:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9a8591c8-91d0-4a20-b7e0-594dfb045344?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9a8591c8-91d0-4a20-b7e0-594dfb045344",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-10T14:05:17+00:00",
      "updated_at": "2023-01-10T14:05:17+00:00",
      "number": "http://bqbl.it/9a8591c8-91d0-4a20-b7e0-594dfb045344",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b9cf5571fbbf239e8e25e9d0eae6dd5e/barcode/image/9a8591c8-91d0-4a20-b7e0-594dfb045344/bfa6a7a8-b987-4321-b127-5ab64e3fc99b.svg",
      "owner_id": "e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b"
        },
        "data": {
          "type": "customers",
          "id": "e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b"
        }
      }
    }
  },
  "included": [
    {
      "id": "e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-10T14:05:17+00:00",
        "updated_at": "2023-01-10T14:05:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e3eb68c0-698a-4d43-bd57-49c1b9dc0b6b&filter[owner_type]=customers"
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
          "owner_id": "b7ad3ab2-8281-414e-a6f9-da478349cf41",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cd852edb-15e2-4bbb-aab2-b56bc9e633e0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-10T14:05:18+00:00",
      "updated_at": "2023-01-10T14:05:18+00:00",
      "number": "http://bqbl.it/cd852edb-15e2-4bbb-aab2-b56bc9e633e0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/71ef685970d99e57a1ceedfa6bc70624/barcode/image/cd852edb-15e2-4bbb-aab2-b56bc9e633e0/fe791d6a-6292-4724-a253-6474cc5bc572.svg",
      "owner_id": "b7ad3ab2-8281-414e-a6f9-da478349cf41",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9396559-3aca-4f1d-9513-afd0380d8919' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a9396559-3aca-4f1d-9513-afd0380d8919",
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
    "id": "a9396559-3aca-4f1d-9513-afd0380d8919",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-10T14:05:18+00:00",
      "updated_at": "2023-01-10T14:05:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/41464b3bf2d8d039572ab17f33cbfbde/barcode/image/a9396559-3aca-4f1d-9513-afd0380d8919/adf79ecf-b7e8-41ea-aaaf-fc0077e221b9.svg",
      "owner_id": "e59e4e2d-5e69-40cb-aa2b-19d846ebe221",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/82b5c112-4b5c-4dc3-bbb0-ba152d4b1138' \
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