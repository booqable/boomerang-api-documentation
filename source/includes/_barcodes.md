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
      "id": "5e77ff78-6734-4e64-aa5f-65dc25ed2820",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T09:26:18+00:00",
        "updated_at": "2023-02-09T09:26:18+00:00",
        "number": "http://bqbl.it/5e77ff78-6734-4e64-aa5f-65dc25ed2820",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1ea75bbdfedbf9e77ed1955e330bb3c/barcode/image/5e77ff78-6734-4e64-aa5f-65dc25ed2820/c86d200e-85d2-4702-9470-c5f426dcc34c.svg",
        "owner_id": "433b9ea7-ca78-4aa0-9ef7-b68dc47491a7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/433b9ea7-ca78-4aa0-9ef7-b68dc47491a7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff566eac8-cb69-45c4-93a0-38c9c26cd4ca&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f566eac8-cb69-45c4-93a0-38c9c26cd4ca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T09:26:19+00:00",
        "updated_at": "2023-02-09T09:26:19+00:00",
        "number": "http://bqbl.it/f566eac8-cb69-45c4-93a0-38c9c26cd4ca",
        "barcode_type": "qr_code",
        "image_url": "/uploads/698c4e46e09788302af461a43faaa901/barcode/image/f566eac8-cb69-45c4-93a0-38c9c26cd4ca/ebcd74f3-cc7c-4b54-a01c-e8ba1b7b842c.svg",
        "owner_id": "480edc6c-65b6-4f35-98d8-1af2a188e8ef",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/480edc6c-65b6-4f35-98d8-1af2a188e8ef"
          },
          "data": {
            "type": "customers",
            "id": "480edc6c-65b6-4f35-98d8-1af2a188e8ef"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "480edc6c-65b6-4f35-98d8-1af2a188e8ef",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T09:26:19+00:00",
        "updated_at": "2023-02-09T09:26:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=480edc6c-65b6-4f35-98d8-1af2a188e8ef&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=480edc6c-65b6-4f35-98d8-1af2a188e8ef&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=480edc6c-65b6-4f35-98d8-1af2a188e8ef&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjNhMjE5ODktOGE0ZS00NTM2LTlhNzEtZTc5ZTQ5M2QzN2Fj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f3a21989-8a4e-4536-9a71-e79e493d37ac",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T09:26:20+00:00",
        "updated_at": "2023-02-09T09:26:20+00:00",
        "number": "http://bqbl.it/f3a21989-8a4e-4536-9a71-e79e493d37ac",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d9474419fe6b64367bee21a799280e98/barcode/image/f3a21989-8a4e-4536-9a71-e79e493d37ac/409ba4d0-f824-4444-a9b6-abb1bd4351aa.svg",
        "owner_id": "80333ccc-b48e-40af-a54f-8107667164c9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/80333ccc-b48e-40af-a54f-8107667164c9"
          },
          "data": {
            "type": "customers",
            "id": "80333ccc-b48e-40af-a54f-8107667164c9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "80333ccc-b48e-40af-a54f-8107667164c9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T09:26:20+00:00",
        "updated_at": "2023-02-09T09:26:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=80333ccc-b48e-40af-a54f-8107667164c9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=80333ccc-b48e-40af-a54f-8107667164c9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=80333ccc-b48e-40af-a54f-8107667164c9&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T09:25:54Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3ab6a111-7e35-4ca1-a6b3-25bb5a636761?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3ab6a111-7e35-4ca1-a6b3-25bb5a636761",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T09:26:21+00:00",
      "updated_at": "2023-02-09T09:26:21+00:00",
      "number": "http://bqbl.it/3ab6a111-7e35-4ca1-a6b3-25bb5a636761",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d87e7a5ad1e08adb89afa84084a9ac13/barcode/image/3ab6a111-7e35-4ca1-a6b3-25bb5a636761/f9053776-2792-4001-beba-e030feafe55f.svg",
      "owner_id": "1bd20b22-2e89-4276-beba-c5b38c18b96e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1bd20b22-2e89-4276-beba-c5b38c18b96e"
        },
        "data": {
          "type": "customers",
          "id": "1bd20b22-2e89-4276-beba-c5b38c18b96e"
        }
      }
    }
  },
  "included": [
    {
      "id": "1bd20b22-2e89-4276-beba-c5b38c18b96e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T09:26:21+00:00",
        "updated_at": "2023-02-09T09:26:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1bd20b22-2e89-4276-beba-c5b38c18b96e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1bd20b22-2e89-4276-beba-c5b38c18b96e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1bd20b22-2e89-4276-beba-c5b38c18b96e&filter[owner_type]=customers"
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
          "owner_id": "c2fdc34f-b869-4e90-b174-d341d82210d2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f2bae2c4-1f2a-4435-974d-eef76b18ff71",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T09:26:22+00:00",
      "updated_at": "2023-02-09T09:26:22+00:00",
      "number": "http://bqbl.it/f2bae2c4-1f2a-4435-974d-eef76b18ff71",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d3e90404f25357149a35260a36713464/barcode/image/f2bae2c4-1f2a-4435-974d-eef76b18ff71/46d6d4cc-9636-4d77-9c5c-d55da5b48159.svg",
      "owner_id": "c2fdc34f-b869-4e90-b174-d341d82210d2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/104bc9e1-e181-4734-82da-326b4d930dd6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "104bc9e1-e181-4734-82da-326b4d930dd6",
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
    "id": "104bc9e1-e181-4734-82da-326b4d930dd6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T09:26:24+00:00",
      "updated_at": "2023-02-09T09:26:24+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c9c1103606984525a5df94e24460206c/barcode/image/104bc9e1-e181-4734-82da-326b4d930dd6/8330e48e-71b2-43e6-bd3c-1a1380b2aa94.svg",
      "owner_id": "839b46dd-c916-4404-881b-6cedbf8316da",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/db265561-732a-41ea-ace4-788fe3fbf016' \
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