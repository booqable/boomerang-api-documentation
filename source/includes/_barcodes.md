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
      "id": "88d69342-1d20-432f-b9c5-b2cb25537e2e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T13:20:37+00:00",
        "updated_at": "2023-01-24T13:20:37+00:00",
        "number": "http://bqbl.it/88d69342-1d20-432f-b9c5-b2cb25537e2e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/418a7d507fc689783bf667fec76fdcfe/barcode/image/88d69342-1d20-432f-b9c5-b2cb25537e2e/bc02c710-3d8e-424a-8351-afbbcca55f66.svg",
        "owner_id": "fd8f98cd-9481-4680-bb9f-f344082c8774",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fd8f98cd-9481-4680-bb9f-f344082c8774"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6a9d3f3c-9a6e-4fb6-804a-408df223f13e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6a9d3f3c-9a6e-4fb6-804a-408df223f13e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T13:20:38+00:00",
        "updated_at": "2023-01-24T13:20:38+00:00",
        "number": "http://bqbl.it/6a9d3f3c-9a6e-4fb6-804a-408df223f13e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/76d55a619e4e30bc3c8c8dee403dbc40/barcode/image/6a9d3f3c-9a6e-4fb6-804a-408df223f13e/b7ba30cd-00aa-4e6c-8697-d644993e2b52.svg",
        "owner_id": "96475d8d-7cd7-4aa2-a082-8a227376dc68",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96475d8d-7cd7-4aa2-a082-8a227376dc68"
          },
          "data": {
            "type": "customers",
            "id": "96475d8d-7cd7-4aa2-a082-8a227376dc68"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "96475d8d-7cd7-4aa2-a082-8a227376dc68",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T13:20:38+00:00",
        "updated_at": "2023-01-24T13:20:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=96475d8d-7cd7-4aa2-a082-8a227376dc68&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=96475d8d-7cd7-4aa2-a082-8a227376dc68&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=96475d8d-7cd7-4aa2-a082-8a227376dc68&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDU3ZWU0YWQtN2M0Yi00NTdiLWIwMDEtMjA5ZjAxNmFmODU1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "057ee4ad-7c4b-457b-b001-209f016af855",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T13:20:39+00:00",
        "updated_at": "2023-01-24T13:20:39+00:00",
        "number": "http://bqbl.it/057ee4ad-7c4b-457b-b001-209f016af855",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9dbf40b237201f8e2b833e49fb813bd7/barcode/image/057ee4ad-7c4b-457b-b001-209f016af855/d013862b-2043-4fca-8c6c-0becec74f373.svg",
        "owner_id": "8c31d250-ceb2-4343-a9c6-a9f1f6e70872",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8c31d250-ceb2-4343-a9c6-a9f1f6e70872"
          },
          "data": {
            "type": "customers",
            "id": "8c31d250-ceb2-4343-a9c6-a9f1f6e70872"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8c31d250-ceb2-4343-a9c6-a9f1f6e70872",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T13:20:39+00:00",
        "updated_at": "2023-01-24T13:20:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8c31d250-ceb2-4343-a9c6-a9f1f6e70872&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8c31d250-ceb2-4343-a9c6-a9f1f6e70872&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8c31d250-ceb2-4343-a9c6-a9f1f6e70872&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:20:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ae4e221a-de13-4657-adc4-c6c0289d696a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ae4e221a-de13-4657-adc4-c6c0289d696a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T13:20:39+00:00",
      "updated_at": "2023-01-24T13:20:39+00:00",
      "number": "http://bqbl.it/ae4e221a-de13-4657-adc4-c6c0289d696a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a97222089475c0322b1cb579ca3d8f8a/barcode/image/ae4e221a-de13-4657-adc4-c6c0289d696a/31b0360d-5bab-4248-b838-0ada88aea01d.svg",
      "owner_id": "e88ab84f-0db5-4421-8abe-19f847a86891",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e88ab84f-0db5-4421-8abe-19f847a86891"
        },
        "data": {
          "type": "customers",
          "id": "e88ab84f-0db5-4421-8abe-19f847a86891"
        }
      }
    }
  },
  "included": [
    {
      "id": "e88ab84f-0db5-4421-8abe-19f847a86891",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T13:20:39+00:00",
        "updated_at": "2023-01-24T13:20:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e88ab84f-0db5-4421-8abe-19f847a86891&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e88ab84f-0db5-4421-8abe-19f847a86891&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e88ab84f-0db5-4421-8abe-19f847a86891&filter[owner_type]=customers"
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
          "owner_id": "8fd7bbb6-80a9-4d2c-8d03-b3126dd1d44d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "17c137a6-aa42-4049-8df5-7dbe8a20fed4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T13:20:40+00:00",
      "updated_at": "2023-01-24T13:20:40+00:00",
      "number": "http://bqbl.it/17c137a6-aa42-4049-8df5-7dbe8a20fed4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e450ea2b69d1019a0de68d76a50cf19/barcode/image/17c137a6-aa42-4049-8df5-7dbe8a20fed4/4c12a8b9-9dd3-4bbb-b376-82cf2c34af12.svg",
      "owner_id": "8fd7bbb6-80a9-4d2c-8d03-b3126dd1d44d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/67620367-7099-4d3e-95a8-ced7f8a15276' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "67620367-7099-4d3e-95a8-ced7f8a15276",
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
    "id": "67620367-7099-4d3e-95a8-ced7f8a15276",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T13:20:40+00:00",
      "updated_at": "2023-01-24T13:20:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/503ce7cd6c93c274703a43824e6995d5/barcode/image/67620367-7099-4d3e-95a8-ced7f8a15276/da16d97c-be88-44fd-892f-62e034e07ebf.svg",
      "owner_id": "a2d76a61-eba7-4c35-a74f-ab6a49e3c3cc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8a0e9d61-8715-40e1-8974-2c4bef360b23' \
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