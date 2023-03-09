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
      "id": "307a1e6e-8040-4b19-b6ed-38199d7aa2bf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T08:56:46+00:00",
        "updated_at": "2023-03-09T08:56:46+00:00",
        "number": "http://bqbl.it/307a1e6e-8040-4b19-b6ed-38199d7aa2bf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2067a92c3a5d513d4f735d9a01c810ed/barcode/image/307a1e6e-8040-4b19-b6ed-38199d7aa2bf/05e927e1-b5c0-4f49-893c-9fb3d7c0c03d.svg",
        "owner_id": "14d36141-10ba-4922-a1a7-5394d0c34cf9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/14d36141-10ba-4922-a1a7-5394d0c34cf9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fda2ae46c-b2c9-47e9-a8ec-6b8860159ac8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "da2ae46c-b2c9-47e9-a8ec-6b8860159ac8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T08:56:47+00:00",
        "updated_at": "2023-03-09T08:56:47+00:00",
        "number": "http://bqbl.it/da2ae46c-b2c9-47e9-a8ec-6b8860159ac8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/64ed797f4e0e92dfd3bf92b696f902e4/barcode/image/da2ae46c-b2c9-47e9-a8ec-6b8860159ac8/b3507e63-513a-4df5-b9d6-c922923f6814.svg",
        "owner_id": "b19d7c59-dfe3-4885-a8fe-05f13f2424eb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b19d7c59-dfe3-4885-a8fe-05f13f2424eb"
          },
          "data": {
            "type": "customers",
            "id": "b19d7c59-dfe3-4885-a8fe-05f13f2424eb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b19d7c59-dfe3-4885-a8fe-05f13f2424eb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T08:56:47+00:00",
        "updated_at": "2023-03-09T08:56:47+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b19d7c59-dfe3-4885-a8fe-05f13f2424eb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b19d7c59-dfe3-4885-a8fe-05f13f2424eb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b19d7c59-dfe3-4885-a8fe-05f13f2424eb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGVmZGY3YWUtMzNjNS00YWY0LTg5YTgtZjM2OTc0OTcxYzkx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8efdf7ae-33c5-4af4-89a8-f36974971c91",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T08:56:47+00:00",
        "updated_at": "2023-03-09T08:56:47+00:00",
        "number": "http://bqbl.it/8efdf7ae-33c5-4af4-89a8-f36974971c91",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6c3506d7a6540274abc5634a22d10ce3/barcode/image/8efdf7ae-33c5-4af4-89a8-f36974971c91/2f8ee912-3735-4341-856c-ddc696828b92.svg",
        "owner_id": "674e0d1b-dfc9-41e3-b0e6-8c062ba66cba",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/674e0d1b-dfc9-41e3-b0e6-8c062ba66cba"
          },
          "data": {
            "type": "customers",
            "id": "674e0d1b-dfc9-41e3-b0e6-8c062ba66cba"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "674e0d1b-dfc9-41e3-b0e6-8c062ba66cba",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T08:56:47+00:00",
        "updated_at": "2023-03-09T08:56:47+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=674e0d1b-dfc9-41e3-b0e6-8c062ba66cba&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=674e0d1b-dfc9-41e3-b0e6-8c062ba66cba&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=674e0d1b-dfc9-41e3-b0e6-8c062ba66cba&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T08:56:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f71983ad-0b52-45a7-8c24-8a5cf38ba0c3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f71983ad-0b52-45a7-8c24-8a5cf38ba0c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T08:56:48+00:00",
      "updated_at": "2023-03-09T08:56:48+00:00",
      "number": "http://bqbl.it/f71983ad-0b52-45a7-8c24-8a5cf38ba0c3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/011392ffef5e4c2c46b7caa7f874c256/barcode/image/f71983ad-0b52-45a7-8c24-8a5cf38ba0c3/0b528dbd-6f17-4842-985d-f687fa1a1fa1.svg",
      "owner_id": "0df241b4-ad58-4d93-a45c-caf72b4697fb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0df241b4-ad58-4d93-a45c-caf72b4697fb"
        },
        "data": {
          "type": "customers",
          "id": "0df241b4-ad58-4d93-a45c-caf72b4697fb"
        }
      }
    }
  },
  "included": [
    {
      "id": "0df241b4-ad58-4d93-a45c-caf72b4697fb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T08:56:48+00:00",
        "updated_at": "2023-03-09T08:56:48+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0df241b4-ad58-4d93-a45c-caf72b4697fb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0df241b4-ad58-4d93-a45c-caf72b4697fb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0df241b4-ad58-4d93-a45c-caf72b4697fb&filter[owner_type]=customers"
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
          "owner_id": "1b2bc1c2-f4af-4a9b-91c7-01685d8292c4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f8b60499-d538-42c6-96a5-bc5268aadb18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T08:56:49+00:00",
      "updated_at": "2023-03-09T08:56:49+00:00",
      "number": "http://bqbl.it/f8b60499-d538-42c6-96a5-bc5268aadb18",
      "barcode_type": "qr_code",
      "image_url": "/uploads/45593996dcc633ec15def7bb84489d27/barcode/image/f8b60499-d538-42c6-96a5-bc5268aadb18/65e61f14-0e0a-4dbd-809c-1768d93ac3c8.svg",
      "owner_id": "1b2bc1c2-f4af-4a9b-91c7-01685d8292c4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2e915afc-0ee7-450c-992b-ebb98819a6b3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2e915afc-0ee7-450c-992b-ebb98819a6b3",
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
    "id": "2e915afc-0ee7-450c-992b-ebb98819a6b3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T08:56:49+00:00",
      "updated_at": "2023-03-09T08:56:49+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c96b7327b92dfdda72c2aad8ff97feec/barcode/image/2e915afc-0ee7-450c-992b-ebb98819a6b3/c47ca13c-8c79-4018-bea4-48a1a9b4b09e.svg",
      "owner_id": "4307d3c6-67b4-4a5f-b714-7ea87327aeca",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1bb15a93-e69b-4927-8389-194b80d90192' \
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