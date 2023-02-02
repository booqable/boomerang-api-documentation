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
      "id": "57743b08-4095-4cba-85cd-0f7b68bfa32a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T15:24:50+00:00",
        "updated_at": "2023-02-02T15:24:50+00:00",
        "number": "http://bqbl.it/57743b08-4095-4cba-85cd-0f7b68bfa32a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/54d50ddc593b2374f7c84a05c0288939/barcode/image/57743b08-4095-4cba-85cd-0f7b68bfa32a/834b7885-447f-44bd-8fea-0eea18f6ff9b.svg",
        "owner_id": "ca7b2492-9645-4b9f-991d-85344790c08a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ca7b2492-9645-4b9f-991d-85344790c08a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9f369fd6-234d-4305-bcf9-fae18f40141e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9f369fd6-234d-4305-bcf9-fae18f40141e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T15:24:51+00:00",
        "updated_at": "2023-02-02T15:24:51+00:00",
        "number": "http://bqbl.it/9f369fd6-234d-4305-bcf9-fae18f40141e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/52ce3b39669a4c70db5e3f8c1a7d515b/barcode/image/9f369fd6-234d-4305-bcf9-fae18f40141e/7d3feb0a-8a16-412b-9f16-a57ca8d29d79.svg",
        "owner_id": "48765bcb-b35c-4b40-be1d-b58540f21d4b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/48765bcb-b35c-4b40-be1d-b58540f21d4b"
          },
          "data": {
            "type": "customers",
            "id": "48765bcb-b35c-4b40-be1d-b58540f21d4b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "48765bcb-b35c-4b40-be1d-b58540f21d4b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T15:24:51+00:00",
        "updated_at": "2023-02-02T15:24:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=48765bcb-b35c-4b40-be1d-b58540f21d4b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=48765bcb-b35c-4b40-be1d-b58540f21d4b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=48765bcb-b35c-4b40-be1d-b58540f21d4b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2VmYTM3MjktZmViOC00N2ZkLWE1NTYtOTk5OGVkNDA0NWIz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3efa3729-feb8-47fd-a556-9998ed4045b3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T15:24:52+00:00",
        "updated_at": "2023-02-02T15:24:52+00:00",
        "number": "http://bqbl.it/3efa3729-feb8-47fd-a556-9998ed4045b3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5e5633bbea5ecd782f135c45890b6933/barcode/image/3efa3729-feb8-47fd-a556-9998ed4045b3/7d639573-ad14-4f7e-9671-0e94b0b911cd.svg",
        "owner_id": "263b3a0e-4077-4fef-8a0f-a4468f554dc1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/263b3a0e-4077-4fef-8a0f-a4468f554dc1"
          },
          "data": {
            "type": "customers",
            "id": "263b3a0e-4077-4fef-8a0f-a4468f554dc1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "263b3a0e-4077-4fef-8a0f-a4468f554dc1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T15:24:51+00:00",
        "updated_at": "2023-02-02T15:24:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=263b3a0e-4077-4fef-8a0f-a4468f554dc1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=263b3a0e-4077-4fef-8a0f-a4468f554dc1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=263b3a0e-4077-4fef-8a0f-a4468f554dc1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T15:24:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0193ec64-ec73-4508-bd4f-bcdf834dc172?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0193ec64-ec73-4508-bd4f-bcdf834dc172",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T15:24:52+00:00",
      "updated_at": "2023-02-02T15:24:52+00:00",
      "number": "http://bqbl.it/0193ec64-ec73-4508-bd4f-bcdf834dc172",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d6706d5a58dec2bc2de04bca75ed628f/barcode/image/0193ec64-ec73-4508-bd4f-bcdf834dc172/b7cbef89-825c-4e21-8c98-9e4163d6f955.svg",
      "owner_id": "62aba49b-aaf3-4a25-95cc-2b2da7377da8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/62aba49b-aaf3-4a25-95cc-2b2da7377da8"
        },
        "data": {
          "type": "customers",
          "id": "62aba49b-aaf3-4a25-95cc-2b2da7377da8"
        }
      }
    }
  },
  "included": [
    {
      "id": "62aba49b-aaf3-4a25-95cc-2b2da7377da8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T15:24:52+00:00",
        "updated_at": "2023-02-02T15:24:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=62aba49b-aaf3-4a25-95cc-2b2da7377da8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=62aba49b-aaf3-4a25-95cc-2b2da7377da8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=62aba49b-aaf3-4a25-95cc-2b2da7377da8&filter[owner_type]=customers"
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
          "owner_id": "da748f96-fdf9-4a4f-9fd3-71efbf4e5c23",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "67abd0ce-debf-402d-bc35-0d383822ee0e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T15:24:53+00:00",
      "updated_at": "2023-02-02T15:24:53+00:00",
      "number": "http://bqbl.it/67abd0ce-debf-402d-bc35-0d383822ee0e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b7337b191ce7083888670c86f4ebab83/barcode/image/67abd0ce-debf-402d-bc35-0d383822ee0e/e72b893a-c029-4358-a1db-1513f30d161e.svg",
      "owner_id": "da748f96-fdf9-4a4f-9fd3-71efbf4e5c23",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0065dec-ac8f-4b99-b8e0-22e8f3a9543a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a0065dec-ac8f-4b99-b8e0-22e8f3a9543a",
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
    "id": "a0065dec-ac8f-4b99-b8e0-22e8f3a9543a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T15:24:53+00:00",
      "updated_at": "2023-02-02T15:24:53+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7d92de116caca029d50eb4ff69fde481/barcode/image/a0065dec-ac8f-4b99-b8e0-22e8f3a9543a/567925de-3e14-4a6d-b726-9d22e868f04e.svg",
      "owner_id": "cc326b02-ed52-47a2-af5c-e92c4bd9dfa4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a8e225e0-607a-4792-b53d-1251f828c000' \
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