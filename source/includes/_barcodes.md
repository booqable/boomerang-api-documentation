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
      "id": "3163f040-6398-4953-bb4a-b6c978ddac45",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T08:39:15+00:00",
        "updated_at": "2023-02-06T08:39:15+00:00",
        "number": "http://bqbl.it/3163f040-6398-4953-bb4a-b6c978ddac45",
        "barcode_type": "qr_code",
        "image_url": "/uploads/df5f7eed47350c99733d3fd7cc9e11b2/barcode/image/3163f040-6398-4953-bb4a-b6c978ddac45/02287474-018d-4ef4-af9a-5ca8015ee6c7.svg",
        "owner_id": "d2b4eb40-175b-41a1-9d2f-4c30bdc22018",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d2b4eb40-175b-41a1-9d2f-4c30bdc22018"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1ac72997-736b-4884-ae4c-231dcc9edc99&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1ac72997-736b-4884-ae4c-231dcc9edc99",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T08:39:16+00:00",
        "updated_at": "2023-02-06T08:39:16+00:00",
        "number": "http://bqbl.it/1ac72997-736b-4884-ae4c-231dcc9edc99",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5d554d786a59b7fc7457b1e04233f3d5/barcode/image/1ac72997-736b-4884-ae4c-231dcc9edc99/bae9600e-ad0a-450a-9384-5de6b5508c55.svg",
        "owner_id": "523b20be-50e3-4473-b650-7651774d48d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/523b20be-50e3-4473-b650-7651774d48d7"
          },
          "data": {
            "type": "customers",
            "id": "523b20be-50e3-4473-b650-7651774d48d7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "523b20be-50e3-4473-b650-7651774d48d7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T08:39:16+00:00",
        "updated_at": "2023-02-06T08:39:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=523b20be-50e3-4473-b650-7651774d48d7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=523b20be-50e3-4473-b650-7651774d48d7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=523b20be-50e3-4473-b650-7651774d48d7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDNhODM2OGMtZTc0MC00NWE2LWFjNWUtNjZiNjY1ODdlM2Iw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d3a8368c-e740-45a6-ac5e-66b66587e3b0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T08:39:16+00:00",
        "updated_at": "2023-02-06T08:39:16+00:00",
        "number": "http://bqbl.it/d3a8368c-e740-45a6-ac5e-66b66587e3b0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/388f6858818f4d3f2317a9b95efe79d1/barcode/image/d3a8368c-e740-45a6-ac5e-66b66587e3b0/496106fe-59fe-4773-aa6a-91fc6bf72e3a.svg",
        "owner_id": "e3b3a761-cef0-4c8b-a68f-c1b0284fb486",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e3b3a761-cef0-4c8b-a68f-c1b0284fb486"
          },
          "data": {
            "type": "customers",
            "id": "e3b3a761-cef0-4c8b-a68f-c1b0284fb486"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e3b3a761-cef0-4c8b-a68f-c1b0284fb486",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T08:39:16+00:00",
        "updated_at": "2023-02-06T08:39:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e3b3a761-cef0-4c8b-a68f-c1b0284fb486&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e3b3a761-cef0-4c8b-a68f-c1b0284fb486&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e3b3a761-cef0-4c8b-a68f-c1b0284fb486&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:38:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/aa6ada49-9539-4fa2-b6d5-c00c7edf612c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aa6ada49-9539-4fa2-b6d5-c00c7edf612c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T08:39:17+00:00",
      "updated_at": "2023-02-06T08:39:17+00:00",
      "number": "http://bqbl.it/aa6ada49-9539-4fa2-b6d5-c00c7edf612c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8fa0c90ddb415b93074f77acbec48028/barcode/image/aa6ada49-9539-4fa2-b6d5-c00c7edf612c/47565af1-2a38-4e5d-9460-07d09360b201.svg",
      "owner_id": "d088fcd6-981d-4faf-8506-90f884b0e78d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d088fcd6-981d-4faf-8506-90f884b0e78d"
        },
        "data": {
          "type": "customers",
          "id": "d088fcd6-981d-4faf-8506-90f884b0e78d"
        }
      }
    }
  },
  "included": [
    {
      "id": "d088fcd6-981d-4faf-8506-90f884b0e78d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T08:39:17+00:00",
        "updated_at": "2023-02-06T08:39:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d088fcd6-981d-4faf-8506-90f884b0e78d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d088fcd6-981d-4faf-8506-90f884b0e78d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d088fcd6-981d-4faf-8506-90f884b0e78d&filter[owner_type]=customers"
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
          "owner_id": "928cef2b-b7cd-4f5c-ba45-7a67885ef8ef",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3b0f0182-33a1-440b-a6c2-0f6bf1651b81",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T08:39:17+00:00",
      "updated_at": "2023-02-06T08:39:17+00:00",
      "number": "http://bqbl.it/3b0f0182-33a1-440b-a6c2-0f6bf1651b81",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d98e0f8867e0ab747cb662e44c1bfae5/barcode/image/3b0f0182-33a1-440b-a6c2-0f6bf1651b81/b6db421b-89d4-437c-bc41-ff1cb108e906.svg",
      "owner_id": "928cef2b-b7cd-4f5c-ba45-7a67885ef8ef",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fe33ad60-8ad3-4204-ada3-f831f18e962c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fe33ad60-8ad3-4204-ada3-f831f18e962c",
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
    "id": "fe33ad60-8ad3-4204-ada3-f831f18e962c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T08:39:18+00:00",
      "updated_at": "2023-02-06T08:39:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/efd9c6e9147b70e779dfb4faa0b0f9b3/barcode/image/fe33ad60-8ad3-4204-ada3-f831f18e962c/8f5d2655-00f2-4df8-aabe-0fa7754c05f2.svg",
      "owner_id": "0dee4775-0020-4fba-bd7d-f40ca95dece8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cff1b5d7-c7e6-4700-b82f-281c580ea104' \
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