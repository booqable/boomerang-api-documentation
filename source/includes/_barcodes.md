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
      "id": "543fff3a-98fa-4941-abe7-deb1ebf30bf7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-30T11:57:24+00:00",
        "updated_at": "2022-09-30T11:57:24+00:00",
        "number": "http://bqbl.it/543fff3a-98fa-4941-abe7-deb1ebf30bf7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/79428fd78f5780a7f8a35dcf8a000ff7/barcode/image/543fff3a-98fa-4941-abe7-deb1ebf30bf7/7788aed1-fabb-46ad-ab3a-bc5ea7302a5f.svg",
        "owner_id": "77390322-2898-4d25-924e-a75a0635077c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/77390322-2898-4d25-924e-a75a0635077c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe7ab1f11-94db-48c8-bf3b-c15720074db4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e7ab1f11-94db-48c8-bf3b-c15720074db4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-30T11:57:24+00:00",
        "updated_at": "2022-09-30T11:57:24+00:00",
        "number": "http://bqbl.it/e7ab1f11-94db-48c8-bf3b-c15720074db4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f5843c2821a1a446d8c1f51736a23305/barcode/image/e7ab1f11-94db-48c8-bf3b-c15720074db4/e0cf4a65-b9b3-49e0-874d-0b81709d70fa.svg",
        "owner_id": "036679f4-5851-446a-bfd7-4ff91de5868f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/036679f4-5851-446a-bfd7-4ff91de5868f"
          },
          "data": {
            "type": "customers",
            "id": "036679f4-5851-446a-bfd7-4ff91de5868f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "036679f4-5851-446a-bfd7-4ff91de5868f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-30T11:57:24+00:00",
        "updated_at": "2022-09-30T11:57:24+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=036679f4-5851-446a-bfd7-4ff91de5868f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=036679f4-5851-446a-bfd7-4ff91de5868f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=036679f4-5851-446a-bfd7-4ff91de5868f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZThmODUzOGMtZjY0Zi00MDA1LTg0OGUtZWZkMmJkZjJmNzgz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e8f8538c-f64f-4005-848e-efd2bdf2f783",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-30T11:57:25+00:00",
        "updated_at": "2022-09-30T11:57:25+00:00",
        "number": "http://bqbl.it/e8f8538c-f64f-4005-848e-efd2bdf2f783",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2f9f120fb34d3bdbeb4faa73c7282395/barcode/image/e8f8538c-f64f-4005-848e-efd2bdf2f783/6032b6f4-5247-4017-a283-70254b27e873.svg",
        "owner_id": "70f21c21-c28f-4cdf-82a3-e489db8fe26d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/70f21c21-c28f-4cdf-82a3-e489db8fe26d"
          },
          "data": {
            "type": "customers",
            "id": "70f21c21-c28f-4cdf-82a3-e489db8fe26d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "70f21c21-c28f-4cdf-82a3-e489db8fe26d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-30T11:57:25+00:00",
        "updated_at": "2022-09-30T11:57:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=70f21c21-c28f-4cdf-82a3-e489db8fe26d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=70f21c21-c28f-4cdf-82a3-e489db8fe26d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=70f21c21-c28f-4cdf-82a3-e489db8fe26d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-30T11:57:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bf6a75db-8286-463d-bfbf-db283da6d1c5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bf6a75db-8286-463d-bfbf-db283da6d1c5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-30T11:57:25+00:00",
      "updated_at": "2022-09-30T11:57:25+00:00",
      "number": "http://bqbl.it/bf6a75db-8286-463d-bfbf-db283da6d1c5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/11bd19a099838836c595835abc5a3583/barcode/image/bf6a75db-8286-463d-bfbf-db283da6d1c5/ddddfc50-be5c-48e7-9b3b-07994b48fc76.svg",
      "owner_id": "8a878338-7328-4498-aa25-e935fc83ea2b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8a878338-7328-4498-aa25-e935fc83ea2b"
        },
        "data": {
          "type": "customers",
          "id": "8a878338-7328-4498-aa25-e935fc83ea2b"
        }
      }
    }
  },
  "included": [
    {
      "id": "8a878338-7328-4498-aa25-e935fc83ea2b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-30T11:57:25+00:00",
        "updated_at": "2022-09-30T11:57:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8a878338-7328-4498-aa25-e935fc83ea2b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a878338-7328-4498-aa25-e935fc83ea2b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a878338-7328-4498-aa25-e935fc83ea2b&filter[owner_type]=customers"
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
          "owner_id": "802eee33-6d5d-47d2-996f-2c0ea6727138",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a949dbcb-7338-4cb8-8245-67a428777394",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-30T11:57:26+00:00",
      "updated_at": "2022-09-30T11:57:26+00:00",
      "number": "http://bqbl.it/a949dbcb-7338-4cb8-8245-67a428777394",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9b20cbd9732758abfde5d0d5e968117e/barcode/image/a949dbcb-7338-4cb8-8245-67a428777394/25d66fa7-f8f7-4a5d-92a0-f16e66711cd8.svg",
      "owner_id": "802eee33-6d5d-47d2-996f-2c0ea6727138",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2708dfd3-4329-4588-899b-f9b9e1bf75b4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2708dfd3-4329-4588-899b-f9b9e1bf75b4",
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
    "id": "2708dfd3-4329-4588-899b-f9b9e1bf75b4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-30T11:57:26+00:00",
      "updated_at": "2022-09-30T11:57:26+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7721e4909f722d2311dc64edf63db57a/barcode/image/2708dfd3-4329-4588-899b-f9b9e1bf75b4/359fb142-9fd4-493f-9ff0-34a2f752eb0d.svg",
      "owner_id": "b175943d-e726-4ec7-b240-66dc243c3c9d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ae9dd690-53b4-4242-ba9d-f543f8c7c60f' \
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