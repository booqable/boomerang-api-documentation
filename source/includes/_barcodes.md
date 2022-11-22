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
      "id": "6e17f3ae-dc1d-4e70-a8de-28c2271f6720",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T17:42:42+00:00",
        "updated_at": "2022-11-22T17:42:42+00:00",
        "number": "http://bqbl.it/6e17f3ae-dc1d-4e70-a8de-28c2271f6720",
        "barcode_type": "qr_code",
        "image_url": "/uploads/10703dddffda0d114697dd3d42b3deff/barcode/image/6e17f3ae-dc1d-4e70-a8de-28c2271f6720/92aedc4d-a07a-44b9-a46c-91ddb3fa304d.svg",
        "owner_id": "6625519d-ff11-40b1-8842-590310d6cc3b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6625519d-ff11-40b1-8842-590310d6cc3b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb1992e2e-9950-48bf-b18d-1f64d54bf51e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b1992e2e-9950-48bf-b18d-1f64d54bf51e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T17:42:42+00:00",
        "updated_at": "2022-11-22T17:42:42+00:00",
        "number": "http://bqbl.it/b1992e2e-9950-48bf-b18d-1f64d54bf51e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/576747b20d787825e6305eb0589461f2/barcode/image/b1992e2e-9950-48bf-b18d-1f64d54bf51e/40cea736-56f9-4055-b9dc-ab6f8f393363.svg",
        "owner_id": "3deff392-273e-4339-b3b5-f5eb3e4c1997",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3deff392-273e-4339-b3b5-f5eb3e4c1997"
          },
          "data": {
            "type": "customers",
            "id": "3deff392-273e-4339-b3b5-f5eb3e4c1997"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3deff392-273e-4339-b3b5-f5eb3e4c1997",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T17:42:42+00:00",
        "updated_at": "2022-11-22T17:42:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3deff392-273e-4339-b3b5-f5eb3e4c1997&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3deff392-273e-4339-b3b5-f5eb3e4c1997&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3deff392-273e-4339-b3b5-f5eb3e4c1997&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzNkYjY3N2EtMzExNC00ZjgyLWFmYWUtMWJmMmY0YTRlOWEx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "73db677a-3114-4f82-afae-1bf2f4a4e9a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T17:42:43+00:00",
        "updated_at": "2022-11-22T17:42:43+00:00",
        "number": "http://bqbl.it/73db677a-3114-4f82-afae-1bf2f4a4e9a1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/271eae317f81cb044bc73d6b3b7216af/barcode/image/73db677a-3114-4f82-afae-1bf2f4a4e9a1/9ff4dbc4-95cf-4638-a616-d7782c7480c0.svg",
        "owner_id": "c2f66ec3-fdb6-40f4-9a42-a6d391381bac",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c2f66ec3-fdb6-40f4-9a42-a6d391381bac"
          },
          "data": {
            "type": "customers",
            "id": "c2f66ec3-fdb6-40f4-9a42-a6d391381bac"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c2f66ec3-fdb6-40f4-9a42-a6d391381bac",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T17:42:43+00:00",
        "updated_at": "2022-11-22T17:42:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c2f66ec3-fdb6-40f4-9a42-a6d391381bac&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c2f66ec3-fdb6-40f4-9a42-a6d391381bac&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c2f66ec3-fdb6-40f4-9a42-a6d391381bac&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:42:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2a95ac0f-b090-4f57-a526-bbf3aec7c0c1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2a95ac0f-b090-4f57-a526-bbf3aec7c0c1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T17:42:43+00:00",
      "updated_at": "2022-11-22T17:42:43+00:00",
      "number": "http://bqbl.it/2a95ac0f-b090-4f57-a526-bbf3aec7c0c1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0c441a1e4b047835f179f34b30087146/barcode/image/2a95ac0f-b090-4f57-a526-bbf3aec7c0c1/b705e5ce-81e3-4f6f-b186-91c2f5b44b97.svg",
      "owner_id": "1390ba62-d242-4d70-9cf0-c0d06400b7fa",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1390ba62-d242-4d70-9cf0-c0d06400b7fa"
        },
        "data": {
          "type": "customers",
          "id": "1390ba62-d242-4d70-9cf0-c0d06400b7fa"
        }
      }
    }
  },
  "included": [
    {
      "id": "1390ba62-d242-4d70-9cf0-c0d06400b7fa",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T17:42:43+00:00",
        "updated_at": "2022-11-22T17:42:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1390ba62-d242-4d70-9cf0-c0d06400b7fa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1390ba62-d242-4d70-9cf0-c0d06400b7fa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1390ba62-d242-4d70-9cf0-c0d06400b7fa&filter[owner_type]=customers"
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
          "owner_id": "2dae6443-6527-4e90-ba10-aeee43c0a328",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5878ad4b-2641-4d88-a373-904102a1a21b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T17:42:44+00:00",
      "updated_at": "2022-11-22T17:42:44+00:00",
      "number": "http://bqbl.it/5878ad4b-2641-4d88-a373-904102a1a21b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2429783e2099b8c3a92f4fdccfc53a2b/barcode/image/5878ad4b-2641-4d88-a373-904102a1a21b/23ccc928-9dbf-4833-a9c7-11b7aadbaaa6.svg",
      "owner_id": "2dae6443-6527-4e90-ba10-aeee43c0a328",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9adf7c78-66e7-4d58-8c53-5ae383e070f8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9adf7c78-66e7-4d58-8c53-5ae383e070f8",
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
    "id": "9adf7c78-66e7-4d58-8c53-5ae383e070f8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T17:42:44+00:00",
      "updated_at": "2022-11-22T17:42:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a1de71cfaccaa564f9032f0b650665e8/barcode/image/9adf7c78-66e7-4d58-8c53-5ae383e070f8/60dfc5dd-e069-4ba3-b684-375e3e149294.svg",
      "owner_id": "ed9df907-f525-45da-95d8-aa731cbd977e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0ba4ddb-ca1e-4d58-81bc-3b7a4be04381' \
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