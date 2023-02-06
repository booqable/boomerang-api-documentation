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
      "id": "16a571b0-ccb4-4e79-997b-17ab5189da2e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T18:56:54+00:00",
        "updated_at": "2023-02-06T18:56:54+00:00",
        "number": "http://bqbl.it/16a571b0-ccb4-4e79-997b-17ab5189da2e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/314b291141af4899831b528175417278/barcode/image/16a571b0-ccb4-4e79-997b-17ab5189da2e/df6d361b-7d80-4cc8-9f1b-7e2e547b2abc.svg",
        "owner_id": "a15e4d33-4777-45a5-b5bf-d05384713574",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a15e4d33-4777-45a5-b5bf-d05384713574"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4dd93715-b44a-4047-8f31-633d2724b46c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4dd93715-b44a-4047-8f31-633d2724b46c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T18:56:54+00:00",
        "updated_at": "2023-02-06T18:56:54+00:00",
        "number": "http://bqbl.it/4dd93715-b44a-4047-8f31-633d2724b46c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ea3973066ce406f89687d6940bc31d7e/barcode/image/4dd93715-b44a-4047-8f31-633d2724b46c/7eaa38d6-635c-4f67-ab39-80479a2acfb4.svg",
        "owner_id": "64762f99-4c50-4cf1-9512-2d6d8dc245e3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/64762f99-4c50-4cf1-9512-2d6d8dc245e3"
          },
          "data": {
            "type": "customers",
            "id": "64762f99-4c50-4cf1-9512-2d6d8dc245e3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "64762f99-4c50-4cf1-9512-2d6d8dc245e3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T18:56:54+00:00",
        "updated_at": "2023-02-06T18:56:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=64762f99-4c50-4cf1-9512-2d6d8dc245e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=64762f99-4c50-4cf1-9512-2d6d8dc245e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=64762f99-4c50-4cf1-9512-2d6d8dc245e3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTRlYzVhMmUtZGFkZC00MGJmLWIzMzctNTljYzUyNzczOTU0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a4ec5a2e-dadd-40bf-b337-59cc52773954",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T18:56:55+00:00",
        "updated_at": "2023-02-06T18:56:55+00:00",
        "number": "http://bqbl.it/a4ec5a2e-dadd-40bf-b337-59cc52773954",
        "barcode_type": "qr_code",
        "image_url": "/uploads/14591bd909f25587d55ce7715282572f/barcode/image/a4ec5a2e-dadd-40bf-b337-59cc52773954/c34acbcd-c8bd-4fea-abfa-5a96ec1368ca.svg",
        "owner_id": "75d0ce4e-af68-438f-9455-136626b4d597",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/75d0ce4e-af68-438f-9455-136626b4d597"
          },
          "data": {
            "type": "customers",
            "id": "75d0ce4e-af68-438f-9455-136626b4d597"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "75d0ce4e-af68-438f-9455-136626b4d597",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T18:56:55+00:00",
        "updated_at": "2023-02-06T18:56:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=75d0ce4e-af68-438f-9455-136626b4d597&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=75d0ce4e-af68-438f-9455-136626b4d597&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=75d0ce4e-af68-438f-9455-136626b4d597&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T18:56:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e4eac740-5617-4d0e-a7a5-81232516239f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e4eac740-5617-4d0e-a7a5-81232516239f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T18:56:55+00:00",
      "updated_at": "2023-02-06T18:56:55+00:00",
      "number": "http://bqbl.it/e4eac740-5617-4d0e-a7a5-81232516239f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e3722cbfbdf67d5b664147ec5faff8ee/barcode/image/e4eac740-5617-4d0e-a7a5-81232516239f/6506b0a0-5994-451f-a0bd-7e1d7ee52a1c.svg",
      "owner_id": "72459bc9-ef07-4618-9e38-2ae9f3b6c7e8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/72459bc9-ef07-4618-9e38-2ae9f3b6c7e8"
        },
        "data": {
          "type": "customers",
          "id": "72459bc9-ef07-4618-9e38-2ae9f3b6c7e8"
        }
      }
    }
  },
  "included": [
    {
      "id": "72459bc9-ef07-4618-9e38-2ae9f3b6c7e8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T18:56:55+00:00",
        "updated_at": "2023-02-06T18:56:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=72459bc9-ef07-4618-9e38-2ae9f3b6c7e8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=72459bc9-ef07-4618-9e38-2ae9f3b6c7e8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=72459bc9-ef07-4618-9e38-2ae9f3b6c7e8&filter[owner_type]=customers"
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
          "owner_id": "be36b55a-e704-41ea-8f2f-0fb74a6dfabd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dff66429-baf1-4d57-921c-f48c137a932d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T18:56:56+00:00",
      "updated_at": "2023-02-06T18:56:56+00:00",
      "number": "http://bqbl.it/dff66429-baf1-4d57-921c-f48c137a932d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/701b5c30aaa42a9e867ac25f75e94a84/barcode/image/dff66429-baf1-4d57-921c-f48c137a932d/e878da62-3387-4058-b0b1-14f1d543da00.svg",
      "owner_id": "be36b55a-e704-41ea-8f2f-0fb74a6dfabd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cc3e6558-d86c-477e-8e40-6d8f9e86a032' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cc3e6558-d86c-477e-8e40-6d8f9e86a032",
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
    "id": "cc3e6558-d86c-477e-8e40-6d8f9e86a032",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T18:56:56+00:00",
      "updated_at": "2023-02-06T18:56:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3a1a9335581a5c2e55f7187d133771f1/barcode/image/cc3e6558-d86c-477e-8e40-6d8f9e86a032/e936ae2f-97d8-4277-b792-5f18f3c2feb2.svg",
      "owner_id": "ef113c93-175d-4601-a53e-80b7e173b376",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7cbc1e69-a25c-4e4c-99da-c174f00bcb2a' \
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