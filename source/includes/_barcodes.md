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
      "id": "09741f63-cebb-4688-9e55-7bfd4440c820",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-19T10:45:24+00:00",
        "updated_at": "2023-01-19T10:45:24+00:00",
        "number": "http://bqbl.it/09741f63-cebb-4688-9e55-7bfd4440c820",
        "barcode_type": "qr_code",
        "image_url": "/uploads/59d9a95323d22508767527476014052d/barcode/image/09741f63-cebb-4688-9e55-7bfd4440c820/080b4bad-fe59-4586-92e9-fcce1b58b908.svg",
        "owner_id": "27d261d4-b2f7-4a7f-8cd3-8913e7ff346c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/27d261d4-b2f7-4a7f-8cd3-8913e7ff346c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc71d7a14-44ac-4ae0-a053-bf6f4dc1a7a1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c71d7a14-44ac-4ae0-a053-bf6f4dc1a7a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-19T10:45:25+00:00",
        "updated_at": "2023-01-19T10:45:25+00:00",
        "number": "http://bqbl.it/c71d7a14-44ac-4ae0-a053-bf6f4dc1a7a1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8c0a86ab8dedeb6dc6211b163c7039d2/barcode/image/c71d7a14-44ac-4ae0-a053-bf6f4dc1a7a1/f6c2eeb6-72e2-4e59-987d-d7aa46cc7c9f.svg",
        "owner_id": "62d7afae-d08e-4c3c-89d9-bbb37a66500e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/62d7afae-d08e-4c3c-89d9-bbb37a66500e"
          },
          "data": {
            "type": "customers",
            "id": "62d7afae-d08e-4c3c-89d9-bbb37a66500e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "62d7afae-d08e-4c3c-89d9-bbb37a66500e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-19T10:45:25+00:00",
        "updated_at": "2023-01-19T10:45:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=62d7afae-d08e-4c3c-89d9-bbb37a66500e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=62d7afae-d08e-4c3c-89d9-bbb37a66500e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=62d7afae-d08e-4c3c-89d9-bbb37a66500e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzhlMDJjOWItZTE0NC00MWQxLWE5NGMtOGJkNzExZDI1M2I1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c8e02c9b-e144-41d1-a94c-8bd711d253b5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-19T10:45:25+00:00",
        "updated_at": "2023-01-19T10:45:25+00:00",
        "number": "http://bqbl.it/c8e02c9b-e144-41d1-a94c-8bd711d253b5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4bc9a380e7c6c6926a1f07227865e4ba/barcode/image/c8e02c9b-e144-41d1-a94c-8bd711d253b5/506ef53e-f759-4938-a8f2-450137cdff43.svg",
        "owner_id": "6ce5ba5e-edaa-4886-b45a-28d866cd2c44",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6ce5ba5e-edaa-4886-b45a-28d866cd2c44"
          },
          "data": {
            "type": "customers",
            "id": "6ce5ba5e-edaa-4886-b45a-28d866cd2c44"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6ce5ba5e-edaa-4886-b45a-28d866cd2c44",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-19T10:45:25+00:00",
        "updated_at": "2023-01-19T10:45:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6ce5ba5e-edaa-4886-b45a-28d866cd2c44&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6ce5ba5e-edaa-4886-b45a-28d866cd2c44&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6ce5ba5e-edaa-4886-b45a-28d866cd2c44&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:45:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/be05bee9-3333-47c9-83fc-f89efa4e5a92?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be05bee9-3333-47c9-83fc-f89efa4e5a92",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-19T10:45:26+00:00",
      "updated_at": "2023-01-19T10:45:26+00:00",
      "number": "http://bqbl.it/be05bee9-3333-47c9-83fc-f89efa4e5a92",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f43798878f3e56fd6349d2e886480f12/barcode/image/be05bee9-3333-47c9-83fc-f89efa4e5a92/ab6346ed-2bd5-4516-90ee-8acedb9db9e3.svg",
      "owner_id": "33adb917-f458-4e70-a63a-d80b834332dd",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/33adb917-f458-4e70-a63a-d80b834332dd"
        },
        "data": {
          "type": "customers",
          "id": "33adb917-f458-4e70-a63a-d80b834332dd"
        }
      }
    }
  },
  "included": [
    {
      "id": "33adb917-f458-4e70-a63a-d80b834332dd",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-19T10:45:26+00:00",
        "updated_at": "2023-01-19T10:45:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=33adb917-f458-4e70-a63a-d80b834332dd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=33adb917-f458-4e70-a63a-d80b834332dd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=33adb917-f458-4e70-a63a-d80b834332dd&filter[owner_type]=customers"
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
          "owner_id": "6804073c-1403-4591-b0b2-2212979623ef",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c30c8cd1-d628-405a-9732-c50c0879cc65",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-19T10:45:26+00:00",
      "updated_at": "2023-01-19T10:45:26+00:00",
      "number": "http://bqbl.it/c30c8cd1-d628-405a-9732-c50c0879cc65",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aa1ee31027134d9585cdedc98bf97997/barcode/image/c30c8cd1-d628-405a-9732-c50c0879cc65/56f2a759-957b-49a8-927b-a30acbcf36ee.svg",
      "owner_id": "6804073c-1403-4591-b0b2-2212979623ef",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bdb75242-1d7e-4a5e-bfc8-b1f46b132384' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bdb75242-1d7e-4a5e-bfc8-b1f46b132384",
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
    "id": "bdb75242-1d7e-4a5e-bfc8-b1f46b132384",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-19T10:45:26+00:00",
      "updated_at": "2023-01-19T10:45:27+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/644c011fff0d1809d5a51a866123950f/barcode/image/bdb75242-1d7e-4a5e-bfc8-b1f46b132384/1c0e02f7-17d0-4e2d-8932-5403670c94ed.svg",
      "owner_id": "d90957a4-e38b-490c-a768-18578d31dff3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9de16167-c6c2-4215-8002-1fe8b5bcfcd3' \
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