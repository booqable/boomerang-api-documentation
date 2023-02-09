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
      "id": "5d698b1a-75e6-4a64-9e59-41cf96f4444e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:17:19+00:00",
        "updated_at": "2023-02-09T12:17:19+00:00",
        "number": "http://bqbl.it/5d698b1a-75e6-4a64-9e59-41cf96f4444e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b31d37fae0703a8c9071668cd2c1f7a/barcode/image/5d698b1a-75e6-4a64-9e59-41cf96f4444e/b69111df-21a9-4aef-97d1-ce81d3822871.svg",
        "owner_id": "e69ca059-ff65-4ec2-9b6c-3bee38e95899",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e69ca059-ff65-4ec2-9b6c-3bee38e95899"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7601d62e-af25-496a-ac76-4334e3de2e6c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7601d62e-af25-496a-ac76-4334e3de2e6c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:17:19+00:00",
        "updated_at": "2023-02-09T12:17:19+00:00",
        "number": "http://bqbl.it/7601d62e-af25-496a-ac76-4334e3de2e6c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9d0752294d47e7fd7cef91bf5b17e7a0/barcode/image/7601d62e-af25-496a-ac76-4334e3de2e6c/f985af1d-fb17-4083-8dec-44cbd9268b12.svg",
        "owner_id": "dcda1b07-0256-46be-936d-7af15aa6da3f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dcda1b07-0256-46be-936d-7af15aa6da3f"
          },
          "data": {
            "type": "customers",
            "id": "dcda1b07-0256-46be-936d-7af15aa6da3f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dcda1b07-0256-46be-936d-7af15aa6da3f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:17:19+00:00",
        "updated_at": "2023-02-09T12:17:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=dcda1b07-0256-46be-936d-7af15aa6da3f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dcda1b07-0256-46be-936d-7af15aa6da3f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dcda1b07-0256-46be-936d-7af15aa6da3f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODBlYmJhMTAtOWRmYy00N2M3LTk3MTEtOGUwMTMwMjJiZmI4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "80ebba10-9dfc-47c7-9711-8e013022bfb8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:17:20+00:00",
        "updated_at": "2023-02-09T12:17:20+00:00",
        "number": "http://bqbl.it/80ebba10-9dfc-47c7-9711-8e013022bfb8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ce1309bbda88ec3d2eb4464fc4424d66/barcode/image/80ebba10-9dfc-47c7-9711-8e013022bfb8/8cf05366-d55a-4c4d-9ceb-f01b90ce6e37.svg",
        "owner_id": "4483cd6b-279a-4805-bda6-ed6c02e7a3ca",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4483cd6b-279a-4805-bda6-ed6c02e7a3ca"
          },
          "data": {
            "type": "customers",
            "id": "4483cd6b-279a-4805-bda6-ed6c02e7a3ca"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4483cd6b-279a-4805-bda6-ed6c02e7a3ca",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:17:20+00:00",
        "updated_at": "2023-02-09T12:17:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4483cd6b-279a-4805-bda6-ed6c02e7a3ca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4483cd6b-279a-4805-bda6-ed6c02e7a3ca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4483cd6b-279a-4805-bda6-ed6c02e7a3ca&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:16:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/933a45b4-e043-40b7-914c-d24e6d1c10c3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "933a45b4-e043-40b7-914c-d24e6d1c10c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:17:20+00:00",
      "updated_at": "2023-02-09T12:17:20+00:00",
      "number": "http://bqbl.it/933a45b4-e043-40b7-914c-d24e6d1c10c3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7d6e7f4f9bd9320b4db734666b953aa9/barcode/image/933a45b4-e043-40b7-914c-d24e6d1c10c3/14d3c3f6-a907-4b9a-93bd-e1e9c7546f2c.svg",
      "owner_id": "b38eb0dd-6e95-41e6-bcab-45dcca0673a2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b38eb0dd-6e95-41e6-bcab-45dcca0673a2"
        },
        "data": {
          "type": "customers",
          "id": "b38eb0dd-6e95-41e6-bcab-45dcca0673a2"
        }
      }
    }
  },
  "included": [
    {
      "id": "b38eb0dd-6e95-41e6-bcab-45dcca0673a2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:17:20+00:00",
        "updated_at": "2023-02-09T12:17:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b38eb0dd-6e95-41e6-bcab-45dcca0673a2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b38eb0dd-6e95-41e6-bcab-45dcca0673a2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b38eb0dd-6e95-41e6-bcab-45dcca0673a2&filter[owner_type]=customers"
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
          "owner_id": "806065a0-558a-4f1c-86b8-92e7a45aa08d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "783e7d25-25d2-4527-a989-33acf7be0fe3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:17:21+00:00",
      "updated_at": "2023-02-09T12:17:21+00:00",
      "number": "http://bqbl.it/783e7d25-25d2-4527-a989-33acf7be0fe3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/187700d46ab7eb00e930cb7fa786d1aa/barcode/image/783e7d25-25d2-4527-a989-33acf7be0fe3/5dcb89e2-40d1-432a-ae26-033abc53a390.svg",
      "owner_id": "806065a0-558a-4f1c-86b8-92e7a45aa08d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4565ad02-39ab-406c-b8ee-d28d7e3f7b9d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4565ad02-39ab-406c-b8ee-d28d7e3f7b9d",
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
    "id": "4565ad02-39ab-406c-b8ee-d28d7e3f7b9d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:17:21+00:00",
      "updated_at": "2023-02-09T12:17:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e3f7657064e830323ee1fd941e4ef248/barcode/image/4565ad02-39ab-406c-b8ee-d28d7e3f7b9d/917c3b0e-a5b9-4bbc-8942-dfee44f92f94.svg",
      "owner_id": "92b87d55-d763-4570-b6b4-97380272013e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/137fc3cf-59b8-4767-8c6a-f27afadf61e3' \
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