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
      "id": "72a61868-6d12-41d6-a175-fc465ecdca64",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T09:46:39+00:00",
        "updated_at": "2023-02-24T09:46:39+00:00",
        "number": "http://bqbl.it/72a61868-6d12-41d6-a175-fc465ecdca64",
        "barcode_type": "qr_code",
        "image_url": "/uploads/15b2069fe8ec716f8f302cfd649fd288/barcode/image/72a61868-6d12-41d6-a175-fc465ecdca64/9f575e5a-77ca-422a-98be-b484c611fe9c.svg",
        "owner_id": "0b5b2a67-f2ea-4990-b258-753308ea8afd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0b5b2a67-f2ea-4990-b258-753308ea8afd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0700be0e-caa8-4f55-a1ac-6f32dc09dae5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0700be0e-caa8-4f55-a1ac-6f32dc09dae5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T09:46:39+00:00",
        "updated_at": "2023-02-24T09:46:39+00:00",
        "number": "http://bqbl.it/0700be0e-caa8-4f55-a1ac-6f32dc09dae5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/98b5523649ee6d8b895957c2ddb4d2fa/barcode/image/0700be0e-caa8-4f55-a1ac-6f32dc09dae5/d373ab8c-2299-4b10-a170-6adf4990cc00.svg",
        "owner_id": "b0882da3-1a89-4b22-96d8-8586abbe0757",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0882da3-1a89-4b22-96d8-8586abbe0757"
          },
          "data": {
            "type": "customers",
            "id": "b0882da3-1a89-4b22-96d8-8586abbe0757"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b0882da3-1a89-4b22-96d8-8586abbe0757",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T09:46:39+00:00",
        "updated_at": "2023-02-24T09:46:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b0882da3-1a89-4b22-96d8-8586abbe0757&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b0882da3-1a89-4b22-96d8-8586abbe0757&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b0882da3-1a89-4b22-96d8-8586abbe0757&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZmI3NmVkNWUtODQ4OC00ZDM0LWE5NjUtNjc2ZDJjYzJkYmNk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fb76ed5e-8488-4d34-a965-676d2cc2dbcd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T09:46:40+00:00",
        "updated_at": "2023-02-24T09:46:40+00:00",
        "number": "http://bqbl.it/fb76ed5e-8488-4d34-a965-676d2cc2dbcd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/276d3e648c73d664034f9f47824afe55/barcode/image/fb76ed5e-8488-4d34-a965-676d2cc2dbcd/68fb5ab9-9ead-43ab-a9f6-fbd5f18fd748.svg",
        "owner_id": "ba82213c-4609-4c8d-b77f-94e951d9709b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ba82213c-4609-4c8d-b77f-94e951d9709b"
          },
          "data": {
            "type": "customers",
            "id": "ba82213c-4609-4c8d-b77f-94e951d9709b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ba82213c-4609-4c8d-b77f-94e951d9709b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T09:46:40+00:00",
        "updated_at": "2023-02-24T09:46:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ba82213c-4609-4c8d-b77f-94e951d9709b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ba82213c-4609-4c8d-b77f-94e951d9709b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ba82213c-4609-4c8d-b77f-94e951d9709b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b4469d48-13cd-41ea-9a82-bce1d41ab390?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b4469d48-13cd-41ea-9a82-bce1d41ab390",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T09:46:41+00:00",
      "updated_at": "2023-02-24T09:46:41+00:00",
      "number": "http://bqbl.it/b4469d48-13cd-41ea-9a82-bce1d41ab390",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e97316bca9ee8e4031bd01580a5eaf37/barcode/image/b4469d48-13cd-41ea-9a82-bce1d41ab390/409aedcb-7ede-4572-b51e-1d1378b4de06.svg",
      "owner_id": "ec46c688-e44f-4c8e-bb99-4241d26b94ff",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ec46c688-e44f-4c8e-bb99-4241d26b94ff"
        },
        "data": {
          "type": "customers",
          "id": "ec46c688-e44f-4c8e-bb99-4241d26b94ff"
        }
      }
    }
  },
  "included": [
    {
      "id": "ec46c688-e44f-4c8e-bb99-4241d26b94ff",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T09:46:40+00:00",
        "updated_at": "2023-02-24T09:46:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ec46c688-e44f-4c8e-bb99-4241d26b94ff&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ec46c688-e44f-4c8e-bb99-4241d26b94ff&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ec46c688-e44f-4c8e-bb99-4241d26b94ff&filter[owner_type]=customers"
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
          "owner_id": "54590a95-a0d2-493e-80d9-785ebb304f4c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b9732500-1c66-47fd-af52-d9e6d646d90c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T09:46:41+00:00",
      "updated_at": "2023-02-24T09:46:41+00:00",
      "number": "http://bqbl.it/b9732500-1c66-47fd-af52-d9e6d646d90c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/60d7ed7f70171ed3ad5b8d926715935e/barcode/image/b9732500-1c66-47fd-af52-d9e6d646d90c/85dff64c-6122-4ac1-8e64-49a1e08998c8.svg",
      "owner_id": "54590a95-a0d2-493e-80d9-785ebb304f4c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/15d7a5bd-ee39-45bb-b1d6-dc761eb1fe73' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "15d7a5bd-ee39-45bb-b1d6-dc761eb1fe73",
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
    "id": "15d7a5bd-ee39-45bb-b1d6-dc761eb1fe73",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T09:46:42+00:00",
      "updated_at": "2023-02-24T09:46:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b14be34491d6d7cd9ab9f5850e94e1a5/barcode/image/15d7a5bd-ee39-45bb-b1d6-dc761eb1fe73/2b9607ad-ae96-4770-98aa-1eb715f7006f.svg",
      "owner_id": "e92ead85-8276-4207-b132-25a1b8594d9b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eb3fe0fd-ff4c-434a-8a3b-12f7fa19b7ec' \
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