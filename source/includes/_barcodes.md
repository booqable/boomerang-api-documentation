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
      "id": "9dd40611-dce1-4aec-93dd-edcfbf46ca0c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T00:22:58+00:00",
        "updated_at": "2023-02-23T00:22:58+00:00",
        "number": "http://bqbl.it/9dd40611-dce1-4aec-93dd-edcfbf46ca0c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cfa39b048c091edf4e5fc4dfae5e7b9b/barcode/image/9dd40611-dce1-4aec-93dd-edcfbf46ca0c/377cb981-ef4d-4159-830d-8d5890051075.svg",
        "owner_id": "785f8a1f-4b6c-486d-96b1-dc8ed1bfa38c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/785f8a1f-4b6c-486d-96b1-dc8ed1bfa38c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F162ebaff-4913-4e55-916a-6c7e642df202&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "162ebaff-4913-4e55-916a-6c7e642df202",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T00:23:01+00:00",
        "updated_at": "2023-02-23T00:23:01+00:00",
        "number": "http://bqbl.it/162ebaff-4913-4e55-916a-6c7e642df202",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3b584407640c2a8507e93e2d598d17b3/barcode/image/162ebaff-4913-4e55-916a-6c7e642df202/9eccc5d8-253a-46a2-914d-739d9b40307e.svg",
        "owner_id": "7ec4122e-0339-44b9-a0d9-f8e42bd4af36",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7ec4122e-0339-44b9-a0d9-f8e42bd4af36"
          },
          "data": {
            "type": "customers",
            "id": "7ec4122e-0339-44b9-a0d9-f8e42bd4af36"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7ec4122e-0339-44b9-a0d9-f8e42bd4af36",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T00:23:01+00:00",
        "updated_at": "2023-02-23T00:23:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ec4122e-0339-44b9-a0d9-f8e42bd4af36&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ec4122e-0339-44b9-a0d9-f8e42bd4af36&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7ec4122e-0339-44b9-a0d9-f8e42bd4af36&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzBmODQ5MTgtNmZmYi00NjlmLTgxNTEtMGRkYjQzMDAzMGJl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "30f84918-6ffb-469f-8151-0ddb430030be",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T00:23:04+00:00",
        "updated_at": "2023-02-23T00:23:04+00:00",
        "number": "http://bqbl.it/30f84918-6ffb-469f-8151-0ddb430030be",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a3768f4770e71e7cb56275d9ebd98457/barcode/image/30f84918-6ffb-469f-8151-0ddb430030be/616a1b23-1901-42eb-b58b-42b44043df0d.svg",
        "owner_id": "2fc20f36-8d56-408f-95d6-ed623139adf0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2fc20f36-8d56-408f-95d6-ed623139adf0"
          },
          "data": {
            "type": "customers",
            "id": "2fc20f36-8d56-408f-95d6-ed623139adf0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2fc20f36-8d56-408f-95d6-ed623139adf0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T00:23:04+00:00",
        "updated_at": "2023-02-23T00:23:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2fc20f36-8d56-408f-95d6-ed623139adf0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2fc20f36-8d56-408f-95d6-ed623139adf0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2fc20f36-8d56-408f-95d6-ed623139adf0&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T00:22:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/237b2783-2e31-4a6d-bede-d19a40e629a8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "237b2783-2e31-4a6d-bede-d19a40e629a8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T00:23:07+00:00",
      "updated_at": "2023-02-23T00:23:07+00:00",
      "number": "http://bqbl.it/237b2783-2e31-4a6d-bede-d19a40e629a8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/64cea68a0b64e20ce0a37a381d576a63/barcode/image/237b2783-2e31-4a6d-bede-d19a40e629a8/88e7e2b8-8326-4d9e-b1f8-c06fef8d1ffb.svg",
      "owner_id": "14c7dee5-a8e2-42f4-8067-5915c7e0279a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/14c7dee5-a8e2-42f4-8067-5915c7e0279a"
        },
        "data": {
          "type": "customers",
          "id": "14c7dee5-a8e2-42f4-8067-5915c7e0279a"
        }
      }
    }
  },
  "included": [
    {
      "id": "14c7dee5-a8e2-42f4-8067-5915c7e0279a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T00:23:07+00:00",
        "updated_at": "2023-02-23T00:23:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=14c7dee5-a8e2-42f4-8067-5915c7e0279a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=14c7dee5-a8e2-42f4-8067-5915c7e0279a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=14c7dee5-a8e2-42f4-8067-5915c7e0279a&filter[owner_type]=customers"
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
          "owner_id": "ffdded34-5678-4025-a394-2ca2409b8fb8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3d2abe60-d1e3-4b69-993d-b12ddbee7a67",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T00:23:10+00:00",
      "updated_at": "2023-02-23T00:23:10+00:00",
      "number": "http://bqbl.it/3d2abe60-d1e3-4b69-993d-b12ddbee7a67",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1bfc9174321265f9231580b58d08e968/barcode/image/3d2abe60-d1e3-4b69-993d-b12ddbee7a67/28522928-5026-4a41-ac95-1a236ba1f0d5.svg",
      "owner_id": "ffdded34-5678-4025-a394-2ca2409b8fb8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f2a67345-2991-47f3-9f8f-15d5b88ed376' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f2a67345-2991-47f3-9f8f-15d5b88ed376",
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
    "id": "f2a67345-2991-47f3-9f8f-15d5b88ed376",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T00:23:12+00:00",
      "updated_at": "2023-02-23T00:23:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/49bd786d117a3a10be0d38789f77d2a7/barcode/image/f2a67345-2991-47f3-9f8f-15d5b88ed376/f4ed3439-23c1-4212-a31b-4f9d3948f778.svg",
      "owner_id": "8bc69e8f-0361-4aa8-9dac-1251468b33bb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f55b4ddd-5821-4a97-a8fe-c0dfa7023dd3' \
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