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
      "id": "73c69753-5d45-4a46-8dfd-51880b03f67a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-27T10:14:52+00:00",
        "updated_at": "2023-02-27T10:14:52+00:00",
        "number": "http://bqbl.it/73c69753-5d45-4a46-8dfd-51880b03f67a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/62e473350772ffc4ecfe231506020f7c/barcode/image/73c69753-5d45-4a46-8dfd-51880b03f67a/2f12d30e-10b8-4079-996f-fd89862cfc2e.svg",
        "owner_id": "f09c7b8b-9dca-45f3-98c9-d9d0be76e955",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f09c7b8b-9dca-45f3-98c9-d9d0be76e955"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1c5c2fe2-1829-4bf4-a045-9253d3d7bbfb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1c5c2fe2-1829-4bf4-a045-9253d3d7bbfb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-27T10:14:53+00:00",
        "updated_at": "2023-02-27T10:14:53+00:00",
        "number": "http://bqbl.it/1c5c2fe2-1829-4bf4-a045-9253d3d7bbfb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1bb66d0f61f7a912579b0d1e21a31b17/barcode/image/1c5c2fe2-1829-4bf4-a045-9253d3d7bbfb/04137acb-de4d-4157-95b6-2eaa1ac4b439.svg",
        "owner_id": "7d0688d5-4ba2-4063-9806-6eabc8b50d83",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7d0688d5-4ba2-4063-9806-6eabc8b50d83"
          },
          "data": {
            "type": "customers",
            "id": "7d0688d5-4ba2-4063-9806-6eabc8b50d83"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7d0688d5-4ba2-4063-9806-6eabc8b50d83",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-27T10:14:52+00:00",
        "updated_at": "2023-02-27T10:14:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7d0688d5-4ba2-4063-9806-6eabc8b50d83&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7d0688d5-4ba2-4063-9806-6eabc8b50d83&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7d0688d5-4ba2-4063-9806-6eabc8b50d83&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTFkNGRlYzUtZWU5NC00OTJjLWE2YmMtN2E4ZGZhNmNiYzIz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "91d4dec5-ee94-492c-a6bc-7a8dfa6cbc23",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-27T10:14:53+00:00",
        "updated_at": "2023-02-27T10:14:53+00:00",
        "number": "http://bqbl.it/91d4dec5-ee94-492c-a6bc-7a8dfa6cbc23",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e469842fde0c48369bea916d85e855ee/barcode/image/91d4dec5-ee94-492c-a6bc-7a8dfa6cbc23/8920b49d-7866-4c79-9adf-ccfa168eddfd.svg",
        "owner_id": "38560a07-eeed-4038-88d9-7f05a834f303",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/38560a07-eeed-4038-88d9-7f05a834f303"
          },
          "data": {
            "type": "customers",
            "id": "38560a07-eeed-4038-88d9-7f05a834f303"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "38560a07-eeed-4038-88d9-7f05a834f303",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-27T10:14:53+00:00",
        "updated_at": "2023-02-27T10:14:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=38560a07-eeed-4038-88d9-7f05a834f303&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=38560a07-eeed-4038-88d9-7f05a834f303&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=38560a07-eeed-4038-88d9-7f05a834f303&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-27T10:14:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3ad2cc8d-b1c1-4138-a27e-77650ce72f69?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3ad2cc8d-b1c1-4138-a27e-77650ce72f69",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-27T10:14:54+00:00",
      "updated_at": "2023-02-27T10:14:54+00:00",
      "number": "http://bqbl.it/3ad2cc8d-b1c1-4138-a27e-77650ce72f69",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d5bdcd49f8c64b9798e5e0d6973a0308/barcode/image/3ad2cc8d-b1c1-4138-a27e-77650ce72f69/39d6af93-3237-4617-bfda-2596b52e8951.svg",
      "owner_id": "f9d126ad-9d26-4b9e-a35d-3a35e4802fcb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f9d126ad-9d26-4b9e-a35d-3a35e4802fcb"
        },
        "data": {
          "type": "customers",
          "id": "f9d126ad-9d26-4b9e-a35d-3a35e4802fcb"
        }
      }
    }
  },
  "included": [
    {
      "id": "f9d126ad-9d26-4b9e-a35d-3a35e4802fcb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-27T10:14:54+00:00",
        "updated_at": "2023-02-27T10:14:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f9d126ad-9d26-4b9e-a35d-3a35e4802fcb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f9d126ad-9d26-4b9e-a35d-3a35e4802fcb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f9d126ad-9d26-4b9e-a35d-3a35e4802fcb&filter[owner_type]=customers"
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
          "owner_id": "487f82d1-bd13-4858-8a72-bbe8acc35908",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6e113fd6-4a1a-43ee-b857-51434d26c4b1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-27T10:14:54+00:00",
      "updated_at": "2023-02-27T10:14:54+00:00",
      "number": "http://bqbl.it/6e113fd6-4a1a-43ee-b857-51434d26c4b1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3ee9dd036c6073729e0f5e066b3229f4/barcode/image/6e113fd6-4a1a-43ee-b857-51434d26c4b1/022c0b8e-c677-493c-b805-d7eaadfb2f2a.svg",
      "owner_id": "487f82d1-bd13-4858-8a72-bbe8acc35908",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/33c5736a-e596-4e2a-ace6-34bca97c7c9b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "33c5736a-e596-4e2a-ace6-34bca97c7c9b",
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
    "id": "33c5736a-e596-4e2a-ace6-34bca97c7c9b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-27T10:14:55+00:00",
      "updated_at": "2023-02-27T10:14:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/821600e2c7fdb234242d3d4e87e207ca/barcode/image/33c5736a-e596-4e2a-ace6-34bca97c7c9b/f498ee43-bdfb-49c5-a84b-ceae130540f0.svg",
      "owner_id": "7e3564b5-b7a3-42c0-b9ca-39499dbd1c7e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9bd5b207-5e31-472c-a68f-345dd8ace19a' \
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