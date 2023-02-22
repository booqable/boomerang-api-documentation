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
      "id": "24521672-4276-4ff6-a1af-6746a8bfd57f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T08:39:49+00:00",
        "updated_at": "2023-02-22T08:39:49+00:00",
        "number": "http://bqbl.it/24521672-4276-4ff6-a1af-6746a8bfd57f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7cf8cf12e74ba1217434c5f698eddde7/barcode/image/24521672-4276-4ff6-a1af-6746a8bfd57f/3aab2298-98e0-4b6a-ac50-5d10119e3b13.svg",
        "owner_id": "ad8092c4-85ce-4be9-9b0a-178d5cf88e7f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ad8092c4-85ce-4be9-9b0a-178d5cf88e7f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F45531fc6-b5f2-46e2-ab99-eaf05cb0ff77&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "45531fc6-b5f2-46e2-ab99-eaf05cb0ff77",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T08:39:49+00:00",
        "updated_at": "2023-02-22T08:39:49+00:00",
        "number": "http://bqbl.it/45531fc6-b5f2-46e2-ab99-eaf05cb0ff77",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f1cfd4082b30694c1fca21b43ad363b3/barcode/image/45531fc6-b5f2-46e2-ab99-eaf05cb0ff77/f36739ee-b903-4133-b741-208e69a8ac99.svg",
        "owner_id": "7b5d4c3f-9948-41b2-b4f8-ed789029d25c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7b5d4c3f-9948-41b2-b4f8-ed789029d25c"
          },
          "data": {
            "type": "customers",
            "id": "7b5d4c3f-9948-41b2-b4f8-ed789029d25c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7b5d4c3f-9948-41b2-b4f8-ed789029d25c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T08:39:49+00:00",
        "updated_at": "2023-02-22T08:39:49+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7b5d4c3f-9948-41b2-b4f8-ed789029d25c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7b5d4c3f-9948-41b2-b4f8-ed789029d25c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7b5d4c3f-9948-41b2-b4f8-ed789029d25c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODA2YjdkMjItNjYwZC00M2JjLThmZDAtZjlmZDJlNjc5ZjYz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "806b7d22-660d-43bc-8fd0-f9fd2e679f63",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T08:39:50+00:00",
        "updated_at": "2023-02-22T08:39:50+00:00",
        "number": "http://bqbl.it/806b7d22-660d-43bc-8fd0-f9fd2e679f63",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fbe9180bbb5fddc44316ed78abb1c3e8/barcode/image/806b7d22-660d-43bc-8fd0-f9fd2e679f63/b40d08c6-feb8-4537-a6ce-f9a850ce26a3.svg",
        "owner_id": "949890bf-5ae2-4b77-9aab-da54eeb05830",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/949890bf-5ae2-4b77-9aab-da54eeb05830"
          },
          "data": {
            "type": "customers",
            "id": "949890bf-5ae2-4b77-9aab-da54eeb05830"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "949890bf-5ae2-4b77-9aab-da54eeb05830",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T08:39:50+00:00",
        "updated_at": "2023-02-22T08:39:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=949890bf-5ae2-4b77-9aab-da54eeb05830&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=949890bf-5ae2-4b77-9aab-da54eeb05830&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=949890bf-5ae2-4b77-9aab-da54eeb05830&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T08:39:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/76331874-f904-4793-a77b-4b11a09d931a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "76331874-f904-4793-a77b-4b11a09d931a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T08:39:50+00:00",
      "updated_at": "2023-02-22T08:39:50+00:00",
      "number": "http://bqbl.it/76331874-f904-4793-a77b-4b11a09d931a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4b9fbb1b8d50c44b7edca630c8265790/barcode/image/76331874-f904-4793-a77b-4b11a09d931a/64c3ba23-1b98-467e-902f-171d86c3659d.svg",
      "owner_id": "4b2214ee-6ff2-474f-a1eb-e9db4aab416e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4b2214ee-6ff2-474f-a1eb-e9db4aab416e"
        },
        "data": {
          "type": "customers",
          "id": "4b2214ee-6ff2-474f-a1eb-e9db4aab416e"
        }
      }
    }
  },
  "included": [
    {
      "id": "4b2214ee-6ff2-474f-a1eb-e9db4aab416e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T08:39:50+00:00",
        "updated_at": "2023-02-22T08:39:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4b2214ee-6ff2-474f-a1eb-e9db4aab416e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4b2214ee-6ff2-474f-a1eb-e9db4aab416e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4b2214ee-6ff2-474f-a1eb-e9db4aab416e&filter[owner_type]=customers"
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
          "owner_id": "322bb412-18ec-4333-a905-6c84c0010b3c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9ae04d02-c467-4b31-b60b-3a1aefa80cd8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T08:39:51+00:00",
      "updated_at": "2023-02-22T08:39:51+00:00",
      "number": "http://bqbl.it/9ae04d02-c467-4b31-b60b-3a1aefa80cd8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8663822eb0c3f5327c0d207b620579bf/barcode/image/9ae04d02-c467-4b31-b60b-3a1aefa80cd8/bdc51ab9-1cbf-411a-b0b0-799fb3816dd0.svg",
      "owner_id": "322bb412-18ec-4333-a905-6c84c0010b3c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fb29b574-4b19-4cdf-abdd-f2a5088e4fc3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fb29b574-4b19-4cdf-abdd-f2a5088e4fc3",
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
    "id": "fb29b574-4b19-4cdf-abdd-f2a5088e4fc3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T08:39:51+00:00",
      "updated_at": "2023-02-22T08:39:51+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/08be799fb44cd60e1b1c8343517f4b8b/barcode/image/fb29b574-4b19-4cdf-abdd-f2a5088e4fc3/ac9ad2d2-a98b-40ac-9795-ce7957278c08.svg",
      "owner_id": "7486b44a-bd74-4822-9a73-fb590a8dd592",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e448b15e-b68e-4a6b-806e-a99e9a7daa6b' \
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