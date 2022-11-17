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
      "id": "27edbbc2-7e2c-4732-bd24-ce43bf72fae0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-17T11:32:41+00:00",
        "updated_at": "2022-11-17T11:32:41+00:00",
        "number": "http://bqbl.it/27edbbc2-7e2c-4732-bd24-ce43bf72fae0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/007bc3231c037976ebd0d59ba04eb60a/barcode/image/27edbbc2-7e2c-4732-bd24-ce43bf72fae0/97d53dc8-e1a8-48ae-99f9-2369abb14353.svg",
        "owner_id": "8153429f-20f5-4120-bcee-3aad49186312",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8153429f-20f5-4120-bcee-3aad49186312"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F52333635-6d3c-4fd9-a8a9-1982a304d65e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "52333635-6d3c-4fd9-a8a9-1982a304d65e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-17T11:32:41+00:00",
        "updated_at": "2022-11-17T11:32:41+00:00",
        "number": "http://bqbl.it/52333635-6d3c-4fd9-a8a9-1982a304d65e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e6e28ae5135b6a856398823171d78290/barcode/image/52333635-6d3c-4fd9-a8a9-1982a304d65e/b68bb5e9-1cf3-4e2d-853d-5aa1adabed46.svg",
        "owner_id": "cf75221f-baac-4297-8f77-c67e960f80b1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cf75221f-baac-4297-8f77-c67e960f80b1"
          },
          "data": {
            "type": "customers",
            "id": "cf75221f-baac-4297-8f77-c67e960f80b1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cf75221f-baac-4297-8f77-c67e960f80b1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-17T11:32:41+00:00",
        "updated_at": "2022-11-17T11:32:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cf75221f-baac-4297-8f77-c67e960f80b1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cf75221f-baac-4297-8f77-c67e960f80b1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cf75221f-baac-4297-8f77-c67e960f80b1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTViMGU0YmQtMzE0MC00M2NjLThiZGQtYjI4OWNjNDM2Mzdk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "95b0e4bd-3140-43cc-8bdd-b289cc43637d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-17T11:32:42+00:00",
        "updated_at": "2022-11-17T11:32:42+00:00",
        "number": "http://bqbl.it/95b0e4bd-3140-43cc-8bdd-b289cc43637d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4ee861f895f4911a95437b74a3f5416a/barcode/image/95b0e4bd-3140-43cc-8bdd-b289cc43637d/c8005df2-9b55-497f-b77d-5a7f2ad4c436.svg",
        "owner_id": "522e99ee-9daa-4b29-8a90-ba4535d5bb56",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/522e99ee-9daa-4b29-8a90-ba4535d5bb56"
          },
          "data": {
            "type": "customers",
            "id": "522e99ee-9daa-4b29-8a90-ba4535d5bb56"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "522e99ee-9daa-4b29-8a90-ba4535d5bb56",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-17T11:32:42+00:00",
        "updated_at": "2022-11-17T11:32:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=522e99ee-9daa-4b29-8a90-ba4535d5bb56&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=522e99ee-9daa-4b29-8a90-ba4535d5bb56&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=522e99ee-9daa-4b29-8a90-ba4535d5bb56&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T11:32:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4d93ff1-56e1-4b00-8a7f-c6df6723ab09?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c4d93ff1-56e1-4b00-8a7f-c6df6723ab09",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-17T11:32:42+00:00",
      "updated_at": "2022-11-17T11:32:42+00:00",
      "number": "http://bqbl.it/c4d93ff1-56e1-4b00-8a7f-c6df6723ab09",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bdd2fbff3a71f5bdd27b0a15fff92d01/barcode/image/c4d93ff1-56e1-4b00-8a7f-c6df6723ab09/14bae70f-c7a6-4e73-8875-1de204c5c5b2.svg",
      "owner_id": "7db5697b-b889-415b-b2e7-867223b61ba9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7db5697b-b889-415b-b2e7-867223b61ba9"
        },
        "data": {
          "type": "customers",
          "id": "7db5697b-b889-415b-b2e7-867223b61ba9"
        }
      }
    }
  },
  "included": [
    {
      "id": "7db5697b-b889-415b-b2e7-867223b61ba9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-17T11:32:42+00:00",
        "updated_at": "2022-11-17T11:32:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7db5697b-b889-415b-b2e7-867223b61ba9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7db5697b-b889-415b-b2e7-867223b61ba9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7db5697b-b889-415b-b2e7-867223b61ba9&filter[owner_type]=customers"
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
          "owner_id": "324b2611-7005-47c5-a327-c94fba4a6bf0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b92e2ec9-1218-4157-8e83-8b6fca20af13",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-17T11:32:43+00:00",
      "updated_at": "2022-11-17T11:32:43+00:00",
      "number": "http://bqbl.it/b92e2ec9-1218-4157-8e83-8b6fca20af13",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dfbbdef109b7dfc1ecd943ce5112a82b/barcode/image/b92e2ec9-1218-4157-8e83-8b6fca20af13/b9db5826-5ff6-467a-9d66-56c03846ebf8.svg",
      "owner_id": "324b2611-7005-47c5-a327-c94fba4a6bf0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f73131b4-6868-4579-b79b-4f995bece52b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f73131b4-6868-4579-b79b-4f995bece52b",
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
    "id": "f73131b4-6868-4579-b79b-4f995bece52b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-17T11:32:43+00:00",
      "updated_at": "2022-11-17T11:32:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0c7f90ff66126a1c0b61e8e5b44a82c8/barcode/image/f73131b4-6868-4579-b79b-4f995bece52b/d4e1d98f-4c26-4432-91d4-eec7fc545891.svg",
      "owner_id": "11984aaf-006d-4a87-8f8c-47e222a84923",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c5f372be-9294-4678-a9f1-a0284099434b' \
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