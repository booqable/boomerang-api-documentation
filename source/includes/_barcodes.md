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
`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd0b3508-c430-40db-85d9-c02e7a6c8d15' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dd0b3508-c430-40db-85d9-c02e7a6c8d15",
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
    "id": "dd0b3508-c430-40db-85d9-c02e7a6c8d15",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-22T09:16:02+00:00",
      "updated_at": "2024-01-22T09:16:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-69.shop.lvh.me:/barcodes/dd0b3508-c430-40db-85d9-c02e7a6c8d15/image",
      "owner_id": "678ef49a-d5ac-48fe-8228-2efc2d7d2c94",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cd563663-1ee7-4500-b07e-29487aa63e87' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/f25b0e75-7aff-4b6d-93ca-8a5f2a6cd476?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f25b0e75-7aff-4b6d-93ca-8a5f2a6cd476",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-22T09:16:07+00:00",
      "updated_at": "2024-01-22T09:16:07+00:00",
      "number": "http://bqbl.it/f25b0e75-7aff-4b6d-93ca-8a5f2a6cd476",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-71.shop.lvh.me:/barcodes/f25b0e75-7aff-4b6d-93ca-8a5f2a6cd476/image",
      "owner_id": "b5ac397e-bba8-4967-a7bc-db383de3a799",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b5ac397e-bba8-4967-a7bc-db383de3a799"
        },
        "data": {
          "type": "customers",
          "id": "b5ac397e-bba8-4967-a7bc-db383de3a799"
        }
      }
    }
  },
  "included": [
    {
      "id": "b5ac397e-bba8-4967-a7bc-db383de3a799",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-22T09:16:07+00:00",
        "updated_at": "2024-01-22T09:16:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-30@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=b5ac397e-bba8-4967-a7bc-db383de3a799&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b5ac397e-bba8-4967-a7bc-db383de3a799&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b5ac397e-bba8-4967-a7bc-db383de3a799&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


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
          "owner_id": "f0f382cf-2c54-451b-a04b-e8d21a3514ad",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "97723a4c-c3a7-4dcd-b7bf-4d5e519bee04",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-22T09:16:08+00:00",
      "updated_at": "2024-01-22T09:16:08+00:00",
      "number": "http://bqbl.it/97723a4c-c3a7-4dcd-b7bf-4d5e519bee04",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-72.shop.lvh.me:/barcodes/97723a4c-c3a7-4dcd-b7bf-4d5e519bee04/image",
      "owner_id": "f0f382cf-2c54-451b-a04b-e8d21a3514ad",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Listing barcodes



> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmRkNjk2NzItM2ZhZS00MjQ3LTk5NzQtMWY1MTFkMzYyMDRi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bdd69672-3fae-4247-9974-1f511d36204b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-22T09:16:09+00:00",
        "updated_at": "2024-01-22T09:16:09+00:00",
        "number": "http://bqbl.it/bdd69672-3fae-4247-9974-1f511d36204b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-73.shop.lvh.me:/barcodes/bdd69672-3fae-4247-9974-1f511d36204b/image",
        "owner_id": "ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06"
          },
          "data": {
            "type": "customers",
            "id": "ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-22T09:16:09+00:00",
        "updated_at": "2024-01-22T09:16:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-34@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ca2e1db2-3c7c-42d3-9f8e-3b6f0dee1c06&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Febf1ddec-1a8f-4ddd-b3b1-81ddd0b2c66e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ebf1ddec-1a8f-4ddd-b3b1-81ddd0b2c66e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-22T09:16:10+00:00",
        "updated_at": "2024-01-22T09:16:10+00:00",
        "number": "http://bqbl.it/ebf1ddec-1a8f-4ddd-b3b1-81ddd0b2c66e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-74.shop.lvh.me:/barcodes/ebf1ddec-1a8f-4ddd-b3b1-81ddd0b2c66e/image",
        "owner_id": "e8bb8596-7734-43fb-819b-f5deae16ab9b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e8bb8596-7734-43fb-819b-f5deae16ab9b"
          },
          "data": {
            "type": "customers",
            "id": "e8bb8596-7734-43fb-819b-f5deae16ab9b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e8bb8596-7734-43fb-819b-f5deae16ab9b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-22T09:16:09+00:00",
        "updated_at": "2024-01-22T09:16:10+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-35@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=e8bb8596-7734-43fb-819b-f5deae16ab9b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e8bb8596-7734-43fb-819b-f5deae16ab9b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e8bb8596-7734-43fb-819b-f5deae16ab9b&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "e6cfc035-8252-468e-add4-c46bf9e75b90",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-22T09:16:10+00:00",
        "updated_at": "2024-01-22T09:16:10+00:00",
        "number": "http://bqbl.it/e6cfc035-8252-468e-add4-c46bf9e75b90",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-75.shop.lvh.me:/barcodes/e6cfc035-8252-468e-add4-c46bf9e75b90/image",
        "owner_id": "c600a670-310e-4f03-b7d8-5bd78a679a7f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c600a670-310e-4f03-b7d8-5bd78a679a7f"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`





