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
      "id": "a9480c7a-779c-4e73-9167-69c3fc5ab5b2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:13:27+00:00",
        "updated_at": "2023-02-13T12:13:27+00:00",
        "number": "http://bqbl.it/a9480c7a-779c-4e73-9167-69c3fc5ab5b2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0cdfa5785e57236fa14dbdb499e966b4/barcode/image/a9480c7a-779c-4e73-9167-69c3fc5ab5b2/ec5ad45b-db35-4de1-b7c1-99b6968de083.svg",
        "owner_id": "e9afbb5d-d7e8-407b-8975-51538a004e14",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e9afbb5d-d7e8-407b-8975-51538a004e14"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4bfc7e3b-b444-49e1-8647-2645e4b5df6b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4bfc7e3b-b444-49e1-8647-2645e4b5df6b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:13:27+00:00",
        "updated_at": "2023-02-13T12:13:27+00:00",
        "number": "http://bqbl.it/4bfc7e3b-b444-49e1-8647-2645e4b5df6b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e6adde2eff107121635d4a83b4ab186e/barcode/image/4bfc7e3b-b444-49e1-8647-2645e4b5df6b/623b0d3b-a303-4af4-a911-07b0e2ea6ce5.svg",
        "owner_id": "82e39efa-5cc5-420c-9b30-61b91ab0de55",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/82e39efa-5cc5-420c-9b30-61b91ab0de55"
          },
          "data": {
            "type": "customers",
            "id": "82e39efa-5cc5-420c-9b30-61b91ab0de55"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "82e39efa-5cc5-420c-9b30-61b91ab0de55",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:13:27+00:00",
        "updated_at": "2023-02-13T12:13:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=82e39efa-5cc5-420c-9b30-61b91ab0de55&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=82e39efa-5cc5-420c-9b30-61b91ab0de55&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=82e39efa-5cc5-420c-9b30-61b91ab0de55&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTc4NzQ1OTQtOGNiZi00NDI4LTk5OTYtYjg4YWI2NTcyOTE4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "17874594-8cbf-4428-9996-b88ab6572918",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:13:28+00:00",
        "updated_at": "2023-02-13T12:13:28+00:00",
        "number": "http://bqbl.it/17874594-8cbf-4428-9996-b88ab6572918",
        "barcode_type": "qr_code",
        "image_url": "/uploads/eb18c02153c797248ee1abafdda385ea/barcode/image/17874594-8cbf-4428-9996-b88ab6572918/f634b52f-0125-4821-9127-38861d039947.svg",
        "owner_id": "f864e2a1-35d7-4427-b213-9cd530054a11",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f864e2a1-35d7-4427-b213-9cd530054a11"
          },
          "data": {
            "type": "customers",
            "id": "f864e2a1-35d7-4427-b213-9cd530054a11"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f864e2a1-35d7-4427-b213-9cd530054a11",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:13:28+00:00",
        "updated_at": "2023-02-13T12:13:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f864e2a1-35d7-4427-b213-9cd530054a11&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f864e2a1-35d7-4427-b213-9cd530054a11&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f864e2a1-35d7-4427-b213-9cd530054a11&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:13:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9798f3d-e9ce-4cce-a152-369327ffdaf5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a9798f3d-e9ce-4cce-a152-369327ffdaf5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:13:29+00:00",
      "updated_at": "2023-02-13T12:13:29+00:00",
      "number": "http://bqbl.it/a9798f3d-e9ce-4cce-a152-369327ffdaf5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1891176c486e12c7adacd1dee22448c7/barcode/image/a9798f3d-e9ce-4cce-a152-369327ffdaf5/b75d5188-dd6d-4972-84b4-d7f9f6c6270d.svg",
      "owner_id": "1c7b632d-ae9c-40c8-ac59-831df2f2fa22",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1c7b632d-ae9c-40c8-ac59-831df2f2fa22"
        },
        "data": {
          "type": "customers",
          "id": "1c7b632d-ae9c-40c8-ac59-831df2f2fa22"
        }
      }
    }
  },
  "included": [
    {
      "id": "1c7b632d-ae9c-40c8-ac59-831df2f2fa22",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:13:28+00:00",
        "updated_at": "2023-02-13T12:13:29+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1c7b632d-ae9c-40c8-ac59-831df2f2fa22&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1c7b632d-ae9c-40c8-ac59-831df2f2fa22&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1c7b632d-ae9c-40c8-ac59-831df2f2fa22&filter[owner_type]=customers"
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
          "owner_id": "6eb2c687-61c3-4423-833f-16a9cd9d6b0a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b8bf3e0c-3cbb-4e86-92e1-e884fdb5db2b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:13:29+00:00",
      "updated_at": "2023-02-13T12:13:29+00:00",
      "number": "http://bqbl.it/b8bf3e0c-3cbb-4e86-92e1-e884fdb5db2b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/38e1cbd1ef3651742a3b79c49c4e2fd2/barcode/image/b8bf3e0c-3cbb-4e86-92e1-e884fdb5db2b/ce933ea2-fbb1-494c-89fd-f939abd4eb0a.svg",
      "owner_id": "6eb2c687-61c3-4423-833f-16a9cd9d6b0a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c9629970-aef8-401d-8c42-61c3816fe87e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c9629970-aef8-401d-8c42-61c3816fe87e",
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
    "id": "c9629970-aef8-401d-8c42-61c3816fe87e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:13:30+00:00",
      "updated_at": "2023-02-13T12:13:30+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6e64be705b0ad7149fc153200fd68598/barcode/image/c9629970-aef8-401d-8c42-61c3816fe87e/93be28cd-d2cf-4d7b-8b89-7e91e44d8bd8.svg",
      "owner_id": "c749470c-e13e-4f1f-b961-30321ce787ee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f8dd1f5-54d5-4a3c-8049-02c29c6554df' \
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