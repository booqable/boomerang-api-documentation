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
      "id": "1c0db324-302a-4348-949e-8dc2d739ed0e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T13:48:36+00:00",
        "updated_at": "2023-03-09T13:48:36+00:00",
        "number": "http://bqbl.it/1c0db324-302a-4348-949e-8dc2d739ed0e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e512814701e5611cdf6dbb07907d2f35/barcode/image/1c0db324-302a-4348-949e-8dc2d739ed0e/30bb0b49-7938-4729-8d95-66d5154bd7ea.svg",
        "owner_id": "6110ff9b-2431-4770-9c6e-16fb6df18a48",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6110ff9b-2431-4770-9c6e-16fb6df18a48"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1813d398-f07c-4346-b011-25e9921b1cb3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1813d398-f07c-4346-b011-25e9921b1cb3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T13:48:36+00:00",
        "updated_at": "2023-03-09T13:48:36+00:00",
        "number": "http://bqbl.it/1813d398-f07c-4346-b011-25e9921b1cb3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/717fb3817b004954d8fd6b924df88139/barcode/image/1813d398-f07c-4346-b011-25e9921b1cb3/f7827085-dd76-47d4-9bf2-fdfcb6eb4286.svg",
        "owner_id": "eb3043c9-4096-43d0-881e-524e24bc588f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/eb3043c9-4096-43d0-881e-524e24bc588f"
          },
          "data": {
            "type": "customers",
            "id": "eb3043c9-4096-43d0-881e-524e24bc588f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "eb3043c9-4096-43d0-881e-524e24bc588f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T13:48:36+00:00",
        "updated_at": "2023-03-09T13:48:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=eb3043c9-4096-43d0-881e-524e24bc588f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=eb3043c9-4096-43d0-881e-524e24bc588f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=eb3043c9-4096-43d0-881e-524e24bc588f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODczMTY5MzQtYjkyZC00Mzg2LTk4NTEtZWFiNzA0YjFlNThl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "87316934-b92d-4386-9851-eab704b1e58e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T13:48:37+00:00",
        "updated_at": "2023-03-09T13:48:37+00:00",
        "number": "http://bqbl.it/87316934-b92d-4386-9851-eab704b1e58e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a32a8d1161719666b0b2008e5295336a/barcode/image/87316934-b92d-4386-9851-eab704b1e58e/e9051284-4db8-49c4-a7f2-4e7f5d36f6de.svg",
        "owner_id": "4892d986-7096-4e35-9f2e-d6901e5f04fa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4892d986-7096-4e35-9f2e-d6901e5f04fa"
          },
          "data": {
            "type": "customers",
            "id": "4892d986-7096-4e35-9f2e-d6901e5f04fa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4892d986-7096-4e35-9f2e-d6901e5f04fa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T13:48:37+00:00",
        "updated_at": "2023-03-09T13:48:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4892d986-7096-4e35-9f2e-d6901e5f04fa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4892d986-7096-4e35-9f2e-d6901e5f04fa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4892d986-7096-4e35-9f2e-d6901e5f04fa&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T13:48:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/677e82a3-14a0-44fe-a077-ae7b8cc2a43b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "677e82a3-14a0-44fe-a077-ae7b8cc2a43b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T13:48:37+00:00",
      "updated_at": "2023-03-09T13:48:37+00:00",
      "number": "http://bqbl.it/677e82a3-14a0-44fe-a077-ae7b8cc2a43b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c9a3f031da34c0f0e0001114bd9a2962/barcode/image/677e82a3-14a0-44fe-a077-ae7b8cc2a43b/15ae3db5-76fd-456a-83e9-111bae9a397d.svg",
      "owner_id": "6d3fffe1-5576-483d-9f6a-fede9c1ab7d5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6d3fffe1-5576-483d-9f6a-fede9c1ab7d5"
        },
        "data": {
          "type": "customers",
          "id": "6d3fffe1-5576-483d-9f6a-fede9c1ab7d5"
        }
      }
    }
  },
  "included": [
    {
      "id": "6d3fffe1-5576-483d-9f6a-fede9c1ab7d5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T13:48:37+00:00",
        "updated_at": "2023-03-09T13:48:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6d3fffe1-5576-483d-9f6a-fede9c1ab7d5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6d3fffe1-5576-483d-9f6a-fede9c1ab7d5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6d3fffe1-5576-483d-9f6a-fede9c1ab7d5&filter[owner_type]=customers"
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
          "owner_id": "980ee460-3b52-4cd6-b7dc-cbd8cc04b54d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f5d45731-3645-4439-9e6e-36476b6e5be3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T13:48:38+00:00",
      "updated_at": "2023-03-09T13:48:38+00:00",
      "number": "http://bqbl.it/f5d45731-3645-4439-9e6e-36476b6e5be3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7e547c025e3e846093cce2790c52b8e6/barcode/image/f5d45731-3645-4439-9e6e-36476b6e5be3/c743f2d4-5df4-4ad3-aba2-0218d1acc08c.svg",
      "owner_id": "980ee460-3b52-4cd6-b7dc-cbd8cc04b54d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/220d8f2f-2953-4583-862f-4f912a80104d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "220d8f2f-2953-4583-862f-4f912a80104d",
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
    "id": "220d8f2f-2953-4583-862f-4f912a80104d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T13:48:38+00:00",
      "updated_at": "2023-03-09T13:48:38+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c47c32e5461a053e601179ff1d761610/barcode/image/220d8f2f-2953-4583-862f-4f912a80104d/e753f0c0-8645-40e0-b1e5-9f9d3b41c910.svg",
      "owner_id": "92772e99-4964-4fa6-add5-67c131364a4a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3000b679-2711-498f-86eb-0a9ff42a6b2b' \
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