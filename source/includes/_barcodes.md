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
      "id": "334f7eb4-1804-4a53-8a93-9ef2f778bd46",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:06:29+00:00",
        "updated_at": "2023-02-14T11:06:29+00:00",
        "number": "http://bqbl.it/334f7eb4-1804-4a53-8a93-9ef2f778bd46",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6ae833175bb5be886bb33ae66973dd79/barcode/image/334f7eb4-1804-4a53-8a93-9ef2f778bd46/1cd96d66-9d58-4018-865b-5583e1233967.svg",
        "owner_id": "c54408f2-caf2-41ff-99d9-7c21db59db60",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c54408f2-caf2-41ff-99d9-7c21db59db60"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F72dc7b23-74d7-4494-ab43-a76bb413189a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "72dc7b23-74d7-4494-ab43-a76bb413189a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:06:30+00:00",
        "updated_at": "2023-02-14T11:06:30+00:00",
        "number": "http://bqbl.it/72dc7b23-74d7-4494-ab43-a76bb413189a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1bd896ff2a9639245158cbecba320b5b/barcode/image/72dc7b23-74d7-4494-ab43-a76bb413189a/78428e59-03fe-4a3c-ba08-bd62d1e7e590.svg",
        "owner_id": "24c042a9-3218-4e05-9cdc-181f8c55f6aa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/24c042a9-3218-4e05-9cdc-181f8c55f6aa"
          },
          "data": {
            "type": "customers",
            "id": "24c042a9-3218-4e05-9cdc-181f8c55f6aa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "24c042a9-3218-4e05-9cdc-181f8c55f6aa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:06:30+00:00",
        "updated_at": "2023-02-14T11:06:30+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=24c042a9-3218-4e05-9cdc-181f8c55f6aa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=24c042a9-3218-4e05-9cdc-181f8c55f6aa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=24c042a9-3218-4e05-9cdc-181f8c55f6aa&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDI3MjMzNWMtMDI0MC00MzI0LWEwMmMtZTdhOGEyMTc5YWMz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0272335c-0240-4324-a02c-e7a8a2179ac3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:06:31+00:00",
        "updated_at": "2023-02-14T11:06:31+00:00",
        "number": "http://bqbl.it/0272335c-0240-4324-a02c-e7a8a2179ac3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7150c8b90e710c725cdad2cac5d6edaa/barcode/image/0272335c-0240-4324-a02c-e7a8a2179ac3/3a48dc6a-6544-4616-8edd-704e2fa239dd.svg",
        "owner_id": "cfe67332-4774-4e10-88d0-2242ab138e22",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cfe67332-4774-4e10-88d0-2242ab138e22"
          },
          "data": {
            "type": "customers",
            "id": "cfe67332-4774-4e10-88d0-2242ab138e22"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cfe67332-4774-4e10-88d0-2242ab138e22",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:06:31+00:00",
        "updated_at": "2023-02-14T11:06:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cfe67332-4774-4e10-88d0-2242ab138e22&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cfe67332-4774-4e10-88d0-2242ab138e22&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cfe67332-4774-4e10-88d0-2242ab138e22&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:06:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e684bda0-3e05-4a05-b59b-a17c106842ad?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e684bda0-3e05-4a05-b59b-a17c106842ad",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:06:31+00:00",
      "updated_at": "2023-02-14T11:06:31+00:00",
      "number": "http://bqbl.it/e684bda0-3e05-4a05-b59b-a17c106842ad",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d622cdc290c1d865332bde32df6f3f96/barcode/image/e684bda0-3e05-4a05-b59b-a17c106842ad/e5c6088d-fe43-4295-99fb-714ac888ff81.svg",
      "owner_id": "b85324da-5731-4397-9c64-3ff7c56e9f4e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b85324da-5731-4397-9c64-3ff7c56e9f4e"
        },
        "data": {
          "type": "customers",
          "id": "b85324da-5731-4397-9c64-3ff7c56e9f4e"
        }
      }
    }
  },
  "included": [
    {
      "id": "b85324da-5731-4397-9c64-3ff7c56e9f4e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:06:31+00:00",
        "updated_at": "2023-02-14T11:06:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b85324da-5731-4397-9c64-3ff7c56e9f4e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b85324da-5731-4397-9c64-3ff7c56e9f4e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b85324da-5731-4397-9c64-3ff7c56e9f4e&filter[owner_type]=customers"
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
          "owner_id": "ff65443f-cf96-4e8f-af91-94dcddba12c8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "40b74e92-9b35-42b0-be90-7cbcd2374d66",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:06:32+00:00",
      "updated_at": "2023-02-14T11:06:32+00:00",
      "number": "http://bqbl.it/40b74e92-9b35-42b0-be90-7cbcd2374d66",
      "barcode_type": "qr_code",
      "image_url": "/uploads/63d2d615155497a7f10c3bed8a97b84c/barcode/image/40b74e92-9b35-42b0-be90-7cbcd2374d66/56dd05a0-edce-481b-afde-ce6b33631847.svg",
      "owner_id": "ff65443f-cf96-4e8f-af91-94dcddba12c8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/649bc91d-bae7-4577-93c7-3dbb6492bce4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "649bc91d-bae7-4577-93c7-3dbb6492bce4",
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
    "id": "649bc91d-bae7-4577-93c7-3dbb6492bce4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:06:33+00:00",
      "updated_at": "2023-02-14T11:06:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/24c047853770bf0447c10b38f915627e/barcode/image/649bc91d-bae7-4577-93c7-3dbb6492bce4/41bc9d12-d734-47b5-ba8d-3e106aeb0900.svg",
      "owner_id": "33244b5b-3b3e-4570-bb96-20e58c988f27",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9e41d95e-51d0-42a5-80f9-5d79415609e6' \
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