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
      "id": "5fefe130-8919-45ce-a7c0-635c0bdeba8e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T14:58:01+00:00",
        "updated_at": "2022-10-25T14:58:01+00:00",
        "number": "http://bqbl.it/5fefe130-8919-45ce-a7c0-635c0bdeba8e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2d88f920329577d6f5b5ecf3b456349d/barcode/image/5fefe130-8919-45ce-a7c0-635c0bdeba8e/77b1fcf6-17e0-4bf1-ac65-c21e0fd543a6.svg",
        "owner_id": "d54ac9d4-efeb-4b95-8c00-52d2eb171c02",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d54ac9d4-efeb-4b95-8c00-52d2eb171c02"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbafd572a-716e-4449-b755-9729d3ba9963&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bafd572a-716e-4449-b755-9729d3ba9963",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T14:58:01+00:00",
        "updated_at": "2022-10-25T14:58:01+00:00",
        "number": "http://bqbl.it/bafd572a-716e-4449-b755-9729d3ba9963",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a7926109171bd4448fc07460e227aeda/barcode/image/bafd572a-716e-4449-b755-9729d3ba9963/c3d1b3e5-beff-4e23-a7be-bb4741991694.svg",
        "owner_id": "fbd2b212-30ea-46ae-829d-204fedbef0b1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fbd2b212-30ea-46ae-829d-204fedbef0b1"
          },
          "data": {
            "type": "customers",
            "id": "fbd2b212-30ea-46ae-829d-204fedbef0b1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fbd2b212-30ea-46ae-829d-204fedbef0b1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T14:58:01+00:00",
        "updated_at": "2022-10-25T14:58:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fbd2b212-30ea-46ae-829d-204fedbef0b1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fbd2b212-30ea-46ae-829d-204fedbef0b1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fbd2b212-30ea-46ae-829d-204fedbef0b1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDE5MGEwZTUtYTU4ZS00ZTE4LWEwMWQtODU1YmQ5OTc3YmRk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0190a0e5-a58e-4e18-a01d-855bd9977bdd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T14:58:02+00:00",
        "updated_at": "2022-10-25T14:58:02+00:00",
        "number": "http://bqbl.it/0190a0e5-a58e-4e18-a01d-855bd9977bdd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2d422777f4bfe43a3f9cba4c71298fe5/barcode/image/0190a0e5-a58e-4e18-a01d-855bd9977bdd/c0dca3c0-afbe-45af-83b6-7efc80fb23e8.svg",
        "owner_id": "20000ac1-9f40-48ac-92e6-678d37862d3c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/20000ac1-9f40-48ac-92e6-678d37862d3c"
          },
          "data": {
            "type": "customers",
            "id": "20000ac1-9f40-48ac-92e6-678d37862d3c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "20000ac1-9f40-48ac-92e6-678d37862d3c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T14:58:02+00:00",
        "updated_at": "2022-10-25T14:58:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=20000ac1-9f40-48ac-92e6-678d37862d3c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=20000ac1-9f40-48ac-92e6-678d37862d3c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=20000ac1-9f40-48ac-92e6-678d37862d3c&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T14:57:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/46295e90-6408-462f-a3f8-3335ae399409?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "46295e90-6408-462f-a3f8-3335ae399409",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T14:58:02+00:00",
      "updated_at": "2022-10-25T14:58:02+00:00",
      "number": "http://bqbl.it/46295e90-6408-462f-a3f8-3335ae399409",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d2f65f5ed0f23bb0e8e7f38a543f3ace/barcode/image/46295e90-6408-462f-a3f8-3335ae399409/df314408-f1e4-4259-ba45-88eaf1d0771c.svg",
      "owner_id": "b1b7e44e-feef-49d5-af03-499acd17a5ed",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b1b7e44e-feef-49d5-af03-499acd17a5ed"
        },
        "data": {
          "type": "customers",
          "id": "b1b7e44e-feef-49d5-af03-499acd17a5ed"
        }
      }
    }
  },
  "included": [
    {
      "id": "b1b7e44e-feef-49d5-af03-499acd17a5ed",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T14:58:02+00:00",
        "updated_at": "2022-10-25T14:58:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b1b7e44e-feef-49d5-af03-499acd17a5ed&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b1b7e44e-feef-49d5-af03-499acd17a5ed&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b1b7e44e-feef-49d5-af03-499acd17a5ed&filter[owner_type]=customers"
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
          "owner_id": "6bfbf567-ee33-470c-a5d8-30ef84ee9a10",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2983587a-f7cb-4150-bb86-800a0b1191ca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T14:58:03+00:00",
      "updated_at": "2022-10-25T14:58:03+00:00",
      "number": "http://bqbl.it/2983587a-f7cb-4150-bb86-800a0b1191ca",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3f7072db02f05ab2c8ceaa774e68ecab/barcode/image/2983587a-f7cb-4150-bb86-800a0b1191ca/835d94d5-b08c-4ec4-b110-5d6786a71ad3.svg",
      "owner_id": "6bfbf567-ee33-470c-a5d8-30ef84ee9a10",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/836ba11e-70e2-43d6-b58c-23b2ef3ee72e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "836ba11e-70e2-43d6-b58c-23b2ef3ee72e",
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
    "id": "836ba11e-70e2-43d6-b58c-23b2ef3ee72e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T14:58:04+00:00",
      "updated_at": "2022-10-25T14:58:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/14bf14f4cbf416c85992324d55bca2a3/barcode/image/836ba11e-70e2-43d6-b58c-23b2ef3ee72e/c40a8917-c106-4ef0-8a90-86e40dcc554a.svg",
      "owner_id": "6c0e037c-2d73-4626-b8bb-aa5ace010a4c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d415336e-7416-45dc-8127-9b22bbd5ab05' \
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