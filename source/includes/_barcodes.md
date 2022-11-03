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
      "id": "85fd4eb2-5e9b-4b10-807d-035c3187bf63",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-03T11:05:34+00:00",
        "updated_at": "2022-11-03T11:05:34+00:00",
        "number": "http://bqbl.it/85fd4eb2-5e9b-4b10-807d-035c3187bf63",
        "barcode_type": "qr_code",
        "image_url": "/uploads/06752f9af938472dd64d1db6379ae8d6/barcode/image/85fd4eb2-5e9b-4b10-807d-035c3187bf63/5afa6f8a-87a4-4ef9-8cbe-8e0c4d30a865.svg",
        "owner_id": "ba31f34a-ac05-495c-96e8-97f997fc0c5a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ba31f34a-ac05-495c-96e8-97f997fc0c5a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F59799313-3770-4015-b0b6-02d61c63ffba&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "59799313-3770-4015-b0b6-02d61c63ffba",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-03T11:05:34+00:00",
        "updated_at": "2022-11-03T11:05:34+00:00",
        "number": "http://bqbl.it/59799313-3770-4015-b0b6-02d61c63ffba",
        "barcode_type": "qr_code",
        "image_url": "/uploads/00bc512aa5dfa754997a43eb68a77a95/barcode/image/59799313-3770-4015-b0b6-02d61c63ffba/35a58ccf-c2f8-4459-957e-29bbd0a17483.svg",
        "owner_id": "4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436"
          },
          "data": {
            "type": "customers",
            "id": "4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-03T11:05:34+00:00",
        "updated_at": "2022-11-03T11:05:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4d0eaafc-7fd6-4a44-9b2c-376e7d0b3436&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWI5Y2Y1MDMtZGNlNi00NzNhLTk4OGEtNjdhZTVlMzRiNThk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ab9cf503-dce6-473a-988a-67ae5e34b58d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-03T11:05:35+00:00",
        "updated_at": "2022-11-03T11:05:35+00:00",
        "number": "http://bqbl.it/ab9cf503-dce6-473a-988a-67ae5e34b58d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fb39c08ace75bfd6295c61cbb1b57059/barcode/image/ab9cf503-dce6-473a-988a-67ae5e34b58d/0937526b-cc87-418e-aa0a-d40c2e2c738c.svg",
        "owner_id": "569777f2-e505-45eb-a4b3-cc162f23ba28",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/569777f2-e505-45eb-a4b3-cc162f23ba28"
          },
          "data": {
            "type": "customers",
            "id": "569777f2-e505-45eb-a4b3-cc162f23ba28"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "569777f2-e505-45eb-a4b3-cc162f23ba28",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-03T11:05:35+00:00",
        "updated_at": "2022-11-03T11:05:35+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=569777f2-e505-45eb-a4b3-cc162f23ba28&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=569777f2-e505-45eb-a4b3-cc162f23ba28&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=569777f2-e505-45eb-a4b3-cc162f23ba28&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-03T11:05:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6aee94b9-f552-4115-8074-007575da4276?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6aee94b9-f552-4115-8074-007575da4276",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-03T11:05:36+00:00",
      "updated_at": "2022-11-03T11:05:36+00:00",
      "number": "http://bqbl.it/6aee94b9-f552-4115-8074-007575da4276",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1b8248dc71697b88d2257699421bfea5/barcode/image/6aee94b9-f552-4115-8074-007575da4276/05f19ced-e720-4d01-8437-017b9feab35f.svg",
      "owner_id": "ce77783a-3670-457d-ac0e-6bc7c7583638",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ce77783a-3670-457d-ac0e-6bc7c7583638"
        },
        "data": {
          "type": "customers",
          "id": "ce77783a-3670-457d-ac0e-6bc7c7583638"
        }
      }
    }
  },
  "included": [
    {
      "id": "ce77783a-3670-457d-ac0e-6bc7c7583638",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-03T11:05:36+00:00",
        "updated_at": "2022-11-03T11:05:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ce77783a-3670-457d-ac0e-6bc7c7583638&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ce77783a-3670-457d-ac0e-6bc7c7583638&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ce77783a-3670-457d-ac0e-6bc7c7583638&filter[owner_type]=customers"
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
          "owner_id": "07a51fb0-f164-4c1b-9744-323a4147a07f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5d382e08-42b7-4d95-8ef9-77cd702434fe",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-03T11:05:37+00:00",
      "updated_at": "2022-11-03T11:05:37+00:00",
      "number": "http://bqbl.it/5d382e08-42b7-4d95-8ef9-77cd702434fe",
      "barcode_type": "qr_code",
      "image_url": "/uploads/da73dcc8be8c86981c13b1b5d93de9eb/barcode/image/5d382e08-42b7-4d95-8ef9-77cd702434fe/88642296-4deb-48a7-a702-e421662a1f9c.svg",
      "owner_id": "07a51fb0-f164-4c1b-9744-323a4147a07f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7333899f-a51b-4fa7-8598-2b541bc86dc3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7333899f-a51b-4fa7-8598-2b541bc86dc3",
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
    "id": "7333899f-a51b-4fa7-8598-2b541bc86dc3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-03T11:05:37+00:00",
      "updated_at": "2022-11-03T11:05:38+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2812f9135263967f42dcf95fc4aa4573/barcode/image/7333899f-a51b-4fa7-8598-2b541bc86dc3/20104b30-6341-4c2e-b2d6-7169854e3273.svg",
      "owner_id": "293e1896-031c-4993-b81f-15cb8f8c5cf0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4a4e8c84-8d2a-4d87-9e2f-718c479e7a8e' \
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