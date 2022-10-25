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
      "id": "277bc2ea-2d3e-4978-9689-42f19f443100",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T17:51:15+00:00",
        "updated_at": "2022-10-25T17:51:15+00:00",
        "number": "http://bqbl.it/277bc2ea-2d3e-4978-9689-42f19f443100",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5517d6e04888a1523db2a3e8c1a0b6d7/barcode/image/277bc2ea-2d3e-4978-9689-42f19f443100/ea90e8f5-887f-4faa-850a-c6f060872ff5.svg",
        "owner_id": "c965bf2b-f5a7-4bbd-a8b9-3cd171736418",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c965bf2b-f5a7-4bbd-a8b9-3cd171736418"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff39b54ff-08f8-4c04-b389-c927d802f756&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f39b54ff-08f8-4c04-b389-c927d802f756",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T17:51:16+00:00",
        "updated_at": "2022-10-25T17:51:16+00:00",
        "number": "http://bqbl.it/f39b54ff-08f8-4c04-b389-c927d802f756",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c1911b45218eca5a53f29cb17d38a416/barcode/image/f39b54ff-08f8-4c04-b389-c927d802f756/b97fc972-68bb-46ac-a4b0-44cbb35c71c8.svg",
        "owner_id": "15e46efe-ab1c-4af6-b148-ba24d06dac38",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/15e46efe-ab1c-4af6-b148-ba24d06dac38"
          },
          "data": {
            "type": "customers",
            "id": "15e46efe-ab1c-4af6-b148-ba24d06dac38"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "15e46efe-ab1c-4af6-b148-ba24d06dac38",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T17:51:16+00:00",
        "updated_at": "2022-10-25T17:51:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=15e46efe-ab1c-4af6-b148-ba24d06dac38&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=15e46efe-ab1c-4af6-b148-ba24d06dac38&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=15e46efe-ab1c-4af6-b148-ba24d06dac38&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTNjM2Y2M2YtODE3Ni00NTUwLWJhNjAtZGEzMGEwMGMyZjQ5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e3c3f63f-8176-4550-ba60-da30a00c2f49",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T17:51:16+00:00",
        "updated_at": "2022-10-25T17:51:16+00:00",
        "number": "http://bqbl.it/e3c3f63f-8176-4550-ba60-da30a00c2f49",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6dec03dfeb6788a8fa3307902cf25f76/barcode/image/e3c3f63f-8176-4550-ba60-da30a00c2f49/a226ee33-1c46-46ef-8b77-328929854a24.svg",
        "owner_id": "7ddd6829-aba0-4471-8210-177158c26d83",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7ddd6829-aba0-4471-8210-177158c26d83"
          },
          "data": {
            "type": "customers",
            "id": "7ddd6829-aba0-4471-8210-177158c26d83"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7ddd6829-aba0-4471-8210-177158c26d83",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T17:51:16+00:00",
        "updated_at": "2022-10-25T17:51:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ddd6829-aba0-4471-8210-177158c26d83&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ddd6829-aba0-4471-8210-177158c26d83&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7ddd6829-aba0-4471-8210-177158c26d83&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/180ae0a2-3361-471e-8321-813fd931c070?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "180ae0a2-3361-471e-8321-813fd931c070",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T17:51:17+00:00",
      "updated_at": "2022-10-25T17:51:17+00:00",
      "number": "http://bqbl.it/180ae0a2-3361-471e-8321-813fd931c070",
      "barcode_type": "qr_code",
      "image_url": "/uploads/abafe4d85889b0f3fca05ad7aea0f535/barcode/image/180ae0a2-3361-471e-8321-813fd931c070/c8e24b72-4673-44c4-887d-dec4ac553bcd.svg",
      "owner_id": "8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb"
        },
        "data": {
          "type": "customers",
          "id": "8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb"
        }
      }
    }
  },
  "included": [
    {
      "id": "8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T17:51:17+00:00",
        "updated_at": "2022-10-25T17:51:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8c49f82f-fd1e-4d0d-bd21-9c0f742ad7bb&filter[owner_type]=customers"
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
          "owner_id": "dc9cefa1-0a16-4dfd-b3c4-8a39b9b70b25",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0ed9eabf-a56f-471f-a6fb-675d07aaa205",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T17:51:17+00:00",
      "updated_at": "2022-10-25T17:51:17+00:00",
      "number": "http://bqbl.it/0ed9eabf-a56f-471f-a6fb-675d07aaa205",
      "barcode_type": "qr_code",
      "image_url": "/uploads/62fc88680d19ef9847a91fdde03d4741/barcode/image/0ed9eabf-a56f-471f-a6fb-675d07aaa205/2f0f76e6-8824-4176-a5b3-2eb89f7c22a7.svg",
      "owner_id": "dc9cefa1-0a16-4dfd-b3c4-8a39b9b70b25",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9cfde2b9-d64f-4cc3-ad6d-72b6e85b63a2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9cfde2b9-d64f-4cc3-ad6d-72b6e85b63a2",
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
    "id": "9cfde2b9-d64f-4cc3-ad6d-72b6e85b63a2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T17:51:18+00:00",
      "updated_at": "2022-10-25T17:51:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e29296cbe9925c9bba55d784c4a3f4d6/barcode/image/9cfde2b9-d64f-4cc3-ad6d-72b6e85b63a2/e8b79d02-02af-4aaa-8971-1af7328181aa.svg",
      "owner_id": "fc638866-4ae8-4da8-b0b4-f97babe4e4be",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a49f1d66-4cd6-4651-a42f-69034647acce' \
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