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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "11586b04-8593-46e8-8c22-7920f85a2b22",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-08-22T15:50:19+00:00",
        "updated_at": "2022-08-22T15:50:19+00:00",
        "number": "http://bqbl.it/11586b04-8593-46e8-8c22-7920f85a2b22",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5d1af40febfce314b2a0f7bf5b8f6495/barcode/image/11586b04-8593-46e8-8c22-7920f85a2b22/97292b34-2202-4a78-84ab-9d5acd2923a1.svg",
        "owner_id": "9c51448f-0a59-4696-9610-9c40ef215538",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9c51448f-0a59-4696-9610-9c40ef215538"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff00c95a8-ba60-4b00-854f-640b0ac20a25&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f00c95a8-ba60-4b00-854f-640b0ac20a25",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-08-22T15:50:20+00:00",
        "updated_at": "2022-08-22T15:50:20+00:00",
        "number": "http://bqbl.it/f00c95a8-ba60-4b00-854f-640b0ac20a25",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e498910a3deb9ece73946885005eea80/barcode/image/f00c95a8-ba60-4b00-854f-640b0ac20a25/60860517-d8d3-48bd-8b79-e4587d2a6b6c.svg",
        "owner_id": "fc12fa8d-69b4-47af-a869-e14cd6de4025",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fc12fa8d-69b4-47af-a869-e14cd6de4025"
          },
          "data": {
            "type": "customers",
            "id": "fc12fa8d-69b4-47af-a869-e14cd6de4025"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fc12fa8d-69b4-47af-a869-e14cd6de4025",
      "type": "customers",
      "attributes": {
        "created_at": "2022-08-22T15:50:20+00:00",
        "updated_at": "2022-08-22T15:50:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fc12fa8d-69b4-47af-a869-e14cd6de4025&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fc12fa8d-69b4-47af-a869-e14cd6de4025&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fc12fa8d-69b4-47af-a869-e14cd6de4025&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2I1NjE2YzMtYzFiZS00YzRkLWFkZDctNDMzMWQzNzMxZjI5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3b5616c3-c1be-4c4d-add7-4331d3731f29",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-08-22T15:50:20+00:00",
        "updated_at": "2022-08-22T15:50:20+00:00",
        "number": "http://bqbl.it/3b5616c3-c1be-4c4d-add7-4331d3731f29",
        "barcode_type": "qr_code",
        "image_url": "/uploads/35619db7beb7630b2c378da335394400/barcode/image/3b5616c3-c1be-4c4d-add7-4331d3731f29/20a2d2e3-a51c-446d-a5d3-65ab6e5adfaa.svg",
        "owner_id": "754e1e43-6d38-4728-b506-18e2ba69a03c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/754e1e43-6d38-4728-b506-18e2ba69a03c"
          },
          "data": {
            "type": "customers",
            "id": "754e1e43-6d38-4728-b506-18e2ba69a03c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "754e1e43-6d38-4728-b506-18e2ba69a03c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-08-22T15:50:20+00:00",
        "updated_at": "2022-08-22T15:50:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=754e1e43-6d38-4728-b506-18e2ba69a03c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=754e1e43-6d38-4728-b506-18e2ba69a03c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=754e1e43-6d38-4728-b506-18e2ba69a03c&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-22T15:50:06Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/741ae019-8dbb-49da-a8a6-7e2e9379e3b7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "741ae019-8dbb-49da-a8a6-7e2e9379e3b7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-08-22T15:50:21+00:00",
      "updated_at": "2022-08-22T15:50:21+00:00",
      "number": "http://bqbl.it/741ae019-8dbb-49da-a8a6-7e2e9379e3b7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/34a59f382be28995a3a5889c379be172/barcode/image/741ae019-8dbb-49da-a8a6-7e2e9379e3b7/ec267d67-ac4c-4292-95e9-0b5f34a4af36.svg",
      "owner_id": "5239cce0-ef13-49ee-be03-d45b3f50e7c9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5239cce0-ef13-49ee-be03-d45b3f50e7c9"
        },
        "data": {
          "type": "customers",
          "id": "5239cce0-ef13-49ee-be03-d45b3f50e7c9"
        }
      }
    }
  },
  "included": [
    {
      "id": "5239cce0-ef13-49ee-be03-d45b3f50e7c9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-08-22T15:50:20+00:00",
        "updated_at": "2022-08-22T15:50:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5239cce0-ef13-49ee-be03-d45b3f50e7c9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5239cce0-ef13-49ee-be03-d45b3f50e7c9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5239cce0-ef13-49ee-be03-d45b3f50e7c9&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "ec1df4ff-2aea-43ef-bcee-9d55d28d3bbc",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d64eee6a-093e-48ba-8699-37cbb986620a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-08-22T15:50:21+00:00",
      "updated_at": "2022-08-22T15:50:21+00:00",
      "number": "http://bqbl.it/d64eee6a-093e-48ba-8699-37cbb986620a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/16b3f8d6934b4e6f94298686eaf652c6/barcode/image/d64eee6a-093e-48ba-8699-37cbb986620a/39710301-59a1-4981-99df-a17636e0e6a9.svg",
      "owner_id": "ec1df4ff-2aea-43ef-bcee-9d55d28d3bbc",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/03135129-8c2a-455e-9765-d5c9260a6422' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "03135129-8c2a-455e-9765-d5c9260a6422",
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
    "id": "03135129-8c2a-455e-9765-d5c9260a6422",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-08-22T15:50:21+00:00",
      "updated_at": "2022-08-22T15:50:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/30f549929f02ad41324e8a5618059cba/barcode/image/03135129-8c2a-455e-9765-d5c9260a6422/92c2d921-9a9a-4010-9fc9-cecddc03a6d0.svg",
      "owner_id": "ebc6fc1d-5581-4c68-9566-12d09cdcca42",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/87e30fb0-b16d-4c9d-a42a-194df679d25d' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes