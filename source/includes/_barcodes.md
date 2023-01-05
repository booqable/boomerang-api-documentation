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
      "id": "f4917d90-4f4d-42bf-896b-1d970a4914d6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T11:02:45+00:00",
        "updated_at": "2023-01-05T11:02:45+00:00",
        "number": "http://bqbl.it/f4917d90-4f4d-42bf-896b-1d970a4914d6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/73abdb662c20efc2f36e52d5133512a9/barcode/image/f4917d90-4f4d-42bf-896b-1d970a4914d6/1a4a827d-8f5f-4779-93bf-0c653bf221b6.svg",
        "owner_id": "c3bda27f-7cc3-4329-9a90-594910fd1c38",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c3bda27f-7cc3-4329-9a90-594910fd1c38"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ea6c8fa-f988-4d59-ace0-1c9564ca7d79&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8ea6c8fa-f988-4d59-ace0-1c9564ca7d79",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T11:02:45+00:00",
        "updated_at": "2023-01-05T11:02:45+00:00",
        "number": "http://bqbl.it/8ea6c8fa-f988-4d59-ace0-1c9564ca7d79",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ac42c30fd2d86336e1e834406ecb5c08/barcode/image/8ea6c8fa-f988-4d59-ace0-1c9564ca7d79/cf282849-107d-445c-bca1-badb0e976e25.svg",
        "owner_id": "92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95"
          },
          "data": {
            "type": "customers",
            "id": "92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T11:02:45+00:00",
        "updated_at": "2023-01-05T11:02:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92d1e1fd-8f2f-4a4c-9c3a-e2ec734c2d95&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDg5YzgzNTAtYmMzMy00MDgxLWJhYWEtM2NiMTc4Y2NjN2Iw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d89c8350-bc33-4081-baaa-3cb178ccc7b0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T11:02:46+00:00",
        "updated_at": "2023-01-05T11:02:46+00:00",
        "number": "http://bqbl.it/d89c8350-bc33-4081-baaa-3cb178ccc7b0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6bccc8d715556a3132fe9eaebbefc4f2/barcode/image/d89c8350-bc33-4081-baaa-3cb178ccc7b0/8b56dead-7a79-4457-9810-f199f3105a54.svg",
        "owner_id": "08facfab-690e-4aba-99ba-79208af839a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/08facfab-690e-4aba-99ba-79208af839a0"
          },
          "data": {
            "type": "customers",
            "id": "08facfab-690e-4aba-99ba-79208af839a0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "08facfab-690e-4aba-99ba-79208af839a0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T11:02:46+00:00",
        "updated_at": "2023-01-05T11:02:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=08facfab-690e-4aba-99ba-79208af839a0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=08facfab-690e-4aba-99ba-79208af839a0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=08facfab-690e-4aba-99ba-79208af839a0&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:02:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f7a389e1-e898-44eb-beb0-7d9636257af6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f7a389e1-e898-44eb-beb0-7d9636257af6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T11:02:46+00:00",
      "updated_at": "2023-01-05T11:02:46+00:00",
      "number": "http://bqbl.it/f7a389e1-e898-44eb-beb0-7d9636257af6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5802e7d79cf32d5e0736dbbef508ada4/barcode/image/f7a389e1-e898-44eb-beb0-7d9636257af6/1bea0076-d637-471f-84e2-de926dc37779.svg",
      "owner_id": "121284f9-1742-4781-b1c0-f4e0144740f5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/121284f9-1742-4781-b1c0-f4e0144740f5"
        },
        "data": {
          "type": "customers",
          "id": "121284f9-1742-4781-b1c0-f4e0144740f5"
        }
      }
    }
  },
  "included": [
    {
      "id": "121284f9-1742-4781-b1c0-f4e0144740f5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T11:02:46+00:00",
        "updated_at": "2023-01-05T11:02:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=121284f9-1742-4781-b1c0-f4e0144740f5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=121284f9-1742-4781-b1c0-f4e0144740f5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=121284f9-1742-4781-b1c0-f4e0144740f5&filter[owner_type]=customers"
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
          "owner_id": "eda6abbc-567e-40c5-8766-8dd441c63912",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "eb14e398-8d2a-4512-ab36-2b10bece1808",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T11:02:47+00:00",
      "updated_at": "2023-01-05T11:02:47+00:00",
      "number": "http://bqbl.it/eb14e398-8d2a-4512-ab36-2b10bece1808",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d69b1331ce66e3689490a5d9f4826960/barcode/image/eb14e398-8d2a-4512-ab36-2b10bece1808/645649cf-2631-4f05-8b2f-7bd89288f5e6.svg",
      "owner_id": "eda6abbc-567e-40c5-8766-8dd441c63912",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e188922e-9433-430c-90ab-e76ae947d529' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e188922e-9433-430c-90ab-e76ae947d529",
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
    "id": "e188922e-9433-430c-90ab-e76ae947d529",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T11:02:47+00:00",
      "updated_at": "2023-01-05T11:02:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1ff7226ba390fa681ffadff8c746fbf7/barcode/image/e188922e-9433-430c-90ab-e76ae947d529/7abf6156-d5b6-4b97-aa46-da9e7babd145.svg",
      "owner_id": "1136134a-6db2-445b-b23a-0f523eddbf1a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/97ab9f73-bcff-4872-93cf-ec1f475e1cf3' \
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