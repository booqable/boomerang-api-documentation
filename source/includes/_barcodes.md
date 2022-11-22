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
      "id": "35ff300e-cf0b-46b9-a083-c9b82f0f40c6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T15:49:44+00:00",
        "updated_at": "2022-11-22T15:49:44+00:00",
        "number": "http://bqbl.it/35ff300e-cf0b-46b9-a083-c9b82f0f40c6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1a115e01ea282f67a7183cf34c396371/barcode/image/35ff300e-cf0b-46b9-a083-c9b82f0f40c6/88612ffd-6d7c-47bf-858e-7024101b7193.svg",
        "owner_id": "e208695e-0608-4785-a878-1a4ce85fe78b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e208695e-0608-4785-a878-1a4ce85fe78b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbe3f0a88-9d69-4427-a357-959e0fd2d3af&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "be3f0a88-9d69-4427-a357-959e0fd2d3af",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T15:49:45+00:00",
        "updated_at": "2022-11-22T15:49:45+00:00",
        "number": "http://bqbl.it/be3f0a88-9d69-4427-a357-959e0fd2d3af",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4288b2b0a25cefe991d0c661ae765830/barcode/image/be3f0a88-9d69-4427-a357-959e0fd2d3af/02b59dbe-2877-437a-85d6-506fcdf396f6.svg",
        "owner_id": "437a8106-7abc-4afe-9a63-a1be9b194686",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/437a8106-7abc-4afe-9a63-a1be9b194686"
          },
          "data": {
            "type": "customers",
            "id": "437a8106-7abc-4afe-9a63-a1be9b194686"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "437a8106-7abc-4afe-9a63-a1be9b194686",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T15:49:45+00:00",
        "updated_at": "2022-11-22T15:49:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=437a8106-7abc-4afe-9a63-a1be9b194686&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=437a8106-7abc-4afe-9a63-a1be9b194686&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=437a8106-7abc-4afe-9a63-a1be9b194686&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWU0YjE4ZmQtYzZmMC00MmNmLWJiNjItZjhmYjQwNGMyNWM0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ee4b18fd-c6f0-42cf-bb62-f8fb404c25c4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T15:49:45+00:00",
        "updated_at": "2022-11-22T15:49:45+00:00",
        "number": "http://bqbl.it/ee4b18fd-c6f0-42cf-bb62-f8fb404c25c4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c51471d272bb5bb7cea30151607e4e01/barcode/image/ee4b18fd-c6f0-42cf-bb62-f8fb404c25c4/0e6cacc2-c70c-4a0a-8340-3be1b7ae0728.svg",
        "owner_id": "ee7e6f31-6079-44c5-9903-6d3e82005779",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ee7e6f31-6079-44c5-9903-6d3e82005779"
          },
          "data": {
            "type": "customers",
            "id": "ee7e6f31-6079-44c5-9903-6d3e82005779"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ee7e6f31-6079-44c5-9903-6d3e82005779",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T15:49:45+00:00",
        "updated_at": "2022-11-22T15:49:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee7e6f31-6079-44c5-9903-6d3e82005779&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee7e6f31-6079-44c5-9903-6d3e82005779&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee7e6f31-6079-44c5-9903-6d3e82005779&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:49:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cc59f6c8-0799-478e-a5f8-4524d9928657?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cc59f6c8-0799-478e-a5f8-4524d9928657",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T15:49:46+00:00",
      "updated_at": "2022-11-22T15:49:46+00:00",
      "number": "http://bqbl.it/cc59f6c8-0799-478e-a5f8-4524d9928657",
      "barcode_type": "qr_code",
      "image_url": "/uploads/415274ab6c67430d5170c14db90dc253/barcode/image/cc59f6c8-0799-478e-a5f8-4524d9928657/516c2d7e-7151-4b89-87bc-44b934761571.svg",
      "owner_id": "7f92e783-ec5f-4f29-af40-1747c899f66f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7f92e783-ec5f-4f29-af40-1747c899f66f"
        },
        "data": {
          "type": "customers",
          "id": "7f92e783-ec5f-4f29-af40-1747c899f66f"
        }
      }
    }
  },
  "included": [
    {
      "id": "7f92e783-ec5f-4f29-af40-1747c899f66f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T15:49:46+00:00",
        "updated_at": "2022-11-22T15:49:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7f92e783-ec5f-4f29-af40-1747c899f66f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7f92e783-ec5f-4f29-af40-1747c899f66f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7f92e783-ec5f-4f29-af40-1747c899f66f&filter[owner_type]=customers"
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
          "owner_id": "2544c263-f332-4cd5-8cd9-3faa2b1a84e4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6b8ce166-06a3-4f17-8f0b-87e1e115a40f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T15:49:46+00:00",
      "updated_at": "2022-11-22T15:49:46+00:00",
      "number": "http://bqbl.it/6b8ce166-06a3-4f17-8f0b-87e1e115a40f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f7f65625113529d66da38f3d00378f69/barcode/image/6b8ce166-06a3-4f17-8f0b-87e1e115a40f/f28125a6-933b-41b3-9efa-8e98d00f8994.svg",
      "owner_id": "2544c263-f332-4cd5-8cd9-3faa2b1a84e4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/60515d15-6849-45da-9f8f-7947a9a9cc06' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "60515d15-6849-45da-9f8f-7947a9a9cc06",
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
    "id": "60515d15-6849-45da-9f8f-7947a9a9cc06",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T15:49:47+00:00",
      "updated_at": "2022-11-22T15:49:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f3f247443690d7e7a49a34845312bed7/barcode/image/60515d15-6849-45da-9f8f-7947a9a9cc06/40011206-3964-4901-b8d9-1a49588b64f5.svg",
      "owner_id": "76816e4e-91e3-4269-bb61-28b0890883b5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e933cdc0-8d58-4984-8fce-2e6e8d74bcb2' \
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