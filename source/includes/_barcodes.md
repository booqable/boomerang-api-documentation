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
      "id": "e9c541a8-a78f-46c3-903c-1f142d8786e5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-13T07:49:42+00:00",
        "updated_at": "2023-03-13T07:49:42+00:00",
        "number": "http://bqbl.it/e9c541a8-a78f-46c3-903c-1f142d8786e5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fd5137f29f3dc8dae169aa7283484209/barcode/image/e9c541a8-a78f-46c3-903c-1f142d8786e5/564eb1d2-694f-4773-8174-0c80aea5873b.svg",
        "owner_id": "e89d0233-2c7f-43ab-99e5-333fb963b489",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e89d0233-2c7f-43ab-99e5-333fb963b489"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4aba2b51-fc21-468d-b6b8-68412be1cc8c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4aba2b51-fc21-468d-b6b8-68412be1cc8c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-13T07:49:42+00:00",
        "updated_at": "2023-03-13T07:49:42+00:00",
        "number": "http://bqbl.it/4aba2b51-fc21-468d-b6b8-68412be1cc8c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/60cb61f215d6ceda28da79b1e677dbe6/barcode/image/4aba2b51-fc21-468d-b6b8-68412be1cc8c/0e055845-fb8d-487b-b7c7-e1a0f62530b2.svg",
        "owner_id": "c89a4a4e-73c7-474b-8dbf-705eb5771cde",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c89a4a4e-73c7-474b-8dbf-705eb5771cde"
          },
          "data": {
            "type": "customers",
            "id": "c89a4a4e-73c7-474b-8dbf-705eb5771cde"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c89a4a4e-73c7-474b-8dbf-705eb5771cde",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-13T07:49:42+00:00",
        "updated_at": "2023-03-13T07:49:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c89a4a4e-73c7-474b-8dbf-705eb5771cde&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c89a4a4e-73c7-474b-8dbf-705eb5771cde&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c89a4a4e-73c7-474b-8dbf-705eb5771cde&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmE4ZThhN2QtOTk1Yi00ZGVkLWIzZGMtYTYwNzhkYTc1NmU1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ba8e8a7d-995b-4ded-b3dc-a6078da756e5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-13T07:49:43+00:00",
        "updated_at": "2023-03-13T07:49:43+00:00",
        "number": "http://bqbl.it/ba8e8a7d-995b-4ded-b3dc-a6078da756e5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/762444e3df498f08850add822a25953f/barcode/image/ba8e8a7d-995b-4ded-b3dc-a6078da756e5/1e8b9992-ceb0-4494-94be-30778ea8b7b0.svg",
        "owner_id": "2c1bf040-9aaa-4e5d-856a-f46597a292be",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2c1bf040-9aaa-4e5d-856a-f46597a292be"
          },
          "data": {
            "type": "customers",
            "id": "2c1bf040-9aaa-4e5d-856a-f46597a292be"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2c1bf040-9aaa-4e5d-856a-f46597a292be",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-13T07:49:43+00:00",
        "updated_at": "2023-03-13T07:49:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2c1bf040-9aaa-4e5d-856a-f46597a292be&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2c1bf040-9aaa-4e5d-856a-f46597a292be&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2c1bf040-9aaa-4e5d-856a-f46597a292be&filter[owner_type]=customers"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-13T07:49:20Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/72678635-c115-489a-a628-1b6008589b8c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "72678635-c115-489a-a628-1b6008589b8c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-13T07:49:44+00:00",
      "updated_at": "2023-03-13T07:49:44+00:00",
      "number": "http://bqbl.it/72678635-c115-489a-a628-1b6008589b8c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3e8d9f5f643718a3ced82b854d6ae8de/barcode/image/72678635-c115-489a-a628-1b6008589b8c/efc27f08-5cb4-49df-b248-01c2a0eaca89.svg",
      "owner_id": "c7d27378-a4b2-4861-a6b5-747726d726df",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c7d27378-a4b2-4861-a6b5-747726d726df"
        },
        "data": {
          "type": "customers",
          "id": "c7d27378-a4b2-4861-a6b5-747726d726df"
        }
      }
    }
  },
  "included": [
    {
      "id": "c7d27378-a4b2-4861-a6b5-747726d726df",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-13T07:49:44+00:00",
        "updated_at": "2023-03-13T07:49:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c7d27378-a4b2-4861-a6b5-747726d726df&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c7d27378-a4b2-4861-a6b5-747726d726df&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c7d27378-a4b2-4861-a6b5-747726d726df&filter[owner_type]=customers"
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
          "owner_id": "3276bb43-1e26-477e-bcac-dfb3ca0479b5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4d788351-ebb1-4329-89da-5e917846580d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-13T07:49:44+00:00",
      "updated_at": "2023-03-13T07:49:44+00:00",
      "number": "http://bqbl.it/4d788351-ebb1-4329-89da-5e917846580d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/166ffec2c41fbb84e6b0f96b859d44fa/barcode/image/4d788351-ebb1-4329-89da-5e917846580d/6f907b83-e21c-4bf7-b880-54c617d4d68c.svg",
      "owner_id": "3276bb43-1e26-477e-bcac-dfb3ca0479b5",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f70674f-cb7b-41cd-9d20-0f162700e59f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9f70674f-cb7b-41cd-9d20-0f162700e59f",
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
    "id": "9f70674f-cb7b-41cd-9d20-0f162700e59f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-13T07:49:45+00:00",
      "updated_at": "2023-03-13T07:49:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/77e0ee475dfe6d4a9cfec6f86bbbe1e4/barcode/image/9f70674f-cb7b-41cd-9d20-0f162700e59f/acd9dae3-ecde-4695-bff5-c5afd82832d1.svg",
      "owner_id": "3f3ca9a3-d2c1-4c4d-8147-756245dd63d1",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ad85d89f-eb5a-4c27-8dac-c7846399cdcd' \
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes