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
      "id": "50bc111c-b5f4-46dd-b759-b09229c3039c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T08:19:02+00:00",
        "updated_at": "2023-02-23T08:19:02+00:00",
        "number": "http://bqbl.it/50bc111c-b5f4-46dd-b759-b09229c3039c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/96ec19af0b96390cc49fb26d7db9c3df/barcode/image/50bc111c-b5f4-46dd-b759-b09229c3039c/ba0aa395-0324-4fb8-93b2-a986e0f8e543.svg",
        "owner_id": "baac4124-1149-4dd2-aff7-86941fd8a54a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/baac4124-1149-4dd2-aff7-86941fd8a54a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe13c976b-9895-4272-8e7e-9b307e88b8df&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e13c976b-9895-4272-8e7e-9b307e88b8df",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T08:19:03+00:00",
        "updated_at": "2023-02-23T08:19:03+00:00",
        "number": "http://bqbl.it/e13c976b-9895-4272-8e7e-9b307e88b8df",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e56f624eac12d7dc9a6aa96281395224/barcode/image/e13c976b-9895-4272-8e7e-9b307e88b8df/8f446afc-74ce-4b1d-973b-421b606984ca.svg",
        "owner_id": "b362b3db-98fa-4cbd-b9d6-4627918ea7bc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b362b3db-98fa-4cbd-b9d6-4627918ea7bc"
          },
          "data": {
            "type": "customers",
            "id": "b362b3db-98fa-4cbd-b9d6-4627918ea7bc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b362b3db-98fa-4cbd-b9d6-4627918ea7bc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T08:19:03+00:00",
        "updated_at": "2023-02-23T08:19:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b362b3db-98fa-4cbd-b9d6-4627918ea7bc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b362b3db-98fa-4cbd-b9d6-4627918ea7bc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b362b3db-98fa-4cbd-b9d6-4627918ea7bc&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2YxN2ZkNzQtOWJlOS00NDVlLTg0OWYtNWZjNzVkZjQ2NDRj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3f17fd74-9be9-445e-849f-5fc75df4644c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T08:19:03+00:00",
        "updated_at": "2023-02-23T08:19:03+00:00",
        "number": "http://bqbl.it/3f17fd74-9be9-445e-849f-5fc75df4644c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1b5ff0d1a8722ccf634929d1d021069/barcode/image/3f17fd74-9be9-445e-849f-5fc75df4644c/8b027d75-aa96-43a7-8b69-491f15ecde20.svg",
        "owner_id": "92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a"
          },
          "data": {
            "type": "customers",
            "id": "92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T08:19:03+00:00",
        "updated_at": "2023-02-23T08:19:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92ac2afc-309e-4b5a-be0b-7c7a31ef2f3a&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T08:18:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/01ad899a-20be-4d2d-974c-9d803577f6d2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "01ad899a-20be-4d2d-974c-9d803577f6d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T08:19:05+00:00",
      "updated_at": "2023-02-23T08:19:05+00:00",
      "number": "http://bqbl.it/01ad899a-20be-4d2d-974c-9d803577f6d2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ca79f08de5baaa27abf29dd7e051a82/barcode/image/01ad899a-20be-4d2d-974c-9d803577f6d2/8241bff7-4f33-4669-94f7-e5383f39a59a.svg",
      "owner_id": "41800c18-d43c-4384-a708-fd112d7b8a6e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/41800c18-d43c-4384-a708-fd112d7b8a6e"
        },
        "data": {
          "type": "customers",
          "id": "41800c18-d43c-4384-a708-fd112d7b8a6e"
        }
      }
    }
  },
  "included": [
    {
      "id": "41800c18-d43c-4384-a708-fd112d7b8a6e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T08:19:04+00:00",
        "updated_at": "2023-02-23T08:19:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=41800c18-d43c-4384-a708-fd112d7b8a6e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=41800c18-d43c-4384-a708-fd112d7b8a6e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=41800c18-d43c-4384-a708-fd112d7b8a6e&filter[owner_type]=customers"
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
          "owner_id": "ebcb6ffe-95aa-4b93-bd6a-13bac4ee6244",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b84d5806-ce11-4f38-810c-929c12ea5c2f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T08:19:06+00:00",
      "updated_at": "2023-02-23T08:19:06+00:00",
      "number": "http://bqbl.it/b84d5806-ce11-4f38-810c-929c12ea5c2f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8955590962b0cef38d6048468d9514dc/barcode/image/b84d5806-ce11-4f38-810c-929c12ea5c2f/fb3a252e-e9e9-402d-b01f-f602e5105aa6.svg",
      "owner_id": "ebcb6ffe-95aa-4b93-bd6a-13bac4ee6244",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3c6f41c7-9c0f-4a93-94a0-a1c6b2fc1948' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3c6f41c7-9c0f-4a93-94a0-a1c6b2fc1948",
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
    "id": "3c6f41c7-9c0f-4a93-94a0-a1c6b2fc1948",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T08:19:07+00:00",
      "updated_at": "2023-02-23T08:19:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4943749aa74d0aff8aa03ab5a35f9044/barcode/image/3c6f41c7-9c0f-4a93-94a0-a1c6b2fc1948/3e0eee78-6831-4384-bcbc-dd35c50d09c9.svg",
      "owner_id": "680db857-be34-4f4b-ad3b-7eab366d78f5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7a1be310-dfdf-49a1-9a7e-aae5362df2ef' \
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