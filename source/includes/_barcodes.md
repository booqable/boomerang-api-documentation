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
      "id": "a72e4dd4-ebfe-4497-8c23-435514b558b6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T12:45:41+00:00",
        "updated_at": "2023-02-14T12:45:41+00:00",
        "number": "http://bqbl.it/a72e4dd4-ebfe-4497-8c23-435514b558b6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3080b5b3e069dfb12c2e290ea038c95a/barcode/image/a72e4dd4-ebfe-4497-8c23-435514b558b6/e0e38c24-5fdf-4146-9d0e-ca5b1885ed6e.svg",
        "owner_id": "05988ede-b360-47ce-b93c-f4321deb7579",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/05988ede-b360-47ce-b93c-f4321deb7579"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F632d3e22-ecfe-4a10-83f8-b677d6e0b025&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "632d3e22-ecfe-4a10-83f8-b677d6e0b025",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T12:45:41+00:00",
        "updated_at": "2023-02-14T12:45:41+00:00",
        "number": "http://bqbl.it/632d3e22-ecfe-4a10-83f8-b677d6e0b025",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7c5d94bd5935be00df95d9e1edb1f312/barcode/image/632d3e22-ecfe-4a10-83f8-b677d6e0b025/29f76e59-79eb-4aba-83ed-44316b178e9f.svg",
        "owner_id": "757e0616-eba6-4ea0-80e3-f17e50e31a4a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/757e0616-eba6-4ea0-80e3-f17e50e31a4a"
          },
          "data": {
            "type": "customers",
            "id": "757e0616-eba6-4ea0-80e3-f17e50e31a4a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "757e0616-eba6-4ea0-80e3-f17e50e31a4a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T12:45:41+00:00",
        "updated_at": "2023-02-14T12:45:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=757e0616-eba6-4ea0-80e3-f17e50e31a4a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=757e0616-eba6-4ea0-80e3-f17e50e31a4a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=757e0616-eba6-4ea0-80e3-f17e50e31a4a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTViZDQ2NjMtZmMyZC00NTMwLTkwNDktZWQ5YjQyM2FiM2Nh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "15bd4663-fc2d-4530-9049-ed9b423ab3ca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T12:45:42+00:00",
        "updated_at": "2023-02-14T12:45:42+00:00",
        "number": "http://bqbl.it/15bd4663-fc2d-4530-9049-ed9b423ab3ca",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e9d53997dd9ddd1bca1f35d64741579d/barcode/image/15bd4663-fc2d-4530-9049-ed9b423ab3ca/151e2617-4815-48bd-b0af-0313b4284105.svg",
        "owner_id": "c910c9f6-1f9d-45b8-9b70-8c3bb51f6833",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c910c9f6-1f9d-45b8-9b70-8c3bb51f6833"
          },
          "data": {
            "type": "customers",
            "id": "c910c9f6-1f9d-45b8-9b70-8c3bb51f6833"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c910c9f6-1f9d-45b8-9b70-8c3bb51f6833",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T12:45:42+00:00",
        "updated_at": "2023-02-14T12:45:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c910c9f6-1f9d-45b8-9b70-8c3bb51f6833&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c910c9f6-1f9d-45b8-9b70-8c3bb51f6833&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c910c9f6-1f9d-45b8-9b70-8c3bb51f6833&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T12:45:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5015f2d1-500b-49f2-8153-3a757948e05a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5015f2d1-500b-49f2-8153-3a757948e05a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T12:45:43+00:00",
      "updated_at": "2023-02-14T12:45:43+00:00",
      "number": "http://bqbl.it/5015f2d1-500b-49f2-8153-3a757948e05a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7bd5f0445eab9b627896785a81fdc206/barcode/image/5015f2d1-500b-49f2-8153-3a757948e05a/d89cac78-e735-4a8d-bac9-4a8dd10f195e.svg",
      "owner_id": "193b9e75-54ea-41bb-a51b-c79b2a95b5b6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/193b9e75-54ea-41bb-a51b-c79b2a95b5b6"
        },
        "data": {
          "type": "customers",
          "id": "193b9e75-54ea-41bb-a51b-c79b2a95b5b6"
        }
      }
    }
  },
  "included": [
    {
      "id": "193b9e75-54ea-41bb-a51b-c79b2a95b5b6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T12:45:42+00:00",
        "updated_at": "2023-02-14T12:45:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=193b9e75-54ea-41bb-a51b-c79b2a95b5b6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=193b9e75-54ea-41bb-a51b-c79b2a95b5b6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=193b9e75-54ea-41bb-a51b-c79b2a95b5b6&filter[owner_type]=customers"
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
          "owner_id": "f7fb735e-2ea9-4e84-9717-7fc1ec7303a9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "af0d8498-a90e-4770-9778-4d3dfc94542c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T12:45:43+00:00",
      "updated_at": "2023-02-14T12:45:43+00:00",
      "number": "http://bqbl.it/af0d8498-a90e-4770-9778-4d3dfc94542c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0eeb5813c1671ecb69aad1392f6498bb/barcode/image/af0d8498-a90e-4770-9778-4d3dfc94542c/ca445224-5342-4957-a0df-2165daa3b1e5.svg",
      "owner_id": "f7fb735e-2ea9-4e84-9717-7fc1ec7303a9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/36f8c777-f184-41b7-bb8d-b2f4ffb0f4e1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "36f8c777-f184-41b7-bb8d-b2f4ffb0f4e1",
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
    "id": "36f8c777-f184-41b7-bb8d-b2f4ffb0f4e1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T12:45:44+00:00",
      "updated_at": "2023-02-14T12:45:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fa1af9b7ab3cde1145f9faba9a7eda64/barcode/image/36f8c777-f184-41b7-bb8d-b2f4ffb0f4e1/60ac7a5d-5703-4e33-9059-deedcd0ddeb8.svg",
      "owner_id": "8959920a-c2a8-44af-95a7-9a57124243b4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1bea0136-1a48-40bc-b89f-bfaba4b033bd' \
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