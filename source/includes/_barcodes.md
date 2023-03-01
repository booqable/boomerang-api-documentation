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
      "id": "67c47df3-1179-4a88-bad4-1a0a8b9a9c31",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T17:36:41+00:00",
        "updated_at": "2023-03-01T17:36:41+00:00",
        "number": "http://bqbl.it/67c47df3-1179-4a88-bad4-1a0a8b9a9c31",
        "barcode_type": "qr_code",
        "image_url": "/uploads/803638fd7c6cdf51fb83539a3505711a/barcode/image/67c47df3-1179-4a88-bad4-1a0a8b9a9c31/29f5718c-473b-4c46-b90b-679e6a6a7baf.svg",
        "owner_id": "63aed7b4-5b60-4aa3-9da3-f6b79b0a883b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/63aed7b4-5b60-4aa3-9da3-f6b79b0a883b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff9f588b6-cbb5-4bda-8589-30c4d55fd9ff&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f9f588b6-cbb5-4bda-8589-30c4d55fd9ff",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T17:36:41+00:00",
        "updated_at": "2023-03-01T17:36:41+00:00",
        "number": "http://bqbl.it/f9f588b6-cbb5-4bda-8589-30c4d55fd9ff",
        "barcode_type": "qr_code",
        "image_url": "/uploads/22cf041d3daad658ff94c284208a7c75/barcode/image/f9f588b6-cbb5-4bda-8589-30c4d55fd9ff/fa7a797a-3de6-4b46-ada4-33b9a40b0b54.svg",
        "owner_id": "52019448-3671-42b9-9f8b-eb1549cf4567",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/52019448-3671-42b9-9f8b-eb1549cf4567"
          },
          "data": {
            "type": "customers",
            "id": "52019448-3671-42b9-9f8b-eb1549cf4567"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "52019448-3671-42b9-9f8b-eb1549cf4567",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T17:36:41+00:00",
        "updated_at": "2023-03-01T17:36:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=52019448-3671-42b9-9f8b-eb1549cf4567&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=52019448-3671-42b9-9f8b-eb1549cf4567&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=52019448-3671-42b9-9f8b-eb1549cf4567&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWYxMjkwYTAtZDRmMy00ZDA2LWE5NWItNTEzODA0YWI4OGRk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ef1290a0-d4f3-4d06-a95b-513804ab88dd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T17:36:42+00:00",
        "updated_at": "2023-03-01T17:36:42+00:00",
        "number": "http://bqbl.it/ef1290a0-d4f3-4d06-a95b-513804ab88dd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7fae32dc28ca254e5e065e255699f907/barcode/image/ef1290a0-d4f3-4d06-a95b-513804ab88dd/3019099a-ce28-4221-bf46-3c80c0ba649d.svg",
        "owner_id": "38c131b0-b3f8-4348-acec-d9a25975c123",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/38c131b0-b3f8-4348-acec-d9a25975c123"
          },
          "data": {
            "type": "customers",
            "id": "38c131b0-b3f8-4348-acec-d9a25975c123"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "38c131b0-b3f8-4348-acec-d9a25975c123",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T17:36:42+00:00",
        "updated_at": "2023-03-01T17:36:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=38c131b0-b3f8-4348-acec-d9a25975c123&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=38c131b0-b3f8-4348-acec-d9a25975c123&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=38c131b0-b3f8-4348-acec-d9a25975c123&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T17:36:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b9d95dda-fd4f-42a9-95cc-c3efc5334ec7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b9d95dda-fd4f-42a9-95cc-c3efc5334ec7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T17:36:42+00:00",
      "updated_at": "2023-03-01T17:36:42+00:00",
      "number": "http://bqbl.it/b9d95dda-fd4f-42a9-95cc-c3efc5334ec7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eead7cbbd1ce08b9008877acaa93bc58/barcode/image/b9d95dda-fd4f-42a9-95cc-c3efc5334ec7/0906f255-e7bd-4ff8-a2f0-f9bec2626d22.svg",
      "owner_id": "a6dcc4f9-9999-4910-b415-ed49b1c3ebd0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a6dcc4f9-9999-4910-b415-ed49b1c3ebd0"
        },
        "data": {
          "type": "customers",
          "id": "a6dcc4f9-9999-4910-b415-ed49b1c3ebd0"
        }
      }
    }
  },
  "included": [
    {
      "id": "a6dcc4f9-9999-4910-b415-ed49b1c3ebd0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T17:36:42+00:00",
        "updated_at": "2023-03-01T17:36:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a6dcc4f9-9999-4910-b415-ed49b1c3ebd0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a6dcc4f9-9999-4910-b415-ed49b1c3ebd0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a6dcc4f9-9999-4910-b415-ed49b1c3ebd0&filter[owner_type]=customers"
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
          "owner_id": "201c4927-f5a8-4649-9da6-d158e0d4a3b1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "09dcd310-cce7-4a15-99db-e5701004299d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T17:36:43+00:00",
      "updated_at": "2023-03-01T17:36:43+00:00",
      "number": "http://bqbl.it/09dcd310-cce7-4a15-99db-e5701004299d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0a514430430856b351225a616399d1c1/barcode/image/09dcd310-cce7-4a15-99db-e5701004299d/2bf53fc3-1fe4-4ae4-84bf-9699096fcce5.svg",
      "owner_id": "201c4927-f5a8-4649-9da6-d158e0d4a3b1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/091a0760-995f-4565-95a7-98dfaa051276' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "091a0760-995f-4565-95a7-98dfaa051276",
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
    "id": "091a0760-995f-4565-95a7-98dfaa051276",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T17:36:44+00:00",
      "updated_at": "2023-03-01T17:36:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0a45aa01b3ad8000b9dd6dd2a1f2578f/barcode/image/091a0760-995f-4565-95a7-98dfaa051276/04939dad-dbf3-4d8d-bd1d-f4c2643545d4.svg",
      "owner_id": "9d907193-73c0-496a-b952-4569afaf65ef",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/024f31a8-6938-4689-ab41-03a3e4eb480d' \
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