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
      "id": "d6d1d44e-61fb-4576-9a4f-4d8bed1da097",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T10:55:42+00:00",
        "updated_at": "2023-02-21T10:55:42+00:00",
        "number": "http://bqbl.it/d6d1d44e-61fb-4576-9a4f-4d8bed1da097",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2d0f6ac331b0258c802f900613b4d22f/barcode/image/d6d1d44e-61fb-4576-9a4f-4d8bed1da097/0b6f2ecc-3099-42b0-8806-9207bedc9090.svg",
        "owner_id": "932f666d-edf9-4690-b4d9-5df2f21bc4a6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/932f666d-edf9-4690-b4d9-5df2f21bc4a6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8348c65c-7faf-4514-b9c9-f06ba0d4f9e5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8348c65c-7faf-4514-b9c9-f06ba0d4f9e5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T10:55:42+00:00",
        "updated_at": "2023-02-21T10:55:42+00:00",
        "number": "http://bqbl.it/8348c65c-7faf-4514-b9c9-f06ba0d4f9e5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d2a4c341215ae775938ecbf352002000/barcode/image/8348c65c-7faf-4514-b9c9-f06ba0d4f9e5/6f42c56a-3c99-4659-a7d6-b17f22bb440b.svg",
        "owner_id": "722e8a69-2f52-48a5-80bf-ceb5bea25051",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/722e8a69-2f52-48a5-80bf-ceb5bea25051"
          },
          "data": {
            "type": "customers",
            "id": "722e8a69-2f52-48a5-80bf-ceb5bea25051"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "722e8a69-2f52-48a5-80bf-ceb5bea25051",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T10:55:42+00:00",
        "updated_at": "2023-02-21T10:55:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=722e8a69-2f52-48a5-80bf-ceb5bea25051&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=722e8a69-2f52-48a5-80bf-ceb5bea25051&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=722e8a69-2f52-48a5-80bf-ceb5bea25051&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTI3YzRkOTktYzhkNi00MDY2LTg2NzctZWJmZDU4ZmEwNDA5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "127c4d99-c8d6-4066-8677-ebfd58fa0409",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T10:55:43+00:00",
        "updated_at": "2023-02-21T10:55:43+00:00",
        "number": "http://bqbl.it/127c4d99-c8d6-4066-8677-ebfd58fa0409",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5a783c650c3333046b663dad2ccc6205/barcode/image/127c4d99-c8d6-4066-8677-ebfd58fa0409/b28c8480-8180-4ea9-9086-5d7058e3f4d7.svg",
        "owner_id": "edc957e6-5b7c-48ef-82ed-60e0faf5fc5b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/edc957e6-5b7c-48ef-82ed-60e0faf5fc5b"
          },
          "data": {
            "type": "customers",
            "id": "edc957e6-5b7c-48ef-82ed-60e0faf5fc5b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "edc957e6-5b7c-48ef-82ed-60e0faf5fc5b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T10:55:43+00:00",
        "updated_at": "2023-02-21T10:55:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=edc957e6-5b7c-48ef-82ed-60e0faf5fc5b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=edc957e6-5b7c-48ef-82ed-60e0faf5fc5b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=edc957e6-5b7c-48ef-82ed-60e0faf5fc5b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:55:23Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/91fa4ffd-632e-4279-998d-ff2f890b17f1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "91fa4ffd-632e-4279-998d-ff2f890b17f1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T10:55:43+00:00",
      "updated_at": "2023-02-21T10:55:43+00:00",
      "number": "http://bqbl.it/91fa4ffd-632e-4279-998d-ff2f890b17f1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2883b6f154ec2447f0953198463df5e7/barcode/image/91fa4ffd-632e-4279-998d-ff2f890b17f1/709d0ba4-9002-4513-af38-16794115a01d.svg",
      "owner_id": "fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4"
        },
        "data": {
          "type": "customers",
          "id": "fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4"
        }
      }
    }
  },
  "included": [
    {
      "id": "fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T10:55:43+00:00",
        "updated_at": "2023-02-21T10:55:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fd798bfb-abe0-4c1f-9776-9d5c6b7c27b4&filter[owner_type]=customers"
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
          "owner_id": "32b613eb-cf89-49bd-bb24-54218d44037e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c20527a4-2eaf-49ef-b520-1a21dfcded2b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T10:55:44+00:00",
      "updated_at": "2023-02-21T10:55:44+00:00",
      "number": "http://bqbl.it/c20527a4-2eaf-49ef-b520-1a21dfcded2b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2485af8299569574d57963523cf35892/barcode/image/c20527a4-2eaf-49ef-b520-1a21dfcded2b/100a541f-4704-4441-be9b-edeb8f9f62a7.svg",
      "owner_id": "32b613eb-cf89-49bd-bb24-54218d44037e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9fa3f2eb-b437-48f1-bc4d-58b41213392c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9fa3f2eb-b437-48f1-bc4d-58b41213392c",
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
    "id": "9fa3f2eb-b437-48f1-bc4d-58b41213392c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T10:55:46+00:00",
      "updated_at": "2023-02-21T10:55:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4da04a1fdba3df23c2155c5dea5c7cfd/barcode/image/9fa3f2eb-b437-48f1-bc4d-58b41213392c/a4060e0e-f702-45b2-82eb-95f937a57c37.svg",
      "owner_id": "0e7632ee-577b-4645-bad7-471cf16c9369",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/706ea829-9519-486a-a3e8-b98a951fdb55' \
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