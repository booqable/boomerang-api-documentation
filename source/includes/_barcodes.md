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
      "id": "28da6df2-dcfd-4ee0-8948-867736edb8f6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T09:54:54+00:00",
        "updated_at": "2023-01-05T09:54:54+00:00",
        "number": "http://bqbl.it/28da6df2-dcfd-4ee0-8948-867736edb8f6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9c26a02a9dd6b593b0d704cc0d4d969f/barcode/image/28da6df2-dcfd-4ee0-8948-867736edb8f6/b38e2dc5-6739-4f7f-8c24-93f1caa433ba.svg",
        "owner_id": "291600db-0da6-45f9-80cc-b8c2f9fb6fc9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/291600db-0da6-45f9-80cc-b8c2f9fb6fc9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F294ba20b-bcea-47a4-8c2b-d047389a2f6e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "294ba20b-bcea-47a4-8c2b-d047389a2f6e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T09:54:55+00:00",
        "updated_at": "2023-01-05T09:54:55+00:00",
        "number": "http://bqbl.it/294ba20b-bcea-47a4-8c2b-d047389a2f6e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/17659f6a60ae48680923cc019f846a29/barcode/image/294ba20b-bcea-47a4-8c2b-d047389a2f6e/26ef21d1-a32e-41f1-84fc-e0813774b1bb.svg",
        "owner_id": "75cfe79c-a821-46b1-8407-010ff38f3ea2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/75cfe79c-a821-46b1-8407-010ff38f3ea2"
          },
          "data": {
            "type": "customers",
            "id": "75cfe79c-a821-46b1-8407-010ff38f3ea2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "75cfe79c-a821-46b1-8407-010ff38f3ea2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T09:54:55+00:00",
        "updated_at": "2023-01-05T09:54:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=75cfe79c-a821-46b1-8407-010ff38f3ea2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=75cfe79c-a821-46b1-8407-010ff38f3ea2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=75cfe79c-a821-46b1-8407-010ff38f3ea2&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzFmNGQ4ZGEtNjBjYy00ZGE5LTllNGQtMTAwOTc1MmRhMzRl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "31f4d8da-60cc-4da9-9e4d-1009752da34e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T09:54:55+00:00",
        "updated_at": "2023-01-05T09:54:55+00:00",
        "number": "http://bqbl.it/31f4d8da-60cc-4da9-9e4d-1009752da34e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1a7cfc69a6a4144a07529ae3e7955afb/barcode/image/31f4d8da-60cc-4da9-9e4d-1009752da34e/29202426-7c23-4b08-9560-62f3fa121399.svg",
        "owner_id": "99e32458-5a4d-4992-9f2a-e3fe23132a74",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/99e32458-5a4d-4992-9f2a-e3fe23132a74"
          },
          "data": {
            "type": "customers",
            "id": "99e32458-5a4d-4992-9f2a-e3fe23132a74"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "99e32458-5a4d-4992-9f2a-e3fe23132a74",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T09:54:55+00:00",
        "updated_at": "2023-01-05T09:54:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=99e32458-5a4d-4992-9f2a-e3fe23132a74&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=99e32458-5a4d-4992-9f2a-e3fe23132a74&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=99e32458-5a4d-4992-9f2a-e3fe23132a74&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T09:54:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6667193e-d339-4b5d-86df-9233ee0d6c55?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6667193e-d339-4b5d-86df-9233ee0d6c55",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T09:54:56+00:00",
      "updated_at": "2023-01-05T09:54:56+00:00",
      "number": "http://bqbl.it/6667193e-d339-4b5d-86df-9233ee0d6c55",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a4909f59b3bdfe91979045c8787e6b33/barcode/image/6667193e-d339-4b5d-86df-9233ee0d6c55/154783cc-88ce-4946-a2b9-d2cee86858d2.svg",
      "owner_id": "489d9999-0ae4-43c1-94ec-00f6ecff14fa",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/489d9999-0ae4-43c1-94ec-00f6ecff14fa"
        },
        "data": {
          "type": "customers",
          "id": "489d9999-0ae4-43c1-94ec-00f6ecff14fa"
        }
      }
    }
  },
  "included": [
    {
      "id": "489d9999-0ae4-43c1-94ec-00f6ecff14fa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T09:54:56+00:00",
        "updated_at": "2023-01-05T09:54:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=489d9999-0ae4-43c1-94ec-00f6ecff14fa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=489d9999-0ae4-43c1-94ec-00f6ecff14fa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=489d9999-0ae4-43c1-94ec-00f6ecff14fa&filter[owner_type]=customers"
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
          "owner_id": "051ee4da-1f83-4e56-8f70-38e13bff0da5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5a3f732f-6e4f-4e86-b3e6-5151bed09bc9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T09:54:56+00:00",
      "updated_at": "2023-01-05T09:54:56+00:00",
      "number": "http://bqbl.it/5a3f732f-6e4f-4e86-b3e6-5151bed09bc9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db89d215aace97d951f7d1be1ce9115a/barcode/image/5a3f732f-6e4f-4e86-b3e6-5151bed09bc9/361ed787-541f-4b12-97ae-6d034a10d3e4.svg",
      "owner_id": "051ee4da-1f83-4e56-8f70-38e13bff0da5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6cf8f33f-36ec-412a-adac-07cf1ca36f7f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6cf8f33f-36ec-412a-adac-07cf1ca36f7f",
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
    "id": "6cf8f33f-36ec-412a-adac-07cf1ca36f7f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T09:54:57+00:00",
      "updated_at": "2023-01-05T09:54:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fcd36d2398ae6092cf685f859452827e/barcode/image/6cf8f33f-36ec-412a-adac-07cf1ca36f7f/21f359aa-40a0-4843-9d7a-fe5937f422c1.svg",
      "owner_id": "aa081aa6-3176-4843-969e-c65eec2df733",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/262571ab-4974-4c6f-aec7-27742f754012' \
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