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
      "id": "974bedfb-b12c-4760-9335-e178324a8f32",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-05-15T13:47:08+00:00",
        "updated_at": "2023-05-15T13:47:08+00:00",
        "number": "http://bqbl.it/974bedfb-b12c-4760-9335-e178324a8f32",
        "barcode_type": "qr_code",
        "image_url": "/uploads/14ca5cadf44d0eb0b6eab0c46c51a9e8/barcode/image/974bedfb-b12c-4760-9335-e178324a8f32/87578080-b209-406a-812f-63b2f587930f.svg",
        "owner_id": "5ae6a793-8672-4030-81cd-12df041e2ac4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5ae6a793-8672-4030-81cd-12df041e2ac4"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F26bf263e-5204-4fbd-9bf6-5ccd67c4f5d9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "26bf263e-5204-4fbd-9bf6-5ccd67c4f5d9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-05-15T13:47:09+00:00",
        "updated_at": "2023-05-15T13:47:09+00:00",
        "number": "http://bqbl.it/26bf263e-5204-4fbd-9bf6-5ccd67c4f5d9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8bae08e10afb7b5257b8ab24917c54b5/barcode/image/26bf263e-5204-4fbd-9bf6-5ccd67c4f5d9/21b7d9a4-d57e-4aeb-9461-55a9bf139d18.svg",
        "owner_id": "643b92a3-7b81-4916-b5bc-04e93e889139",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/643b92a3-7b81-4916-b5bc-04e93e889139"
          },
          "data": {
            "type": "customers",
            "id": "643b92a3-7b81-4916-b5bc-04e93e889139"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "643b92a3-7b81-4916-b5bc-04e93e889139",
      "type": "customers",
      "attributes": {
        "created_at": "2023-05-15T13:47:09+00:00",
        "updated_at": "2023-05-15T13:47:09+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=643b92a3-7b81-4916-b5bc-04e93e889139&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=643b92a3-7b81-4916-b5bc-04e93e889139&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=643b92a3-7b81-4916-b5bc-04e93e889139&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzkzYmExOTMtZmUwZS00M2Q5LThmMDUtNzBhYjRiMWZkOTQy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "393ba193-fe0e-43d9-8f05-70ab4b1fd942",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-05-15T13:47:10+00:00",
        "updated_at": "2023-05-15T13:47:10+00:00",
        "number": "http://bqbl.it/393ba193-fe0e-43d9-8f05-70ab4b1fd942",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c4f9775bd6498edbb7d56acd76bb75b8/barcode/image/393ba193-fe0e-43d9-8f05-70ab4b1fd942/2aa47c38-d7c9-4563-8c3b-506ccd65806f.svg",
        "owner_id": "9139e5e6-fcfa-45c7-9abb-efb9a0428821",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9139e5e6-fcfa-45c7-9abb-efb9a0428821"
          },
          "data": {
            "type": "customers",
            "id": "9139e5e6-fcfa-45c7-9abb-efb9a0428821"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9139e5e6-fcfa-45c7-9abb-efb9a0428821",
      "type": "customers",
      "attributes": {
        "created_at": "2023-05-15T13:47:10+00:00",
        "updated_at": "2023-05-15T13:47:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9139e5e6-fcfa-45c7-9abb-efb9a0428821&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9139e5e6-fcfa-45c7-9abb-efb9a0428821&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9139e5e6-fcfa-45c7-9abb-efb9a0428821&filter[owner_type]=customers"
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






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/225a785a-26f1-4478-9f5d-1222ad635479?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "225a785a-26f1-4478-9f5d-1222ad635479",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-05-15T13:47:14+00:00",
      "updated_at": "2023-05-15T13:47:14+00:00",
      "number": "http://bqbl.it/225a785a-26f1-4478-9f5d-1222ad635479",
      "barcode_type": "qr_code",
      "image_url": "/uploads/604231d71a838daa69809db630e6aeef/barcode/image/225a785a-26f1-4478-9f5d-1222ad635479/b195ebe7-9084-4241-949a-d5c4aac4907c.svg",
      "owner_id": "002447ce-30ea-4184-8b04-27815771b99e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/002447ce-30ea-4184-8b04-27815771b99e"
        },
        "data": {
          "type": "customers",
          "id": "002447ce-30ea-4184-8b04-27815771b99e"
        }
      }
    }
  },
  "included": [
    {
      "id": "002447ce-30ea-4184-8b04-27815771b99e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-05-15T13:47:14+00:00",
        "updated_at": "2023-05-15T13:47:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=002447ce-30ea-4184-8b04-27815771b99e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=002447ce-30ea-4184-8b04-27815771b99e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=002447ce-30ea-4184-8b04-27815771b99e&filter[owner_type]=customers"
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
          "owner_id": "43864b8c-4a5d-4534-8d8f-333eb9e475ff",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "14993b49-416a-485e-95d1-0c58670338ae",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-05-15T13:47:15+00:00",
      "updated_at": "2023-05-15T13:47:15+00:00",
      "number": "http://bqbl.it/14993b49-416a-485e-95d1-0c58670338ae",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1ca3ed81a03d8b0e59995f2de4a3ef86/barcode/image/14993b49-416a-485e-95d1-0c58670338ae/a4a9e282-ca80-4e26-bd74-d39a9d3cf8f8.svg",
      "owner_id": "43864b8c-4a5d-4534-8d8f-333eb9e475ff",
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e6519330-8443-4b2d-8f4f-8e96b75f9457' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e6519330-8443-4b2d-8f4f-8e96b75f9457",
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
    "id": "e6519330-8443-4b2d-8f4f-8e96b75f9457",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-05-15T13:47:15+00:00",
      "updated_at": "2023-05-15T13:47:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ca87cee777b9be929a2a88c8e3242a3e/barcode/image/e6519330-8443-4b2d-8f4f-8e96b75f9457/8d45a172-290f-4ac7-bb1c-42305773d703.svg",
      "owner_id": "5a94ec4d-07ad-4126-88dd-e654dc906e13",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d54ee157-5ce1-4428-a069-a3ccb9212847' \
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