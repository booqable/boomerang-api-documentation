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
      "id": "d078d4f8-0ba9-47ff-a270-6b7c4e7d6ec9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-20T14:48:01+00:00",
        "updated_at": "2022-12-20T14:48:01+00:00",
        "number": "http://bqbl.it/d078d4f8-0ba9-47ff-a270-6b7c4e7d6ec9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d9c8c69ac1f52059bb5787b24e42cd3d/barcode/image/d078d4f8-0ba9-47ff-a270-6b7c4e7d6ec9/c2c8ead7-bb51-4173-bcf4-c5246ef48f51.svg",
        "owner_id": "784d00c0-4ebd-4e71-8fa5-177c32ec02b9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/784d00c0-4ebd-4e71-8fa5-177c32ec02b9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0cb20f75-d12c-4df4-9d52-bb955572c5cf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0cb20f75-d12c-4df4-9d52-bb955572c5cf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-20T14:48:01+00:00",
        "updated_at": "2022-12-20T14:48:01+00:00",
        "number": "http://bqbl.it/0cb20f75-d12c-4df4-9d52-bb955572c5cf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/141c9916a5a1a1bb6c6ee66795bc49bf/barcode/image/0cb20f75-d12c-4df4-9d52-bb955572c5cf/58fc4954-730e-4bce-9d88-1da754ab8e9d.svg",
        "owner_id": "246836e9-d192-4779-8921-80cfaf1ec733",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/246836e9-d192-4779-8921-80cfaf1ec733"
          },
          "data": {
            "type": "customers",
            "id": "246836e9-d192-4779-8921-80cfaf1ec733"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "246836e9-d192-4779-8921-80cfaf1ec733",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-20T14:48:01+00:00",
        "updated_at": "2022-12-20T14:48:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=246836e9-d192-4779-8921-80cfaf1ec733&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=246836e9-d192-4779-8921-80cfaf1ec733&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=246836e9-d192-4779-8921-80cfaf1ec733&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTViNDc1M2MtMzkxOS00ZGM0LWE5ZjYtOTFjNGVmMjM1NDk3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "95b4753c-3919-4dc4-a9f6-91c4ef235497",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-20T14:48:02+00:00",
        "updated_at": "2022-12-20T14:48:02+00:00",
        "number": "http://bqbl.it/95b4753c-3919-4dc4-a9f6-91c4ef235497",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e0271a215cccf99aba2f53403acaa2ed/barcode/image/95b4753c-3919-4dc4-a9f6-91c4ef235497/6bc02b3f-a3db-4430-8d06-ebfcf5cfc69e.svg",
        "owner_id": "3b547fea-d5eb-4385-99aa-3ca384d7c90d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3b547fea-d5eb-4385-99aa-3ca384d7c90d"
          },
          "data": {
            "type": "customers",
            "id": "3b547fea-d5eb-4385-99aa-3ca384d7c90d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3b547fea-d5eb-4385-99aa-3ca384d7c90d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-20T14:48:02+00:00",
        "updated_at": "2022-12-20T14:48:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3b547fea-d5eb-4385-99aa-3ca384d7c90d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3b547fea-d5eb-4385-99aa-3ca384d7c90d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3b547fea-d5eb-4385-99aa-3ca384d7c90d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-20T14:47:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7d27a742-2760-4239-95c3-3e00163b1121?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d27a742-2760-4239-95c3-3e00163b1121",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-20T14:48:02+00:00",
      "updated_at": "2022-12-20T14:48:02+00:00",
      "number": "http://bqbl.it/7d27a742-2760-4239-95c3-3e00163b1121",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d5f10e5631a3ae0c3ad476cd94f87619/barcode/image/7d27a742-2760-4239-95c3-3e00163b1121/5e0e954c-dfb3-4be1-9107-025bf0338a96.svg",
      "owner_id": "6bc6ced8-b7f7-4b86-a64f-a0248ba030df",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6bc6ced8-b7f7-4b86-a64f-a0248ba030df"
        },
        "data": {
          "type": "customers",
          "id": "6bc6ced8-b7f7-4b86-a64f-a0248ba030df"
        }
      }
    }
  },
  "included": [
    {
      "id": "6bc6ced8-b7f7-4b86-a64f-a0248ba030df",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-20T14:48:02+00:00",
        "updated_at": "2022-12-20T14:48:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6bc6ced8-b7f7-4b86-a64f-a0248ba030df&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6bc6ced8-b7f7-4b86-a64f-a0248ba030df&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6bc6ced8-b7f7-4b86-a64f-a0248ba030df&filter[owner_type]=customers"
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
          "owner_id": "224cbc3b-188d-48d4-b729-64293b9542e1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b1cecdf3-cb52-4bf3-b365-16e2bf054d0d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-20T14:48:03+00:00",
      "updated_at": "2022-12-20T14:48:03+00:00",
      "number": "http://bqbl.it/b1cecdf3-cb52-4bf3-b365-16e2bf054d0d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c4d26a7082c6345925de584fd0efb996/barcode/image/b1cecdf3-cb52-4bf3-b365-16e2bf054d0d/f18b103f-4548-4b46-b144-dad488a20d3e.svg",
      "owner_id": "224cbc3b-188d-48d4-b729-64293b9542e1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f1ecff6b-bc3c-4695-8d8e-81cdb48ea59a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f1ecff6b-bc3c-4695-8d8e-81cdb48ea59a",
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
    "id": "f1ecff6b-bc3c-4695-8d8e-81cdb48ea59a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-20T14:48:04+00:00",
      "updated_at": "2022-12-20T14:48:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c1001c44719562df2c572e4193642b6b/barcode/image/f1ecff6b-bc3c-4695-8d8e-81cdb48ea59a/00cef959-7d3f-40c6-b1ae-151f3d704684.svg",
      "owner_id": "4d128dba-b18e-41c5-8b0f-56bf41a76eac",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f49bab46-409f-4aac-82e2-b7f29639376e' \
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