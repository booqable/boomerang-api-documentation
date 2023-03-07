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
      "id": "467fac6d-db5f-4841-a344-d0e9a94b1794",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T08:07:37+00:00",
        "updated_at": "2023-03-07T08:07:37+00:00",
        "number": "http://bqbl.it/467fac6d-db5f-4841-a344-d0e9a94b1794",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8dc42f73a43f853b3716ea04c18966a7/barcode/image/467fac6d-db5f-4841-a344-d0e9a94b1794/52de7c57-e110-4fd4-8977-45473df9f9ee.svg",
        "owner_id": "78fa3e6f-9231-4fb4-9832-833bb9e40280",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/78fa3e6f-9231-4fb4-9832-833bb9e40280"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F51db1dc7-223c-476a-a908-cd001d2b3b57&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "51db1dc7-223c-476a-a908-cd001d2b3b57",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T08:07:37+00:00",
        "updated_at": "2023-03-07T08:07:37+00:00",
        "number": "http://bqbl.it/51db1dc7-223c-476a-a908-cd001d2b3b57",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1bc367fea0512bb2d458ed8bb04f8833/barcode/image/51db1dc7-223c-476a-a908-cd001d2b3b57/50bebe19-eee2-45b0-b5cc-0a7ce54c87b0.svg",
        "owner_id": "59a1cc53-8110-4d7b-9429-d8e65e1e0131",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/59a1cc53-8110-4d7b-9429-d8e65e1e0131"
          },
          "data": {
            "type": "customers",
            "id": "59a1cc53-8110-4d7b-9429-d8e65e1e0131"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "59a1cc53-8110-4d7b-9429-d8e65e1e0131",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T08:07:37+00:00",
        "updated_at": "2023-03-07T08:07:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=59a1cc53-8110-4d7b-9429-d8e65e1e0131&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=59a1cc53-8110-4d7b-9429-d8e65e1e0131&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=59a1cc53-8110-4d7b-9429-d8e65e1e0131&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTk5YTY0NWItOTc3Mi00YmRkLWEzNmUtYjA4N2JmOWQwNzEy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "999a645b-9772-4bdd-a36e-b087bf9d0712",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T08:07:38+00:00",
        "updated_at": "2023-03-07T08:07:38+00:00",
        "number": "http://bqbl.it/999a645b-9772-4bdd-a36e-b087bf9d0712",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b00d7c2d2a3a649b4af1c312b363ce45/barcode/image/999a645b-9772-4bdd-a36e-b087bf9d0712/fd082d9d-81a9-4884-851b-352caecea6da.svg",
        "owner_id": "b25da24b-58d0-49ea-b825-771a9821e165",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b25da24b-58d0-49ea-b825-771a9821e165"
          },
          "data": {
            "type": "customers",
            "id": "b25da24b-58d0-49ea-b825-771a9821e165"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b25da24b-58d0-49ea-b825-771a9821e165",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T08:07:38+00:00",
        "updated_at": "2023-03-07T08:07:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b25da24b-58d0-49ea-b825-771a9821e165&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b25da24b-58d0-49ea-b825-771a9821e165&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b25da24b-58d0-49ea-b825-771a9821e165&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:07:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8e12fa65-c816-4bb4-a0cb-29b8f7ed74ee?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8e12fa65-c816-4bb4-a0cb-29b8f7ed74ee",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T08:07:39+00:00",
      "updated_at": "2023-03-07T08:07:39+00:00",
      "number": "http://bqbl.it/8e12fa65-c816-4bb4-a0cb-29b8f7ed74ee",
      "barcode_type": "qr_code",
      "image_url": "/uploads/462a4ac06b67803e273c51bdc56d7c6b/barcode/image/8e12fa65-c816-4bb4-a0cb-29b8f7ed74ee/ad486a70-30d1-4b00-be10-20b253736e60.svg",
      "owner_id": "87ca9f28-d7a3-4902-b7a2-19814cdc32f9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/87ca9f28-d7a3-4902-b7a2-19814cdc32f9"
        },
        "data": {
          "type": "customers",
          "id": "87ca9f28-d7a3-4902-b7a2-19814cdc32f9"
        }
      }
    }
  },
  "included": [
    {
      "id": "87ca9f28-d7a3-4902-b7a2-19814cdc32f9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T08:07:39+00:00",
        "updated_at": "2023-03-07T08:07:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=87ca9f28-d7a3-4902-b7a2-19814cdc32f9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87ca9f28-d7a3-4902-b7a2-19814cdc32f9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87ca9f28-d7a3-4902-b7a2-19814cdc32f9&filter[owner_type]=customers"
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
          "owner_id": "14c878c7-2053-43df-b51c-ea93234fab4c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "54520465-906a-4b4d-8074-7e0878d65e81",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T08:07:41+00:00",
      "updated_at": "2023-03-07T08:07:41+00:00",
      "number": "http://bqbl.it/54520465-906a-4b4d-8074-7e0878d65e81",
      "barcode_type": "qr_code",
      "image_url": "/uploads/643296183f1cc38e8bc21f3b1d1ce312/barcode/image/54520465-906a-4b4d-8074-7e0878d65e81/0631ff13-6aed-4cdd-b3c1-f1c311e84a69.svg",
      "owner_id": "14c878c7-2053-43df-b51c-ea93234fab4c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bfbab838-5a4b-4500-a3ef-30a4ffde0d25' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bfbab838-5a4b-4500-a3ef-30a4ffde0d25",
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
    "id": "bfbab838-5a4b-4500-a3ef-30a4ffde0d25",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T08:07:44+00:00",
      "updated_at": "2023-03-07T08:07:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/19201cdbe9f5306828d0731725c677ad/barcode/image/bfbab838-5a4b-4500-a3ef-30a4ffde0d25/38a89738-eee7-4e55-ab73-2622a343adc9.svg",
      "owner_id": "c6250cca-521f-4765-86fd-0f69b258a683",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1800226c-9bcf-4ad2-9e25-06552ffe060c' \
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