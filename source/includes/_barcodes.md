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
      "id": "c88552ce-1622-4455-8d15-1df4469955bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T11:55:45+00:00",
        "updated_at": "2022-10-07T11:55:45+00:00",
        "number": "http://bqbl.it/c88552ce-1622-4455-8d15-1df4469955bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1eebdc85b59fee392fc2974d6c29b14/barcode/image/c88552ce-1622-4455-8d15-1df4469955bd/e019a01e-a1b6-4d2b-9cc8-68d0b336d5ef.svg",
        "owner_id": "baf2e72e-ec18-4edd-ba3b-a51674db0c99",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/baf2e72e-ec18-4edd-ba3b-a51674db0c99"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1adac6e0-1e41-44ca-b30b-51537453e886&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1adac6e0-1e41-44ca-b30b-51537453e886",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T11:55:45+00:00",
        "updated_at": "2022-10-07T11:55:45+00:00",
        "number": "http://bqbl.it/1adac6e0-1e41-44ca-b30b-51537453e886",
        "barcode_type": "qr_code",
        "image_url": "/uploads/830cc7ca5f4be6c50d1297e868193b61/barcode/image/1adac6e0-1e41-44ca-b30b-51537453e886/f9fc43a2-ec9a-4bc5-8c43-bc6dca489dee.svg",
        "owner_id": "6a3c9060-1dad-4ecb-a310-0633dd01619b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6a3c9060-1dad-4ecb-a310-0633dd01619b"
          },
          "data": {
            "type": "customers",
            "id": "6a3c9060-1dad-4ecb-a310-0633dd01619b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6a3c9060-1dad-4ecb-a310-0633dd01619b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T11:55:45+00:00",
        "updated_at": "2022-10-07T11:55:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6a3c9060-1dad-4ecb-a310-0633dd01619b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6a3c9060-1dad-4ecb-a310-0633dd01619b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6a3c9060-1dad-4ecb-a310-0633dd01619b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjVhMmE1NTUtMGNjMC00ZjM3LTljYTktYjhjOWNmZTg5Yjg0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f5a2a555-0cc0-4f37-9ca9-b8c9cfe89b84",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T11:55:46+00:00",
        "updated_at": "2022-10-07T11:55:46+00:00",
        "number": "http://bqbl.it/f5a2a555-0cc0-4f37-9ca9-b8c9cfe89b84",
        "barcode_type": "qr_code",
        "image_url": "/uploads/65cd78b91a693a82f8d2ca1e67d954fe/barcode/image/f5a2a555-0cc0-4f37-9ca9-b8c9cfe89b84/10311d63-7ed5-4291-a3dc-ea4c1b0045e7.svg",
        "owner_id": "0720655f-ad5d-4c7d-85cf-d20a42e61daa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0720655f-ad5d-4c7d-85cf-d20a42e61daa"
          },
          "data": {
            "type": "customers",
            "id": "0720655f-ad5d-4c7d-85cf-d20a42e61daa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0720655f-ad5d-4c7d-85cf-d20a42e61daa",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T11:55:46+00:00",
        "updated_at": "2022-10-07T11:55:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0720655f-ad5d-4c7d-85cf-d20a42e61daa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0720655f-ad5d-4c7d-85cf-d20a42e61daa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0720655f-ad5d-4c7d-85cf-d20a42e61daa&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T11:55:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/920fa76a-2b64-4252-bbdc-3edd8f9d4639?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "920fa76a-2b64-4252-bbdc-3edd8f9d4639",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T11:55:46+00:00",
      "updated_at": "2022-10-07T11:55:46+00:00",
      "number": "http://bqbl.it/920fa76a-2b64-4252-bbdc-3edd8f9d4639",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4c303e63ef48b4807bec2dca82844671/barcode/image/920fa76a-2b64-4252-bbdc-3edd8f9d4639/ab72e974-967f-4eff-9694-f60aa0a657ca.svg",
      "owner_id": "e4b0b165-f4ec-4ea9-bf64-7a873141d280",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e4b0b165-f4ec-4ea9-bf64-7a873141d280"
        },
        "data": {
          "type": "customers",
          "id": "e4b0b165-f4ec-4ea9-bf64-7a873141d280"
        }
      }
    }
  },
  "included": [
    {
      "id": "e4b0b165-f4ec-4ea9-bf64-7a873141d280",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T11:55:46+00:00",
        "updated_at": "2022-10-07T11:55:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e4b0b165-f4ec-4ea9-bf64-7a873141d280&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e4b0b165-f4ec-4ea9-bf64-7a873141d280&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e4b0b165-f4ec-4ea9-bf64-7a873141d280&filter[owner_type]=customers"
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
          "owner_id": "a2d565f2-174f-499f-9a64-bb37024c7dc2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d085f1bc-6ed1-4752-84e0-7e3f53e6ba2c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T11:55:47+00:00",
      "updated_at": "2022-10-07T11:55:47+00:00",
      "number": "http://bqbl.it/d085f1bc-6ed1-4752-84e0-7e3f53e6ba2c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/18a15411323c16e1eac687eaad997991/barcode/image/d085f1bc-6ed1-4752-84e0-7e3f53e6ba2c/b4c596a0-5562-419d-a61f-a027de0895e5.svg",
      "owner_id": "a2d565f2-174f-499f-9a64-bb37024c7dc2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4f8540f-0417-478c-b189-4e6f39d8ae6f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c4f8540f-0417-478c-b189-4e6f39d8ae6f",
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
    "id": "c4f8540f-0417-478c-b189-4e6f39d8ae6f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T11:55:47+00:00",
      "updated_at": "2022-10-07T11:55:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e2a70e19573bcecea4b9d120edf93ae5/barcode/image/c4f8540f-0417-478c-b189-4e6f39d8ae6f/511b1719-2536-47a0-8dae-f9a554343d8c.svg",
      "owner_id": "02922098-e40e-43d2-986c-db8b26585ac6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bd4c28eb-c569-479f-bcc0-4e8a05d2be2e' \
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