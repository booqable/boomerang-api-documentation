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
      "id": "b6c99627-39c3-4457-b9b6-d56300a6c929",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-06T10:39:56+00:00",
        "updated_at": "2023-03-06T10:39:56+00:00",
        "number": "http://bqbl.it/b6c99627-39c3-4457-b9b6-d56300a6c929",
        "barcode_type": "qr_code",
        "image_url": "/uploads/064dfdaa2bd0c5cb325efc4acbc979ad/barcode/image/b6c99627-39c3-4457-b9b6-d56300a6c929/0d6c1021-227e-4df3-98a6-a03f0102f127.svg",
        "owner_id": "ab0ce78e-566f-4c91-84d9-54e33014f3f2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ab0ce78e-566f-4c91-84d9-54e33014f3f2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1b31e987-d8e8-4622-aca1-fbdd36e42976&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1b31e987-d8e8-4622-aca1-fbdd36e42976",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-06T10:39:57+00:00",
        "updated_at": "2023-03-06T10:39:57+00:00",
        "number": "http://bqbl.it/1b31e987-d8e8-4622-aca1-fbdd36e42976",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e3c05a05f0b781e57774122e2b13ff92/barcode/image/1b31e987-d8e8-4622-aca1-fbdd36e42976/6e63f13a-17a8-4854-8370-5247fa5e881a.svg",
        "owner_id": "e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9"
          },
          "data": {
            "type": "customers",
            "id": "e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-06T10:39:57+00:00",
        "updated_at": "2023-03-06T10:39:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e7005e9f-6ecb-4a8c-b627-f357e0dd9ec9&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGU2MmMyZTYtZjZlMC00ZGQzLWJlNjAtNTFhNTM5OGIzMGM3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "de62c2e6-f6e0-4dd3-be60-51a5398b30c7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-06T10:39:57+00:00",
        "updated_at": "2023-03-06T10:39:57+00:00",
        "number": "http://bqbl.it/de62c2e6-f6e0-4dd3-be60-51a5398b30c7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7e03eae66cec94057915c76b2f967f5d/barcode/image/de62c2e6-f6e0-4dd3-be60-51a5398b30c7/1d0ca654-f102-449e-99ec-933579b10bc8.svg",
        "owner_id": "b16fd19c-af86-4db6-81f6-12f7c945d5cf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b16fd19c-af86-4db6-81f6-12f7c945d5cf"
          },
          "data": {
            "type": "customers",
            "id": "b16fd19c-af86-4db6-81f6-12f7c945d5cf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b16fd19c-af86-4db6-81f6-12f7c945d5cf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-06T10:39:57+00:00",
        "updated_at": "2023-03-06T10:39:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b16fd19c-af86-4db6-81f6-12f7c945d5cf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b16fd19c-af86-4db6-81f6-12f7c945d5cf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b16fd19c-af86-4db6-81f6-12f7c945d5cf&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T10:39:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bdc28219-2ecf-436e-b05e-70a402d520f8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bdc28219-2ecf-436e-b05e-70a402d520f8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-06T10:39:58+00:00",
      "updated_at": "2023-03-06T10:39:58+00:00",
      "number": "http://bqbl.it/bdc28219-2ecf-436e-b05e-70a402d520f8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b24d0279a523ae34abe2fe7961d8d439/barcode/image/bdc28219-2ecf-436e-b05e-70a402d520f8/19fdb95d-95d2-49c0-bf66-a18509c1b241.svg",
      "owner_id": "44b2233f-52ce-42ab-a551-48c6142355f6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/44b2233f-52ce-42ab-a551-48c6142355f6"
        },
        "data": {
          "type": "customers",
          "id": "44b2233f-52ce-42ab-a551-48c6142355f6"
        }
      }
    }
  },
  "included": [
    {
      "id": "44b2233f-52ce-42ab-a551-48c6142355f6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-06T10:39:58+00:00",
        "updated_at": "2023-03-06T10:39:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=44b2233f-52ce-42ab-a551-48c6142355f6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=44b2233f-52ce-42ab-a551-48c6142355f6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=44b2233f-52ce-42ab-a551-48c6142355f6&filter[owner_type]=customers"
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
          "owner_id": "b27f2865-1022-4521-8e5d-30784cd09fb0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d8ae7717-23dc-49d1-8fb4-6640fd5945ec",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-06T10:39:58+00:00",
      "updated_at": "2023-03-06T10:39:58+00:00",
      "number": "http://bqbl.it/d8ae7717-23dc-49d1-8fb4-6640fd5945ec",
      "barcode_type": "qr_code",
      "image_url": "/uploads/77526251df1b0b957dd37c947b63dc01/barcode/image/d8ae7717-23dc-49d1-8fb4-6640fd5945ec/a8999bd8-f270-4b09-87fd-173d97ce14f0.svg",
      "owner_id": "b27f2865-1022-4521-8e5d-30784cd09fb0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/014ac68c-06dc-46c6-b1e0-e0a0c4771d18' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "014ac68c-06dc-46c6-b1e0-e0a0c4771d18",
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
    "id": "014ac68c-06dc-46c6-b1e0-e0a0c4771d18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-06T10:39:59+00:00",
      "updated_at": "2023-03-06T10:39:59+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/87c4d5fbf703ce4560b29e85775a9a5b/barcode/image/014ac68c-06dc-46c6-b1e0-e0a0c4771d18/16315aa7-72b4-4625-8952-66b00e162980.svg",
      "owner_id": "e423cd5b-fa73-4be0-8a48-102cfa5a5ecc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a15c35a4-5e67-4315-9bea-41db42d984cb' \
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