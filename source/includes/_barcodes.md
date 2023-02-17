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
      "id": "f871e26f-06ee-406e-8046-e42fbaf5408e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-17T13:25:26+00:00",
        "updated_at": "2023-02-17T13:25:26+00:00",
        "number": "http://bqbl.it/f871e26f-06ee-406e-8046-e42fbaf5408e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d2c1711e4877c80d270ce5d09eee12c2/barcode/image/f871e26f-06ee-406e-8046-e42fbaf5408e/419d590e-8e27-4cad-8f50-5c3bec948ec3.svg",
        "owner_id": "7f0ee662-3e89-4e86-8ff4-b92ab62db495",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7f0ee662-3e89-4e86-8ff4-b92ab62db495"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3bdc7936-4afa-44e0-a09d-ea9b8b2b1330&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3bdc7936-4afa-44e0-a09d-ea9b8b2b1330",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-17T13:25:26+00:00",
        "updated_at": "2023-02-17T13:25:26+00:00",
        "number": "http://bqbl.it/3bdc7936-4afa-44e0-a09d-ea9b8b2b1330",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cc0ccdedbc6aa1a6a25d7faf73deb265/barcode/image/3bdc7936-4afa-44e0-a09d-ea9b8b2b1330/b5cd0da4-b74f-4e5a-a802-752f8e6aff00.svg",
        "owner_id": "a6cf8c54-b8f6-4333-a5f2-4f4e8dace540",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a6cf8c54-b8f6-4333-a5f2-4f4e8dace540"
          },
          "data": {
            "type": "customers",
            "id": "a6cf8c54-b8f6-4333-a5f2-4f4e8dace540"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a6cf8c54-b8f6-4333-a5f2-4f4e8dace540",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-17T13:25:26+00:00",
        "updated_at": "2023-02-17T13:25:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a6cf8c54-b8f6-4333-a5f2-4f4e8dace540&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a6cf8c54-b8f6-4333-a5f2-4f4e8dace540&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a6cf8c54-b8f6-4333-a5f2-4f4e8dace540&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGJjMDFmZDMtNDViNi00MjA1LTg5NmQtNDEyOGZkYmY3Yjlh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8bc01fd3-45b6-4205-896d-4128fdbf7b9a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-17T13:25:27+00:00",
        "updated_at": "2023-02-17T13:25:27+00:00",
        "number": "http://bqbl.it/8bc01fd3-45b6-4205-896d-4128fdbf7b9a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/090992a1d1135d961451d9037226e615/barcode/image/8bc01fd3-45b6-4205-896d-4128fdbf7b9a/b5b6afa4-c108-4fcf-8015-30510123d349.svg",
        "owner_id": "e63475d3-ee73-4697-b029-ca9fffc71231",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e63475d3-ee73-4697-b029-ca9fffc71231"
          },
          "data": {
            "type": "customers",
            "id": "e63475d3-ee73-4697-b029-ca9fffc71231"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e63475d3-ee73-4697-b029-ca9fffc71231",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-17T13:25:27+00:00",
        "updated_at": "2023-02-17T13:25:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e63475d3-ee73-4697-b029-ca9fffc71231&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e63475d3-ee73-4697-b029-ca9fffc71231&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e63475d3-ee73-4697-b029-ca9fffc71231&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-17T13:25:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e1e4d3dc-5221-44ea-90ff-2ca23d26fc81?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e1e4d3dc-5221-44ea-90ff-2ca23d26fc81",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-17T13:25:27+00:00",
      "updated_at": "2023-02-17T13:25:27+00:00",
      "number": "http://bqbl.it/e1e4d3dc-5221-44ea-90ff-2ca23d26fc81",
      "barcode_type": "qr_code",
      "image_url": "/uploads/410d5cbbf7f4c5009a8314ec7f06cac9/barcode/image/e1e4d3dc-5221-44ea-90ff-2ca23d26fc81/6ce7d98c-8604-4c92-8a7b-f6307ffed14e.svg",
      "owner_id": "e2847156-ba78-4260-af90-43667dd1b157",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e2847156-ba78-4260-af90-43667dd1b157"
        },
        "data": {
          "type": "customers",
          "id": "e2847156-ba78-4260-af90-43667dd1b157"
        }
      }
    }
  },
  "included": [
    {
      "id": "e2847156-ba78-4260-af90-43667dd1b157",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-17T13:25:27+00:00",
        "updated_at": "2023-02-17T13:25:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e2847156-ba78-4260-af90-43667dd1b157&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e2847156-ba78-4260-af90-43667dd1b157&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e2847156-ba78-4260-af90-43667dd1b157&filter[owner_type]=customers"
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
          "owner_id": "a87c2429-b445-426d-ae96-e94339664d49",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "618bae17-1272-48b0-95f7-88f8489ad2b9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-17T13:25:28+00:00",
      "updated_at": "2023-02-17T13:25:28+00:00",
      "number": "http://bqbl.it/618bae17-1272-48b0-95f7-88f8489ad2b9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e1b17f9187495c809de81621bf5e5718/barcode/image/618bae17-1272-48b0-95f7-88f8489ad2b9/c6f1789c-0e02-4b92-b778-f964dd3a027f.svg",
      "owner_id": "a87c2429-b445-426d-ae96-e94339664d49",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9bae3069-d7fb-405e-895e-c4cf0a461774' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9bae3069-d7fb-405e-895e-c4cf0a461774",
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
    "id": "9bae3069-d7fb-405e-895e-c4cf0a461774",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-17T13:25:29+00:00",
      "updated_at": "2023-02-17T13:25:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b074337a9d352a778dfcfc8a2da2d544/barcode/image/9bae3069-d7fb-405e-895e-c4cf0a461774/100e7aec-aca3-48fa-a2f6-a360dfc7cfab.svg",
      "owner_id": "4c90e7b1-22db-4f01-a5d4-59f668df0006",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/245097c8-9f92-4d09-99f5-ec05dd459b8b' \
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