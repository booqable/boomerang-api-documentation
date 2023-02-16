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
      "id": "114672c1-7d37-40a7-900f-e7823edb3adc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:59:09+00:00",
        "updated_at": "2023-02-16T09:59:09+00:00",
        "number": "http://bqbl.it/114672c1-7d37-40a7-900f-e7823edb3adc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/08f4e96f7b0305d85a79ebe9acacaa1f/barcode/image/114672c1-7d37-40a7-900f-e7823edb3adc/bc225984-0324-4b12-a558-14b20a1f130e.svg",
        "owner_id": "15fef066-adb7-430a-ad0e-763a5c65af73",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/15fef066-adb7-430a-ad0e-763a5c65af73"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9a3261b2-036b-4768-a03b-8532da8ab6fd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9a3261b2-036b-4768-a03b-8532da8ab6fd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:59:10+00:00",
        "updated_at": "2023-02-16T09:59:10+00:00",
        "number": "http://bqbl.it/9a3261b2-036b-4768-a03b-8532da8ab6fd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9939b0c51a5eef6bd0742553f02bf856/barcode/image/9a3261b2-036b-4768-a03b-8532da8ab6fd/a3201cae-1922-4647-8122-c4c489d419a4.svg",
        "owner_id": "85b119b0-cb7d-4cf8-9cbc-2923e20d9764",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/85b119b0-cb7d-4cf8-9cbc-2923e20d9764"
          },
          "data": {
            "type": "customers",
            "id": "85b119b0-cb7d-4cf8-9cbc-2923e20d9764"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "85b119b0-cb7d-4cf8-9cbc-2923e20d9764",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:59:09+00:00",
        "updated_at": "2023-02-16T09:59:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=85b119b0-cb7d-4cf8-9cbc-2923e20d9764&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=85b119b0-cb7d-4cf8-9cbc-2923e20d9764&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=85b119b0-cb7d-4cf8-9cbc-2923e20d9764&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjgzZGNkNzItN2Y4Yy00NmQ0LWIzYjktMDBhMTRiM2MyYjgx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "283dcd72-7f8c-46d4-b3b9-00a14b3c2b81",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:59:10+00:00",
        "updated_at": "2023-02-16T09:59:10+00:00",
        "number": "http://bqbl.it/283dcd72-7f8c-46d4-b3b9-00a14b3c2b81",
        "barcode_type": "qr_code",
        "image_url": "/uploads/38f74d85f13cfd40e57122be51d460ad/barcode/image/283dcd72-7f8c-46d4-b3b9-00a14b3c2b81/4a213906-c5d0-4aae-834e-1c5358776911.svg",
        "owner_id": "710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d"
          },
          "data": {
            "type": "customers",
            "id": "710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:59:10+00:00",
        "updated_at": "2023-02-16T09:59:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=710bfcbf-0e1f-4b65-8f3a-b1d3101ae52d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:58:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/79dbfceb-62fe-4a20-accf-46fcd04e17a5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "79dbfceb-62fe-4a20-accf-46fcd04e17a5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:59:11+00:00",
      "updated_at": "2023-02-16T09:59:11+00:00",
      "number": "http://bqbl.it/79dbfceb-62fe-4a20-accf-46fcd04e17a5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/adfa1198521287004065bf2c3f92e18e/barcode/image/79dbfceb-62fe-4a20-accf-46fcd04e17a5/b7071999-fda9-44fd-8d31-e25316b4c3cb.svg",
      "owner_id": "df6ab0d2-9cfe-4b89-9b34-f6bb440c848d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/df6ab0d2-9cfe-4b89-9b34-f6bb440c848d"
        },
        "data": {
          "type": "customers",
          "id": "df6ab0d2-9cfe-4b89-9b34-f6bb440c848d"
        }
      }
    }
  },
  "included": [
    {
      "id": "df6ab0d2-9cfe-4b89-9b34-f6bb440c848d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:59:10+00:00",
        "updated_at": "2023-02-16T09:59:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=df6ab0d2-9cfe-4b89-9b34-f6bb440c848d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=df6ab0d2-9cfe-4b89-9b34-f6bb440c848d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=df6ab0d2-9cfe-4b89-9b34-f6bb440c848d&filter[owner_type]=customers"
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
          "owner_id": "07bb3e92-d5fd-411b-974b-4a9094b659b8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "057c2966-6a4c-4f25-83b4-d2e29a587c69",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:59:11+00:00",
      "updated_at": "2023-02-16T09:59:11+00:00",
      "number": "http://bqbl.it/057c2966-6a4c-4f25-83b4-d2e29a587c69",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2a9cdc354be89c9619ddddd491f7e7aa/barcode/image/057c2966-6a4c-4f25-83b4-d2e29a587c69/d38b9320-5fc2-4dab-828c-66b15ea1a51c.svg",
      "owner_id": "07bb3e92-d5fd-411b-974b-4a9094b659b8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c79c5d2-a4b1-4cc5-b9dd-edd1d94510cf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c79c5d2-a4b1-4cc5-b9dd-edd1d94510cf",
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
    "id": "1c79c5d2-a4b1-4cc5-b9dd-edd1d94510cf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:59:12+00:00",
      "updated_at": "2023-02-16T09:59:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e15ac42226e763239ebac39c47d91fa4/barcode/image/1c79c5d2-a4b1-4cc5-b9dd-edd1d94510cf/df0241de-41a9-46a6-ab47-9cf38d85ebeb.svg",
      "owner_id": "ce1e1d29-d18e-4dac-8fd4-369a84940dd8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d9fc3367-25db-49e4-9784-a950dc9a6b99' \
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