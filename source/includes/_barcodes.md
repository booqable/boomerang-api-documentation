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
      "id": "7d9777d4-8eb4-43cf-b2ac-8fafd06da88e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T13:00:10+00:00",
        "updated_at": "2023-02-08T13:00:10+00:00",
        "number": "http://bqbl.it/7d9777d4-8eb4-43cf-b2ac-8fafd06da88e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cb9b30fd5d84bd4f64ccefe96d7c4c4d/barcode/image/7d9777d4-8eb4-43cf-b2ac-8fafd06da88e/3d6dffe4-c39f-4fbf-8a14-c64f48bfa1f9.svg",
        "owner_id": "367f8deb-2c14-4ed3-b889-b9d1bbbb088b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/367f8deb-2c14-4ed3-b889-b9d1bbbb088b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fadd0e72d-1bca-4a9f-b622-5e982beaeebe&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "add0e72d-1bca-4a9f-b622-5e982beaeebe",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T13:00:10+00:00",
        "updated_at": "2023-02-08T13:00:10+00:00",
        "number": "http://bqbl.it/add0e72d-1bca-4a9f-b622-5e982beaeebe",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5826cd82e311ca90494183c5e61386a0/barcode/image/add0e72d-1bca-4a9f-b622-5e982beaeebe/1880ac58-7fb1-4ac5-99c8-5181c9ce076c.svg",
        "owner_id": "82eca022-8740-49da-a61c-2a8caffc8caa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/82eca022-8740-49da-a61c-2a8caffc8caa"
          },
          "data": {
            "type": "customers",
            "id": "82eca022-8740-49da-a61c-2a8caffc8caa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "82eca022-8740-49da-a61c-2a8caffc8caa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T13:00:10+00:00",
        "updated_at": "2023-02-08T13:00:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=82eca022-8740-49da-a61c-2a8caffc8caa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=82eca022-8740-49da-a61c-2a8caffc8caa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=82eca022-8740-49da-a61c-2a8caffc8caa&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODM2ZTY1YzQtYzNlMS00YTYzLThhZWItNWFmMjU0MDBkMWI3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "836e65c4-c3e1-4a63-8aeb-5af25400d1b7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T13:00:10+00:00",
        "updated_at": "2023-02-08T13:00:10+00:00",
        "number": "http://bqbl.it/836e65c4-c3e1-4a63-8aeb-5af25400d1b7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2385cc480ea4939f6c454d0e2fe8366b/barcode/image/836e65c4-c3e1-4a63-8aeb-5af25400d1b7/1c0ddabf-47ab-488a-8be4-d1ce62b4e044.svg",
        "owner_id": "58289245-c198-40f1-8c49-51d0440c1985",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/58289245-c198-40f1-8c49-51d0440c1985"
          },
          "data": {
            "type": "customers",
            "id": "58289245-c198-40f1-8c49-51d0440c1985"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "58289245-c198-40f1-8c49-51d0440c1985",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T13:00:10+00:00",
        "updated_at": "2023-02-08T13:00:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=58289245-c198-40f1-8c49-51d0440c1985&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=58289245-c198-40f1-8c49-51d0440c1985&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=58289245-c198-40f1-8c49-51d0440c1985&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T12:59:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3cf9ea3a-6a7e-45b9-a10f-99069be17d38?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3cf9ea3a-6a7e-45b9-a10f-99069be17d38",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T13:00:11+00:00",
      "updated_at": "2023-02-08T13:00:11+00:00",
      "number": "http://bqbl.it/3cf9ea3a-6a7e-45b9-a10f-99069be17d38",
      "barcode_type": "qr_code",
      "image_url": "/uploads/40a1c6918619742ab1cd0711285ee3db/barcode/image/3cf9ea3a-6a7e-45b9-a10f-99069be17d38/6367508f-6c0a-4562-9164-ae150ed6f887.svg",
      "owner_id": "13a6cac3-7c34-432f-89b2-dd37da24bb95",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/13a6cac3-7c34-432f-89b2-dd37da24bb95"
        },
        "data": {
          "type": "customers",
          "id": "13a6cac3-7c34-432f-89b2-dd37da24bb95"
        }
      }
    }
  },
  "included": [
    {
      "id": "13a6cac3-7c34-432f-89b2-dd37da24bb95",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T13:00:11+00:00",
        "updated_at": "2023-02-08T13:00:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=13a6cac3-7c34-432f-89b2-dd37da24bb95&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=13a6cac3-7c34-432f-89b2-dd37da24bb95&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=13a6cac3-7c34-432f-89b2-dd37da24bb95&filter[owner_type]=customers"
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
          "owner_id": "a0765a77-2bff-4335-a6af-925e678894e4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "563c6c6d-d9e4-45df-813e-938c627dc598",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T13:00:12+00:00",
      "updated_at": "2023-02-08T13:00:12+00:00",
      "number": "http://bqbl.it/563c6c6d-d9e4-45df-813e-938c627dc598",
      "barcode_type": "qr_code",
      "image_url": "/uploads/290adb0dcfd7197a99885652536168e9/barcode/image/563c6c6d-d9e4-45df-813e-938c627dc598/220a99d1-9f25-4e44-b181-4547d1aac848.svg",
      "owner_id": "a0765a77-2bff-4335-a6af-925e678894e4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eb19c369-524f-467d-8da1-8e1dd9cb04f8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eb19c369-524f-467d-8da1-8e1dd9cb04f8",
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
    "id": "eb19c369-524f-467d-8da1-8e1dd9cb04f8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T13:00:12+00:00",
      "updated_at": "2023-02-08T13:00:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0e7ecbc7ba1e51cfb360aac80c5d648d/barcode/image/eb19c369-524f-467d-8da1-8e1dd9cb04f8/2c8e29d8-d466-4d6f-9daf-271e2a92c851.svg",
      "owner_id": "c66f5f60-e423-489c-8506-1049e219acce",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d62fbbfe-82d9-49b5-85cf-c557e6f11e6c' \
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