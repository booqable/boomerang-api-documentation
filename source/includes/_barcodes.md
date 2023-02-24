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
      "id": "e7498a4b-8ff5-4beb-8bbd-7da20d168f87",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T08:52:32+00:00",
        "updated_at": "2023-02-24T08:52:32+00:00",
        "number": "http://bqbl.it/e7498a4b-8ff5-4beb-8bbd-7da20d168f87",
        "barcode_type": "qr_code",
        "image_url": "/uploads/be10c414280e016e5c1130aa5b795649/barcode/image/e7498a4b-8ff5-4beb-8bbd-7da20d168f87/7031a1b3-4b0c-44f7-9bb9-64b87167b3bd.svg",
        "owner_id": "c07e7986-0c29-407e-98df-df9bc8e3f1c1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c07e7986-0c29-407e-98df-df9bc8e3f1c1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3c5c2492-9b81-4cd6-a2fe-50ab72404085&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3c5c2492-9b81-4cd6-a2fe-50ab72404085",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T08:52:32+00:00",
        "updated_at": "2023-02-24T08:52:32+00:00",
        "number": "http://bqbl.it/3c5c2492-9b81-4cd6-a2fe-50ab72404085",
        "barcode_type": "qr_code",
        "image_url": "/uploads/528e56367c5e7b827212ff9aae415b91/barcode/image/3c5c2492-9b81-4cd6-a2fe-50ab72404085/ce91596d-61d6-4ad9-89d6-5d84c8a9aab3.svg",
        "owner_id": "9f1f64d1-a252-4efd-ac08-d29c2b3857a4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9f1f64d1-a252-4efd-ac08-d29c2b3857a4"
          },
          "data": {
            "type": "customers",
            "id": "9f1f64d1-a252-4efd-ac08-d29c2b3857a4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9f1f64d1-a252-4efd-ac08-d29c2b3857a4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T08:52:32+00:00",
        "updated_at": "2023-02-24T08:52:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9f1f64d1-a252-4efd-ac08-d29c2b3857a4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9f1f64d1-a252-4efd-ac08-d29c2b3857a4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9f1f64d1-a252-4efd-ac08-d29c2b3857a4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGU4MDQwNGUtMGVhMy00YmZhLTk5ZGUtZjZkZjg3NTkzZjI3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "de80404e-0ea3-4bfa-99de-f6df87593f27",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T08:52:33+00:00",
        "updated_at": "2023-02-24T08:52:33+00:00",
        "number": "http://bqbl.it/de80404e-0ea3-4bfa-99de-f6df87593f27",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3c514d5b066fb8185e1f0d81f8513c7f/barcode/image/de80404e-0ea3-4bfa-99de-f6df87593f27/9c4dd111-d62b-4d96-b97c-4cab0df2f932.svg",
        "owner_id": "32f8513f-e5fe-43c8-84b1-b5667e285c9b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/32f8513f-e5fe-43c8-84b1-b5667e285c9b"
          },
          "data": {
            "type": "customers",
            "id": "32f8513f-e5fe-43c8-84b1-b5667e285c9b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "32f8513f-e5fe-43c8-84b1-b5667e285c9b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T08:52:33+00:00",
        "updated_at": "2023-02-24T08:52:33+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=32f8513f-e5fe-43c8-84b1-b5667e285c9b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=32f8513f-e5fe-43c8-84b1-b5667e285c9b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=32f8513f-e5fe-43c8-84b1-b5667e285c9b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:52:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b5af02b4-d5aa-4e78-8789-b7d8eba2d234?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b5af02b4-d5aa-4e78-8789-b7d8eba2d234",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T08:52:33+00:00",
      "updated_at": "2023-02-24T08:52:33+00:00",
      "number": "http://bqbl.it/b5af02b4-d5aa-4e78-8789-b7d8eba2d234",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1306408dc2bc8611e02c2dc886d1d105/barcode/image/b5af02b4-d5aa-4e78-8789-b7d8eba2d234/c8342083-8017-4998-9156-27ba310a18e3.svg",
      "owner_id": "da238af2-6aca-44ad-9126-021fa526fa0b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/da238af2-6aca-44ad-9126-021fa526fa0b"
        },
        "data": {
          "type": "customers",
          "id": "da238af2-6aca-44ad-9126-021fa526fa0b"
        }
      }
    }
  },
  "included": [
    {
      "id": "da238af2-6aca-44ad-9126-021fa526fa0b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T08:52:33+00:00",
        "updated_at": "2023-02-24T08:52:33+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=da238af2-6aca-44ad-9126-021fa526fa0b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=da238af2-6aca-44ad-9126-021fa526fa0b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=da238af2-6aca-44ad-9126-021fa526fa0b&filter[owner_type]=customers"
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
          "owner_id": "85e10560-4f39-431c-a002-2ea6ce94c5c8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a82f5b95-8036-4652-8c67-95d4a78eac07",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T08:52:34+00:00",
      "updated_at": "2023-02-24T08:52:34+00:00",
      "number": "http://bqbl.it/a82f5b95-8036-4652-8c67-95d4a78eac07",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a84fc18baa3ad6a3c59576e564e1c554/barcode/image/a82f5b95-8036-4652-8c67-95d4a78eac07/dd9f1b59-a767-4f1e-9b9a-8d00088f4819.svg",
      "owner_id": "85e10560-4f39-431c-a002-2ea6ce94c5c8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ceba6e53-08dd-446f-80f0-75cc966c7848' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ceba6e53-08dd-446f-80f0-75cc966c7848",
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
    "id": "ceba6e53-08dd-446f-80f0-75cc966c7848",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T08:52:34+00:00",
      "updated_at": "2023-02-24T08:52:34+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/982ac3e0e36ab3f5ae9cfbdd36e3b5f5/barcode/image/ceba6e53-08dd-446f-80f0-75cc966c7848/d7eb9a3e-b128-4f64-90ed-7a70d96ca8a0.svg",
      "owner_id": "894abcc2-06d4-4f33-baf1-978b1ef65592",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0064e2f3-f5d1-477a-aac8-126d316368ed' \
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