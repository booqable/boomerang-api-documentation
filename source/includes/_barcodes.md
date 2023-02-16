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
      "id": "3369c45b-bcfc-45c7-98b7-f8a504954ffd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T15:34:36+00:00",
        "updated_at": "2023-02-16T15:34:36+00:00",
        "number": "http://bqbl.it/3369c45b-bcfc-45c7-98b7-f8a504954ffd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0dd845c5ecd5103607d01ca4a5c83586/barcode/image/3369c45b-bcfc-45c7-98b7-f8a504954ffd/a3051d4c-ccbe-466f-8653-fcdcdbf21041.svg",
        "owner_id": "5cc856e8-e7c2-4424-9bcc-8e6c4c48f377",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5cc856e8-e7c2-4424-9bcc-8e6c4c48f377"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff85c81ce-ee90-4822-b327-5ef400570ca9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f85c81ce-ee90-4822-b327-5ef400570ca9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T15:34:36+00:00",
        "updated_at": "2023-02-16T15:34:36+00:00",
        "number": "http://bqbl.it/f85c81ce-ee90-4822-b327-5ef400570ca9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/32790bf45161c03b1cfb1f18fd156b58/barcode/image/f85c81ce-ee90-4822-b327-5ef400570ca9/534db2ff-5cea-4a3c-9668-f8ef66da8a69.svg",
        "owner_id": "f0ec25f8-6644-4684-a899-a501cbf9ea38",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f0ec25f8-6644-4684-a899-a501cbf9ea38"
          },
          "data": {
            "type": "customers",
            "id": "f0ec25f8-6644-4684-a899-a501cbf9ea38"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f0ec25f8-6644-4684-a899-a501cbf9ea38",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T15:34:36+00:00",
        "updated_at": "2023-02-16T15:34:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f0ec25f8-6644-4684-a899-a501cbf9ea38&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f0ec25f8-6644-4684-a899-a501cbf9ea38&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f0ec25f8-6644-4684-a899-a501cbf9ea38&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmJjMWMyMmYtMTZjZS00MmYwLTk1ZTItMjg3MDVjMmUyNTQw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bbc1c22f-16ce-42f0-95e2-28705c2e2540",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T15:34:37+00:00",
        "updated_at": "2023-02-16T15:34:37+00:00",
        "number": "http://bqbl.it/bbc1c22f-16ce-42f0-95e2-28705c2e2540",
        "barcode_type": "qr_code",
        "image_url": "/uploads/837d850949dfc5d988000f05c951de56/barcode/image/bbc1c22f-16ce-42f0-95e2-28705c2e2540/13ce889b-be69-48b4-8309-2a9c2b7e347f.svg",
        "owner_id": "afa43398-bdea-4141-a0fa-868559cf3021",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/afa43398-bdea-4141-a0fa-868559cf3021"
          },
          "data": {
            "type": "customers",
            "id": "afa43398-bdea-4141-a0fa-868559cf3021"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "afa43398-bdea-4141-a0fa-868559cf3021",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T15:34:37+00:00",
        "updated_at": "2023-02-16T15:34:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=afa43398-bdea-4141-a0fa-868559cf3021&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=afa43398-bdea-4141-a0fa-868559cf3021&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=afa43398-bdea-4141-a0fa-868559cf3021&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T15:34:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c234747-d4fa-4551-8728-7f608fd7b53c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1c234747-d4fa-4551-8728-7f608fd7b53c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T15:34:37+00:00",
      "updated_at": "2023-02-16T15:34:37+00:00",
      "number": "http://bqbl.it/1c234747-d4fa-4551-8728-7f608fd7b53c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4591d15e6b9083f59a3d840ffd7cf7e1/barcode/image/1c234747-d4fa-4551-8728-7f608fd7b53c/39966328-e0d4-49df-8a2c-8ee6f27de328.svg",
      "owner_id": "9097a4a6-3789-43f2-aa93-714908cfea3f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9097a4a6-3789-43f2-aa93-714908cfea3f"
        },
        "data": {
          "type": "customers",
          "id": "9097a4a6-3789-43f2-aa93-714908cfea3f"
        }
      }
    }
  },
  "included": [
    {
      "id": "9097a4a6-3789-43f2-aa93-714908cfea3f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T15:34:37+00:00",
        "updated_at": "2023-02-16T15:34:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9097a4a6-3789-43f2-aa93-714908cfea3f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9097a4a6-3789-43f2-aa93-714908cfea3f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9097a4a6-3789-43f2-aa93-714908cfea3f&filter[owner_type]=customers"
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
          "owner_id": "39fef5b1-9ee6-4aa8-a2de-9d3835abff3e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fdcf657b-eeae-4a03-9141-e3049ab8bf2f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T15:34:38+00:00",
      "updated_at": "2023-02-16T15:34:38+00:00",
      "number": "http://bqbl.it/fdcf657b-eeae-4a03-9141-e3049ab8bf2f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e2b5534a0cabd567a2fbbd871b01da7/barcode/image/fdcf657b-eeae-4a03-9141-e3049ab8bf2f/364774df-a13c-4ac6-9936-0cefb1814cbe.svg",
      "owner_id": "39fef5b1-9ee6-4aa8-a2de-9d3835abff3e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/819e6825-4213-4b60-9b1e-a996edf1385a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "819e6825-4213-4b60-9b1e-a996edf1385a",
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
    "id": "819e6825-4213-4b60-9b1e-a996edf1385a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T15:34:38+00:00",
      "updated_at": "2023-02-16T15:34:38+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ebc5a659a6bcbf8f2276db42f6803eed/barcode/image/819e6825-4213-4b60-9b1e-a996edf1385a/7f8beb06-56a9-47a1-aafe-426600fd24d4.svg",
      "owner_id": "5f602c7c-bff8-401b-a6b8-1edd6a7b2504",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7dfc46b5-5d0f-4cc7-9ce3-6d66b9e1f82c' \
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