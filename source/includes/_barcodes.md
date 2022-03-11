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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "291eecb6-8dab-4ec1-9aec-e873e79fdb31",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-11T12:48:44+00:00",
        "updated_at": "2022-03-11T12:48:44+00:00",
        "number": "http://bqbl.it/291eecb6-8dab-4ec1-9aec-e873e79fdb31",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b942bf0b4e62555a0fd23159eb541384/barcode/image/291eecb6-8dab-4ec1-9aec-e873e79fdb31/8df38b61-c2fb-4e3a-9eec-69cf4fe884e0.svg",
        "owner_id": "f564ae39-589c-4ec8-8da9-8876c9c4dbc7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f564ae39-589c-4ec8-8da9-8876c9c4dbc7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F553a2ae7-7db8-444e-bdcd-536d63a2d743&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "553a2ae7-7db8-444e-bdcd-536d63a2d743",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-11T12:48:45+00:00",
        "updated_at": "2022-03-11T12:48:45+00:00",
        "number": "http://bqbl.it/553a2ae7-7db8-444e-bdcd-536d63a2d743",
        "barcode_type": "qr_code",
        "image_url": "/uploads/53e5e4dea6015f553fd401b6dde27f2d/barcode/image/553a2ae7-7db8-444e-bdcd-536d63a2d743/b019369c-eb10-4a84-8230-a88b81a12b81.svg",
        "owner_id": "24d48c90-e638-4fc6-bf0b-9c9a6c355dd4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/24d48c90-e638-4fc6-bf0b-9c9a6c355dd4"
          },
          "data": {
            "type": "customers",
            "id": "24d48c90-e638-4fc6-bf0b-9c9a6c355dd4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "24d48c90-e638-4fc6-bf0b-9c9a6c355dd4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-11T12:48:44+00:00",
        "updated_at": "2022-03-11T12:48:45+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hamill-Kirlin",
        "email": "hamill.kirlin@parisian-gottlieb.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=24d48c90-e638-4fc6-bf0b-9c9a6c355dd4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=24d48c90-e638-4fc6-bf0b-9c9a6c355dd4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=24d48c90-e638-4fc6-bf0b-9c9a6c355dd4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2QwM2VjZTktOTM3Yi00YmNiLTgwMWEtZjM4NzExNzBkZWFl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3d03ece9-937b-4bcb-801a-f3871170deae",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-11T12:48:45+00:00",
        "updated_at": "2022-03-11T12:48:45+00:00",
        "number": "http://bqbl.it/3d03ece9-937b-4bcb-801a-f3871170deae",
        "barcode_type": "qr_code",
        "image_url": "/uploads/07a93ab819285f29d37f335d173e9cd1/barcode/image/3d03ece9-937b-4bcb-801a-f3871170deae/c7b83517-650b-4286-b81d-c13c70faa95f.svg",
        "owner_id": "f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee"
          },
          "data": {
            "type": "customers",
            "id": "f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-11T12:48:45+00:00",
        "updated_at": "2022-03-11T12:48:45+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Witting, Yundt and Auer",
        "email": "and_witting_yundt_auer@graham.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f4ef62d7-ddb1-4fb1-bdc4-8ec2b4e564ee&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-11T12:48:34Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b1fed4e5-6125-4646-b2c8-46c3bc1b6e3f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b1fed4e5-6125-4646-b2c8-46c3bc1b6e3f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-11T12:48:45+00:00",
      "updated_at": "2022-03-11T12:48:45+00:00",
      "number": "http://bqbl.it/b1fed4e5-6125-4646-b2c8-46c3bc1b6e3f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dcab885e09b636bb32bb0925ded547e4/barcode/image/b1fed4e5-6125-4646-b2c8-46c3bc1b6e3f/304cf7f9-5456-451f-a87f-d659b4a76b5b.svg",
      "owner_id": "3a149f99-be2f-4f39-b615-7736c8df0d61",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3a149f99-be2f-4f39-b615-7736c8df0d61"
        },
        "data": {
          "type": "customers",
          "id": "3a149f99-be2f-4f39-b615-7736c8df0d61"
        }
      }
    }
  },
  "included": [
    {
      "id": "3a149f99-be2f-4f39-b615-7736c8df0d61",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-11T12:48:45+00:00",
        "updated_at": "2022-03-11T12:48:45+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Davis Inc",
        "email": "davis_inc@skiles-paucek.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=3a149f99-be2f-4f39-b615-7736c8df0d61&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3a149f99-be2f-4f39-b615-7736c8df0d61&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3a149f99-be2f-4f39-b615-7736c8df0d61&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "9728402f-17e8-4ff0-b78a-365f0112c3e3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7dc19258-8e01-4c68-aca0-dcfc82a212f1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-11T12:48:46+00:00",
      "updated_at": "2022-03-11T12:48:46+00:00",
      "number": "http://bqbl.it/7dc19258-8e01-4c68-aca0-dcfc82a212f1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e0b8ec295d473929527bc76c7ee15996/barcode/image/7dc19258-8e01-4c68-aca0-dcfc82a212f1/8002a445-03a1-45e4-bade-bf295089c5b6.svg",
      "owner_id": "9728402f-17e8-4ff0-b78a-365f0112c3e3",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/57984e50-9bed-4d8e-abda-849fb773a119' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "57984e50-9bed-4d8e-abda-849fb773a119",
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
    "id": "57984e50-9bed-4d8e-abda-849fb773a119",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-11T12:48:46+00:00",
      "updated_at": "2022-03-11T12:48:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1fb0f072c5cafcdcae6e738866d091d9/barcode/image/57984e50-9bed-4d8e-abda-849fb773a119/57588552-3ec1-4592-b3b5-dc6ab4a498d7.svg",
      "owner_id": "36af13b2-53d8-4905-82a7-bc62bda32807",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/3c80e58a-7a9e-44e6-88f5-6c1dc39e9232' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes