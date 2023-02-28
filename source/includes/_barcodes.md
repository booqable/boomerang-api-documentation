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
      "id": "7aa738b9-9c39-463f-9fd7-5077adabfe6f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T11:25:46+00:00",
        "updated_at": "2023-02-28T11:25:46+00:00",
        "number": "http://bqbl.it/7aa738b9-9c39-463f-9fd7-5077adabfe6f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9ee181be6bd7eb98808d23ba9fab1580/barcode/image/7aa738b9-9c39-463f-9fd7-5077adabfe6f/c27878df-e737-4882-b395-b44ac63213ed.svg",
        "owner_id": "92eb7d43-4ccf-4969-8deb-068d2e2d025b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/92eb7d43-4ccf-4969-8deb-068d2e2d025b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F016fcbc4-4465-4979-b8f0-cb7960b671cb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "016fcbc4-4465-4979-b8f0-cb7960b671cb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T11:25:46+00:00",
        "updated_at": "2023-02-28T11:25:46+00:00",
        "number": "http://bqbl.it/016fcbc4-4465-4979-b8f0-cb7960b671cb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/85f9d9b89170fba077187689794ed63a/barcode/image/016fcbc4-4465-4979-b8f0-cb7960b671cb/1e28d435-e28a-44d4-bbf5-e1c85f5289db.svg",
        "owner_id": "12f367be-dc16-4f1a-a41d-655fc1ba573d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/12f367be-dc16-4f1a-a41d-655fc1ba573d"
          },
          "data": {
            "type": "customers",
            "id": "12f367be-dc16-4f1a-a41d-655fc1ba573d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "12f367be-dc16-4f1a-a41d-655fc1ba573d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T11:25:46+00:00",
        "updated_at": "2023-02-28T11:25:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=12f367be-dc16-4f1a-a41d-655fc1ba573d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=12f367be-dc16-4f1a-a41d-655fc1ba573d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=12f367be-dc16-4f1a-a41d-655fc1ba573d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDMxZWJhODItOTgyZS00MjE1LWI4NGItZDBiODBhOTgzM2I0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "031eba82-982e-4215-b84b-d0b80a9833b4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T11:25:47+00:00",
        "updated_at": "2023-02-28T11:25:47+00:00",
        "number": "http://bqbl.it/031eba82-982e-4215-b84b-d0b80a9833b4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ba93e76c5275612527c7df369647db8f/barcode/image/031eba82-982e-4215-b84b-d0b80a9833b4/0437a1fb-c82b-4503-ab61-ccef1f5ea729.svg",
        "owner_id": "2848d950-24c6-4f2a-ba21-7aec15e41f56",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2848d950-24c6-4f2a-ba21-7aec15e41f56"
          },
          "data": {
            "type": "customers",
            "id": "2848d950-24c6-4f2a-ba21-7aec15e41f56"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2848d950-24c6-4f2a-ba21-7aec15e41f56",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T11:25:47+00:00",
        "updated_at": "2023-02-28T11:25:47+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2848d950-24c6-4f2a-ba21-7aec15e41f56&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2848d950-24c6-4f2a-ba21-7aec15e41f56&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2848d950-24c6-4f2a-ba21-7aec15e41f56&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T11:25:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f8dedb10-ad7c-4437-af28-bba87eb15140?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f8dedb10-ad7c-4437-af28-bba87eb15140",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T11:25:47+00:00",
      "updated_at": "2023-02-28T11:25:47+00:00",
      "number": "http://bqbl.it/f8dedb10-ad7c-4437-af28-bba87eb15140",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7bed91c08783a48d45b961fdd63fd912/barcode/image/f8dedb10-ad7c-4437-af28-bba87eb15140/478eba59-98a6-4723-9a59-b1a801d8dfaa.svg",
      "owner_id": "aa8e3866-c31f-4a2c-a123-6cd52c2f19cf",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/aa8e3866-c31f-4a2c-a123-6cd52c2f19cf"
        },
        "data": {
          "type": "customers",
          "id": "aa8e3866-c31f-4a2c-a123-6cd52c2f19cf"
        }
      }
    }
  },
  "included": [
    {
      "id": "aa8e3866-c31f-4a2c-a123-6cd52c2f19cf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T11:25:47+00:00",
        "updated_at": "2023-02-28T11:25:47+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=aa8e3866-c31f-4a2c-a123-6cd52c2f19cf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aa8e3866-c31f-4a2c-a123-6cd52c2f19cf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aa8e3866-c31f-4a2c-a123-6cd52c2f19cf&filter[owner_type]=customers"
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
          "owner_id": "8e6cb1ac-cf78-4777-b679-6d782a0ac970",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a0dbbd6d-e798-40bf-b19e-25dbc67f5d93",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T11:25:48+00:00",
      "updated_at": "2023-02-28T11:25:48+00:00",
      "number": "http://bqbl.it/a0dbbd6d-e798-40bf-b19e-25dbc67f5d93",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cd8139096a5e7241afea09e3c2db04d2/barcode/image/a0dbbd6d-e798-40bf-b19e-25dbc67f5d93/a34d47f3-4f55-46e5-9b50-853c603d2d9d.svg",
      "owner_id": "8e6cb1ac-cf78-4777-b679-6d782a0ac970",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7be615d5-a39a-4c7a-9a1c-00e1922d602c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7be615d5-a39a-4c7a-9a1c-00e1922d602c",
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
    "id": "7be615d5-a39a-4c7a-9a1c-00e1922d602c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T11:25:48+00:00",
      "updated_at": "2023-02-28T11:25:48+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f623fc82aa3b794a37845a01273400a3/barcode/image/7be615d5-a39a-4c7a-9a1c-00e1922d602c/15fba3da-03b8-4ba8-8d2f-fbb7335aab74.svg",
      "owner_id": "554d037d-2d8d-4070-a440-5f9a22ad6a1c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/aef02e9f-07ac-4e3b-8bc6-d408e7b4777f' \
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