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
      "id": "d486e975-2e38-4214-88a5-00a19dd829ef",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T10:26:38+00:00",
        "updated_at": "2023-02-07T10:26:38+00:00",
        "number": "http://bqbl.it/d486e975-2e38-4214-88a5-00a19dd829ef",
        "barcode_type": "qr_code",
        "image_url": "/uploads/03f9380f83bf5531fe5a8895222ecd2c/barcode/image/d486e975-2e38-4214-88a5-00a19dd829ef/0e15ebad-c18f-48bd-9e29-5d4c6ca62398.svg",
        "owner_id": "2fc5af73-b200-409e-8db5-623f7e686538",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2fc5af73-b200-409e-8db5-623f7e686538"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2847603c-fb45-4ecb-82ec-2c631d3fa5ca&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2847603c-fb45-4ecb-82ec-2c631d3fa5ca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T10:26:38+00:00",
        "updated_at": "2023-02-07T10:26:38+00:00",
        "number": "http://bqbl.it/2847603c-fb45-4ecb-82ec-2c631d3fa5ca",
        "barcode_type": "qr_code",
        "image_url": "/uploads/08bb48a229c28df1fb3d5a538cea730d/barcode/image/2847603c-fb45-4ecb-82ec-2c631d3fa5ca/a05d9189-aad8-4c4b-a77d-4d152664f4e6.svg",
        "owner_id": "947208a8-96fb-459c-bee5-b9cc0fdbee63",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/947208a8-96fb-459c-bee5-b9cc0fdbee63"
          },
          "data": {
            "type": "customers",
            "id": "947208a8-96fb-459c-bee5-b9cc0fdbee63"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "947208a8-96fb-459c-bee5-b9cc0fdbee63",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T10:26:38+00:00",
        "updated_at": "2023-02-07T10:26:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=947208a8-96fb-459c-bee5-b9cc0fdbee63&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=947208a8-96fb-459c-bee5-b9cc0fdbee63&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=947208a8-96fb-459c-bee5-b9cc0fdbee63&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTljYjg5NjQtNjE0Mi00ZTc1LWFmYTQtMTdjNjQyZDRmNDY2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a9cb8964-6142-4e75-afa4-17c642d4f466",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T10:26:39+00:00",
        "updated_at": "2023-02-07T10:26:39+00:00",
        "number": "http://bqbl.it/a9cb8964-6142-4e75-afa4-17c642d4f466",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5fde92af564eba72b33d152eb5f0d2b7/barcode/image/a9cb8964-6142-4e75-afa4-17c642d4f466/3c20f296-36e2-454e-b9f7-c14c686ba0c4.svg",
        "owner_id": "49a7ddf2-52a6-4c5e-936f-1e37cc5b3849",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/49a7ddf2-52a6-4c5e-936f-1e37cc5b3849"
          },
          "data": {
            "type": "customers",
            "id": "49a7ddf2-52a6-4c5e-936f-1e37cc5b3849"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "49a7ddf2-52a6-4c5e-936f-1e37cc5b3849",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T10:26:39+00:00",
        "updated_at": "2023-02-07T10:26:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=49a7ddf2-52a6-4c5e-936f-1e37cc5b3849&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=49a7ddf2-52a6-4c5e-936f-1e37cc5b3849&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=49a7ddf2-52a6-4c5e-936f-1e37cc5b3849&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:26:13Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eb98e890-add6-45c5-9ac4-b3f9b3989820?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eb98e890-add6-45c5-9ac4-b3f9b3989820",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T10:26:40+00:00",
      "updated_at": "2023-02-07T10:26:40+00:00",
      "number": "http://bqbl.it/eb98e890-add6-45c5-9ac4-b3f9b3989820",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7405c5c056e05d10742b0ba1d1c44837/barcode/image/eb98e890-add6-45c5-9ac4-b3f9b3989820/ad5846ed-9a7b-4207-986c-ca5785cc8751.svg",
      "owner_id": "f50afbff-d0ca-4134-804c-90c8911a123d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f50afbff-d0ca-4134-804c-90c8911a123d"
        },
        "data": {
          "type": "customers",
          "id": "f50afbff-d0ca-4134-804c-90c8911a123d"
        }
      }
    }
  },
  "included": [
    {
      "id": "f50afbff-d0ca-4134-804c-90c8911a123d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T10:26:40+00:00",
        "updated_at": "2023-02-07T10:26:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f50afbff-d0ca-4134-804c-90c8911a123d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f50afbff-d0ca-4134-804c-90c8911a123d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f50afbff-d0ca-4134-804c-90c8911a123d&filter[owner_type]=customers"
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
          "owner_id": "0a33c261-61da-4a2b-b2c0-89fcbb51fa94",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2524ca03-80e6-41f9-a988-4034641c5c89",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T10:26:41+00:00",
      "updated_at": "2023-02-07T10:26:41+00:00",
      "number": "http://bqbl.it/2524ca03-80e6-41f9-a988-4034641c5c89",
      "barcode_type": "qr_code",
      "image_url": "/uploads/de4b849a68e74f83cba291e27d5d3c12/barcode/image/2524ca03-80e6-41f9-a988-4034641c5c89/0bc7c2b4-1363-4131-987e-8b8c1881c459.svg",
      "owner_id": "0a33c261-61da-4a2b-b2c0-89fcbb51fa94",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c119d749-e7c9-4e23-831a-eec375c26ee4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c119d749-e7c9-4e23-831a-eec375c26ee4",
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
    "id": "c119d749-e7c9-4e23-831a-eec375c26ee4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T10:26:41+00:00",
      "updated_at": "2023-02-07T10:26:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/53f84705224598e6b5eea4e4106b48f8/barcode/image/c119d749-e7c9-4e23-831a-eec375c26ee4/cf98a9c6-2aff-4ce5-80c0-db2fb16d441f.svg",
      "owner_id": "0aec9ed0-6f83-411e-84c8-1c0781b05ac2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1bf969b9-9a39-4001-8f36-fdc4c5250452' \
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