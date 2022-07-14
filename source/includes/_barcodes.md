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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "cdb78b61-105b-4f45-9a92-3032ecd63c1d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T11:59:46+00:00",
        "updated_at": "2022-07-14T11:59:46+00:00",
        "number": "http://bqbl.it/cdb78b61-105b-4f45-9a92-3032ecd63c1d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5baa18b216388a8bf304379d0865ae85/barcode/image/cdb78b61-105b-4f45-9a92-3032ecd63c1d/2c8a3908-a119-43c2-986d-608f96e979a8.svg",
        "owner_id": "271ddff9-7f62-4534-b0cc-fe304505cf89",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/271ddff9-7f62-4534-b0cc-fe304505cf89"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F581a4633-e392-4c5f-af7a-e4b582f0e83e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "581a4633-e392-4c5f-af7a-e4b582f0e83e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T11:59:47+00:00",
        "updated_at": "2022-07-14T11:59:47+00:00",
        "number": "http://bqbl.it/581a4633-e392-4c5f-af7a-e4b582f0e83e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/df933adcac042615db7b1e3a3ed24e62/barcode/image/581a4633-e392-4c5f-af7a-e4b582f0e83e/a7c1c9e3-030d-4d92-b0c1-25743bc5939d.svg",
        "owner_id": "7f41688e-ec8a-4985-8930-d63707f7a4c5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7f41688e-ec8a-4985-8930-d63707f7a4c5"
          },
          "data": {
            "type": "customers",
            "id": "7f41688e-ec8a-4985-8930-d63707f7a4c5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7f41688e-ec8a-4985-8930-d63707f7a4c5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T11:59:47+00:00",
        "updated_at": "2022-07-14T11:59:47+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Paucek LLC",
        "email": "paucek.llc@haley-bernhard.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=7f41688e-ec8a-4985-8930-d63707f7a4c5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7f41688e-ec8a-4985-8930-d63707f7a4c5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7f41688e-ec8a-4985-8930-d63707f7a4c5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMGZjZDFiNzUtOTdmYy00NzQ4LWFmYmMtNmM2ODg3ZmQwMTgz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0fcd1b75-97fc-4748-afbc-6c6887fd0183",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T11:59:48+00:00",
        "updated_at": "2022-07-14T11:59:48+00:00",
        "number": "http://bqbl.it/0fcd1b75-97fc-4748-afbc-6c6887fd0183",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b1df4ddd0d02bfc827561c6e2b051432/barcode/image/0fcd1b75-97fc-4748-afbc-6c6887fd0183/3bf6b001-2d6d-4079-afd1-975cb24d09d0.svg",
        "owner_id": "1853505f-b1a9-46a4-a8d3-0d0aaff5c281",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1853505f-b1a9-46a4-a8d3-0d0aaff5c281"
          },
          "data": {
            "type": "customers",
            "id": "1853505f-b1a9-46a4-a8d3-0d0aaff5c281"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1853505f-b1a9-46a4-a8d3-0d0aaff5c281",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T11:59:48+00:00",
        "updated_at": "2022-07-14T11:59:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mills-Bayer",
        "email": "bayer_mills@wunsch.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=1853505f-b1a9-46a4-a8d3-0d0aaff5c281&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1853505f-b1a9-46a4-a8d3-0d0aaff5c281&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1853505f-b1a9-46a4-a8d3-0d0aaff5c281&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T11:59:27Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/04aa6dfe-0123-4728-9533-17dd32001670?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "04aa6dfe-0123-4728-9533-17dd32001670",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T11:59:49+00:00",
      "updated_at": "2022-07-14T11:59:49+00:00",
      "number": "http://bqbl.it/04aa6dfe-0123-4728-9533-17dd32001670",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e2af01583281050e5547f03b2b5a00c2/barcode/image/04aa6dfe-0123-4728-9533-17dd32001670/1a68b7e5-f056-44ca-ac5b-812da2c38890.svg",
      "owner_id": "a4f3104c-8ec5-43ea-b072-29f85aba4425",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a4f3104c-8ec5-43ea-b072-29f85aba4425"
        },
        "data": {
          "type": "customers",
          "id": "a4f3104c-8ec5-43ea-b072-29f85aba4425"
        }
      }
    }
  },
  "included": [
    {
      "id": "a4f3104c-8ec5-43ea-b072-29f85aba4425",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T11:59:48+00:00",
        "updated_at": "2022-07-14T11:59:49+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Stiedemann-Zboncak",
        "email": "zboncak_stiedemann@tillman.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=a4f3104c-8ec5-43ea-b072-29f85aba4425&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a4f3104c-8ec5-43ea-b072-29f85aba4425&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a4f3104c-8ec5-43ea-b072-29f85aba4425&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "fa2f556a-32da-41b1-aab8-0006acfc804c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7bef1559-a0dc-4be2-a75d-6109fb57db2d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T11:59:49+00:00",
      "updated_at": "2022-07-14T11:59:49+00:00",
      "number": "http://bqbl.it/7bef1559-a0dc-4be2-a75d-6109fb57db2d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2576398099cacad46a046a2104e875df/barcode/image/7bef1559-a0dc-4be2-a75d-6109fb57db2d/fa7778ef-df9b-4cc6-b486-0fe47fd45cd4.svg",
      "owner_id": "fa2f556a-32da-41b1-aab8-0006acfc804c",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/7d7c03c2-7ae7-4530-b94c-6522217a82b8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7d7c03c2-7ae7-4530-b94c-6522217a82b8",
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
    "id": "7d7c03c2-7ae7-4530-b94c-6522217a82b8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T11:59:50+00:00",
      "updated_at": "2022-07-14T11:59:50+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/439b6dfe481e2484ac1f3a767413f217/barcode/image/7d7c03c2-7ae7-4530-b94c-6522217a82b8/a294c8ba-1295-4a24-aed9-38c89e66e305.svg",
      "owner_id": "8f7cbfcd-f780-4cc5-939d-33f7dd0ef3df",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/59a0c4da-af9a-48d4-9b01-f35055c17768' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes