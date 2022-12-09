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
      "id": "51642562-94a1-425b-b41c-ff5d30083584",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-09T08:12:12+00:00",
        "updated_at": "2022-12-09T08:12:12+00:00",
        "number": "http://bqbl.it/51642562-94a1-425b-b41c-ff5d30083584",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4aeef669585749b04c1a67051cf2cedd/barcode/image/51642562-94a1-425b-b41c-ff5d30083584/88f9ee68-35c4-494d-b658-943431f3fa1d.svg",
        "owner_id": "bfaa5479-3355-433f-b132-7c85f94edfde",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bfaa5479-3355-433f-b132-7c85f94edfde"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F21f6a14b-421b-4722-b3e6-5c9ff95f9007&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "21f6a14b-421b-4722-b3e6-5c9ff95f9007",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-09T08:12:12+00:00",
        "updated_at": "2022-12-09T08:12:12+00:00",
        "number": "http://bqbl.it/21f6a14b-421b-4722-b3e6-5c9ff95f9007",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2b60eab329cbf635ccfd8042df4bb08b/barcode/image/21f6a14b-421b-4722-b3e6-5c9ff95f9007/f56245e0-a132-4a7a-8f14-2fd1c265f7bb.svg",
        "owner_id": "f80e9947-f05c-4872-95e0-e2cdd09ed71e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f80e9947-f05c-4872-95e0-e2cdd09ed71e"
          },
          "data": {
            "type": "customers",
            "id": "f80e9947-f05c-4872-95e0-e2cdd09ed71e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f80e9947-f05c-4872-95e0-e2cdd09ed71e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-09T08:12:12+00:00",
        "updated_at": "2022-12-09T08:12:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f80e9947-f05c-4872-95e0-e2cdd09ed71e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f80e9947-f05c-4872-95e0-e2cdd09ed71e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f80e9947-f05c-4872-95e0-e2cdd09ed71e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODFhMDhiZjUtYzNkYi00ODQ1LWI3ZmMtN2NlOGM5MDlhN2Y4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "81a08bf5-c3db-4845-b7fc-7ce8c909a7f8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-09T08:12:13+00:00",
        "updated_at": "2022-12-09T08:12:13+00:00",
        "number": "http://bqbl.it/81a08bf5-c3db-4845-b7fc-7ce8c909a7f8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9902d147d3cfafddcd84d2fba9891daf/barcode/image/81a08bf5-c3db-4845-b7fc-7ce8c909a7f8/82ced614-2c2b-4f50-9100-3796d4b9b5a3.svg",
        "owner_id": "516b0964-1e65-47a6-8918-0a7d9e46698b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/516b0964-1e65-47a6-8918-0a7d9e46698b"
          },
          "data": {
            "type": "customers",
            "id": "516b0964-1e65-47a6-8918-0a7d9e46698b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "516b0964-1e65-47a6-8918-0a7d9e46698b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-09T08:12:13+00:00",
        "updated_at": "2022-12-09T08:12:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=516b0964-1e65-47a6-8918-0a7d9e46698b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=516b0964-1e65-47a6-8918-0a7d9e46698b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=516b0964-1e65-47a6-8918-0a7d9e46698b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-09T08:11:54Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9ba4b6e8-7539-4683-8b43-585237c3ccbb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9ba4b6e8-7539-4683-8b43-585237c3ccbb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-09T08:12:13+00:00",
      "updated_at": "2022-12-09T08:12:13+00:00",
      "number": "http://bqbl.it/9ba4b6e8-7539-4683-8b43-585237c3ccbb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1a2127c98b15c97c9076fcecc7a8e012/barcode/image/9ba4b6e8-7539-4683-8b43-585237c3ccbb/12f99849-aecd-46cf-ab86-3c107ab24495.svg",
      "owner_id": "2e48d9e2-cc89-4db7-9c57-b65e37d9bb90",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2e48d9e2-cc89-4db7-9c57-b65e37d9bb90"
        },
        "data": {
          "type": "customers",
          "id": "2e48d9e2-cc89-4db7-9c57-b65e37d9bb90"
        }
      }
    }
  },
  "included": [
    {
      "id": "2e48d9e2-cc89-4db7-9c57-b65e37d9bb90",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-09T08:12:13+00:00",
        "updated_at": "2022-12-09T08:12:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2e48d9e2-cc89-4db7-9c57-b65e37d9bb90&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2e48d9e2-cc89-4db7-9c57-b65e37d9bb90&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2e48d9e2-cc89-4db7-9c57-b65e37d9bb90&filter[owner_type]=customers"
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
          "owner_id": "30679cb5-337e-4cb4-bf7b-186a533b5585",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6f166555-4472-43b9-a022-0c477cd56875",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-09T08:12:14+00:00",
      "updated_at": "2022-12-09T08:12:14+00:00",
      "number": "http://bqbl.it/6f166555-4472-43b9-a022-0c477cd56875",
      "barcode_type": "qr_code",
      "image_url": "/uploads/26eceaa2f7136fc12908363e14686c90/barcode/image/6f166555-4472-43b9-a022-0c477cd56875/b4537a36-c31d-4eb8-bf49-e515c7486fa3.svg",
      "owner_id": "30679cb5-337e-4cb4-bf7b-186a533b5585",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/69e56768-5369-4e2e-bd0f-75758b72debf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "69e56768-5369-4e2e-bd0f-75758b72debf",
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
    "id": "69e56768-5369-4e2e-bd0f-75758b72debf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-09T08:12:14+00:00",
      "updated_at": "2022-12-09T08:12:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a3b7c1164475d0d26f5289783a9d15a7/barcode/image/69e56768-5369-4e2e-bd0f-75758b72debf/34d58953-7c87-4762-a2fb-3e6206c94273.svg",
      "owner_id": "9a705264-a179-4e44-8879-d99e0a549193",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6e04a2ad-ef15-4a47-a91a-b62c5d046dce' \
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