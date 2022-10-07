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
      "id": "1a807c86-08af-4330-b480-686a63517d08",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T12:07:28+00:00",
        "updated_at": "2022-10-07T12:07:28+00:00",
        "number": "http://bqbl.it/1a807c86-08af-4330-b480-686a63517d08",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1cdbdd1f1dd3ad7da72f65d91e77148/barcode/image/1a807c86-08af-4330-b480-686a63517d08/69eebdb3-2627-4e44-a3dc-d27495e408a5.svg",
        "owner_id": "2523a1ca-db5c-4df6-8cda-654faa217416",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2523a1ca-db5c-4df6-8cda-654faa217416"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fad570c48-3742-4d96-989f-a912c1b35474&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ad570c48-3742-4d96-989f-a912c1b35474",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T12:07:28+00:00",
        "updated_at": "2022-10-07T12:07:28+00:00",
        "number": "http://bqbl.it/ad570c48-3742-4d96-989f-a912c1b35474",
        "barcode_type": "qr_code",
        "image_url": "/uploads/90d1c79a42e989ccc443cc688b684ead/barcode/image/ad570c48-3742-4d96-989f-a912c1b35474/cfcbd091-0ad1-4d11-8d01-6ca51db3866e.svg",
        "owner_id": "41a7fef8-7dee-4db9-9968-121617644bbc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/41a7fef8-7dee-4db9-9968-121617644bbc"
          },
          "data": {
            "type": "customers",
            "id": "41a7fef8-7dee-4db9-9968-121617644bbc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "41a7fef8-7dee-4db9-9968-121617644bbc",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T12:07:28+00:00",
        "updated_at": "2022-10-07T12:07:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=41a7fef8-7dee-4db9-9968-121617644bbc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=41a7fef8-7dee-4db9-9968-121617644bbc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=41a7fef8-7dee-4db9-9968-121617644bbc&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzNhOTYwZDktZTE5MC00M2E4LTg5NTUtNmYxMzBlZjA0NzJm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "33a960d9-e190-43a8-8955-6f130ef0472f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T12:07:28+00:00",
        "updated_at": "2022-10-07T12:07:28+00:00",
        "number": "http://bqbl.it/33a960d9-e190-43a8-8955-6f130ef0472f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/16fc7bcb83eb3381a980cf40925058a4/barcode/image/33a960d9-e190-43a8-8955-6f130ef0472f/14154d41-04f0-4df9-a908-0badb19a182a.svg",
        "owner_id": "cf6b34e8-4839-443c-b2e1-c33126d76360",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cf6b34e8-4839-443c-b2e1-c33126d76360"
          },
          "data": {
            "type": "customers",
            "id": "cf6b34e8-4839-443c-b2e1-c33126d76360"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cf6b34e8-4839-443c-b2e1-c33126d76360",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T12:07:28+00:00",
        "updated_at": "2022-10-07T12:07:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cf6b34e8-4839-443c-b2e1-c33126d76360&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cf6b34e8-4839-443c-b2e1-c33126d76360&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cf6b34e8-4839-443c-b2e1-c33126d76360&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T12:07:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/70c4dfe1-0fd3-438e-bbc5-7aa157e30e32?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "70c4dfe1-0fd3-438e-bbc5-7aa157e30e32",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T12:07:29+00:00",
      "updated_at": "2022-10-07T12:07:29+00:00",
      "number": "http://bqbl.it/70c4dfe1-0fd3-438e-bbc5-7aa157e30e32",
      "barcode_type": "qr_code",
      "image_url": "/uploads/03a2e7e6db0cdd861884e5c57fe376f8/barcode/image/70c4dfe1-0fd3-438e-bbc5-7aa157e30e32/eab8ceea-fa4f-4b1d-9e33-353db3f580ec.svg",
      "owner_id": "3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7"
        },
        "data": {
          "type": "customers",
          "id": "3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7"
        }
      }
    }
  },
  "included": [
    {
      "id": "3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T12:07:29+00:00",
        "updated_at": "2022-10-07T12:07:29+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3ccdcc23-d6f1-4f31-8a6b-12ecf4dd5bf7&filter[owner_type]=customers"
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
          "owner_id": "3cee3d07-8ba5-4d77-8765-4bc2acf464a4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f3744376-a63f-406f-90fc-9e0118d593d4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T12:07:29+00:00",
      "updated_at": "2022-10-07T12:07:29+00:00",
      "number": "http://bqbl.it/f3744376-a63f-406f-90fc-9e0118d593d4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c44b161b68cb7636e978fbae72e3e80/barcode/image/f3744376-a63f-406f-90fc-9e0118d593d4/3b3f8b87-a33b-48c9-b5d5-f3ecd69da41e.svg",
      "owner_id": "3cee3d07-8ba5-4d77-8765-4bc2acf464a4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5cff685d-8c7f-4f8a-8710-1a90bc2d9ae9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5cff685d-8c7f-4f8a-8710-1a90bc2d9ae9",
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
    "id": "5cff685d-8c7f-4f8a-8710-1a90bc2d9ae9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T12:07:30+00:00",
      "updated_at": "2022-10-07T12:07:30+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/877fba3675110dd7b797006a7d03b7c0/barcode/image/5cff685d-8c7f-4f8a-8710-1a90bc2d9ae9/79399d48-9174-4b75-9733-648abd1e3386.svg",
      "owner_id": "1c0a9ab6-6624-467a-ae2c-3021c6644edc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8cfbcdda-eba8-4f07-97bb-e35dcb6ded73' \
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