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
      "id": "8ca326ae-bccb-4ca1-9034-fbb641f9bd09",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T19:25:12+00:00",
        "updated_at": "2023-02-02T19:25:12+00:00",
        "number": "http://bqbl.it/8ca326ae-bccb-4ca1-9034-fbb641f9bd09",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ff18f70ab21cb69cc00c69dff64421b3/barcode/image/8ca326ae-bccb-4ca1-9034-fbb641f9bd09/8a3b10b1-bf6e-4836-9a42-d85a20b1be51.svg",
        "owner_id": "7aa2779b-3a01-4287-902a-6ee31c42a2d0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7aa2779b-3a01-4287-902a-6ee31c42a2d0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fcfb6bc27-d45c-4a3e-a849-1c4f271b1977&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cfb6bc27-d45c-4a3e-a849-1c4f271b1977",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T19:25:12+00:00",
        "updated_at": "2023-02-02T19:25:12+00:00",
        "number": "http://bqbl.it/cfb6bc27-d45c-4a3e-a849-1c4f271b1977",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b7caa5387e7466cfeff4a22c78d18424/barcode/image/cfb6bc27-d45c-4a3e-a849-1c4f271b1977/4266ef3d-c661-4235-aa67-63a866ab53f7.svg",
        "owner_id": "5bac4f88-5688-4a3b-b1f4-12faa5d8072d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5bac4f88-5688-4a3b-b1f4-12faa5d8072d"
          },
          "data": {
            "type": "customers",
            "id": "5bac4f88-5688-4a3b-b1f4-12faa5d8072d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5bac4f88-5688-4a3b-b1f4-12faa5d8072d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T19:25:12+00:00",
        "updated_at": "2023-02-02T19:25:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5bac4f88-5688-4a3b-b1f4-12faa5d8072d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5bac4f88-5688-4a3b-b1f4-12faa5d8072d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5bac4f88-5688-4a3b-b1f4-12faa5d8072d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGVlOWQzZmEtZjI3MC00MTNlLTg1MWMtMDc1NTRhNTU1NWNk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dee9d3fa-f270-413e-851c-07554a5555cd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T19:25:13+00:00",
        "updated_at": "2023-02-02T19:25:13+00:00",
        "number": "http://bqbl.it/dee9d3fa-f270-413e-851c-07554a5555cd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c604d182af3c725df9b11dbd6bddffc5/barcode/image/dee9d3fa-f270-413e-851c-07554a5555cd/1999f2f6-1948-47b7-9365-d6eb022d4fa1.svg",
        "owner_id": "1cbde908-5e1e-44ca-969a-311e2fbd583b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1cbde908-5e1e-44ca-969a-311e2fbd583b"
          },
          "data": {
            "type": "customers",
            "id": "1cbde908-5e1e-44ca-969a-311e2fbd583b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1cbde908-5e1e-44ca-969a-311e2fbd583b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T19:25:13+00:00",
        "updated_at": "2023-02-02T19:25:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1cbde908-5e1e-44ca-969a-311e2fbd583b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1cbde908-5e1e-44ca-969a-311e2fbd583b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1cbde908-5e1e-44ca-969a-311e2fbd583b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T19:24:48Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bebc6df1-4c5b-47e6-bb96-759a1223121d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bebc6df1-4c5b-47e6-bb96-759a1223121d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T19:25:14+00:00",
      "updated_at": "2023-02-02T19:25:14+00:00",
      "number": "http://bqbl.it/bebc6df1-4c5b-47e6-bb96-759a1223121d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f309f67f76d9a12ea59e7e372b9325ab/barcode/image/bebc6df1-4c5b-47e6-bb96-759a1223121d/5ee1e1b6-9080-45a3-b455-77ba0670b7f0.svg",
      "owner_id": "64e7a0bf-be74-4073-8ed7-5c9b805c9296",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/64e7a0bf-be74-4073-8ed7-5c9b805c9296"
        },
        "data": {
          "type": "customers",
          "id": "64e7a0bf-be74-4073-8ed7-5c9b805c9296"
        }
      }
    }
  },
  "included": [
    {
      "id": "64e7a0bf-be74-4073-8ed7-5c9b805c9296",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T19:25:14+00:00",
        "updated_at": "2023-02-02T19:25:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=64e7a0bf-be74-4073-8ed7-5c9b805c9296&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=64e7a0bf-be74-4073-8ed7-5c9b805c9296&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=64e7a0bf-be74-4073-8ed7-5c9b805c9296&filter[owner_type]=customers"
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
          "owner_id": "1759a3b8-24eb-4010-b9f0-86019939c08d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f0363766-58ca-40af-9ad8-1d13bbdfaffc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T19:25:15+00:00",
      "updated_at": "2023-02-02T19:25:15+00:00",
      "number": "http://bqbl.it/f0363766-58ca-40af-9ad8-1d13bbdfaffc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2c697d63cd898e47060ba6c67fb4fbbd/barcode/image/f0363766-58ca-40af-9ad8-1d13bbdfaffc/5afd27db-20ff-4178-adb7-6e8d6e4d9e3f.svg",
      "owner_id": "1759a3b8-24eb-4010-b9f0-86019939c08d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/db169298-4f57-449b-a62e-08eb51383a39' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "db169298-4f57-449b-a62e-08eb51383a39",
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
    "id": "db169298-4f57-449b-a62e-08eb51383a39",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T19:25:15+00:00",
      "updated_at": "2023-02-02T19:25:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2ebb32a3688726ad0080033340015472/barcode/image/db169298-4f57-449b-a62e-08eb51383a39/6316c81f-665d-4b03-82a2-09b8287315bd.svg",
      "owner_id": "f7d3a06e-89d6-4713-91ba-f0a0bc74d28b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e0077a7a-3364-40e8-8252-a886617ab853' \
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