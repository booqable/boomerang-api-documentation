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
      "id": "9cef23a5-be2c-4e01-a5c1-b0614e2498fe",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T16:13:22+00:00",
        "updated_at": "2023-02-21T16:13:22+00:00",
        "number": "http://bqbl.it/9cef23a5-be2c-4e01-a5c1-b0614e2498fe",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0f03801d1c037cbc87bb381d15f7fee1/barcode/image/9cef23a5-be2c-4e01-a5c1-b0614e2498fe/62446357-24b6-437f-9ec2-52553c9e9010.svg",
        "owner_id": "dd2a8227-50e4-4196-bd77-aa413c4e7b75",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dd2a8227-50e4-4196-bd77-aa413c4e7b75"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F02591ac8-64a7-446c-bf68-7312fbf237c9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "02591ac8-64a7-446c-bf68-7312fbf237c9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T16:13:23+00:00",
        "updated_at": "2023-02-21T16:13:23+00:00",
        "number": "http://bqbl.it/02591ac8-64a7-446c-bf68-7312fbf237c9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e3ed6370f7c969b7ac98c492f549b5a2/barcode/image/02591ac8-64a7-446c-bf68-7312fbf237c9/7a3a8985-3830-409f-8e3c-3e9c39a0fc6d.svg",
        "owner_id": "c8489b13-1560-4222-8d40-db29ab7e9288",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c8489b13-1560-4222-8d40-db29ab7e9288"
          },
          "data": {
            "type": "customers",
            "id": "c8489b13-1560-4222-8d40-db29ab7e9288"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c8489b13-1560-4222-8d40-db29ab7e9288",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T16:13:23+00:00",
        "updated_at": "2023-02-21T16:13:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c8489b13-1560-4222-8d40-db29ab7e9288&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c8489b13-1560-4222-8d40-db29ab7e9288&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c8489b13-1560-4222-8d40-db29ab7e9288&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjk2MjgxZmMtYTIwMC00ODAzLWJhOTEtODdmYzI1NjNiYTg4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f96281fc-a200-4803-ba91-87fc2563ba88",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T16:13:23+00:00",
        "updated_at": "2023-02-21T16:13:23+00:00",
        "number": "http://bqbl.it/f96281fc-a200-4803-ba91-87fc2563ba88",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e80b87b9211952490974a63aff657b41/barcode/image/f96281fc-a200-4803-ba91-87fc2563ba88/27f195e8-d7a4-4238-bc2a-f8e4b8493022.svg",
        "owner_id": "5fcd1715-c3de-45f3-a875-d6526cf36e4c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5fcd1715-c3de-45f3-a875-d6526cf36e4c"
          },
          "data": {
            "type": "customers",
            "id": "5fcd1715-c3de-45f3-a875-d6526cf36e4c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5fcd1715-c3de-45f3-a875-d6526cf36e4c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T16:13:23+00:00",
        "updated_at": "2023-02-21T16:13:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5fcd1715-c3de-45f3-a875-d6526cf36e4c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5fcd1715-c3de-45f3-a875-d6526cf36e4c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5fcd1715-c3de-45f3-a875-d6526cf36e4c&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T16:13:02Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bfc6a762-0ce9-42c9-898a-2c491f20b1ae?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bfc6a762-0ce9-42c9-898a-2c491f20b1ae",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T16:13:24+00:00",
      "updated_at": "2023-02-21T16:13:24+00:00",
      "number": "http://bqbl.it/bfc6a762-0ce9-42c9-898a-2c491f20b1ae",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9aceba8d1f76f9dbdedb323179f5ed29/barcode/image/bfc6a762-0ce9-42c9-898a-2c491f20b1ae/7dc6cdd4-8eaa-4b07-9e1b-075486f68088.svg",
      "owner_id": "779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd"
        },
        "data": {
          "type": "customers",
          "id": "779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd"
        }
      }
    }
  },
  "included": [
    {
      "id": "779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T16:13:24+00:00",
        "updated_at": "2023-02-21T16:13:24+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=779a5679-3ddb-4aa6-8ec2-3a44ffbcffdd&filter[owner_type]=customers"
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
          "owner_id": "232365b9-0e59-4df4-b44c-c713c9484e25",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2ca1c9e1-85b7-4af8-9ed9-daf73e8c2ce4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T16:13:25+00:00",
      "updated_at": "2023-02-21T16:13:25+00:00",
      "number": "http://bqbl.it/2ca1c9e1-85b7-4af8-9ed9-daf73e8c2ce4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7ed98d00785c88d1bb30f688259191dd/barcode/image/2ca1c9e1-85b7-4af8-9ed9-daf73e8c2ce4/17b59638-b9a9-4653-bc10-9cee1ffde7ca.svg",
      "owner_id": "232365b9-0e59-4df4-b44c-c713c9484e25",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99a462c1-8264-40fc-a6de-cff42d035253' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "99a462c1-8264-40fc-a6de-cff42d035253",
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
    "id": "99a462c1-8264-40fc-a6de-cff42d035253",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T16:13:25+00:00",
      "updated_at": "2023-02-21T16:13:25+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d44279e86f0d711d89d3a738831ea9e0/barcode/image/99a462c1-8264-40fc-a6de-cff42d035253/36bc0312-efd2-4936-9f73-e7252bf52908.svg",
      "owner_id": "7897b682-bba0-4eb7-9f2a-12fc1c8f86d1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8bb7e116-e7d4-48f5-9cdd-e7bc569df411' \
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