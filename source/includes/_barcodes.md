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
      "id": "23f4ed8a-5c9c-4884-b9d3-70068605a779",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T11:25:59+00:00",
        "updated_at": "2023-01-05T11:25:59+00:00",
        "number": "http://bqbl.it/23f4ed8a-5c9c-4884-b9d3-70068605a779",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5613cf497bd668419b2a1eb762881849/barcode/image/23f4ed8a-5c9c-4884-b9d3-70068605a779/7e5ab8b3-6214-4339-aa0e-815af04dfc85.svg",
        "owner_id": "7bb06973-037e-4321-95a0-b7e69ba8dd99",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7bb06973-037e-4321-95a0-b7e69ba8dd99"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb2b175d5-2c4a-47d9-9c53-3992446e0a05&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b2b175d5-2c4a-47d9-9c53-3992446e0a05",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T11:25:59+00:00",
        "updated_at": "2023-01-05T11:25:59+00:00",
        "number": "http://bqbl.it/b2b175d5-2c4a-47d9-9c53-3992446e0a05",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5cbb0ad89678b0c9e7a004de9ea06bc8/barcode/image/b2b175d5-2c4a-47d9-9c53-3992446e0a05/96bb2446-95de-4911-b249-b3426838007c.svg",
        "owner_id": "35a1535b-559e-460b-948a-8f9502ead7b3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/35a1535b-559e-460b-948a-8f9502ead7b3"
          },
          "data": {
            "type": "customers",
            "id": "35a1535b-559e-460b-948a-8f9502ead7b3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "35a1535b-559e-460b-948a-8f9502ead7b3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T11:25:59+00:00",
        "updated_at": "2023-01-05T11:25:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=35a1535b-559e-460b-948a-8f9502ead7b3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=35a1535b-559e-460b-948a-8f9502ead7b3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=35a1535b-559e-460b-948a-8f9502ead7b3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTUzNjZhZGUtNWVmOS00NzgyLWIyYzQtMjVlOGJlYzYzNGYy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "15366ade-5ef9-4782-b2c4-25e8bec634f2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T11:26:00+00:00",
        "updated_at": "2023-01-05T11:26:00+00:00",
        "number": "http://bqbl.it/15366ade-5ef9-4782-b2c4-25e8bec634f2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/284777893f07ecdcaafd9b76d79673ca/barcode/image/15366ade-5ef9-4782-b2c4-25e8bec634f2/ff86c2f1-3143-40c1-85a4-760e71a75325.svg",
        "owner_id": "37642be5-d15b-4357-8b06-a6f7b6538305",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/37642be5-d15b-4357-8b06-a6f7b6538305"
          },
          "data": {
            "type": "customers",
            "id": "37642be5-d15b-4357-8b06-a6f7b6538305"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "37642be5-d15b-4357-8b06-a6f7b6538305",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T11:26:00+00:00",
        "updated_at": "2023-01-05T11:26:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=37642be5-d15b-4357-8b06-a6f7b6538305&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=37642be5-d15b-4357-8b06-a6f7b6538305&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=37642be5-d15b-4357-8b06-a6f7b6538305&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:25:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/527ec8c4-200f-40b4-b116-aec3583294f4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "527ec8c4-200f-40b4-b116-aec3583294f4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T11:26:01+00:00",
      "updated_at": "2023-01-05T11:26:01+00:00",
      "number": "http://bqbl.it/527ec8c4-200f-40b4-b116-aec3583294f4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ad1e439c1d523eecc3288734858a6c91/barcode/image/527ec8c4-200f-40b4-b116-aec3583294f4/d2d2c269-6176-4f43-b99b-678b281297d1.svg",
      "owner_id": "b8490ade-79e5-4cc6-93df-cc1da31d7f03",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b8490ade-79e5-4cc6-93df-cc1da31d7f03"
        },
        "data": {
          "type": "customers",
          "id": "b8490ade-79e5-4cc6-93df-cc1da31d7f03"
        }
      }
    }
  },
  "included": [
    {
      "id": "b8490ade-79e5-4cc6-93df-cc1da31d7f03",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T11:26:01+00:00",
        "updated_at": "2023-01-05T11:26:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b8490ade-79e5-4cc6-93df-cc1da31d7f03&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b8490ade-79e5-4cc6-93df-cc1da31d7f03&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b8490ade-79e5-4cc6-93df-cc1da31d7f03&filter[owner_type]=customers"
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
          "owner_id": "fc4186b8-835b-4fb6-81e5-ceafa7d19366",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "54c18277-6d7d-4e0d-9cf0-3fd0f57dc1e0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T11:26:02+00:00",
      "updated_at": "2023-01-05T11:26:02+00:00",
      "number": "http://bqbl.it/54c18277-6d7d-4e0d-9cf0-3fd0f57dc1e0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4257ac91cbe0cc40fbfe1d3bd23d9c9b/barcode/image/54c18277-6d7d-4e0d-9cf0-3fd0f57dc1e0/ca0657db-cc0b-4ee0-a1c9-01ad206c0a4d.svg",
      "owner_id": "fc4186b8-835b-4fb6-81e5-ceafa7d19366",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a3663835-3131-4c2b-a503-be63757cfc85' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3663835-3131-4c2b-a503-be63757cfc85",
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
    "id": "a3663835-3131-4c2b-a503-be63757cfc85",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T11:26:03+00:00",
      "updated_at": "2023-01-05T11:26:03+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ec902b7d3c7c1529e7539bd530eda688/barcode/image/a3663835-3131-4c2b-a503-be63757cfc85/33bc5f93-ac04-4253-b5ae-22656ca396e6.svg",
      "owner_id": "3d283e6a-53a4-45c6-a314-b5e19fba56be",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/38bc3c8c-a4c1-4fa1-bf6d-ef48e9693a38' \
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