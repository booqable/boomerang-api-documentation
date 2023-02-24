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
      "id": "ea669328-5173-45ae-a794-d9ed2a1ac03c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T08:41:37+00:00",
        "updated_at": "2023-02-24T08:41:37+00:00",
        "number": "http://bqbl.it/ea669328-5173-45ae-a794-d9ed2a1ac03c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/14d8f2c58d6207aa65740fb04d7ac6f0/barcode/image/ea669328-5173-45ae-a794-d9ed2a1ac03c/c36e52d3-d457-4bec-b7b6-605ec789dc33.svg",
        "owner_id": "87dd521b-72ec-4833-af8f-c39cde23d8b7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87dd521b-72ec-4833-af8f-c39cde23d8b7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa1c6b45d-68c3-42a1-9530-1e90fa2c7388&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a1c6b45d-68c3-42a1-9530-1e90fa2c7388",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T08:41:37+00:00",
        "updated_at": "2023-02-24T08:41:37+00:00",
        "number": "http://bqbl.it/a1c6b45d-68c3-42a1-9530-1e90fa2c7388",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f19e706a51ddbf7fd47c062ea77356ec/barcode/image/a1c6b45d-68c3-42a1-9530-1e90fa2c7388/42fe2576-0c73-4012-a10e-178eea343e5f.svg",
        "owner_id": "6a3d837d-1c2f-4aba-a25d-250d8f981586",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6a3d837d-1c2f-4aba-a25d-250d8f981586"
          },
          "data": {
            "type": "customers",
            "id": "6a3d837d-1c2f-4aba-a25d-250d8f981586"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6a3d837d-1c2f-4aba-a25d-250d8f981586",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T08:41:37+00:00",
        "updated_at": "2023-02-24T08:41:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6a3d837d-1c2f-4aba-a25d-250d8f981586&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6a3d837d-1c2f-4aba-a25d-250d8f981586&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6a3d837d-1c2f-4aba-a25d-250d8f981586&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzVmNmY2NjAtY2VkNy00ZTkxLTgyNjgtMGZjYTExMjY0Yzhj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c5f6f660-ced7-4e91-8268-0fca11264c8c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T08:41:38+00:00",
        "updated_at": "2023-02-24T08:41:38+00:00",
        "number": "http://bqbl.it/c5f6f660-ced7-4e91-8268-0fca11264c8c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e9d3a0fba735e91092d1b39802f66bc3/barcode/image/c5f6f660-ced7-4e91-8268-0fca11264c8c/cb3533ef-76ea-48ad-b6ce-5c42ffe32dd0.svg",
        "owner_id": "afd5ba4c-3d18-4580-ac6b-d4b639d96e32",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/afd5ba4c-3d18-4580-ac6b-d4b639d96e32"
          },
          "data": {
            "type": "customers",
            "id": "afd5ba4c-3d18-4580-ac6b-d4b639d96e32"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "afd5ba4c-3d18-4580-ac6b-d4b639d96e32",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T08:41:38+00:00",
        "updated_at": "2023-02-24T08:41:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=afd5ba4c-3d18-4580-ac6b-d4b639d96e32&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=afd5ba4c-3d18-4580-ac6b-d4b639d96e32&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=afd5ba4c-3d18-4580-ac6b-d4b639d96e32&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:41:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6aa4f89b-db47-4840-afef-cbb58f124854?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6aa4f89b-db47-4840-afef-cbb58f124854",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T08:41:39+00:00",
      "updated_at": "2023-02-24T08:41:39+00:00",
      "number": "http://bqbl.it/6aa4f89b-db47-4840-afef-cbb58f124854",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9f534b0433518a0592d79b6109177600/barcode/image/6aa4f89b-db47-4840-afef-cbb58f124854/c11cfa13-b26b-4887-81da-be619722505d.svg",
      "owner_id": "bf5d661c-c66b-40de-b5bf-13d0fe3be63f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/bf5d661c-c66b-40de-b5bf-13d0fe3be63f"
        },
        "data": {
          "type": "customers",
          "id": "bf5d661c-c66b-40de-b5bf-13d0fe3be63f"
        }
      }
    }
  },
  "included": [
    {
      "id": "bf5d661c-c66b-40de-b5bf-13d0fe3be63f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T08:41:39+00:00",
        "updated_at": "2023-02-24T08:41:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=bf5d661c-c66b-40de-b5bf-13d0fe3be63f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bf5d661c-c66b-40de-b5bf-13d0fe3be63f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bf5d661c-c66b-40de-b5bf-13d0fe3be63f&filter[owner_type]=customers"
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
          "owner_id": "36a8f2f2-bbac-437a-8b03-444d4f4dfe47",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3371bc31-26ec-4b4b-8902-75a7f76ab00c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T08:41:40+00:00",
      "updated_at": "2023-02-24T08:41:40+00:00",
      "number": "http://bqbl.it/3371bc31-26ec-4b4b-8902-75a7f76ab00c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a2234ca6f857a9ad6e583519d3f87f41/barcode/image/3371bc31-26ec-4b4b-8902-75a7f76ab00c/eec41aef-282c-4d0d-bdb6-54ebcdc25281.svg",
      "owner_id": "36a8f2f2-bbac-437a-8b03-444d4f4dfe47",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/26fb602b-d5b7-449b-908e-b215a15de994' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "26fb602b-d5b7-449b-908e-b215a15de994",
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
    "id": "26fb602b-d5b7-449b-908e-b215a15de994",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T08:41:40+00:00",
      "updated_at": "2023-02-24T08:41:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/31339668f28fa212cd104927cec89978/barcode/image/26fb602b-d5b7-449b-908e-b215a15de994/86c77031-b313-451f-8dad-aa6c76896065.svg",
      "owner_id": "ca7b8329-c941-4e6e-bc57-d5700e76d5b1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6978bb1e-c9ac-4959-be1a-e1de2eb52c98' \
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