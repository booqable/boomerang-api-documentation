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
      "id": "21e43906-4eca-4be2-a77a-915fcf17b380",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:45:50+00:00",
        "updated_at": "2023-02-13T12:45:50+00:00",
        "number": "http://bqbl.it/21e43906-4eca-4be2-a77a-915fcf17b380",
        "barcode_type": "qr_code",
        "image_url": "/uploads/22d816b6c1b49074b11c03dfa48fb10e/barcode/image/21e43906-4eca-4be2-a77a-915fcf17b380/e1bf8619-a9b3-4ddc-985d-b7119748101d.svg",
        "owner_id": "59432f79-e70c-4955-ac81-26fd25ae32a8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/59432f79-e70c-4955-ac81-26fd25ae32a8"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F53481e50-da3f-4e4f-baf6-a4cd6d7001ae&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "53481e50-da3f-4e4f-baf6-a4cd6d7001ae",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:45:50+00:00",
        "updated_at": "2023-02-13T12:45:50+00:00",
        "number": "http://bqbl.it/53481e50-da3f-4e4f-baf6-a4cd6d7001ae",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8caa1fde9cfebfe7ebb076c302d99bbc/barcode/image/53481e50-da3f-4e4f-baf6-a4cd6d7001ae/ec307d61-871b-4fd9-94a5-24580653c811.svg",
        "owner_id": "2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1"
          },
          "data": {
            "type": "customers",
            "id": "2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:45:50+00:00",
        "updated_at": "2023-02-13T12:45:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2e51b6ce-e2ea-4ede-8f04-39bbe77f8cf1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjM0ZGIwMmEtZWIzMC00NzU4LTkwMjctNjk1MDUyZTI5ZDNi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "234db02a-eb30-4758-9027-695052e29d3b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:45:51+00:00",
        "updated_at": "2023-02-13T12:45:51+00:00",
        "number": "http://bqbl.it/234db02a-eb30-4758-9027-695052e29d3b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8c24420fa8acdfc3ee4c753e552935c6/barcode/image/234db02a-eb30-4758-9027-695052e29d3b/cc99cf1e-b7ea-468d-88a4-b0720a62c49c.svg",
        "owner_id": "5be6ade2-116b-4747-a7c2-33381daf193b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5be6ade2-116b-4747-a7c2-33381daf193b"
          },
          "data": {
            "type": "customers",
            "id": "5be6ade2-116b-4747-a7c2-33381daf193b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5be6ade2-116b-4747-a7c2-33381daf193b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:45:51+00:00",
        "updated_at": "2023-02-13T12:45:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5be6ade2-116b-4747-a7c2-33381daf193b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5be6ade2-116b-4747-a7c2-33381daf193b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5be6ade2-116b-4747-a7c2-33381daf193b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:45:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dfd5451d-b674-4189-b7cd-b7cce6fdd1c0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dfd5451d-b674-4189-b7cd-b7cce6fdd1c0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:45:52+00:00",
      "updated_at": "2023-02-13T12:45:52+00:00",
      "number": "http://bqbl.it/dfd5451d-b674-4189-b7cd-b7cce6fdd1c0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9cde38fbf2bcdfc0ff72a0035f8b30ba/barcode/image/dfd5451d-b674-4189-b7cd-b7cce6fdd1c0/25bc7f1b-1cea-4924-8f5a-ce3d0e89827a.svg",
      "owner_id": "5980520d-c4aa-4606-b0be-2bc203c04874",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5980520d-c4aa-4606-b0be-2bc203c04874"
        },
        "data": {
          "type": "customers",
          "id": "5980520d-c4aa-4606-b0be-2bc203c04874"
        }
      }
    }
  },
  "included": [
    {
      "id": "5980520d-c4aa-4606-b0be-2bc203c04874",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:45:52+00:00",
        "updated_at": "2023-02-13T12:45:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5980520d-c4aa-4606-b0be-2bc203c04874&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5980520d-c4aa-4606-b0be-2bc203c04874&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5980520d-c4aa-4606-b0be-2bc203c04874&filter[owner_type]=customers"
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
          "owner_id": "3e64b5ce-f1fe-492c-a81e-42750134bbd9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d3581a03-d216-4b23-ba8b-b2287ff765a5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:45:54+00:00",
      "updated_at": "2023-02-13T12:45:54+00:00",
      "number": "http://bqbl.it/d3581a03-d216-4b23-ba8b-b2287ff765a5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d26cf9352986ec6d7f00a5e7f3bbbfd5/barcode/image/d3581a03-d216-4b23-ba8b-b2287ff765a5/8e9ee86d-fde9-45ba-8ed8-cc0da54d1be0.svg",
      "owner_id": "3e64b5ce-f1fe-492c-a81e-42750134bbd9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/94f35d83-40ad-4aed-b554-efa9f74856f9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "94f35d83-40ad-4aed-b554-efa9f74856f9",
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
    "id": "94f35d83-40ad-4aed-b554-efa9f74856f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:45:55+00:00",
      "updated_at": "2023-02-13T12:45:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eb380e7f14355271e773d46a9c56ebf8/barcode/image/94f35d83-40ad-4aed-b554-efa9f74856f9/e4706809-2b18-4ed6-afcc-a27692ce46c9.svg",
      "owner_id": "9e38d67a-14ef-402d-88f9-89568643889b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/122f489b-57fe-4df9-aecc-da845c61d1b5' \
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