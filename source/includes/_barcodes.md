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
      "id": "7c89112b-3f0f-437f-900e-f331391c14d4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-05T11:35:00+00:00",
        "updated_at": "2022-10-05T11:35:00+00:00",
        "number": "http://bqbl.it/7c89112b-3f0f-437f-900e-f331391c14d4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b3dab603615dfdc59c17a8e79bd8b52e/barcode/image/7c89112b-3f0f-437f-900e-f331391c14d4/60ba8998-361a-4278-81da-08780dea6478.svg",
        "owner_id": "252397b8-1282-4916-be74-53978bfc314d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/252397b8-1282-4916-be74-53978bfc314d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fae43d7c4-1e50-41a6-b6df-af34bcbc48be&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ae43d7c4-1e50-41a6-b6df-af34bcbc48be",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-05T11:35:00+00:00",
        "updated_at": "2022-10-05T11:35:00+00:00",
        "number": "http://bqbl.it/ae43d7c4-1e50-41a6-b6df-af34bcbc48be",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9e09b1bff169291ebf33872ccf47c423/barcode/image/ae43d7c4-1e50-41a6-b6df-af34bcbc48be/5cf9285d-c855-4311-81e3-e62e56a8c7a1.svg",
        "owner_id": "805c593d-bcef-4132-812e-28a094fef98c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/805c593d-bcef-4132-812e-28a094fef98c"
          },
          "data": {
            "type": "customers",
            "id": "805c593d-bcef-4132-812e-28a094fef98c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "805c593d-bcef-4132-812e-28a094fef98c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-05T11:35:00+00:00",
        "updated_at": "2022-10-05T11:35:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=805c593d-bcef-4132-812e-28a094fef98c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=805c593d-bcef-4132-812e-28a094fef98c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=805c593d-bcef-4132-812e-28a094fef98c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzlmZmEzMjctMThhNi00ZTE4LWExM2QtMjBmMTg3NmM3NTUw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "79ffa327-18a6-4e18-a13d-20f1876c7550",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-05T11:35:01+00:00",
        "updated_at": "2022-10-05T11:35:01+00:00",
        "number": "http://bqbl.it/79ffa327-18a6-4e18-a13d-20f1876c7550",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b2fe8e8a53f8bcfe8cbc8ce6272011b2/barcode/image/79ffa327-18a6-4e18-a13d-20f1876c7550/036fbd3e-7b35-4c05-a130-07c6f3efc985.svg",
        "owner_id": "d5bfc72f-50e9-4324-8731-b895991efefc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d5bfc72f-50e9-4324-8731-b895991efefc"
          },
          "data": {
            "type": "customers",
            "id": "d5bfc72f-50e9-4324-8731-b895991efefc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d5bfc72f-50e9-4324-8731-b895991efefc",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-05T11:35:01+00:00",
        "updated_at": "2022-10-05T11:35:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d5bfc72f-50e9-4324-8731-b895991efefc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d5bfc72f-50e9-4324-8731-b895991efefc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d5bfc72f-50e9-4324-8731-b895991efefc&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-05T11:34:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cb7ed0c4-6395-4660-a084-6faca9699c72?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cb7ed0c4-6395-4660-a084-6faca9699c72",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-05T11:35:01+00:00",
      "updated_at": "2022-10-05T11:35:01+00:00",
      "number": "http://bqbl.it/cb7ed0c4-6395-4660-a084-6faca9699c72",
      "barcode_type": "qr_code",
      "image_url": "/uploads/283341b46a7e1bf50cae188a7df4503b/barcode/image/cb7ed0c4-6395-4660-a084-6faca9699c72/a9b478aa-8b41-42ce-995b-1fd9087fd248.svg",
      "owner_id": "f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9"
        },
        "data": {
          "type": "customers",
          "id": "f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9"
        }
      }
    }
  },
  "included": [
    {
      "id": "f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-05T11:35:01+00:00",
        "updated_at": "2022-10-05T11:35:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f27ea9ff-8d47-4308-b7cd-0c3427b4a9d9&filter[owner_type]=customers"
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
          "owner_id": "b6b40188-ee00-4f22-8574-d68e0e433a0c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a839e81d-f85b-4b85-9eb7-e5f88127eab4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-05T11:35:02+00:00",
      "updated_at": "2022-10-05T11:35:02+00:00",
      "number": "http://bqbl.it/a839e81d-f85b-4b85-9eb7-e5f88127eab4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/132514617ecc0549f42fc916bb7e5a72/barcode/image/a839e81d-f85b-4b85-9eb7-e5f88127eab4/bb55590b-f5ae-403f-a380-32c6be126eb6.svg",
      "owner_id": "b6b40188-ee00-4f22-8574-d68e0e433a0c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d9d3835d-60f0-44f7-b588-ff45380fc95c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d9d3835d-60f0-44f7-b588-ff45380fc95c",
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
    "id": "d9d3835d-60f0-44f7-b588-ff45380fc95c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-05T11:35:02+00:00",
      "updated_at": "2022-10-05T11:35:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/72875b3a26fe6c3fe412da279da4cc0f/barcode/image/d9d3835d-60f0-44f7-b588-ff45380fc95c/61139735-327e-4417-bb1f-46e516762e8e.svg",
      "owner_id": "21591ec1-c403-473d-b7c8-c7e7920dc66f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6eb8faf1-5a9e-463a-a9c8-1c59828e18fb' \
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