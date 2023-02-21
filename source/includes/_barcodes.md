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
      "id": "e462e5f3-d6cb-457c-8a54-9c3ebfe5111a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T12:15:42+00:00",
        "updated_at": "2023-02-21T12:15:42+00:00",
        "number": "http://bqbl.it/e462e5f3-d6cb-457c-8a54-9c3ebfe5111a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b99d4153fb2b3a9c37915ab8317d7ae3/barcode/image/e462e5f3-d6cb-457c-8a54-9c3ebfe5111a/7cf8f7f8-d0b9-43e3-a0bd-e6006397ce4f.svg",
        "owner_id": "0478aa33-ebb5-4f87-8638-16db0b5053a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0478aa33-ebb5-4f87-8638-16db0b5053a0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F77fcf830-5c45-48a4-a880-ef26a389fc19&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "77fcf830-5c45-48a4-a880-ef26a389fc19",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T12:15:43+00:00",
        "updated_at": "2023-02-21T12:15:43+00:00",
        "number": "http://bqbl.it/77fcf830-5c45-48a4-a880-ef26a389fc19",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ed849753535955618bfb74cf2589fe59/barcode/image/77fcf830-5c45-48a4-a880-ef26a389fc19/f7b1e3e7-c9f1-498e-8caa-7e2eb9ef1783.svg",
        "owner_id": "1290ff49-e704-408f-b642-cd27b5579213",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1290ff49-e704-408f-b642-cd27b5579213"
          },
          "data": {
            "type": "customers",
            "id": "1290ff49-e704-408f-b642-cd27b5579213"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1290ff49-e704-408f-b642-cd27b5579213",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T12:15:43+00:00",
        "updated_at": "2023-02-21T12:15:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1290ff49-e704-408f-b642-cd27b5579213&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1290ff49-e704-408f-b642-cd27b5579213&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1290ff49-e704-408f-b642-cd27b5579213&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWNlYWU3NDItODM3NS00ODYxLWFkMGYtYTEwN2U4NWQ2OTA0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "aceae742-8375-4861-ad0f-a107e85d6904",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T12:15:43+00:00",
        "updated_at": "2023-02-21T12:15:43+00:00",
        "number": "http://bqbl.it/aceae742-8375-4861-ad0f-a107e85d6904",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f3d37e095f0d31eaa6ebd9b109db8ec5/barcode/image/aceae742-8375-4861-ad0f-a107e85d6904/32be0ef3-7c2c-40d9-a164-e9447bad9488.svg",
        "owner_id": "5d4b33e0-c4cf-481f-8c55-2736d8b76d47",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5d4b33e0-c4cf-481f-8c55-2736d8b76d47"
          },
          "data": {
            "type": "customers",
            "id": "5d4b33e0-c4cf-481f-8c55-2736d8b76d47"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5d4b33e0-c4cf-481f-8c55-2736d8b76d47",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T12:15:43+00:00",
        "updated_at": "2023-02-21T12:15:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5d4b33e0-c4cf-481f-8c55-2736d8b76d47&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5d4b33e0-c4cf-481f-8c55-2736d8b76d47&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5d4b33e0-c4cf-481f-8c55-2736d8b76d47&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T12:15:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e0a40cc8-ef94-4f3d-9110-dc98dd150869?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e0a40cc8-ef94-4f3d-9110-dc98dd150869",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T12:15:44+00:00",
      "updated_at": "2023-02-21T12:15:44+00:00",
      "number": "http://bqbl.it/e0a40cc8-ef94-4f3d-9110-dc98dd150869",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3f1992317e2eb95aa43ce2996d57fe17/barcode/image/e0a40cc8-ef94-4f3d-9110-dc98dd150869/0e189ee5-8c44-48ae-b3d7-0f8c6c8e2a3e.svg",
      "owner_id": "55561f17-9ad8-4fed-ac59-1504f8e3197c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/55561f17-9ad8-4fed-ac59-1504f8e3197c"
        },
        "data": {
          "type": "customers",
          "id": "55561f17-9ad8-4fed-ac59-1504f8e3197c"
        }
      }
    }
  },
  "included": [
    {
      "id": "55561f17-9ad8-4fed-ac59-1504f8e3197c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T12:15:44+00:00",
        "updated_at": "2023-02-21T12:15:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=55561f17-9ad8-4fed-ac59-1504f8e3197c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=55561f17-9ad8-4fed-ac59-1504f8e3197c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=55561f17-9ad8-4fed-ac59-1504f8e3197c&filter[owner_type]=customers"
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
          "owner_id": "5f1ed296-af51-4fa8-8c56-ad417c0e8502",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8e34f0f9-4c17-4541-89e2-f63bc4a7aef4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T12:15:44+00:00",
      "updated_at": "2023-02-21T12:15:44+00:00",
      "number": "http://bqbl.it/8e34f0f9-4c17-4541-89e2-f63bc4a7aef4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d32568233d3fc72001a68952e8002597/barcode/image/8e34f0f9-4c17-4541-89e2-f63bc4a7aef4/c12b935e-73f1-4327-8e47-1b529794f2dd.svg",
      "owner_id": "5f1ed296-af51-4fa8-8c56-ad417c0e8502",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9be3d6d2-e355-4d5a-8c68-e9adf6abb572' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9be3d6d2-e355-4d5a-8c68-e9adf6abb572",
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
    "id": "9be3d6d2-e355-4d5a-8c68-e9adf6abb572",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T12:15:45+00:00",
      "updated_at": "2023-02-21T12:15:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cabe22863e47398168d7ecf7a6eab70c/barcode/image/9be3d6d2-e355-4d5a-8c68-e9adf6abb572/349bfb66-184c-48bc-a7c0-3c05f3aff181.svg",
      "owner_id": "bff4fd15-4f29-4d03-9c0d-7b39a2a602f5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7759bff7-b9b1-499e-a118-8e0114f5520c' \
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