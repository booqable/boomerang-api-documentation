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
      "id": "1e2ac9b0-b1cd-4976-97b4-b7a349ab8c2c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T11:17:38+00:00",
        "updated_at": "2022-07-13T11:17:38+00:00",
        "number": "http://bqbl.it/1e2ac9b0-b1cd-4976-97b4-b7a349ab8c2c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/68eb9f86686ed64e7519a0bbda937b63/barcode/image/1e2ac9b0-b1cd-4976-97b4-b7a349ab8c2c/834f6ceb-2352-40a0-9aec-fd6169e1e0fe.svg",
        "owner_id": "ac23c0a6-19cc-40da-86b4-3cecbf03172b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ac23c0a6-19cc-40da-86b4-3cecbf03172b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7e6d62c2-89d9-4a2b-abc8-554123557f9a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7e6d62c2-89d9-4a2b-abc8-554123557f9a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T11:17:39+00:00",
        "updated_at": "2022-07-13T11:17:39+00:00",
        "number": "http://bqbl.it/7e6d62c2-89d9-4a2b-abc8-554123557f9a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c27d3cfaae172b0aa541099e45a9aa5b/barcode/image/7e6d62c2-89d9-4a2b-abc8-554123557f9a/66039a79-b28b-4147-982b-9e0fb4065543.svg",
        "owner_id": "11296d6f-7465-4e05-bb22-ffb5cf78b2c6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/11296d6f-7465-4e05-bb22-ffb5cf78b2c6"
          },
          "data": {
            "type": "customers",
            "id": "11296d6f-7465-4e05-bb22-ffb5cf78b2c6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "11296d6f-7465-4e05-bb22-ffb5cf78b2c6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T11:17:39+00:00",
        "updated_at": "2022-07-13T11:17:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Langworth LLC",
        "email": "llc.langworth@rowe.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=11296d6f-7465-4e05-bb22-ffb5cf78b2c6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=11296d6f-7465-4e05-bb22-ffb5cf78b2c6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=11296d6f-7465-4e05-bb22-ffb5cf78b2c6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWRjYmM1ZjQtZTI4Mi00MmRiLWI3NjQtYjViY2QyOTc5YTlj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "adcbc5f4-e282-42db-b764-b5bcd2979a9c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T11:17:40+00:00",
        "updated_at": "2022-07-13T11:17:40+00:00",
        "number": "http://bqbl.it/adcbc5f4-e282-42db-b764-b5bcd2979a9c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/934f5014bc25f18db475bb2e1886d51c/barcode/image/adcbc5f4-e282-42db-b764-b5bcd2979a9c/95e1fffc-0a6b-47ff-a70f-fdfc55a32151.svg",
        "owner_id": "e61b9add-f5d1-4c21-9725-ef912c713011",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e61b9add-f5d1-4c21-9725-ef912c713011"
          },
          "data": {
            "type": "customers",
            "id": "e61b9add-f5d1-4c21-9725-ef912c713011"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e61b9add-f5d1-4c21-9725-ef912c713011",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T11:17:40+00:00",
        "updated_at": "2022-07-13T11:17:40+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Kemmer, Abernathy and Welch",
        "email": "and_abernathy_welch_kemmer@miller.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=e61b9add-f5d1-4c21-9725-ef912c713011&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e61b9add-f5d1-4c21-9725-ef912c713011&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e61b9add-f5d1-4c21-9725-ef912c713011&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:17:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4307aa07-e071-4806-97d1-393eb8252d93?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4307aa07-e071-4806-97d1-393eb8252d93",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T11:17:40+00:00",
      "updated_at": "2022-07-13T11:17:40+00:00",
      "number": "http://bqbl.it/4307aa07-e071-4806-97d1-393eb8252d93",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8fb2ef6f1023cd1b867baf4d433b7dbc/barcode/image/4307aa07-e071-4806-97d1-393eb8252d93/dec2684a-fc35-43ef-83c8-1044a16f2e62.svg",
      "owner_id": "dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898"
        },
        "data": {
          "type": "customers",
          "id": "dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898"
        }
      }
    }
  },
  "included": [
    {
      "id": "dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T11:17:40+00:00",
        "updated_at": "2022-07-13T11:17:40+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kertzmann, Beatty and Stoltenberg",
        "email": "kertzmann.stoltenberg.and.beatty@brown-emmerich.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dbc03ec5-bcdc-477e-ad1b-a4cfd29b0898&filter[owner_type]=customers"
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
          "owner_id": "5375db81-53f0-4791-a867-85c96dc12fa2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "776bcceb-38c4-4b63-a9d4-e7f94c7bef9b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T11:17:41+00:00",
      "updated_at": "2022-07-13T11:17:41+00:00",
      "number": "http://bqbl.it/776bcceb-38c4-4b63-a9d4-e7f94c7bef9b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/827be2e151d92b68935f9c622ddc1dbd/barcode/image/776bcceb-38c4-4b63-a9d4-e7f94c7bef9b/91fd80f3-ecf9-4f62-afcf-6fdb4be40ae8.svg",
      "owner_id": "5375db81-53f0-4791-a867-85c96dc12fa2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f9a4c1f9-7993-4ac0-9ba5-97ac6d5570f0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f9a4c1f9-7993-4ac0-9ba5-97ac6d5570f0",
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
    "id": "f9a4c1f9-7993-4ac0-9ba5-97ac6d5570f0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T11:17:42+00:00",
      "updated_at": "2022-07-13T11:17:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3d2b85fcc0ef7832a31a50280448daa6/barcode/image/f9a4c1f9-7993-4ac0-9ba5-97ac6d5570f0/c6c86c83-7833-4da0-8981-2198d61f7aca.svg",
      "owner_id": "ebe1a6a5-50e6-41e6-8e9a-b0ecd7271544",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/370844cd-66b0-4b4f-994b-2cc90f462bc9' \
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