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
      "id": "71651e2f-176f-4c94-ba77-4aa027f278ca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-20T10:22:42+00:00",
        "updated_at": "2023-02-20T10:22:42+00:00",
        "number": "http://bqbl.it/71651e2f-176f-4c94-ba77-4aa027f278ca",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5bd6364420160b00da8799696197d096/barcode/image/71651e2f-176f-4c94-ba77-4aa027f278ca/ea64ffc6-c4ec-4f97-8bfa-e95748f4a142.svg",
        "owner_id": "4931d6bd-730f-40d5-9913-aa024feb1e67",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4931d6bd-730f-40d5-9913-aa024feb1e67"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fefe857b3-1279-4629-aaac-0bce09308ba0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "efe857b3-1279-4629-aaac-0bce09308ba0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-20T10:22:42+00:00",
        "updated_at": "2023-02-20T10:22:42+00:00",
        "number": "http://bqbl.it/efe857b3-1279-4629-aaac-0bce09308ba0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cfef37bf9c212d8097e02bbf95b57fbb/barcode/image/efe857b3-1279-4629-aaac-0bce09308ba0/36a3eb9f-a8d5-45f2-aa6f-05e3ef535965.svg",
        "owner_id": "c582d711-f6c2-4a2f-8f0e-4f67b5df16aa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c582d711-f6c2-4a2f-8f0e-4f67b5df16aa"
          },
          "data": {
            "type": "customers",
            "id": "c582d711-f6c2-4a2f-8f0e-4f67b5df16aa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c582d711-f6c2-4a2f-8f0e-4f67b5df16aa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-20T10:22:42+00:00",
        "updated_at": "2023-02-20T10:22:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c582d711-f6c2-4a2f-8f0e-4f67b5df16aa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c582d711-f6c2-4a2f-8f0e-4f67b5df16aa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c582d711-f6c2-4a2f-8f0e-4f67b5df16aa&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzlhMzIwNDYtMTE5YS00NDU2LWJjNmMtODk0NTI2N2M4YThl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c9a32046-119a-4456-bc6c-8945267c8a8e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-20T10:22:43+00:00",
        "updated_at": "2023-02-20T10:22:43+00:00",
        "number": "http://bqbl.it/c9a32046-119a-4456-bc6c-8945267c8a8e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5296b60575ace17272c3af4b43ecf47b/barcode/image/c9a32046-119a-4456-bc6c-8945267c8a8e/2c63572a-23f8-4b44-87c7-bd004029e45f.svg",
        "owner_id": "23bfe4b4-0957-4d24-924c-5862e5e758aa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/23bfe4b4-0957-4d24-924c-5862e5e758aa"
          },
          "data": {
            "type": "customers",
            "id": "23bfe4b4-0957-4d24-924c-5862e5e758aa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "23bfe4b4-0957-4d24-924c-5862e5e758aa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-20T10:22:43+00:00",
        "updated_at": "2023-02-20T10:22:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=23bfe4b4-0957-4d24-924c-5862e5e758aa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=23bfe4b4-0957-4d24-924c-5862e5e758aa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=23bfe4b4-0957-4d24-924c-5862e5e758aa&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T10:22:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/43c02fad-7683-4e5d-a9c5-3b7ab1130953?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "43c02fad-7683-4e5d-a9c5-3b7ab1130953",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-20T10:22:43+00:00",
      "updated_at": "2023-02-20T10:22:43+00:00",
      "number": "http://bqbl.it/43c02fad-7683-4e5d-a9c5-3b7ab1130953",
      "barcode_type": "qr_code",
      "image_url": "/uploads/16f2afdadd41edfbab0ce007ac11acc4/barcode/image/43c02fad-7683-4e5d-a9c5-3b7ab1130953/cd963e15-ef1f-4617-a201-64e7d36be0c6.svg",
      "owner_id": "afce7ef6-93b5-4732-9671-036cfe40a805",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/afce7ef6-93b5-4732-9671-036cfe40a805"
        },
        "data": {
          "type": "customers",
          "id": "afce7ef6-93b5-4732-9671-036cfe40a805"
        }
      }
    }
  },
  "included": [
    {
      "id": "afce7ef6-93b5-4732-9671-036cfe40a805",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-20T10:22:43+00:00",
        "updated_at": "2023-02-20T10:22:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=afce7ef6-93b5-4732-9671-036cfe40a805&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=afce7ef6-93b5-4732-9671-036cfe40a805&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=afce7ef6-93b5-4732-9671-036cfe40a805&filter[owner_type]=customers"
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
          "owner_id": "b8ad2014-78a3-469c-84cc-997d4d845926",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f1b99fa1-3811-45fd-b64b-2751c0215d6d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-20T10:22:44+00:00",
      "updated_at": "2023-02-20T10:22:44+00:00",
      "number": "http://bqbl.it/f1b99fa1-3811-45fd-b64b-2751c0215d6d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/81a98fe9a4445bd87a68334ef537aec1/barcode/image/f1b99fa1-3811-45fd-b64b-2751c0215d6d/1ac68984-4ad9-4d98-af60-96fea7e2eb2a.svg",
      "owner_id": "b8ad2014-78a3-469c-84cc-997d4d845926",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/47592cac-65f5-48f7-9d5a-1d3a4d84e356' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "47592cac-65f5-48f7-9d5a-1d3a4d84e356",
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
    "id": "47592cac-65f5-48f7-9d5a-1d3a4d84e356",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-20T10:22:44+00:00",
      "updated_at": "2023-02-20T10:22:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b3acaf7b09d03051ecab3196388229b2/barcode/image/47592cac-65f5-48f7-9d5a-1d3a4d84e356/9d39612a-1fa7-4f9b-85c9-f02085458145.svg",
      "owner_id": "d4851037-f665-473e-aae7-6a8d3f43fbb1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/82a6de3d-f6cd-42a6-a5a2-9a01d030b58b' \
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