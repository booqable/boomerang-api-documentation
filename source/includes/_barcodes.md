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
      "id": "53c4d049-0221-48b7-8d9c-59e600cba118",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T08:05:59+00:00",
        "updated_at": "2023-02-07T08:05:59+00:00",
        "number": "http://bqbl.it/53c4d049-0221-48b7-8d9c-59e600cba118",
        "barcode_type": "qr_code",
        "image_url": "/uploads/72cb122104bb99647a6ba5a3bade2911/barcode/image/53c4d049-0221-48b7-8d9c-59e600cba118/f64cdb75-151a-445f-86f3-adc6173838b1.svg",
        "owner_id": "841caa9c-e552-43d5-8bce-eee805481acb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/841caa9c-e552-43d5-8bce-eee805481acb"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc10fd889-2a02-41cc-8c90-6d2093b1e6bd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c10fd889-2a02-41cc-8c90-6d2093b1e6bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T08:05:59+00:00",
        "updated_at": "2023-02-07T08:05:59+00:00",
        "number": "http://bqbl.it/c10fd889-2a02-41cc-8c90-6d2093b1e6bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2a12d679ffddb73908b467a172faeb0c/barcode/image/c10fd889-2a02-41cc-8c90-6d2093b1e6bd/73dbcc4a-d484-4ebb-9aef-2e9062416fd7.svg",
        "owner_id": "4bc00dd8-3ef5-41b6-a054-e0a2c532faaf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4bc00dd8-3ef5-41b6-a054-e0a2c532faaf"
          },
          "data": {
            "type": "customers",
            "id": "4bc00dd8-3ef5-41b6-a054-e0a2c532faaf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4bc00dd8-3ef5-41b6-a054-e0a2c532faaf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T08:05:59+00:00",
        "updated_at": "2023-02-07T08:05:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4bc00dd8-3ef5-41b6-a054-e0a2c532faaf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4bc00dd8-3ef5-41b6-a054-e0a2c532faaf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4bc00dd8-3ef5-41b6-a054-e0a2c532faaf&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGI2NzMwNGYtNjkyYS00NjMwLThmYjYtYzRjNmU5OTI2MzZm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8b67304f-692a-4630-8fb6-c4c6e992636f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T08:06:00+00:00",
        "updated_at": "2023-02-07T08:06:00+00:00",
        "number": "http://bqbl.it/8b67304f-692a-4630-8fb6-c4c6e992636f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/749c765de0044c76069c945d9e8811fb/barcode/image/8b67304f-692a-4630-8fb6-c4c6e992636f/9805d923-b7ce-4fb0-98c4-7e6aa94f5443.svg",
        "owner_id": "ff33be6b-395b-40a3-805d-b04f90e182a8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ff33be6b-395b-40a3-805d-b04f90e182a8"
          },
          "data": {
            "type": "customers",
            "id": "ff33be6b-395b-40a3-805d-b04f90e182a8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ff33be6b-395b-40a3-805d-b04f90e182a8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T08:06:00+00:00",
        "updated_at": "2023-02-07T08:06:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ff33be6b-395b-40a3-805d-b04f90e182a8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ff33be6b-395b-40a3-805d-b04f90e182a8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ff33be6b-395b-40a3-805d-b04f90e182a8&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T08:05:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4e2bc33-179d-4551-b02a-2170e16c5da8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c4e2bc33-179d-4551-b02a-2170e16c5da8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T08:06:01+00:00",
      "updated_at": "2023-02-07T08:06:01+00:00",
      "number": "http://bqbl.it/c4e2bc33-179d-4551-b02a-2170e16c5da8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/37cc4589b31b7b4c581e942dc5c04a5f/barcode/image/c4e2bc33-179d-4551-b02a-2170e16c5da8/7dcf575a-f5db-495a-afd0-37e71dba3c34.svg",
      "owner_id": "b9d68545-3ba8-453b-be0b-65780f14c024",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b9d68545-3ba8-453b-be0b-65780f14c024"
        },
        "data": {
          "type": "customers",
          "id": "b9d68545-3ba8-453b-be0b-65780f14c024"
        }
      }
    }
  },
  "included": [
    {
      "id": "b9d68545-3ba8-453b-be0b-65780f14c024",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T08:06:01+00:00",
        "updated_at": "2023-02-07T08:06:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b9d68545-3ba8-453b-be0b-65780f14c024&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b9d68545-3ba8-453b-be0b-65780f14c024&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b9d68545-3ba8-453b-be0b-65780f14c024&filter[owner_type]=customers"
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
          "owner_id": "19dbd6d7-a7c8-4f47-873b-feb07c8a9fce",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4f54f8b9-0a05-4c10-8a4d-e35856164e26",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T08:06:01+00:00",
      "updated_at": "2023-02-07T08:06:01+00:00",
      "number": "http://bqbl.it/4f54f8b9-0a05-4c10-8a4d-e35856164e26",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c0b3a9fa729cda4edd6781dd81d802f2/barcode/image/4f54f8b9-0a05-4c10-8a4d-e35856164e26/56baa142-9971-4283-a481-32b57fcb31c9.svg",
      "owner_id": "19dbd6d7-a7c8-4f47-873b-feb07c8a9fce",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0e45bed4-585f-44c1-b64a-a7d19141b7b3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0e45bed4-585f-44c1-b64a-a7d19141b7b3",
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
    "id": "0e45bed4-585f-44c1-b64a-a7d19141b7b3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T08:06:02+00:00",
      "updated_at": "2023-02-07T08:06:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a2a2388a65a024f4838ba26378540c2c/barcode/image/0e45bed4-585f-44c1-b64a-a7d19141b7b3/0e38e810-8967-4f10-8bef-3d81739cb7aa.svg",
      "owner_id": "a193b007-af81-4440-83ce-cab10a2edbaa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e59dc54b-444c-4311-86a5-4183133fa429' \
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