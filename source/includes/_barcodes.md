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
      "id": "0dfa21fe-9e92-4912-8c9a-4a480ad22353",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T10:35:00+00:00",
        "updated_at": "2023-02-22T10:35:00+00:00",
        "number": "http://bqbl.it/0dfa21fe-9e92-4912-8c9a-4a480ad22353",
        "barcode_type": "qr_code",
        "image_url": "/uploads/04c42a3ce07254987a17de69e5fa7cfb/barcode/image/0dfa21fe-9e92-4912-8c9a-4a480ad22353/b4b99eaf-ad81-440c-b235-5a662d26abbf.svg",
        "owner_id": "af30e05f-ae6b-48ab-bbc5-184196fc1e28",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/af30e05f-ae6b-48ab-bbc5-184196fc1e28"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9eaa2f07-6bf7-4565-a175-6064d391a82a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9eaa2f07-6bf7-4565-a175-6064d391a82a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T10:35:01+00:00",
        "updated_at": "2023-02-22T10:35:01+00:00",
        "number": "http://bqbl.it/9eaa2f07-6bf7-4565-a175-6064d391a82a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/950c379978e32732f2e435dbd5ff7129/barcode/image/9eaa2f07-6bf7-4565-a175-6064d391a82a/ab2b70b0-ccf2-455e-9b62-b2b35777e407.svg",
        "owner_id": "fda9e4b4-e719-404a-827f-24e7fe2f72ee",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fda9e4b4-e719-404a-827f-24e7fe2f72ee"
          },
          "data": {
            "type": "customers",
            "id": "fda9e4b4-e719-404a-827f-24e7fe2f72ee"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fda9e4b4-e719-404a-827f-24e7fe2f72ee",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T10:35:01+00:00",
        "updated_at": "2023-02-22T10:35:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fda9e4b4-e719-404a-827f-24e7fe2f72ee&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fda9e4b4-e719-404a-827f-24e7fe2f72ee&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fda9e4b4-e719-404a-827f-24e7fe2f72ee&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTQ3Y2MxNDAtMTgxNy00NjRhLThiMTQtYjMwZjYzN2M1OWVi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "147cc140-1817-464a-8b14-b30f637c59eb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T10:35:02+00:00",
        "updated_at": "2023-02-22T10:35:02+00:00",
        "number": "http://bqbl.it/147cc140-1817-464a-8b14-b30f637c59eb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cfa7e2c518f6590870f6b690810f8f18/barcode/image/147cc140-1817-464a-8b14-b30f637c59eb/548e82d3-0639-44f4-8301-4635c702ae97.svg",
        "owner_id": "7cf721cd-7e10-42f8-910b-9acdf73379b4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7cf721cd-7e10-42f8-910b-9acdf73379b4"
          },
          "data": {
            "type": "customers",
            "id": "7cf721cd-7e10-42f8-910b-9acdf73379b4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7cf721cd-7e10-42f8-910b-9acdf73379b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T10:35:01+00:00",
        "updated_at": "2023-02-22T10:35:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7cf721cd-7e10-42f8-910b-9acdf73379b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7cf721cd-7e10-42f8-910b-9acdf73379b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7cf721cd-7e10-42f8-910b-9acdf73379b4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T10:34:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2a8cbb00-bdf8-4a67-8730-5554dd8275f9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2a8cbb00-bdf8-4a67-8730-5554dd8275f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T10:35:02+00:00",
      "updated_at": "2023-02-22T10:35:02+00:00",
      "number": "http://bqbl.it/2a8cbb00-bdf8-4a67-8730-5554dd8275f9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6f982c6b85dc8b6ba7836e9a17f71ae8/barcode/image/2a8cbb00-bdf8-4a67-8730-5554dd8275f9/3bb85493-04e1-4d3f-af36-ee59e6a7fff6.svg",
      "owner_id": "6c2b6e84-21e2-432c-81ff-e2d31ac20e4d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6c2b6e84-21e2-432c-81ff-e2d31ac20e4d"
        },
        "data": {
          "type": "customers",
          "id": "6c2b6e84-21e2-432c-81ff-e2d31ac20e4d"
        }
      }
    }
  },
  "included": [
    {
      "id": "6c2b6e84-21e2-432c-81ff-e2d31ac20e4d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T10:35:02+00:00",
        "updated_at": "2023-02-22T10:35:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6c2b6e84-21e2-432c-81ff-e2d31ac20e4d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6c2b6e84-21e2-432c-81ff-e2d31ac20e4d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6c2b6e84-21e2-432c-81ff-e2d31ac20e4d&filter[owner_type]=customers"
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
          "owner_id": "bcf1a6fc-5362-40aa-9520-b2b0c8deaace",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1ed4035f-eab0-4d18-bc7e-74e0760cf7d9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T10:35:03+00:00",
      "updated_at": "2023-02-22T10:35:03+00:00",
      "number": "http://bqbl.it/1ed4035f-eab0-4d18-bc7e-74e0760cf7d9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ac2fd3c87dfaa6b63cfc73cac5a40704/barcode/image/1ed4035f-eab0-4d18-bc7e-74e0760cf7d9/5d9e24b6-99a0-4d56-b79a-da3e7f5ff384.svg",
      "owner_id": "bcf1a6fc-5362-40aa-9520-b2b0c8deaace",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/18cda906-8167-442b-945b-2b710ce21729' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "18cda906-8167-442b-945b-2b710ce21729",
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
    "id": "18cda906-8167-442b-945b-2b710ce21729",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T10:35:04+00:00",
      "updated_at": "2023-02-22T10:35:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3c6a05d8e9a458381a3a0948686c9c8f/barcode/image/18cda906-8167-442b-945b-2b710ce21729/a6c6387d-3f8c-4a86-aa69-ac92e65aa296.svg",
      "owner_id": "42f8395d-7b58-402e-aeb4-fd8ea488eef9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b7d024f0-6efb-4645-bfc7-4e92944d7343' \
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