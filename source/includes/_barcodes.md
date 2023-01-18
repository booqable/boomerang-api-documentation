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
      "id": "9696f40a-0b36-4406-bd1c-40bccaef6b58",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-18T13:34:45+00:00",
        "updated_at": "2023-01-18T13:34:45+00:00",
        "number": "http://bqbl.it/9696f40a-0b36-4406-bd1c-40bccaef6b58",
        "barcode_type": "qr_code",
        "image_url": "/uploads/edcc4f7c42ae6ed0d3ea1c7f1c40fd50/barcode/image/9696f40a-0b36-4406-bd1c-40bccaef6b58/b0521f99-5728-49c2-b514-1bb75ebd9cf4.svg",
        "owner_id": "123b2b27-1f0c-494e-95e7-6a554066ae78",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/123b2b27-1f0c-494e-95e7-6a554066ae78"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F67f226e7-d0b6-44ba-844c-41b26be4ea55&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67f226e7-d0b6-44ba-844c-41b26be4ea55",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-18T13:34:45+00:00",
        "updated_at": "2023-01-18T13:34:45+00:00",
        "number": "http://bqbl.it/67f226e7-d0b6-44ba-844c-41b26be4ea55",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cc052706953ba8f00a00afa95812af40/barcode/image/67f226e7-d0b6-44ba-844c-41b26be4ea55/9d606841-c8fd-4e4b-a3bf-3e872ae68890.svg",
        "owner_id": "dc1c0d16-4d41-4424-b7b6-9e4b87756b0a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dc1c0d16-4d41-4424-b7b6-9e4b87756b0a"
          },
          "data": {
            "type": "customers",
            "id": "dc1c0d16-4d41-4424-b7b6-9e4b87756b0a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dc1c0d16-4d41-4424-b7b6-9e4b87756b0a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-18T13:34:45+00:00",
        "updated_at": "2023-01-18T13:34:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=dc1c0d16-4d41-4424-b7b6-9e4b87756b0a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dc1c0d16-4d41-4424-b7b6-9e4b87756b0a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dc1c0d16-4d41-4424-b7b6-9e4b87756b0a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGJhYTM0NGItMjE1NS00YjdhLWJkNDgtMWY0NDRkZmE2Zjcw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dbaa344b-2155-4b7a-bd48-1f444dfa6f70",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-18T13:34:46+00:00",
        "updated_at": "2023-01-18T13:34:46+00:00",
        "number": "http://bqbl.it/dbaa344b-2155-4b7a-bd48-1f444dfa6f70",
        "barcode_type": "qr_code",
        "image_url": "/uploads/71d1363a85617070f055c037417cd5a8/barcode/image/dbaa344b-2155-4b7a-bd48-1f444dfa6f70/c8ec71e7-0b51-40ec-aad1-24e871e00040.svg",
        "owner_id": "03581dbe-5179-444e-a3b2-43b58c56a0f6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/03581dbe-5179-444e-a3b2-43b58c56a0f6"
          },
          "data": {
            "type": "customers",
            "id": "03581dbe-5179-444e-a3b2-43b58c56a0f6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "03581dbe-5179-444e-a3b2-43b58c56a0f6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-18T13:34:45+00:00",
        "updated_at": "2023-01-18T13:34:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=03581dbe-5179-444e-a3b2-43b58c56a0f6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=03581dbe-5179-444e-a3b2-43b58c56a0f6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=03581dbe-5179-444e-a3b2-43b58c56a0f6&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-18T13:34:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fe95cec3-7a86-4765-ba13-456da9e4bfbb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fe95cec3-7a86-4765-ba13-456da9e4bfbb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-18T13:34:46+00:00",
      "updated_at": "2023-01-18T13:34:46+00:00",
      "number": "http://bqbl.it/fe95cec3-7a86-4765-ba13-456da9e4bfbb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0e8c6d6e01b4e9b5850eebe647bad249/barcode/image/fe95cec3-7a86-4765-ba13-456da9e4bfbb/c040df6b-e08f-4582-afe3-594dcba9b8a3.svg",
      "owner_id": "285abf22-8c96-475a-ad42-3ec49e0d39fb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/285abf22-8c96-475a-ad42-3ec49e0d39fb"
        },
        "data": {
          "type": "customers",
          "id": "285abf22-8c96-475a-ad42-3ec49e0d39fb"
        }
      }
    }
  },
  "included": [
    {
      "id": "285abf22-8c96-475a-ad42-3ec49e0d39fb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-18T13:34:46+00:00",
        "updated_at": "2023-01-18T13:34:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=285abf22-8c96-475a-ad42-3ec49e0d39fb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=285abf22-8c96-475a-ad42-3ec49e0d39fb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=285abf22-8c96-475a-ad42-3ec49e0d39fb&filter[owner_type]=customers"
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
          "owner_id": "b591150c-a1c4-4f43-83e7-81a04edf5b35",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7d9c0b98-8f59-4d95-80f7-8a909bf645ce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-18T13:34:47+00:00",
      "updated_at": "2023-01-18T13:34:47+00:00",
      "number": "http://bqbl.it/7d9c0b98-8f59-4d95-80f7-8a909bf645ce",
      "barcode_type": "qr_code",
      "image_url": "/uploads/047a3c253019a448211fb2161522cfc7/barcode/image/7d9c0b98-8f59-4d95-80f7-8a909bf645ce/8fe06506-41da-4a69-a176-b743bffcd664.svg",
      "owner_id": "b591150c-a1c4-4f43-83e7-81a04edf5b35",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c7c42b37-90cd-4584-bdbd-24cbf44f4913' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c7c42b37-90cd-4584-bdbd-24cbf44f4913",
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
    "id": "c7c42b37-90cd-4584-bdbd-24cbf44f4913",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-18T13:34:47+00:00",
      "updated_at": "2023-01-18T13:34:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/600b3a8265a16e00e981ab08addc1300/barcode/image/c7c42b37-90cd-4584-bdbd-24cbf44f4913/e6284855-e2d1-452d-8947-6cbd029ea760.svg",
      "owner_id": "d88d9d6f-3307-4bbe-8e64-8d9596c8fcb2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9878fdd1-5edc-440a-b8a0-c566dc751804' \
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