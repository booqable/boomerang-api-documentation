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
      "id": "667a27e4-1888-4081-89cc-c2e1ceef90e7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T12:15:56+00:00",
        "updated_at": "2023-01-26T12:15:56+00:00",
        "number": "http://bqbl.it/667a27e4-1888-4081-89cc-c2e1ceef90e7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c3c19a6017df34b56da31118993b4d88/barcode/image/667a27e4-1888-4081-89cc-c2e1ceef90e7/bfa3a415-1f53-4645-8f6b-e0ac7631531e.svg",
        "owner_id": "da7cbe57-19af-4d43-a111-0d1bd72072a2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/da7cbe57-19af-4d43-a111-0d1bd72072a2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1394ef86-14bd-4f24-b0aa-d80b953e4977&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1394ef86-14bd-4f24-b0aa-d80b953e4977",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T12:15:57+00:00",
        "updated_at": "2023-01-26T12:15:57+00:00",
        "number": "http://bqbl.it/1394ef86-14bd-4f24-b0aa-d80b953e4977",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bc32aeff94abc330fd91861101720fa4/barcode/image/1394ef86-14bd-4f24-b0aa-d80b953e4977/4d052663-f686-423b-b59e-7115e61d6472.svg",
        "owner_id": "374c544a-cc6d-458b-a84c-76ae44cc774b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/374c544a-cc6d-458b-a84c-76ae44cc774b"
          },
          "data": {
            "type": "customers",
            "id": "374c544a-cc6d-458b-a84c-76ae44cc774b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "374c544a-cc6d-458b-a84c-76ae44cc774b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T12:15:57+00:00",
        "updated_at": "2023-01-26T12:15:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=374c544a-cc6d-458b-a84c-76ae44cc774b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=374c544a-cc6d-458b-a84c-76ae44cc774b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=374c544a-cc6d-458b-a84c-76ae44cc774b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDgxMWU4NzEtZTMxNy00ODE3LWIwYmYtM2YwNDZjMzc3OThh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4811e871-e317-4817-b0bf-3f046c37798a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T12:15:57+00:00",
        "updated_at": "2023-01-26T12:15:57+00:00",
        "number": "http://bqbl.it/4811e871-e317-4817-b0bf-3f046c37798a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8619003e4d11d549cd0c4b9b19031ff9/barcode/image/4811e871-e317-4817-b0bf-3f046c37798a/baa55644-4a4b-424b-89a2-389aabf861d6.svg",
        "owner_id": "5a5090aa-6eec-4fdb-9d1d-09463591b4b8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5a5090aa-6eec-4fdb-9d1d-09463591b4b8"
          },
          "data": {
            "type": "customers",
            "id": "5a5090aa-6eec-4fdb-9d1d-09463591b4b8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5a5090aa-6eec-4fdb-9d1d-09463591b4b8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T12:15:57+00:00",
        "updated_at": "2023-01-26T12:15:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5a5090aa-6eec-4fdb-9d1d-09463591b4b8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5a5090aa-6eec-4fdb-9d1d-09463591b4b8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5a5090aa-6eec-4fdb-9d1d-09463591b4b8&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T12:15:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/15188535-e8b3-48b3-b07e-2d315334f336?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15188535-e8b3-48b3-b07e-2d315334f336",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T12:15:58+00:00",
      "updated_at": "2023-01-26T12:15:58+00:00",
      "number": "http://bqbl.it/15188535-e8b3-48b3-b07e-2d315334f336",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a16902a931bd91baa8d8310988146883/barcode/image/15188535-e8b3-48b3-b07e-2d315334f336/8a9c522e-312d-4717-ae19-f6f69e466243.svg",
      "owner_id": "59476894-d49a-4fb6-9f45-aaef6057b416",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/59476894-d49a-4fb6-9f45-aaef6057b416"
        },
        "data": {
          "type": "customers",
          "id": "59476894-d49a-4fb6-9f45-aaef6057b416"
        }
      }
    }
  },
  "included": [
    {
      "id": "59476894-d49a-4fb6-9f45-aaef6057b416",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T12:15:58+00:00",
        "updated_at": "2023-01-26T12:15:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=59476894-d49a-4fb6-9f45-aaef6057b416&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=59476894-d49a-4fb6-9f45-aaef6057b416&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=59476894-d49a-4fb6-9f45-aaef6057b416&filter[owner_type]=customers"
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
          "owner_id": "8aebbe86-81fe-4bac-aca3-56db96fd8a2e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "addbe14a-a3bf-428d-91af-3819901772f7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T12:15:59+00:00",
      "updated_at": "2023-01-26T12:15:59+00:00",
      "number": "http://bqbl.it/addbe14a-a3bf-428d-91af-3819901772f7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e2f8e3542e985e17f2c6492cc02cbb3a/barcode/image/addbe14a-a3bf-428d-91af-3819901772f7/2e17099f-88fd-4383-b733-76f4c961df90.svg",
      "owner_id": "8aebbe86-81fe-4bac-aca3-56db96fd8a2e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/445a4521-7191-4a4b-b8fc-68c61d09853c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "445a4521-7191-4a4b-b8fc-68c61d09853c",
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
    "id": "445a4521-7191-4a4b-b8fc-68c61d09853c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T12:15:59+00:00",
      "updated_at": "2023-01-26T12:15:59+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/135db67e74f89e7870aa854e772629ff/barcode/image/445a4521-7191-4a4b-b8fc-68c61d09853c/9975d0ca-3aa5-45b0-8b91-30923238507b.svg",
      "owner_id": "1093a56d-cb4c-4d09-8fc8-8d3b01b2b6e1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/72ece0d8-d19c-48c8-bab6-554fa9b4cfe5' \
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