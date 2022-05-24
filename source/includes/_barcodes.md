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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "b52f9bf4-3152-44a4-aa4c-25d134ba187d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:19:00+00:00",
        "updated_at": "2022-05-24T07:19:00+00:00",
        "number": "http://bqbl.it/b52f9bf4-3152-44a4-aa4c-25d134ba187d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e3465d02d83784fc1ca5a21b6979a77a/barcode/image/b52f9bf4-3152-44a4-aa4c-25d134ba187d/b0c98195-0b72-4328-a1b2-30b724b89012.svg",
        "owner_id": "f68a1dc9-b35d-4ef8-8dce-469ce0a15b51",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f68a1dc9-b35d-4ef8-8dce-469ce0a15b51"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F53dd1c05-bef7-4701-a366-80c559e78b23&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "53dd1c05-bef7-4701-a366-80c559e78b23",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:19:00+00:00",
        "updated_at": "2022-05-24T07:19:00+00:00",
        "number": "http://bqbl.it/53dd1c05-bef7-4701-a366-80c559e78b23",
        "barcode_type": "qr_code",
        "image_url": "/uploads/01e116ff078301b4f68d172b651a20d5/barcode/image/53dd1c05-bef7-4701-a366-80c559e78b23/ffe32d0c-bb6a-4f46-aa6e-0858f28e4fd2.svg",
        "owner_id": "1083718c-9dd1-4a8a-898a-98d4a21f0754",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1083718c-9dd1-4a8a-898a-98d4a21f0754"
          },
          "data": {
            "type": "customers",
            "id": "1083718c-9dd1-4a8a-898a-98d4a21f0754"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1083718c-9dd1-4a8a-898a-98d4a21f0754",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:19:00+00:00",
        "updated_at": "2022-05-24T07:19:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Funk-Weimann",
        "email": "funk.weimann@paucek-johnson.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=1083718c-9dd1-4a8a-898a-98d4a21f0754&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1083718c-9dd1-4a8a-898a-98d4a21f0754&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1083718c-9dd1-4a8a-898a-98d4a21f0754&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmRiMDg2MzgtNWYwYi00YmI5LTgzZDYtYWYxYzdmOWY1NTZj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6db08638-5f0b-4bb9-83d6-af1c7f9f556c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:19:01+00:00",
        "updated_at": "2022-05-24T07:19:01+00:00",
        "number": "http://bqbl.it/6db08638-5f0b-4bb9-83d6-af1c7f9f556c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1289e936b0421d08b4d2fdaa67e50b9d/barcode/image/6db08638-5f0b-4bb9-83d6-af1c7f9f556c/70ea2195-ab15-415c-879f-b2d6a1dd0d4e.svg",
        "owner_id": "e01819a1-1b6e-4e7c-8890-2461da09c5fa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e01819a1-1b6e-4e7c-8890-2461da09c5fa"
          },
          "data": {
            "type": "customers",
            "id": "e01819a1-1b6e-4e7c-8890-2461da09c5fa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e01819a1-1b6e-4e7c-8890-2461da09c5fa",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:19:01+00:00",
        "updated_at": "2022-05-24T07:19:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Powlowski LLC",
        "email": "llc.powlowski@howe.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=e01819a1-1b6e-4e7c-8890-2461da09c5fa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e01819a1-1b6e-4e7c-8890-2461da09c5fa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e01819a1-1b6e-4e7c-8890-2461da09c5fa&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:18:49Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e7c3ee8f-65da-45e9-a6b7-b406ced902e5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e7c3ee8f-65da-45e9-a6b7-b406ced902e5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:19:01+00:00",
      "updated_at": "2022-05-24T07:19:01+00:00",
      "number": "http://bqbl.it/e7c3ee8f-65da-45e9-a6b7-b406ced902e5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1184303224e9a4dcaa71d42ae3f4ff60/barcode/image/e7c3ee8f-65da-45e9-a6b7-b406ced902e5/856d47f8-caa2-4e96-9232-c248f3de3862.svg",
      "owner_id": "8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18"
        },
        "data": {
          "type": "customers",
          "id": "8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18"
        }
      }
    }
  },
  "included": [
    {
      "id": "8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:19:01+00:00",
        "updated_at": "2022-05-24T07:19:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Thiel-Balistreri",
        "email": "balistreri.thiel@swift.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8ea0800d-171f-42dc-bbcc-fd6d0a9d5c18&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "6a4dbe0e-9b18-4ab8-afbc-b4e97fc82970",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2401a93c-31f2-437d-b29e-91cd52b3e53d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:19:02+00:00",
      "updated_at": "2022-05-24T07:19:02+00:00",
      "number": "http://bqbl.it/2401a93c-31f2-437d-b29e-91cd52b3e53d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9847139327811820b11a9f786a1f02f1/barcode/image/2401a93c-31f2-437d-b29e-91cd52b3e53d/91eae5ba-773d-4b75-96d3-d8da382fc9f7.svg",
      "owner_id": "6a4dbe0e-9b18-4ab8-afbc-b4e97fc82970",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/f9001027-c5ed-445d-b505-5d1125b95e66' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f9001027-c5ed-445d-b505-5d1125b95e66",
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
    "id": "f9001027-c5ed-445d-b505-5d1125b95e66",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:19:02+00:00",
      "updated_at": "2022-05-24T07:19:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/963b60b4030f1c658a0f455f1bddecfd/barcode/image/f9001027-c5ed-445d-b505-5d1125b95e66/e45d35f3-c7fa-405d-9daa-6953aca93a67.svg",
      "owner_id": "b84a4d9f-7670-4f5e-a5c9-4a144fc888cb",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e7612339-e027-4809-8ec9-743f57e3fe6a' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes