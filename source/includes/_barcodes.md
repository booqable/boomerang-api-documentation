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
      "id": "0b7f09db-5ef9-46a8-821d-c2faa9cc2a3d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T10:26:37+00:00",
        "updated_at": "2023-03-09T10:26:37+00:00",
        "number": "http://bqbl.it/0b7f09db-5ef9-46a8-821d-c2faa9cc2a3d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8afb10b4d0eea07bf833668ba851488c/barcode/image/0b7f09db-5ef9-46a8-821d-c2faa9cc2a3d/835991c1-1b7d-4505-a79b-053b2eae398c.svg",
        "owner_id": "9d3dee38-2b8f-47fe-a4fd-441271178b0e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9d3dee38-2b8f-47fe-a4fd-441271178b0e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3ae5d897-d07d-47c9-8f76-f12e433de5ee&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3ae5d897-d07d-47c9-8f76-f12e433de5ee",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T10:26:38+00:00",
        "updated_at": "2023-03-09T10:26:38+00:00",
        "number": "http://bqbl.it/3ae5d897-d07d-47c9-8f76-f12e433de5ee",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b489c361d5dc311a8950be6f6eb141d4/barcode/image/3ae5d897-d07d-47c9-8f76-f12e433de5ee/3ffa085b-f0aa-480a-a2af-ccc0cc89a249.svg",
        "owner_id": "99a7a7bd-9b4b-4871-bf3f-f13684dce134",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/99a7a7bd-9b4b-4871-bf3f-f13684dce134"
          },
          "data": {
            "type": "customers",
            "id": "99a7a7bd-9b4b-4871-bf3f-f13684dce134"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "99a7a7bd-9b4b-4871-bf3f-f13684dce134",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T10:26:38+00:00",
        "updated_at": "2023-03-09T10:26:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=99a7a7bd-9b4b-4871-bf3f-f13684dce134&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=99a7a7bd-9b4b-4871-bf3f-f13684dce134&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=99a7a7bd-9b4b-4871-bf3f-f13684dce134&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGUyMjg4NGMtNjk3ZC00NzhhLTk3MjAtN2NiZjMyZWU0N2Rl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4e22884c-697d-478a-9720-7cbf32ee47de",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T10:26:39+00:00",
        "updated_at": "2023-03-09T10:26:39+00:00",
        "number": "http://bqbl.it/4e22884c-697d-478a-9720-7cbf32ee47de",
        "barcode_type": "qr_code",
        "image_url": "/uploads/19fd6f59cf007bbd8a2d93c1363d310f/barcode/image/4e22884c-697d-478a-9720-7cbf32ee47de/b48b9fe2-76be-42c7-b57f-66dd3f3b03c4.svg",
        "owner_id": "a23ec934-6ca7-4160-841b-44d32fe60845",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a23ec934-6ca7-4160-841b-44d32fe60845"
          },
          "data": {
            "type": "customers",
            "id": "a23ec934-6ca7-4160-841b-44d32fe60845"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a23ec934-6ca7-4160-841b-44d32fe60845",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T10:26:39+00:00",
        "updated_at": "2023-03-09T10:26:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a23ec934-6ca7-4160-841b-44d32fe60845&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a23ec934-6ca7-4160-841b-44d32fe60845&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a23ec934-6ca7-4160-841b-44d32fe60845&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T10:26:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9451f47c-c30d-4a76-9840-2b4a977bdb8c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9451f47c-c30d-4a76-9840-2b4a977bdb8c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T10:26:40+00:00",
      "updated_at": "2023-03-09T10:26:40+00:00",
      "number": "http://bqbl.it/9451f47c-c30d-4a76-9840-2b4a977bdb8c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c7ca5b4cfafc0aba3aa9bf434b353e1b/barcode/image/9451f47c-c30d-4a76-9840-2b4a977bdb8c/1d151c67-3d1f-42d0-908a-f94de6459149.svg",
      "owner_id": "47688fbc-5f98-4065-84af-337b7e831ce5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/47688fbc-5f98-4065-84af-337b7e831ce5"
        },
        "data": {
          "type": "customers",
          "id": "47688fbc-5f98-4065-84af-337b7e831ce5"
        }
      }
    }
  },
  "included": [
    {
      "id": "47688fbc-5f98-4065-84af-337b7e831ce5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T10:26:40+00:00",
        "updated_at": "2023-03-09T10:26:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=47688fbc-5f98-4065-84af-337b7e831ce5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=47688fbc-5f98-4065-84af-337b7e831ce5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=47688fbc-5f98-4065-84af-337b7e831ce5&filter[owner_type]=customers"
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
          "owner_id": "88153dc3-3c85-413c-85ea-41286f29d36b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dcba419f-7d59-42f9-a131-875c4060738b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T10:26:41+00:00",
      "updated_at": "2023-03-09T10:26:41+00:00",
      "number": "http://bqbl.it/dcba419f-7d59-42f9-a131-875c4060738b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b2252e0e721c013eb70ef5569d229848/barcode/image/dcba419f-7d59-42f9-a131-875c4060738b/cc21fb3d-e372-4a80-9975-88566d5af6fd.svg",
      "owner_id": "88153dc3-3c85-413c-85ea-41286f29d36b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2f704823-a540-4cf0-ac6e-857ac0e4afb4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2f704823-a540-4cf0-ac6e-857ac0e4afb4",
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
    "id": "2f704823-a540-4cf0-ac6e-857ac0e4afb4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T10:26:41+00:00",
      "updated_at": "2023-03-09T10:26:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/48e61a473ac1f9836d1ad694649c6935/barcode/image/2f704823-a540-4cf0-ac6e-857ac0e4afb4/7edd5f64-20e6-474f-a31d-2ad8081e5477.svg",
      "owner_id": "8d69297a-988a-43ce-9e20-599c883fef1d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fedd360f-ef5f-4e5a-a232-19fb9f0ff3a6' \
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