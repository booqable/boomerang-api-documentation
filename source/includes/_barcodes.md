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
      "id": "0be3c949-100a-4e83-9a44-b1858ed3fa21",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-27T06:42:03+00:00",
        "updated_at": "2022-09-27T06:42:03+00:00",
        "number": "http://bqbl.it/0be3c949-100a-4e83-9a44-b1858ed3fa21",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6f9957aceea68098978315bf28f57070/barcode/image/0be3c949-100a-4e83-9a44-b1858ed3fa21/4eda1eee-b12c-47bf-96af-2715fe7fd566.svg",
        "owner_id": "8a127625-2b8d-4169-a89d-6438b4369d34",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8a127625-2b8d-4169-a89d-6438b4369d34"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F292bdef4-ebfc-4b41-8401-7b3ce8014ff2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "292bdef4-ebfc-4b41-8401-7b3ce8014ff2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-27T06:42:03+00:00",
        "updated_at": "2022-09-27T06:42:03+00:00",
        "number": "http://bqbl.it/292bdef4-ebfc-4b41-8401-7b3ce8014ff2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e7f9ad98e64ee441565a5a6df42d981e/barcode/image/292bdef4-ebfc-4b41-8401-7b3ce8014ff2/64d1e6ef-457a-4a9b-bc26-a7f3f7dbff7c.svg",
        "owner_id": "ed16b02c-dad8-4ecc-8beb-32cdc74a45b6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ed16b02c-dad8-4ecc-8beb-32cdc74a45b6"
          },
          "data": {
            "type": "customers",
            "id": "ed16b02c-dad8-4ecc-8beb-32cdc74a45b6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ed16b02c-dad8-4ecc-8beb-32cdc74a45b6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-27T06:42:03+00:00",
        "updated_at": "2022-09-27T06:42:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ed16b02c-dad8-4ecc-8beb-32cdc74a45b6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ed16b02c-dad8-4ecc-8beb-32cdc74a45b6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ed16b02c-dad8-4ecc-8beb-32cdc74a45b6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTY1NjYxNzQtYjcxNC00MDdhLTg0NmMtNTUxNzk0NTM1MjM5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "56566174-b714-407a-846c-551794535239",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-27T06:42:04+00:00",
        "updated_at": "2022-09-27T06:42:04+00:00",
        "number": "http://bqbl.it/56566174-b714-407a-846c-551794535239",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4ca3aefa36df8a34f56293d21b323299/barcode/image/56566174-b714-407a-846c-551794535239/e451b294-5fc2-44f8-b585-6b51fef39124.svg",
        "owner_id": "17ae54a4-ec92-4111-9a3d-6c09669dcff7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/17ae54a4-ec92-4111-9a3d-6c09669dcff7"
          },
          "data": {
            "type": "customers",
            "id": "17ae54a4-ec92-4111-9a3d-6c09669dcff7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "17ae54a4-ec92-4111-9a3d-6c09669dcff7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-27T06:42:04+00:00",
        "updated_at": "2022-09-27T06:42:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=17ae54a4-ec92-4111-9a3d-6c09669dcff7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=17ae54a4-ec92-4111-9a3d-6c09669dcff7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=17ae54a4-ec92-4111-9a3d-6c09669dcff7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-27T06:41:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b98dc926-4caa-4270-8b6a-bdacf81fecb4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b98dc926-4caa-4270-8b6a-bdacf81fecb4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-27T06:42:05+00:00",
      "updated_at": "2022-09-27T06:42:05+00:00",
      "number": "http://bqbl.it/b98dc926-4caa-4270-8b6a-bdacf81fecb4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ea97f0b2e94c49225b850133b54038af/barcode/image/b98dc926-4caa-4270-8b6a-bdacf81fecb4/76e11edf-a76d-4561-bf21-b0969ac25ca2.svg",
      "owner_id": "4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c"
        },
        "data": {
          "type": "customers",
          "id": "4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c"
        }
      }
    }
  },
  "included": [
    {
      "id": "4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-27T06:42:05+00:00",
        "updated_at": "2022-09-27T06:42:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4d91b0d9-9f98-42ce-ac6e-e28a196a1d7c&filter[owner_type]=customers"
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
          "owner_id": "ba011b35-fa6c-4f02-b5d4-4bf7ba60f853",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5b45607f-cd39-487e-82b1-854fb6074bab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-27T06:42:05+00:00",
      "updated_at": "2022-09-27T06:42:05+00:00",
      "number": "http://bqbl.it/5b45607f-cd39-487e-82b1-854fb6074bab",
      "barcode_type": "qr_code",
      "image_url": "/uploads/16fca396bff7e119659d04102906afc0/barcode/image/5b45607f-cd39-487e-82b1-854fb6074bab/02bcf888-f208-4183-84af-c2208c60deac.svg",
      "owner_id": "ba011b35-fa6c-4f02-b5d4-4bf7ba60f853",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f0c1187c-a21a-411b-a3df-013b294e5ee0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f0c1187c-a21a-411b-a3df-013b294e5ee0",
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
    "id": "f0c1187c-a21a-411b-a3df-013b294e5ee0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-27T06:42:06+00:00",
      "updated_at": "2022-09-27T06:42:06+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8d9e6890e4e49a793184cb289bd0e484/barcode/image/f0c1187c-a21a-411b-a3df-013b294e5ee0/b245b6b7-ecab-4652-a7b7-e93cd78b440d.svg",
      "owner_id": "de8ad511-b3fc-4b75-98b0-41553852b78c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2fb6f595-0185-47e5-8100-f519cc1c160e' \
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