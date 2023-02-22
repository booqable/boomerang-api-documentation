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
      "id": "58540a7b-ab02-4f34-8adb-0c15a8b44d18",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T14:12:38+00:00",
        "updated_at": "2023-02-22T14:12:38+00:00",
        "number": "http://bqbl.it/58540a7b-ab02-4f34-8adb-0c15a8b44d18",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2c26f2be97abc9bf3e2ef73982970d62/barcode/image/58540a7b-ab02-4f34-8adb-0c15a8b44d18/83ded071-15bc-4f0a-87c2-8c80c8501261.svg",
        "owner_id": "434bb6c8-03cb-47ee-bdc4-9a17340c1f2d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/434bb6c8-03cb-47ee-bdc4-9a17340c1f2d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F923e6930-94f8-4fc9-907c-fd44cf9cfb5a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "923e6930-94f8-4fc9-907c-fd44cf9cfb5a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T14:12:38+00:00",
        "updated_at": "2023-02-22T14:12:38+00:00",
        "number": "http://bqbl.it/923e6930-94f8-4fc9-907c-fd44cf9cfb5a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4c36d02bc48e2700a0e566f2c8a93eb4/barcode/image/923e6930-94f8-4fc9-907c-fd44cf9cfb5a/757496c0-c2b1-4e10-a387-67df80ab6237.svg",
        "owner_id": "b3d6b8ec-0f05-4488-b680-8110b0e099fe",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b3d6b8ec-0f05-4488-b680-8110b0e099fe"
          },
          "data": {
            "type": "customers",
            "id": "b3d6b8ec-0f05-4488-b680-8110b0e099fe"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b3d6b8ec-0f05-4488-b680-8110b0e099fe",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T14:12:38+00:00",
        "updated_at": "2023-02-22T14:12:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b3d6b8ec-0f05-4488-b680-8110b0e099fe&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b3d6b8ec-0f05-4488-b680-8110b0e099fe&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b3d6b8ec-0f05-4488-b680-8110b0e099fe&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODU5NzYxMTYtOGRjNi00YTE5LTgwZTItMDdhOTE0NTM0YmZi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "85976116-8dc6-4a19-80e2-07a914534bfb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T14:12:39+00:00",
        "updated_at": "2023-02-22T14:12:39+00:00",
        "number": "http://bqbl.it/85976116-8dc6-4a19-80e2-07a914534bfb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e2d82e825dc789b82fcc08f8af5b30aa/barcode/image/85976116-8dc6-4a19-80e2-07a914534bfb/da989495-ba8c-4a68-8e62-89e27d3578b9.svg",
        "owner_id": "3c2dd64b-3cc9-4256-820a-09ecc4ffd54f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3c2dd64b-3cc9-4256-820a-09ecc4ffd54f"
          },
          "data": {
            "type": "customers",
            "id": "3c2dd64b-3cc9-4256-820a-09ecc4ffd54f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3c2dd64b-3cc9-4256-820a-09ecc4ffd54f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T14:12:39+00:00",
        "updated_at": "2023-02-22T14:12:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3c2dd64b-3cc9-4256-820a-09ecc4ffd54f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3c2dd64b-3cc9-4256-820a-09ecc4ffd54f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3c2dd64b-3cc9-4256-820a-09ecc4ffd54f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T14:12:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/214aaccb-4bbf-4e8e-9f26-303ad92a4cd1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "214aaccb-4bbf-4e8e-9f26-303ad92a4cd1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T14:12:40+00:00",
      "updated_at": "2023-02-22T14:12:40+00:00",
      "number": "http://bqbl.it/214aaccb-4bbf-4e8e-9f26-303ad92a4cd1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/169feda46fcc6bbe79b0e81ca7932902/barcode/image/214aaccb-4bbf-4e8e-9f26-303ad92a4cd1/3836836a-8e6d-4bdb-b7aa-ea56d36ca6bb.svg",
      "owner_id": "d78ea642-c2ed-42a9-932d-facf3ad14d81",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d78ea642-c2ed-42a9-932d-facf3ad14d81"
        },
        "data": {
          "type": "customers",
          "id": "d78ea642-c2ed-42a9-932d-facf3ad14d81"
        }
      }
    }
  },
  "included": [
    {
      "id": "d78ea642-c2ed-42a9-932d-facf3ad14d81",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T14:12:39+00:00",
        "updated_at": "2023-02-22T14:12:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d78ea642-c2ed-42a9-932d-facf3ad14d81&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d78ea642-c2ed-42a9-932d-facf3ad14d81&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d78ea642-c2ed-42a9-932d-facf3ad14d81&filter[owner_type]=customers"
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
          "owner_id": "a6d5ad61-27e0-4610-9bb3-27c5e2c52e55",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "21bee07c-f5c9-42f3-9f48-1808a31dd537",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T14:12:40+00:00",
      "updated_at": "2023-02-22T14:12:40+00:00",
      "number": "http://bqbl.it/21bee07c-f5c9-42f3-9f48-1808a31dd537",
      "barcode_type": "qr_code",
      "image_url": "/uploads/31f010dba0f7d10560741ea23480e881/barcode/image/21bee07c-f5c9-42f3-9f48-1808a31dd537/603cfb81-ff65-49c6-97e7-b2246b029869.svg",
      "owner_id": "a6d5ad61-27e0-4610-9bb3-27c5e2c52e55",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0be435a-b241-4603-ab0c-bfe563089460' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a0be435a-b241-4603-ab0c-bfe563089460",
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
    "id": "a0be435a-b241-4603-ab0c-bfe563089460",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T14:12:41+00:00",
      "updated_at": "2023-02-22T14:12:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/198c9e8e0cd6ba733aa27c1184b82c10/barcode/image/a0be435a-b241-4603-ab0c-bfe563089460/98e88d75-28aa-4d5e-b24b-463946aed26d.svg",
      "owner_id": "08c0b759-5fbd-4618-8d51-8285b032b27a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d4e4c995-cca4-4544-8931-5fb2a44047ad' \
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