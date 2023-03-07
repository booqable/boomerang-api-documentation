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
      "id": "d0e23597-0c81-4383-bde7-c6988d4d2639",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T11:18:26+00:00",
        "updated_at": "2023-03-07T11:18:26+00:00",
        "number": "http://bqbl.it/d0e23597-0c81-4383-bde7-c6988d4d2639",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1008ff39549e69f0c0d0703ec9f1d443/barcode/image/d0e23597-0c81-4383-bde7-c6988d4d2639/4d2f96cd-45a0-433f-962e-9d6a80be6602.svg",
        "owner_id": "c4f9f9a4-6abb-4cf8-b6ec-a940611d114e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c4f9f9a4-6abb-4cf8-b6ec-a940611d114e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc5a83b17-c911-4518-9e1b-7222c03aba23&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c5a83b17-c911-4518-9e1b-7222c03aba23",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T11:18:26+00:00",
        "updated_at": "2023-03-07T11:18:26+00:00",
        "number": "http://bqbl.it/c5a83b17-c911-4518-9e1b-7222c03aba23",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d06b882d31d6c6f468095b8646d13284/barcode/image/c5a83b17-c911-4518-9e1b-7222c03aba23/427124d2-84a0-46ee-84ab-6faefd3ce2e6.svg",
        "owner_id": "c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe"
          },
          "data": {
            "type": "customers",
            "id": "c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T11:18:26+00:00",
        "updated_at": "2023-03-07T11:18:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c0ca5d7c-cfda-4d5c-b5af-3c8aefad3dbe&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmE4YzY5OGMtZjg2NC00ZDY3LTlkMDAtYTE2ZmViMjg5ZDQ2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ba8c698c-f864-4d67-9d00-a16feb289d46",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T11:18:27+00:00",
        "updated_at": "2023-03-07T11:18:27+00:00",
        "number": "http://bqbl.it/ba8c698c-f864-4d67-9d00-a16feb289d46",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b21237878e46718eaecdafa922bc7ac/barcode/image/ba8c698c-f864-4d67-9d00-a16feb289d46/ec5dd65a-b243-4d35-ac1f-8822509d4ab0.svg",
        "owner_id": "25fee49d-7cc2-472c-89b9-64480efdb86b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/25fee49d-7cc2-472c-89b9-64480efdb86b"
          },
          "data": {
            "type": "customers",
            "id": "25fee49d-7cc2-472c-89b9-64480efdb86b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "25fee49d-7cc2-472c-89b9-64480efdb86b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T11:18:27+00:00",
        "updated_at": "2023-03-07T11:18:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=25fee49d-7cc2-472c-89b9-64480efdb86b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=25fee49d-7cc2-472c-89b9-64480efdb86b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=25fee49d-7cc2-472c-89b9-64480efdb86b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T11:18:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f8c4e68c-03b7-4aac-894b-79372c834cee?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f8c4e68c-03b7-4aac-894b-79372c834cee",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T11:18:28+00:00",
      "updated_at": "2023-03-07T11:18:28+00:00",
      "number": "http://bqbl.it/f8c4e68c-03b7-4aac-894b-79372c834cee",
      "barcode_type": "qr_code",
      "image_url": "/uploads/656ba1203d80c89c7c9bbee67bc3ebc4/barcode/image/f8c4e68c-03b7-4aac-894b-79372c834cee/008714e9-d3d9-4bc9-8bc6-ea77ab878b10.svg",
      "owner_id": "b395765d-5817-46e2-8fdb-845dd7aaf1d6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b395765d-5817-46e2-8fdb-845dd7aaf1d6"
        },
        "data": {
          "type": "customers",
          "id": "b395765d-5817-46e2-8fdb-845dd7aaf1d6"
        }
      }
    }
  },
  "included": [
    {
      "id": "b395765d-5817-46e2-8fdb-845dd7aaf1d6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T11:18:28+00:00",
        "updated_at": "2023-03-07T11:18:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b395765d-5817-46e2-8fdb-845dd7aaf1d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b395765d-5817-46e2-8fdb-845dd7aaf1d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b395765d-5817-46e2-8fdb-845dd7aaf1d6&filter[owner_type]=customers"
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
          "owner_id": "770b78ec-74c9-4732-9709-46b6c51ed3a3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "233aaec0-b1e3-4f5e-8401-eb34f007b87a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T11:18:28+00:00",
      "updated_at": "2023-03-07T11:18:28+00:00",
      "number": "http://bqbl.it/233aaec0-b1e3-4f5e-8401-eb34f007b87a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f00bea9139cae1a645bfe5bc8c5f425e/barcode/image/233aaec0-b1e3-4f5e-8401-eb34f007b87a/0727e465-6dfa-4df0-a35f-e49231a30e8f.svg",
      "owner_id": "770b78ec-74c9-4732-9709-46b6c51ed3a3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ef334427-2834-4f7e-be76-924916d0d4d9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ef334427-2834-4f7e-be76-924916d0d4d9",
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
    "id": "ef334427-2834-4f7e-be76-924916d0d4d9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T11:18:29+00:00",
      "updated_at": "2023-03-07T11:18:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d62d9dad1380c09ea44d4d7c5c80c7ee/barcode/image/ef334427-2834-4f7e-be76-924916d0d4d9/1bf715dd-4682-4fc7-8c37-e87c1dff2f8d.svg",
      "owner_id": "9cdb6d61-a4df-4b51-ac57-000eff84aa57",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/20c0a6ee-4110-44ce-a132-06becd7d0f1d' \
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