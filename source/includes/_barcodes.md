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
      "id": "6d91a318-68ce-4f12-a1a5-7d81f0496a87",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-06T11:16:56+00:00",
        "updated_at": "2022-12-06T11:16:56+00:00",
        "number": "http://bqbl.it/6d91a318-68ce-4f12-a1a5-7d81f0496a87",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f4cba912c671bc1c26f47867d8a4795b/barcode/image/6d91a318-68ce-4f12-a1a5-7d81f0496a87/fedc042b-abcd-439c-a4b0-bf9dd9876f8b.svg",
        "owner_id": "fa63fc9c-caaf-4575-bf3d-cb41b6d4cd4a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fa63fc9c-caaf-4575-bf3d-cb41b6d4cd4a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe649cccf-7352-4554-a69d-5ca77edbfba7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e649cccf-7352-4554-a69d-5ca77edbfba7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-06T11:16:56+00:00",
        "updated_at": "2022-12-06T11:16:56+00:00",
        "number": "http://bqbl.it/e649cccf-7352-4554-a69d-5ca77edbfba7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c7350527fc4259a42b5be416c0959005/barcode/image/e649cccf-7352-4554-a69d-5ca77edbfba7/5da69b7f-0f0f-4eb5-8269-35432151cdcb.svg",
        "owner_id": "21a8f6c3-bbbb-4f4a-83f1-cd50120458d0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/21a8f6c3-bbbb-4f4a-83f1-cd50120458d0"
          },
          "data": {
            "type": "customers",
            "id": "21a8f6c3-bbbb-4f4a-83f1-cd50120458d0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "21a8f6c3-bbbb-4f4a-83f1-cd50120458d0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-06T11:16:56+00:00",
        "updated_at": "2022-12-06T11:16:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=21a8f6c3-bbbb-4f4a-83f1-cd50120458d0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=21a8f6c3-bbbb-4f4a-83f1-cd50120458d0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=21a8f6c3-bbbb-4f4a-83f1-cd50120458d0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzE2YjZhN2UtOWFjYy00ZTViLTllMzktMDU2YjNhZGVhNDFk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "716b6a7e-9acc-4e5b-9e39-056b3adea41d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-06T11:16:58+00:00",
        "updated_at": "2022-12-06T11:16:58+00:00",
        "number": "http://bqbl.it/716b6a7e-9acc-4e5b-9e39-056b3adea41d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/677edaef8ada9c245ffb58c20f0c22f4/barcode/image/716b6a7e-9acc-4e5b-9e39-056b3adea41d/06f9cd51-46c4-4444-9ae4-7691a0ba9827.svg",
        "owner_id": "8eef59ea-12c1-43f1-8f9a-8de52d9caa5b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8eef59ea-12c1-43f1-8f9a-8de52d9caa5b"
          },
          "data": {
            "type": "customers",
            "id": "8eef59ea-12c1-43f1-8f9a-8de52d9caa5b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8eef59ea-12c1-43f1-8f9a-8de52d9caa5b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-06T11:16:57+00:00",
        "updated_at": "2022-12-06T11:16:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8eef59ea-12c1-43f1-8f9a-8de52d9caa5b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8eef59ea-12c1-43f1-8f9a-8de52d9caa5b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8eef59ea-12c1-43f1-8f9a-8de52d9caa5b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-06T11:16:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8fe2e755-93ad-4fd1-a551-abfad960e51c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8fe2e755-93ad-4fd1-a551-abfad960e51c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-06T11:16:58+00:00",
      "updated_at": "2022-12-06T11:16:58+00:00",
      "number": "http://bqbl.it/8fe2e755-93ad-4fd1-a551-abfad960e51c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a41886ae1797274be9896af59282b38e/barcode/image/8fe2e755-93ad-4fd1-a551-abfad960e51c/c1b3805b-277d-49eb-9ec3-6e9d1e7223dc.svg",
      "owner_id": "a068aca3-9846-4bb8-b70b-7029222cf412",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a068aca3-9846-4bb8-b70b-7029222cf412"
        },
        "data": {
          "type": "customers",
          "id": "a068aca3-9846-4bb8-b70b-7029222cf412"
        }
      }
    }
  },
  "included": [
    {
      "id": "a068aca3-9846-4bb8-b70b-7029222cf412",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-06T11:16:58+00:00",
        "updated_at": "2022-12-06T11:16:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a068aca3-9846-4bb8-b70b-7029222cf412&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a068aca3-9846-4bb8-b70b-7029222cf412&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a068aca3-9846-4bb8-b70b-7029222cf412&filter[owner_type]=customers"
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
          "owner_id": "f7902170-5ece-44be-98f2-3de6a0a02012",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8bd1cce4-6755-4628-993f-950696f788a6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-06T11:17:00+00:00",
      "updated_at": "2022-12-06T11:17:00+00:00",
      "number": "http://bqbl.it/8bd1cce4-6755-4628-993f-950696f788a6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ba9e3fdfab96ad404717047c0c88d354/barcode/image/8bd1cce4-6755-4628-993f-950696f788a6/897b2a63-88a3-4018-92e0-fa9f6b162087.svg",
      "owner_id": "f7902170-5ece-44be-98f2-3de6a0a02012",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a81cfb1f-ccc7-4458-b87b-8298bf6f7da4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a81cfb1f-ccc7-4458-b87b-8298bf6f7da4",
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
    "id": "a81cfb1f-ccc7-4458-b87b-8298bf6f7da4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-06T11:17:02+00:00",
      "updated_at": "2022-12-06T11:17:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9f3aa8d7629f464434a8096de550cd07/barcode/image/a81cfb1f-ccc7-4458-b87b-8298bf6f7da4/90c2c0f5-4afd-4588-ab0a-3055d4d6c7b3.svg",
      "owner_id": "4d010556-3447-4e8e-8c58-b5453bf5e79f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/12286d1b-52d7-423b-8b3d-e260f2a2a2bf' \
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