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
      "id": "bef42578-de05-4e26-b53d-a3ffe44fb3d1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T12:59:08+00:00",
        "updated_at": "2023-02-01T12:59:08+00:00",
        "number": "http://bqbl.it/bef42578-de05-4e26-b53d-a3ffe44fb3d1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/144a2ec136584282ff62bf3b1c462bc9/barcode/image/bef42578-de05-4e26-b53d-a3ffe44fb3d1/c43f88bd-ae17-4ceb-830d-a15ad4e313a2.svg",
        "owner_id": "c8b221f1-c796-4e48-baad-42f5557bbff4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c8b221f1-c796-4e48-baad-42f5557bbff4"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2493a3e8-008e-47e3-a726-a15e99166081&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2493a3e8-008e-47e3-a726-a15e99166081",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T12:59:09+00:00",
        "updated_at": "2023-02-01T12:59:09+00:00",
        "number": "http://bqbl.it/2493a3e8-008e-47e3-a726-a15e99166081",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fa3f4bfee72d69239002cec9190da967/barcode/image/2493a3e8-008e-47e3-a726-a15e99166081/8b658155-c336-4b29-a3b5-eca918475ae6.svg",
        "owner_id": "43ff7d57-f304-4390-b3bc-451a8f51ea2e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/43ff7d57-f304-4390-b3bc-451a8f51ea2e"
          },
          "data": {
            "type": "customers",
            "id": "43ff7d57-f304-4390-b3bc-451a8f51ea2e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "43ff7d57-f304-4390-b3bc-451a8f51ea2e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T12:59:09+00:00",
        "updated_at": "2023-02-01T12:59:09+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=43ff7d57-f304-4390-b3bc-451a8f51ea2e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=43ff7d57-f304-4390-b3bc-451a8f51ea2e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=43ff7d57-f304-4390-b3bc-451a8f51ea2e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvN2IzMzZjNTEtYjU5Yi00YWEwLTliMzQtMGU0OGFjYjI2ZGU4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7b336c51-b59b-4aa0-9b34-0e48acb26de8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T12:59:10+00:00",
        "updated_at": "2023-02-01T12:59:10+00:00",
        "number": "http://bqbl.it/7b336c51-b59b-4aa0-9b34-0e48acb26de8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/597fbb58bdd6a61b99a8f9d1b37e14ae/barcode/image/7b336c51-b59b-4aa0-9b34-0e48acb26de8/ef4870b1-85d4-444a-a8a9-07f6a5b6b3f7.svg",
        "owner_id": "2933a7cc-0ea9-4959-84b1-4fdf645d19f8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2933a7cc-0ea9-4959-84b1-4fdf645d19f8"
          },
          "data": {
            "type": "customers",
            "id": "2933a7cc-0ea9-4959-84b1-4fdf645d19f8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2933a7cc-0ea9-4959-84b1-4fdf645d19f8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T12:59:10+00:00",
        "updated_at": "2023-02-01T12:59:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2933a7cc-0ea9-4959-84b1-4fdf645d19f8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2933a7cc-0ea9-4959-84b1-4fdf645d19f8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2933a7cc-0ea9-4959-84b1-4fdf645d19f8&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T12:58:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/86a39f45-dba5-4a85-a527-036b0b6f9fa5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "86a39f45-dba5-4a85-a527-036b0b6f9fa5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T12:59:11+00:00",
      "updated_at": "2023-02-01T12:59:11+00:00",
      "number": "http://bqbl.it/86a39f45-dba5-4a85-a527-036b0b6f9fa5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/79ff67f8e4db9c57371069da746dc12e/barcode/image/86a39f45-dba5-4a85-a527-036b0b6f9fa5/1b3d687e-1049-4135-b9e3-01bff69bb092.svg",
      "owner_id": "4302b31d-d26a-46ec-b1b9-9eb47582db53",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4302b31d-d26a-46ec-b1b9-9eb47582db53"
        },
        "data": {
          "type": "customers",
          "id": "4302b31d-d26a-46ec-b1b9-9eb47582db53"
        }
      }
    }
  },
  "included": [
    {
      "id": "4302b31d-d26a-46ec-b1b9-9eb47582db53",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T12:59:11+00:00",
        "updated_at": "2023-02-01T12:59:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4302b31d-d26a-46ec-b1b9-9eb47582db53&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4302b31d-d26a-46ec-b1b9-9eb47582db53&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4302b31d-d26a-46ec-b1b9-9eb47582db53&filter[owner_type]=customers"
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
          "owner_id": "39c27d7d-98c6-4955-95ef-943dc9212537",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "889cd1e0-69d3-4e05-a059-816717d91139",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T12:59:12+00:00",
      "updated_at": "2023-02-01T12:59:12+00:00",
      "number": "http://bqbl.it/889cd1e0-69d3-4e05-a059-816717d91139",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4fd582e2829b045b03352f38a18dc5a4/barcode/image/889cd1e0-69d3-4e05-a059-816717d91139/28010a78-5116-41aa-9d51-0bcf43ed677d.svg",
      "owner_id": "39c27d7d-98c6-4955-95ef-943dc9212537",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5d15fe42-27bf-475c-87aa-288a4e8bd910' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5d15fe42-27bf-475c-87aa-288a4e8bd910",
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
    "id": "5d15fe42-27bf-475c-87aa-288a4e8bd910",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T12:59:12+00:00",
      "updated_at": "2023-02-01T12:59:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/12c9c7d5ff7a9aaec3f1babc67aa93d4/barcode/image/5d15fe42-27bf-475c-87aa-288a4e8bd910/84c838b7-048f-47d7-9fdd-8b8835d31384.svg",
      "owner_id": "531f374c-7677-4d5f-921f-9f11ebe44887",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c3fc3ef9-1e83-426b-9a26-86530d83ff12' \
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