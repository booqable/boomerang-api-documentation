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
      "id": "35c71bcd-b51a-4bf5-9f7e-ff2cdde43af1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T15:47:54+00:00",
        "updated_at": "2023-02-16T15:47:54+00:00",
        "number": "http://bqbl.it/35c71bcd-b51a-4bf5-9f7e-ff2cdde43af1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6d70931242d9a36c454d8305f2975543/barcode/image/35c71bcd-b51a-4bf5-9f7e-ff2cdde43af1/b9a061aa-1612-4d03-85e3-af6f87d3066a.svg",
        "owner_id": "83eec591-7f89-4dbe-96d4-ceafdccd47d2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/83eec591-7f89-4dbe-96d4-ceafdccd47d2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7cd828f7-874a-49f4-a983-4375b06d0ba0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7cd828f7-874a-49f4-a983-4375b06d0ba0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T15:47:55+00:00",
        "updated_at": "2023-02-16T15:47:55+00:00",
        "number": "http://bqbl.it/7cd828f7-874a-49f4-a983-4375b06d0ba0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d21100ca1be9c6c6069cc9c104da3bc9/barcode/image/7cd828f7-874a-49f4-a983-4375b06d0ba0/a4946690-b310-460f-8699-9a4d3a8cd147.svg",
        "owner_id": "e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c"
          },
          "data": {
            "type": "customers",
            "id": "e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T15:47:55+00:00",
        "updated_at": "2023-02-16T15:47:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e7a4d09e-ba4a-4727-9ce3-5ea7ca61b36c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmZmZTkxZDctYzc2OS00M2NiLTliMmEtOWI1OTdiM2VlNjk0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6ffe91d7-c769-43cb-9b2a-9b597b3ee694",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T15:47:55+00:00",
        "updated_at": "2023-02-16T15:47:55+00:00",
        "number": "http://bqbl.it/6ffe91d7-c769-43cb-9b2a-9b597b3ee694",
        "barcode_type": "qr_code",
        "image_url": "/uploads/db2a048a44b4b0e4a6184cdb9e986f96/barcode/image/6ffe91d7-c769-43cb-9b2a-9b597b3ee694/4ed71ff7-61aa-4807-8e8a-7c7b89bccd77.svg",
        "owner_id": "3604d0ec-2aab-48a1-83d8-6bedbe9021b9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3604d0ec-2aab-48a1-83d8-6bedbe9021b9"
          },
          "data": {
            "type": "customers",
            "id": "3604d0ec-2aab-48a1-83d8-6bedbe9021b9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3604d0ec-2aab-48a1-83d8-6bedbe9021b9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T15:47:55+00:00",
        "updated_at": "2023-02-16T15:47:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3604d0ec-2aab-48a1-83d8-6bedbe9021b9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3604d0ec-2aab-48a1-83d8-6bedbe9021b9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3604d0ec-2aab-48a1-83d8-6bedbe9021b9&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T15:47:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b25a39b0-1dbd-4c1b-ad28-c2afd0377a87?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b25a39b0-1dbd-4c1b-ad28-c2afd0377a87",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T15:47:56+00:00",
      "updated_at": "2023-02-16T15:47:56+00:00",
      "number": "http://bqbl.it/b25a39b0-1dbd-4c1b-ad28-c2afd0377a87",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d010ede48493b0dbb8f431bf9b02af5c/barcode/image/b25a39b0-1dbd-4c1b-ad28-c2afd0377a87/baada452-1d48-4f16-a77e-57a90679668f.svg",
      "owner_id": "87a6b31d-b63e-49f6-9b33-e98d778f59f6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/87a6b31d-b63e-49f6-9b33-e98d778f59f6"
        },
        "data": {
          "type": "customers",
          "id": "87a6b31d-b63e-49f6-9b33-e98d778f59f6"
        }
      }
    }
  },
  "included": [
    {
      "id": "87a6b31d-b63e-49f6-9b33-e98d778f59f6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T15:47:56+00:00",
        "updated_at": "2023-02-16T15:47:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=87a6b31d-b63e-49f6-9b33-e98d778f59f6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87a6b31d-b63e-49f6-9b33-e98d778f59f6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87a6b31d-b63e-49f6-9b33-e98d778f59f6&filter[owner_type]=customers"
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
          "owner_id": "17c1c85d-bfa2-4ae6-b1f6-ba9687d8c44a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7cf619e6-329c-4613-8e21-7f1f3ae0edcc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T15:47:56+00:00",
      "updated_at": "2023-02-16T15:47:56+00:00",
      "number": "http://bqbl.it/7cf619e6-329c-4613-8e21-7f1f3ae0edcc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5da535c0598e2bc46afbe05475df0a65/barcode/image/7cf619e6-329c-4613-8e21-7f1f3ae0edcc/25c6025f-d54c-4b26-943c-a68989008dcd.svg",
      "owner_id": "17c1c85d-bfa2-4ae6-b1f6-ba9687d8c44a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7b9d510c-95aa-458e-9c79-d702e36674d5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7b9d510c-95aa-458e-9c79-d702e36674d5",
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
    "id": "7b9d510c-95aa-458e-9c79-d702e36674d5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T15:47:57+00:00",
      "updated_at": "2023-02-16T15:47:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2a549bc943d9498a59147646218077e8/barcode/image/7b9d510c-95aa-458e-9c79-d702e36674d5/e29a159e-1384-400d-86bc-4f9bf4fbe22f.svg",
      "owner_id": "ebcb9686-89b7-40ba-b7bb-38273632a2c2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a2dbe3e9-4ef1-4077-a398-dc34b0a30c8f' \
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