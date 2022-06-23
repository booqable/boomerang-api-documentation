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
      "id": "1e5e75a5-09de-4b8c-bc73-8ba2e9219c53",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-23T19:00:48+00:00",
        "updated_at": "2022-06-23T19:00:48+00:00",
        "number": "http://bqbl.it/1e5e75a5-09de-4b8c-bc73-8ba2e9219c53",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8fdb5a05840a5b06056c1fb4e9dfd6b1/barcode/image/1e5e75a5-09de-4b8c-bc73-8ba2e9219c53/ce34df61-18c8-4e6c-b674-077550a3e23b.svg",
        "owner_id": "c6a3dd14-8085-4763-a523-f67afbaee7a6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c6a3dd14-8085-4763-a523-f67afbaee7a6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9f99eedc-adba-4c40-8f96-197ca965c167&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9f99eedc-adba-4c40-8f96-197ca965c167",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-23T19:00:49+00:00",
        "updated_at": "2022-06-23T19:00:49+00:00",
        "number": "http://bqbl.it/9f99eedc-adba-4c40-8f96-197ca965c167",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8904c4bfd22657cdafed77b34d4aec85/barcode/image/9f99eedc-adba-4c40-8f96-197ca965c167/00e58a22-ef3b-42bd-b786-026a496a4e70.svg",
        "owner_id": "81faeac6-e5de-4028-b0c8-c9f0af64bde4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/81faeac6-e5de-4028-b0c8-c9f0af64bde4"
          },
          "data": {
            "type": "customers",
            "id": "81faeac6-e5de-4028-b0c8-c9f0af64bde4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "81faeac6-e5de-4028-b0c8-c9f0af64bde4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-23T19:00:49+00:00",
        "updated_at": "2022-06-23T19:00:49+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Lubowitz, Roberts and Konopelski",
        "email": "and_lubowitz_roberts_konopelski@connelly.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=81faeac6-e5de-4028-b0c8-c9f0af64bde4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=81faeac6-e5de-4028-b0c8-c9f0af64bde4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=81faeac6-e5de-4028-b0c8-c9f0af64bde4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDQ1M2M5ZTQtNWNhMC00MDkyLWIyM2EtNWE1ZTE4YzQ5ZGFm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4453c9e4-5ca0-4092-b23a-5a5e18c49daf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-23T19:00:49+00:00",
        "updated_at": "2022-06-23T19:00:49+00:00",
        "number": "http://bqbl.it/4453c9e4-5ca0-4092-b23a-5a5e18c49daf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/98aad893372985bbd4ce0e40d500e5dc/barcode/image/4453c9e4-5ca0-4092-b23a-5a5e18c49daf/8d87362d-23e3-4c02-b2f6-7c675bc29efc.svg",
        "owner_id": "23a10b21-882d-4128-a069-5862cd1ea315",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/23a10b21-882d-4128-a069-5862cd1ea315"
          },
          "data": {
            "type": "customers",
            "id": "23a10b21-882d-4128-a069-5862cd1ea315"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "23a10b21-882d-4128-a069-5862cd1ea315",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-23T19:00:49+00:00",
        "updated_at": "2022-06-23T19:00:49+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Bartoletti Group",
        "email": "group.bartoletti@conn.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=23a10b21-882d-4128-a069-5862cd1ea315&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=23a10b21-882d-4128-a069-5862cd1ea315&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=23a10b21-882d-4128-a069-5862cd1ea315&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2f3ae751-4a0a-48c7-8d5c-cf1593808da0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2f3ae751-4a0a-48c7-8d5c-cf1593808da0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-23T19:00:50+00:00",
      "updated_at": "2022-06-23T19:00:50+00:00",
      "number": "http://bqbl.it/2f3ae751-4a0a-48c7-8d5c-cf1593808da0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/28a87f07fd919c6fae2641ded4ba6c8e/barcode/image/2f3ae751-4a0a-48c7-8d5c-cf1593808da0/b43c52f1-c956-428c-bb2b-d9f8082ef420.svg",
      "owner_id": "25dcbf6e-c391-45ee-9e54-65d230d8a1a8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/25dcbf6e-c391-45ee-9e54-65d230d8a1a8"
        },
        "data": {
          "type": "customers",
          "id": "25dcbf6e-c391-45ee-9e54-65d230d8a1a8"
        }
      }
    }
  },
  "included": [
    {
      "id": "25dcbf6e-c391-45ee-9e54-65d230d8a1a8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-23T19:00:50+00:00",
        "updated_at": "2022-06-23T19:00:50+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Rohan LLC",
        "email": "rohan.llc@langworth-schoen.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=25dcbf6e-c391-45ee-9e54-65d230d8a1a8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=25dcbf6e-c391-45ee-9e54-65d230d8a1a8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=25dcbf6e-c391-45ee-9e54-65d230d8a1a8&filter[owner_type]=customers"
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
          "owner_id": "df992a66-147e-41dd-958c-0029a70376fe",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d0a3abfa-8a74-44b8-95f7-f096a8732b3c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-23T19:00:51+00:00",
      "updated_at": "2022-06-23T19:00:51+00:00",
      "number": "http://bqbl.it/d0a3abfa-8a74-44b8-95f7-f096a8732b3c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8cd9745fe70c6e80e42e1c09967d46a1/barcode/image/d0a3abfa-8a74-44b8-95f7-f096a8732b3c/16a3dcfc-dfaa-416d-8961-1a0c1c4d83e4.svg",
      "owner_id": "df992a66-147e-41dd-958c-0029a70376fe",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6679c59c-1d37-4d38-b5fd-30b485dcdb63' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6679c59c-1d37-4d38-b5fd-30b485dcdb63",
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
    "id": "6679c59c-1d37-4d38-b5fd-30b485dcdb63",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-23T19:00:51+00:00",
      "updated_at": "2022-06-23T19:00:51+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c0cb75f09586bd80538797d11e9355ca/barcode/image/6679c59c-1d37-4d38-b5fd-30b485dcdb63/b0eb4195-8cc5-4067-a91e-fac3b51034ce.svg",
      "owner_id": "fc9e74c9-913c-438b-a5bc-25b3a42bfd83",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3ba7c26d-fefe-46d2-8664-0ece385b3079' \
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