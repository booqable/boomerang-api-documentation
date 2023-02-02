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
      "id": "84a56d67-f5c0-4227-93f0-c163d92746f6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T07:55:35+00:00",
        "updated_at": "2023-02-02T07:55:35+00:00",
        "number": "http://bqbl.it/84a56d67-f5c0-4227-93f0-c163d92746f6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a6ef2cb75e4114b1a30736274e6c0cdb/barcode/image/84a56d67-f5c0-4227-93f0-c163d92746f6/fd8904c3-f996-4de7-869c-9dc4758fbc57.svg",
        "owner_id": "d86b64f5-aa1f-4adf-8bba-20a1c886b4db",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d86b64f5-aa1f-4adf-8bba-20a1c886b4db"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F155625b4-1ea5-4cca-8218-7c97beabe94b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "155625b4-1ea5-4cca-8218-7c97beabe94b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T07:55:35+00:00",
        "updated_at": "2023-02-02T07:55:35+00:00",
        "number": "http://bqbl.it/155625b4-1ea5-4cca-8218-7c97beabe94b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8b52e924e9f8ddc387dd9af11bcb3347/barcode/image/155625b4-1ea5-4cca-8218-7c97beabe94b/19627645-b294-45e5-908f-b3b99ac77444.svg",
        "owner_id": "ea0c697e-d919-4fc3-a65c-92d64a4e2a50",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ea0c697e-d919-4fc3-a65c-92d64a4e2a50"
          },
          "data": {
            "type": "customers",
            "id": "ea0c697e-d919-4fc3-a65c-92d64a4e2a50"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ea0c697e-d919-4fc3-a65c-92d64a4e2a50",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T07:55:35+00:00",
        "updated_at": "2023-02-02T07:55:35+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ea0c697e-d919-4fc3-a65c-92d64a4e2a50&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ea0c697e-d919-4fc3-a65c-92d64a4e2a50&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ea0c697e-d919-4fc3-a65c-92d64a4e2a50&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDcxMTFiYmUtN2U1MC00ODhhLWI3ODQtY2I2YTg0NmNhZDk5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "07111bbe-7e50-488a-b784-cb6a846cad99",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T07:55:36+00:00",
        "updated_at": "2023-02-02T07:55:36+00:00",
        "number": "http://bqbl.it/07111bbe-7e50-488a-b784-cb6a846cad99",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7568d4aca283fa9d94f6da64aa0820c7/barcode/image/07111bbe-7e50-488a-b784-cb6a846cad99/d9f04d06-beae-4f9f-bc3d-ad7e10afa464.svg",
        "owner_id": "0e6fb25a-f922-4b32-94fe-ff743076c53f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0e6fb25a-f922-4b32-94fe-ff743076c53f"
          },
          "data": {
            "type": "customers",
            "id": "0e6fb25a-f922-4b32-94fe-ff743076c53f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0e6fb25a-f922-4b32-94fe-ff743076c53f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T07:55:36+00:00",
        "updated_at": "2023-02-02T07:55:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0e6fb25a-f922-4b32-94fe-ff743076c53f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0e6fb25a-f922-4b32-94fe-ff743076c53f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0e6fb25a-f922-4b32-94fe-ff743076c53f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T07:55:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0196d477-46eb-4aa4-b741-5b9f39725a23?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0196d477-46eb-4aa4-b741-5b9f39725a23",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T07:55:36+00:00",
      "updated_at": "2023-02-02T07:55:36+00:00",
      "number": "http://bqbl.it/0196d477-46eb-4aa4-b741-5b9f39725a23",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f7696342ce6dceec45d825b5b9c344b0/barcode/image/0196d477-46eb-4aa4-b741-5b9f39725a23/61edc1f0-dbc3-45eb-8beb-cb4eeb695402.svg",
      "owner_id": "5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c"
        },
        "data": {
          "type": "customers",
          "id": "5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c"
        }
      }
    }
  },
  "included": [
    {
      "id": "5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T07:55:36+00:00",
        "updated_at": "2023-02-02T07:55:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5eb11c47-46d8-4c7b-96eb-e1ab76fcc89c&filter[owner_type]=customers"
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
          "owner_id": "cf4d17b1-ccb9-4fad-933f-61f9b049d90a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "eb221e09-3a28-4b57-998e-32552f35dae4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T07:55:37+00:00",
      "updated_at": "2023-02-02T07:55:37+00:00",
      "number": "http://bqbl.it/eb221e09-3a28-4b57-998e-32552f35dae4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5b20c7f0f5b2fe59a05462309f23a9cf/barcode/image/eb221e09-3a28-4b57-998e-32552f35dae4/777e3289-f0b1-410a-bc53-4b8007893663.svg",
      "owner_id": "cf4d17b1-ccb9-4fad-933f-61f9b049d90a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/783b3560-aa35-45aa-b715-ee3f68c31175' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "783b3560-aa35-45aa-b715-ee3f68c31175",
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
    "id": "783b3560-aa35-45aa-b715-ee3f68c31175",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T07:55:37+00:00",
      "updated_at": "2023-02-02T07:55:37+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6d099c8110b90867d33ec1cc1ade9d67/barcode/image/783b3560-aa35-45aa-b715-ee3f68c31175/21f17c6e-2c71-4c53-a210-9444d98f6b88.svg",
      "owner_id": "a561d650-a455-4588-8d5a-fec63777170f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9ef8e91b-60fb-48ed-90b1-20082154a3d8' \
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