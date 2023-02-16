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
      "id": "9f69b4ca-9b24-4f5f-8414-d32625d4c748",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T23:11:43+00:00",
        "updated_at": "2023-02-16T23:11:43+00:00",
        "number": "http://bqbl.it/9f69b4ca-9b24-4f5f-8414-d32625d4c748",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3c191c1aead386f34f27413d41aa2995/barcode/image/9f69b4ca-9b24-4f5f-8414-d32625d4c748/126c73fd-9b7b-4e9b-a38a-773ea8c6982d.svg",
        "owner_id": "d9886e04-846b-4df2-b34f-c5a6cea3593a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d9886e04-846b-4df2-b34f-c5a6cea3593a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbb5156ea-bd60-4faa-85e5-22b5266ddc05&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bb5156ea-bd60-4faa-85e5-22b5266ddc05",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T23:11:44+00:00",
        "updated_at": "2023-02-16T23:11:44+00:00",
        "number": "http://bqbl.it/bb5156ea-bd60-4faa-85e5-22b5266ddc05",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b83b48c0d2f1931b822152961a6798e/barcode/image/bb5156ea-bd60-4faa-85e5-22b5266ddc05/2eb1fcac-c91b-473a-98c1-5a50adb875a5.svg",
        "owner_id": "3f87875a-faff-46f7-994c-5e092a6eba6e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3f87875a-faff-46f7-994c-5e092a6eba6e"
          },
          "data": {
            "type": "customers",
            "id": "3f87875a-faff-46f7-994c-5e092a6eba6e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3f87875a-faff-46f7-994c-5e092a6eba6e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T23:11:44+00:00",
        "updated_at": "2023-02-16T23:11:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3f87875a-faff-46f7-994c-5e092a6eba6e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3f87875a-faff-46f7-994c-5e092a6eba6e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3f87875a-faff-46f7-994c-5e092a6eba6e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDExOTg5ZTAtMDg4Ny00ODIzLTg5YWItZDhkYzFlMmI1MGEy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d11989e0-0887-4823-89ab-d8dc1e2b50a2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T23:11:45+00:00",
        "updated_at": "2023-02-16T23:11:45+00:00",
        "number": "http://bqbl.it/d11989e0-0887-4823-89ab-d8dc1e2b50a2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1899d5068326e6a5b47a8e9e688ce11e/barcode/image/d11989e0-0887-4823-89ab-d8dc1e2b50a2/062586cb-deb2-44e1-80cb-9b1177a4aea7.svg",
        "owner_id": "5019b0a3-eb46-430d-abbe-b03c3fac2c9b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5019b0a3-eb46-430d-abbe-b03c3fac2c9b"
          },
          "data": {
            "type": "customers",
            "id": "5019b0a3-eb46-430d-abbe-b03c3fac2c9b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5019b0a3-eb46-430d-abbe-b03c3fac2c9b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T23:11:44+00:00",
        "updated_at": "2023-02-16T23:11:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5019b0a3-eb46-430d-abbe-b03c3fac2c9b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5019b0a3-eb46-430d-abbe-b03c3fac2c9b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5019b0a3-eb46-430d-abbe-b03c3fac2c9b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T23:11:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6c626fa6-8b73-4c0e-acc0-6734ca6e6a8d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6c626fa6-8b73-4c0e-acc0-6734ca6e6a8d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T23:11:45+00:00",
      "updated_at": "2023-02-16T23:11:45+00:00",
      "number": "http://bqbl.it/6c626fa6-8b73-4c0e-acc0-6734ca6e6a8d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ab2a9365ab6e07ba7dfea8a0d5dee66/barcode/image/6c626fa6-8b73-4c0e-acc0-6734ca6e6a8d/81027b6c-47d7-4ad7-9d22-1fc1fbe3fb7e.svg",
      "owner_id": "2dd71d5c-8fd6-480f-b671-7c3321c7e8b4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2dd71d5c-8fd6-480f-b671-7c3321c7e8b4"
        },
        "data": {
          "type": "customers",
          "id": "2dd71d5c-8fd6-480f-b671-7c3321c7e8b4"
        }
      }
    }
  },
  "included": [
    {
      "id": "2dd71d5c-8fd6-480f-b671-7c3321c7e8b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T23:11:45+00:00",
        "updated_at": "2023-02-16T23:11:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2dd71d5c-8fd6-480f-b671-7c3321c7e8b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2dd71d5c-8fd6-480f-b671-7c3321c7e8b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2dd71d5c-8fd6-480f-b671-7c3321c7e8b4&filter[owner_type]=customers"
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
          "owner_id": "c31830a1-da78-4daf-8538-b20548a4b79f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8f47c726-5928-4243-8a72-cd7610e88c3d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T23:11:46+00:00",
      "updated_at": "2023-02-16T23:11:46+00:00",
      "number": "http://bqbl.it/8f47c726-5928-4243-8a72-cd7610e88c3d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9b54118a6c65d2aac473a66ff8c925b7/barcode/image/8f47c726-5928-4243-8a72-cd7610e88c3d/83e36e50-398f-4425-a582-5eda2533fb65.svg",
      "owner_id": "c31830a1-da78-4daf-8538-b20548a4b79f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6dbad542-6eb7-4529-a23b-f8bce7d84940' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6dbad542-6eb7-4529-a23b-f8bce7d84940",
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
    "id": "6dbad542-6eb7-4529-a23b-f8bce7d84940",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T23:11:46+00:00",
      "updated_at": "2023-02-16T23:11:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c342da7c9b34d11da1b29beac16666ca/barcode/image/6dbad542-6eb7-4529-a23b-f8bce7d84940/4c22fdf9-3e33-40b3-b73b-329e0612a4ff.svg",
      "owner_id": "37ebcae8-bba6-4df8-8c5d-cea281d1c1df",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/18bd00f3-63f4-422d-9851-e494d0df8387' \
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