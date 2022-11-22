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
      "id": "ca92aeac-a28c-4722-9be4-0a5c20ba8c14",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T17:41:19+00:00",
        "updated_at": "2022-11-22T17:41:19+00:00",
        "number": "http://bqbl.it/ca92aeac-a28c-4722-9be4-0a5c20ba8c14",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c8724fefc69dd47463b22ff696241784/barcode/image/ca92aeac-a28c-4722-9be4-0a5c20ba8c14/5a6c3452-2424-4202-a82a-c11bf0a4080b.svg",
        "owner_id": "949ffa46-cfc5-47d3-b50c-5cc1c2784c49",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/949ffa46-cfc5-47d3-b50c-5cc1c2784c49"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8dcfa4b8-34a6-4301-94f6-0f5d54ccf3ac&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8dcfa4b8-34a6-4301-94f6-0f5d54ccf3ac",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T17:41:19+00:00",
        "updated_at": "2022-11-22T17:41:19+00:00",
        "number": "http://bqbl.it/8dcfa4b8-34a6-4301-94f6-0f5d54ccf3ac",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8223ca6c03e9460b3f72516ec469a7e3/barcode/image/8dcfa4b8-34a6-4301-94f6-0f5d54ccf3ac/54337ef3-1eda-4140-8906-cc5a9d4bcb68.svg",
        "owner_id": "35f81de5-b4ed-49b5-94cb-ea2663bf5316",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/35f81de5-b4ed-49b5-94cb-ea2663bf5316"
          },
          "data": {
            "type": "customers",
            "id": "35f81de5-b4ed-49b5-94cb-ea2663bf5316"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "35f81de5-b4ed-49b5-94cb-ea2663bf5316",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T17:41:19+00:00",
        "updated_at": "2022-11-22T17:41:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=35f81de5-b4ed-49b5-94cb-ea2663bf5316&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=35f81de5-b4ed-49b5-94cb-ea2663bf5316&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=35f81de5-b4ed-49b5-94cb-ea2663bf5316&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjJkYWRmNzAtNTA2Ny00MTVlLTg5YWYtZDYzOWQyNjU4Y2Q4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b2dadf70-5067-415e-89af-d639d2658cd8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T17:41:20+00:00",
        "updated_at": "2022-11-22T17:41:20+00:00",
        "number": "http://bqbl.it/b2dadf70-5067-415e-89af-d639d2658cd8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5e913805a22fd51de56ad61cd6914b8c/barcode/image/b2dadf70-5067-415e-89af-d639d2658cd8/d6d0dd27-9c0e-45a1-b54b-ac723779fadc.svg",
        "owner_id": "41feef1e-6619-4b42-b71d-b863a546d1b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/41feef1e-6619-4b42-b71d-b863a546d1b2"
          },
          "data": {
            "type": "customers",
            "id": "41feef1e-6619-4b42-b71d-b863a546d1b2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "41feef1e-6619-4b42-b71d-b863a546d1b2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T17:41:20+00:00",
        "updated_at": "2022-11-22T17:41:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=41feef1e-6619-4b42-b71d-b863a546d1b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=41feef1e-6619-4b42-b71d-b863a546d1b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=41feef1e-6619-4b42-b71d-b863a546d1b2&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:40:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f3164ce9-e9f6-44b8-82ae-f58106a4a45b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f3164ce9-e9f6-44b8-82ae-f58106a4a45b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T17:41:20+00:00",
      "updated_at": "2022-11-22T17:41:20+00:00",
      "number": "http://bqbl.it/f3164ce9-e9f6-44b8-82ae-f58106a4a45b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/35173aec020b371b9293e97891e97aa2/barcode/image/f3164ce9-e9f6-44b8-82ae-f58106a4a45b/205b680e-c48c-4095-88f9-02e8d9b5d6a0.svg",
      "owner_id": "7832dda6-55b7-41ea-84f2-f2b6345e3491",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7832dda6-55b7-41ea-84f2-f2b6345e3491"
        },
        "data": {
          "type": "customers",
          "id": "7832dda6-55b7-41ea-84f2-f2b6345e3491"
        }
      }
    }
  },
  "included": [
    {
      "id": "7832dda6-55b7-41ea-84f2-f2b6345e3491",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T17:41:20+00:00",
        "updated_at": "2022-11-22T17:41:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7832dda6-55b7-41ea-84f2-f2b6345e3491&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7832dda6-55b7-41ea-84f2-f2b6345e3491&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7832dda6-55b7-41ea-84f2-f2b6345e3491&filter[owner_type]=customers"
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
          "owner_id": "edf3c0ba-4e5a-4ca8-87a7-75703689d4fd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "631e9360-dafd-4acc-b095-9aaba6c09098",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T17:41:21+00:00",
      "updated_at": "2022-11-22T17:41:21+00:00",
      "number": "http://bqbl.it/631e9360-dafd-4acc-b095-9aaba6c09098",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aa15e28458385965836b0ad00773422a/barcode/image/631e9360-dafd-4acc-b095-9aaba6c09098/91d33f7c-c1bd-478e-9aff-5c23d5f34278.svg",
      "owner_id": "edf3c0ba-4e5a-4ca8-87a7-75703689d4fd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/742391be-56a0-4433-a1a6-dc2f762e0728' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "742391be-56a0-4433-a1a6-dc2f762e0728",
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
    "id": "742391be-56a0-4433-a1a6-dc2f762e0728",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T17:41:21+00:00",
      "updated_at": "2022-11-22T17:41:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/07aff65f9db507385b6d57a20b470e92/barcode/image/742391be-56a0-4433-a1a6-dc2f762e0728/edcf3039-c0a0-4d4b-ac3a-097e303af1f0.svg",
      "owner_id": "84e95cbf-08b7-46c6-879b-0186d00d54e3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3d58e972-32a3-4550-b6d5-bdf5764f3e56' \
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