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
      "id": "c4c4494f-2d33-4352-9224-4c4d52f1f40b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T09:17:43+00:00",
        "updated_at": "2023-02-08T09:17:43+00:00",
        "number": "http://bqbl.it/c4c4494f-2d33-4352-9224-4c4d52f1f40b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f2364b97ba0451d9ee5dda14ec4b7adb/barcode/image/c4c4494f-2d33-4352-9224-4c4d52f1f40b/631ead0d-df7f-496e-8e09-3d09ee8a632e.svg",
        "owner_id": "b31422d8-1b8d-4969-9655-d5e67d089df0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b31422d8-1b8d-4969-9655-d5e67d089df0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4d658d01-4870-428c-a1f1-829e4335ccdf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4d658d01-4870-428c-a1f1-829e4335ccdf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T09:17:44+00:00",
        "updated_at": "2023-02-08T09:17:44+00:00",
        "number": "http://bqbl.it/4d658d01-4870-428c-a1f1-829e4335ccdf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5d25b04b9079ab5a9b74280ec5533dea/barcode/image/4d658d01-4870-428c-a1f1-829e4335ccdf/607ab583-19e2-426d-b741-0a049a646917.svg",
        "owner_id": "6c72de36-b948-4bce-a45f-d91930362bd0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6c72de36-b948-4bce-a45f-d91930362bd0"
          },
          "data": {
            "type": "customers",
            "id": "6c72de36-b948-4bce-a45f-d91930362bd0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6c72de36-b948-4bce-a45f-d91930362bd0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T09:17:44+00:00",
        "updated_at": "2023-02-08T09:17:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6c72de36-b948-4bce-a45f-d91930362bd0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6c72de36-b948-4bce-a45f-d91930362bd0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6c72de36-b948-4bce-a45f-d91930362bd0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzQ0ODY3MzQtOWI1Yy00M2FkLTljMzItMGM1ZGI3ZGYyZDJh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "74486734-9b5c-43ad-9c32-0c5db7df2d2a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T09:17:44+00:00",
        "updated_at": "2023-02-08T09:17:44+00:00",
        "number": "http://bqbl.it/74486734-9b5c-43ad-9c32-0c5db7df2d2a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d9182d1cbbfe9871a74cda5d59728551/barcode/image/74486734-9b5c-43ad-9c32-0c5db7df2d2a/68f55a32-64ae-46e1-a8eb-2ca5dd2195b8.svg",
        "owner_id": "a044edd1-4a6f-4f73-9aac-5ac40c1ab712",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a044edd1-4a6f-4f73-9aac-5ac40c1ab712"
          },
          "data": {
            "type": "customers",
            "id": "a044edd1-4a6f-4f73-9aac-5ac40c1ab712"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a044edd1-4a6f-4f73-9aac-5ac40c1ab712",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T09:17:44+00:00",
        "updated_at": "2023-02-08T09:17:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a044edd1-4a6f-4f73-9aac-5ac40c1ab712&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a044edd1-4a6f-4f73-9aac-5ac40c1ab712&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a044edd1-4a6f-4f73-9aac-5ac40c1ab712&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:17:23Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4a312d71-784c-4872-86c8-0b1724be1e5a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4a312d71-784c-4872-86c8-0b1724be1e5a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T09:17:45+00:00",
      "updated_at": "2023-02-08T09:17:45+00:00",
      "number": "http://bqbl.it/4a312d71-784c-4872-86c8-0b1724be1e5a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9a95c8691cf8d6c5f5dc977f94db0854/barcode/image/4a312d71-784c-4872-86c8-0b1724be1e5a/a773a1a7-0ae6-464f-bde7-0a6d50ca27a8.svg",
      "owner_id": "f170deb3-9db4-4680-853c-cec43a56ef5d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f170deb3-9db4-4680-853c-cec43a56ef5d"
        },
        "data": {
          "type": "customers",
          "id": "f170deb3-9db4-4680-853c-cec43a56ef5d"
        }
      }
    }
  },
  "included": [
    {
      "id": "f170deb3-9db4-4680-853c-cec43a56ef5d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T09:17:45+00:00",
        "updated_at": "2023-02-08T09:17:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f170deb3-9db4-4680-853c-cec43a56ef5d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f170deb3-9db4-4680-853c-cec43a56ef5d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f170deb3-9db4-4680-853c-cec43a56ef5d&filter[owner_type]=customers"
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
          "owner_id": "ccc75624-7145-4fcd-8f6a-66fb9deaf903",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "438563fe-5ce5-4af5-9641-dae3a3c479d8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T09:17:46+00:00",
      "updated_at": "2023-02-08T09:17:46+00:00",
      "number": "http://bqbl.it/438563fe-5ce5-4af5-9641-dae3a3c479d8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c152d9f5966c60d9a62af81711bf3efb/barcode/image/438563fe-5ce5-4af5-9641-dae3a3c479d8/49d94ce7-e5b9-4fba-984e-a25bb8e7d11e.svg",
      "owner_id": "ccc75624-7145-4fcd-8f6a-66fb9deaf903",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/017c4e67-98ef-4c94-8f85-0d055d290c99' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "017c4e67-98ef-4c94-8f85-0d055d290c99",
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
    "id": "017c4e67-98ef-4c94-8f85-0d055d290c99",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T09:17:46+00:00",
      "updated_at": "2023-02-08T09:17:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/399ecc82a1ac561e201192a8cc29e6f3/barcode/image/017c4e67-98ef-4c94-8f85-0d055d290c99/15182dc3-8395-4dfb-838e-a9633adf1fc2.svg",
      "owner_id": "34305710-db1e-46df-a1c5-df5fe6e097d0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d4a37b1-e9d4-48e8-a52d-b73a50553517' \
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