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
      "id": "d64a44f4-8e1b-4593-964d-eb422e2689bb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T11:01:49+00:00",
        "updated_at": "2023-02-09T11:01:49+00:00",
        "number": "http://bqbl.it/d64a44f4-8e1b-4593-964d-eb422e2689bb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0a9a43ba15adacc821dc822f078d025b/barcode/image/d64a44f4-8e1b-4593-964d-eb422e2689bb/f9742fb5-6bfc-4fc8-b088-5a8912db9dd5.svg",
        "owner_id": "c37396e8-6bd5-48b4-8050-b5e2b8faf91b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c37396e8-6bd5-48b4-8050-b5e2b8faf91b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbfe7f2f6-583b-46ab-8c77-d01bb37ec98e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bfe7f2f6-583b-46ab-8c77-d01bb37ec98e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T11:01:50+00:00",
        "updated_at": "2023-02-09T11:01:50+00:00",
        "number": "http://bqbl.it/bfe7f2f6-583b-46ab-8c77-d01bb37ec98e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0709adc59e67a0e24644b6a78fae029c/barcode/image/bfe7f2f6-583b-46ab-8c77-d01bb37ec98e/1d365e6c-c614-464b-87d1-9989fc0621c4.svg",
        "owner_id": "314b6454-b6d5-4acd-b245-09a3f086d4b4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/314b6454-b6d5-4acd-b245-09a3f086d4b4"
          },
          "data": {
            "type": "customers",
            "id": "314b6454-b6d5-4acd-b245-09a3f086d4b4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "314b6454-b6d5-4acd-b245-09a3f086d4b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T11:01:49+00:00",
        "updated_at": "2023-02-09T11:01:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=314b6454-b6d5-4acd-b245-09a3f086d4b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=314b6454-b6d5-4acd-b245-09a3f086d4b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=314b6454-b6d5-4acd-b245-09a3f086d4b4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNWU4N2RiN2EtN2ZhNi00ZDhiLTk1YzctM2VlYzc2YjAyOTRl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5e87db7a-7fa6-4d8b-95c7-3eec76b0294e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T11:01:50+00:00",
        "updated_at": "2023-02-09T11:01:50+00:00",
        "number": "http://bqbl.it/5e87db7a-7fa6-4d8b-95c7-3eec76b0294e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f77e79102e67b3c7b2d6732bf7f7b619/barcode/image/5e87db7a-7fa6-4d8b-95c7-3eec76b0294e/e9c3ee35-b074-4ead-a2c4-fb18c8ba23ce.svg",
        "owner_id": "67639e9a-da53-4e44-823d-73cf71276beb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/67639e9a-da53-4e44-823d-73cf71276beb"
          },
          "data": {
            "type": "customers",
            "id": "67639e9a-da53-4e44-823d-73cf71276beb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "67639e9a-da53-4e44-823d-73cf71276beb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T11:01:50+00:00",
        "updated_at": "2023-02-09T11:01:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=67639e9a-da53-4e44-823d-73cf71276beb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=67639e9a-da53-4e44-823d-73cf71276beb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=67639e9a-da53-4e44-823d-73cf71276beb&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T11:01:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a00c57e8-6cae-4387-aece-be8544b12415?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a00c57e8-6cae-4387-aece-be8544b12415",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T11:01:51+00:00",
      "updated_at": "2023-02-09T11:01:51+00:00",
      "number": "http://bqbl.it/a00c57e8-6cae-4387-aece-be8544b12415",
      "barcode_type": "qr_code",
      "image_url": "/uploads/edb67f854b039828696633760f4149f3/barcode/image/a00c57e8-6cae-4387-aece-be8544b12415/f505877d-6166-4ab2-92ac-39ab50d8311c.svg",
      "owner_id": "4b802a24-8c44-4deb-8fe2-1f05e2851d20",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4b802a24-8c44-4deb-8fe2-1f05e2851d20"
        },
        "data": {
          "type": "customers",
          "id": "4b802a24-8c44-4deb-8fe2-1f05e2851d20"
        }
      }
    }
  },
  "included": [
    {
      "id": "4b802a24-8c44-4deb-8fe2-1f05e2851d20",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T11:01:51+00:00",
        "updated_at": "2023-02-09T11:01:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4b802a24-8c44-4deb-8fe2-1f05e2851d20&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4b802a24-8c44-4deb-8fe2-1f05e2851d20&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4b802a24-8c44-4deb-8fe2-1f05e2851d20&filter[owner_type]=customers"
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
          "owner_id": "36cb0f37-7189-433d-9d5e-d7f06d45f879",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "393e9de6-3362-4e67-a9dc-de86be91207e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T11:01:51+00:00",
      "updated_at": "2023-02-09T11:01:51+00:00",
      "number": "http://bqbl.it/393e9de6-3362-4e67-a9dc-de86be91207e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5314f46245bbfa9209b185d1151a256a/barcode/image/393e9de6-3362-4e67-a9dc-de86be91207e/26ba2edb-2693-4da7-a6f5-88b67b744f7a.svg",
      "owner_id": "36cb0f37-7189-433d-9d5e-d7f06d45f879",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fccee07d-69e5-4bb5-b1fa-b3362a47a708' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fccee07d-69e5-4bb5-b1fa-b3362a47a708",
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
    "id": "fccee07d-69e5-4bb5-b1fa-b3362a47a708",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T11:01:52+00:00",
      "updated_at": "2023-02-09T11:01:52+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3e30f22b4b3e03f71a66d3b046df12ac/barcode/image/fccee07d-69e5-4bb5-b1fa-b3362a47a708/c6fa5a75-0786-479d-93d9-59b2d42c6354.svg",
      "owner_id": "3363e455-77f9-4bbf-ba84-2061e9c814d8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/761a96ca-9020-4ac2-9ddb-dfef709ae707' \
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