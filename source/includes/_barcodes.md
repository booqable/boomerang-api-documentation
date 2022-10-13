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
      "id": "0118b2c8-4ce1-4573-b30f-c931b63d0e1f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T12:36:59+00:00",
        "updated_at": "2022-10-13T12:36:59+00:00",
        "number": "http://bqbl.it/0118b2c8-4ce1-4573-b30f-c931b63d0e1f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8ffa520448156ce3d42eccef5007e83f/barcode/image/0118b2c8-4ce1-4573-b30f-c931b63d0e1f/bc0dd196-37d7-4824-bdc6-0f3ac4745935.svg",
        "owner_id": "2bef75ae-d836-4cdf-9a2e-879cf923bd63",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2bef75ae-d836-4cdf-9a2e-879cf923bd63"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7833cc71-707a-4762-8d8d-f642952011c4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7833cc71-707a-4762-8d8d-f642952011c4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T12:37:00+00:00",
        "updated_at": "2022-10-13T12:37:00+00:00",
        "number": "http://bqbl.it/7833cc71-707a-4762-8d8d-f642952011c4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8bf90b10c1fece07f4e4cb3bba97d3de/barcode/image/7833cc71-707a-4762-8d8d-f642952011c4/d8423692-4ce2-43d7-8987-b6cb718c389d.svg",
        "owner_id": "909e426f-5f62-47f9-aa99-157dcb31bf4a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/909e426f-5f62-47f9-aa99-157dcb31bf4a"
          },
          "data": {
            "type": "customers",
            "id": "909e426f-5f62-47f9-aa99-157dcb31bf4a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "909e426f-5f62-47f9-aa99-157dcb31bf4a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T12:37:00+00:00",
        "updated_at": "2022-10-13T12:37:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=909e426f-5f62-47f9-aa99-157dcb31bf4a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=909e426f-5f62-47f9-aa99-157dcb31bf4a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=909e426f-5f62-47f9-aa99-157dcb31bf4a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjY2YzRjYjQtOTVhOS00N2RhLWFhZTItMjFjZTJmMDA0OWU4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b66c4cb4-95a9-47da-aae2-21ce2f0049e8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T12:37:00+00:00",
        "updated_at": "2022-10-13T12:37:00+00:00",
        "number": "http://bqbl.it/b66c4cb4-95a9-47da-aae2-21ce2f0049e8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7e3491ebc4bcebe1527a829312acdff7/barcode/image/b66c4cb4-95a9-47da-aae2-21ce2f0049e8/f0601c8e-c5d1-48ec-9ba1-0a40c59538c9.svg",
        "owner_id": "ab4d8e15-484c-4e1c-a32b-1fd0013889cd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ab4d8e15-484c-4e1c-a32b-1fd0013889cd"
          },
          "data": {
            "type": "customers",
            "id": "ab4d8e15-484c-4e1c-a32b-1fd0013889cd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ab4d8e15-484c-4e1c-a32b-1fd0013889cd",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T12:37:00+00:00",
        "updated_at": "2022-10-13T12:37:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ab4d8e15-484c-4e1c-a32b-1fd0013889cd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ab4d8e15-484c-4e1c-a32b-1fd0013889cd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ab4d8e15-484c-4e1c-a32b-1fd0013889cd&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T12:36:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/478a2a3d-8e81-4967-bfb0-4aadc2dcc15d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "478a2a3d-8e81-4967-bfb0-4aadc2dcc15d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T12:37:01+00:00",
      "updated_at": "2022-10-13T12:37:01+00:00",
      "number": "http://bqbl.it/478a2a3d-8e81-4967-bfb0-4aadc2dcc15d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a1fa5f0b46f253d64f7133ee7125d391/barcode/image/478a2a3d-8e81-4967-bfb0-4aadc2dcc15d/5cf464b2-203a-4612-9ea9-30c642add96a.svg",
      "owner_id": "f63a623d-cc97-4cec-a1fc-84107fd64c14",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f63a623d-cc97-4cec-a1fc-84107fd64c14"
        },
        "data": {
          "type": "customers",
          "id": "f63a623d-cc97-4cec-a1fc-84107fd64c14"
        }
      }
    }
  },
  "included": [
    {
      "id": "f63a623d-cc97-4cec-a1fc-84107fd64c14",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T12:37:01+00:00",
        "updated_at": "2022-10-13T12:37:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f63a623d-cc97-4cec-a1fc-84107fd64c14&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f63a623d-cc97-4cec-a1fc-84107fd64c14&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f63a623d-cc97-4cec-a1fc-84107fd64c14&filter[owner_type]=customers"
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
          "owner_id": "94633a30-f7e2-4891-8bb8-ba3cec0939fa",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "80edd503-f5ff-4bf9-9bc1-7977569bc578",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T12:37:02+00:00",
      "updated_at": "2022-10-13T12:37:02+00:00",
      "number": "http://bqbl.it/80edd503-f5ff-4bf9-9bc1-7977569bc578",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4b986f452e6cac3576c5a7a856252171/barcode/image/80edd503-f5ff-4bf9-9bc1-7977569bc578/f9c69062-6790-4a88-a43e-665bc9143b49.svg",
      "owner_id": "94633a30-f7e2-4891-8bb8-ba3cec0939fa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/26e9ffaf-f6f9-4792-a334-1f41afc4d5ea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "26e9ffaf-f6f9-4792-a334-1f41afc4d5ea",
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
    "id": "26e9ffaf-f6f9-4792-a334-1f41afc4d5ea",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T12:37:02+00:00",
      "updated_at": "2022-10-13T12:37:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a3ac5ab33a28d677c9c333659230f15b/barcode/image/26e9ffaf-f6f9-4792-a334-1f41afc4d5ea/34aafe1e-eba5-44a5-8524-7f619fdc3dae.svg",
      "owner_id": "a2ff45d9-244a-4831-bcb8-e91f613d21d9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f3192453-4c5d-42e4-aeca-a709ae6ac91f' \
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