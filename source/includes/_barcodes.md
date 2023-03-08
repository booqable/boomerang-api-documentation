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
      "id": "e50ac4ce-2c7a-496c-ba18-2adc01a18cdf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T07:52:04+00:00",
        "updated_at": "2023-03-08T07:52:04+00:00",
        "number": "http://bqbl.it/e50ac4ce-2c7a-496c-ba18-2adc01a18cdf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a145724e616d991cf7835abaa96a0a7b/barcode/image/e50ac4ce-2c7a-496c-ba18-2adc01a18cdf/8a4ccaa8-fc01-44b5-965d-a41dd9ed49ee.svg",
        "owner_id": "9bcd5725-4d62-425f-a142-2c839f36e981",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9bcd5725-4d62-425f-a142-2c839f36e981"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe3a2b442-2fff-4f40-a785-270d60fb8bea&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e3a2b442-2fff-4f40-a785-270d60fb8bea",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T07:52:04+00:00",
        "updated_at": "2023-03-08T07:52:04+00:00",
        "number": "http://bqbl.it/e3a2b442-2fff-4f40-a785-270d60fb8bea",
        "barcode_type": "qr_code",
        "image_url": "/uploads/48e0f2b4567c4593ce2d6247a6fe72c1/barcode/image/e3a2b442-2fff-4f40-a785-270d60fb8bea/917c9874-1b3f-4123-97c5-60f03cd59fb7.svg",
        "owner_id": "8c870797-a5ac-41bf-80bc-22969256c28f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8c870797-a5ac-41bf-80bc-22969256c28f"
          },
          "data": {
            "type": "customers",
            "id": "8c870797-a5ac-41bf-80bc-22969256c28f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8c870797-a5ac-41bf-80bc-22969256c28f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T07:52:04+00:00",
        "updated_at": "2023-03-08T07:52:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8c870797-a5ac-41bf-80bc-22969256c28f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8c870797-a5ac-41bf-80bc-22969256c28f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8c870797-a5ac-41bf-80bc-22969256c28f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTBmMTY4NDEtOWVjZS00YjIzLTkwNzItN2NjNTEwNDhiOTY3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "90f16841-9ece-4b23-9072-7cc51048b967",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T07:52:05+00:00",
        "updated_at": "2023-03-08T07:52:05+00:00",
        "number": "http://bqbl.it/90f16841-9ece-4b23-9072-7cc51048b967",
        "barcode_type": "qr_code",
        "image_url": "/uploads/25402011cbd1611fd6ae01abdd032a75/barcode/image/90f16841-9ece-4b23-9072-7cc51048b967/cc6cbce4-bb76-48b1-8dce-50a5cba5f349.svg",
        "owner_id": "92eae0b3-cf76-4536-b228-19a8e47aa023",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/92eae0b3-cf76-4536-b228-19a8e47aa023"
          },
          "data": {
            "type": "customers",
            "id": "92eae0b3-cf76-4536-b228-19a8e47aa023"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "92eae0b3-cf76-4536-b228-19a8e47aa023",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T07:52:05+00:00",
        "updated_at": "2023-03-08T07:52:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=92eae0b3-cf76-4536-b228-19a8e47aa023&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92eae0b3-cf76-4536-b228-19a8e47aa023&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92eae0b3-cf76-4536-b228-19a8e47aa023&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T07:51:48Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fcac6385-2ce3-4480-953a-5165c72bcb1a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fcac6385-2ce3-4480-953a-5165c72bcb1a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T07:52:05+00:00",
      "updated_at": "2023-03-08T07:52:05+00:00",
      "number": "http://bqbl.it/fcac6385-2ce3-4480-953a-5165c72bcb1a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9e27dc15915694ac8334f81d71ca864f/barcode/image/fcac6385-2ce3-4480-953a-5165c72bcb1a/2c8a341c-308b-4ff7-8a1a-830d69814e4c.svg",
      "owner_id": "f3304d10-e321-440d-9fc9-b4f8141d393b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f3304d10-e321-440d-9fc9-b4f8141d393b"
        },
        "data": {
          "type": "customers",
          "id": "f3304d10-e321-440d-9fc9-b4f8141d393b"
        }
      }
    }
  },
  "included": [
    {
      "id": "f3304d10-e321-440d-9fc9-b4f8141d393b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T07:52:05+00:00",
        "updated_at": "2023-03-08T07:52:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f3304d10-e321-440d-9fc9-b4f8141d393b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f3304d10-e321-440d-9fc9-b4f8141d393b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f3304d10-e321-440d-9fc9-b4f8141d393b&filter[owner_type]=customers"
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
          "owner_id": "4ef87373-b5fe-4fec-b6b2-c2ce22644630",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "949e6f0a-5d48-450f-9775-6e8bec1f822e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T07:52:06+00:00",
      "updated_at": "2023-03-08T07:52:06+00:00",
      "number": "http://bqbl.it/949e6f0a-5d48-450f-9775-6e8bec1f822e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/133f946fbbb421c7db44bf1d28577bd9/barcode/image/949e6f0a-5d48-450f-9775-6e8bec1f822e/68f81d1d-2f86-4288-ba81-f7547ec5c473.svg",
      "owner_id": "4ef87373-b5fe-4fec-b6b2-c2ce22644630",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4608f2fe-4f1c-4bd4-8581-40056e3c5278' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4608f2fe-4f1c-4bd4-8581-40056e3c5278",
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
    "id": "4608f2fe-4f1c-4bd4-8581-40056e3c5278",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T07:52:06+00:00",
      "updated_at": "2023-03-08T07:52:06+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/36593bc0969c72beba92d9bc1199a8a8/barcode/image/4608f2fe-4f1c-4bd4-8581-40056e3c5278/a8ff9f0f-2e86-4e92-9213-49d0c66674d3.svg",
      "owner_id": "8b7e1f8f-ee22-455f-b3bd-b726479975fb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2cd039aa-064b-47b9-8d62-2e2666f2de38' \
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