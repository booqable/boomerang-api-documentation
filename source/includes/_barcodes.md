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
      "id": "f64a4595-85b6-4b39-aa4a-e7482b246652",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:45:07+00:00",
        "updated_at": "2022-05-24T07:45:07+00:00",
        "number": "http://bqbl.it/f64a4595-85b6-4b39-aa4a-e7482b246652",
        "barcode_type": "qr_code",
        "image_url": "/uploads/14fcc4da646b9ed83e1ab62c7ca03139/barcode/image/f64a4595-85b6-4b39-aa4a-e7482b246652/7def7271-af12-4f24-be1b-64daa0c3a544.svg",
        "owner_id": "774da587-66c6-4472-90d2-b240bc7fc038",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/774da587-66c6-4472-90d2-b240bc7fc038"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd8d80374-5e83-43e9-a6d3-28f7efad55ae&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d8d80374-5e83-43e9-a6d3-28f7efad55ae",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:45:08+00:00",
        "updated_at": "2022-05-24T07:45:08+00:00",
        "number": "http://bqbl.it/d8d80374-5e83-43e9-a6d3-28f7efad55ae",
        "barcode_type": "qr_code",
        "image_url": "/uploads/09c4f428eacc1044d95920df0f15e31b/barcode/image/d8d80374-5e83-43e9-a6d3-28f7efad55ae/6b927848-ab01-4ef6-a117-091226613f68.svg",
        "owner_id": "1061f7b4-fe99-4abe-a05b-39b215839661",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1061f7b4-fe99-4abe-a05b-39b215839661"
          },
          "data": {
            "type": "customers",
            "id": "1061f7b4-fe99-4abe-a05b-39b215839661"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1061f7b4-fe99-4abe-a05b-39b215839661",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:45:08+00:00",
        "updated_at": "2022-05-24T07:45:08+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Connelly-Von",
        "email": "connelly_von@altenwerth-ryan.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=1061f7b4-fe99-4abe-a05b-39b215839661&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1061f7b4-fe99-4abe-a05b-39b215839661&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1061f7b4-fe99-4abe-a05b-39b215839661&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTBkODU3MTUtMDJiYy00ZmMxLTg2ZTUtNGM4OTZiNGI1ZGJl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "10d85715-02bc-4fc1-86e5-4c896b4b5dbe",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:45:08+00:00",
        "updated_at": "2022-05-24T07:45:08+00:00",
        "number": "http://bqbl.it/10d85715-02bc-4fc1-86e5-4c896b4b5dbe",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3f92bad4bf61b8572ce99ad2d76ad633/barcode/image/10d85715-02bc-4fc1-86e5-4c896b4b5dbe/96c85e9f-d068-4354-9946-2b3d8fe45ba7.svg",
        "owner_id": "ee09813a-0ce0-4cae-b51d-8d4fa4992b31",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ee09813a-0ce0-4cae-b51d-8d4fa4992b31"
          },
          "data": {
            "type": "customers",
            "id": "ee09813a-0ce0-4cae-b51d-8d4fa4992b31"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ee09813a-0ce0-4cae-b51d-8d4fa4992b31",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:45:08+00:00",
        "updated_at": "2022-05-24T07:45:08+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Rolfson, Thiel and Altenwerth",
        "email": "altenwerth_and_thiel_rolfson@stanton.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee09813a-0ce0-4cae-b51d-8d4fa4992b31&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee09813a-0ce0-4cae-b51d-8d4fa4992b31&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee09813a-0ce0-4cae-b51d-8d4fa4992b31&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:44:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/409084f9-4eb8-43bc-bf01-f78b469dc63d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "409084f9-4eb8-43bc-bf01-f78b469dc63d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:45:09+00:00",
      "updated_at": "2022-05-24T07:45:09+00:00",
      "number": "http://bqbl.it/409084f9-4eb8-43bc-bf01-f78b469dc63d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/872e1283282dc988b41cf439801197ea/barcode/image/409084f9-4eb8-43bc-bf01-f78b469dc63d/2bd937e5-4ef2-4757-89cc-685327d67448.svg",
      "owner_id": "66108e85-34d4-4b28-a4b5-e9d34374dd31",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/66108e85-34d4-4b28-a4b5-e9d34374dd31"
        },
        "data": {
          "type": "customers",
          "id": "66108e85-34d4-4b28-a4b5-e9d34374dd31"
        }
      }
    }
  },
  "included": [
    {
      "id": "66108e85-34d4-4b28-a4b5-e9d34374dd31",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:45:09+00:00",
        "updated_at": "2022-05-24T07:45:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Lubowitz-Hirthe",
        "email": "hirthe_lubowitz@bartell.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=66108e85-34d4-4b28-a4b5-e9d34374dd31&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=66108e85-34d4-4b28-a4b5-e9d34374dd31&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=66108e85-34d4-4b28-a4b5-e9d34374dd31&filter[owner_type]=customers"
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
          "owner_id": "f2fe924e-8404-4f7d-abeb-5f69957159f9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fbee5292-66cd-4899-ab4d-9ca0c7a971e0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:45:09+00:00",
      "updated_at": "2022-05-24T07:45:09+00:00",
      "number": "http://bqbl.it/fbee5292-66cd-4899-ab4d-9ca0c7a971e0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/37c3a54d4d5fcdb4729961076ed1f390/barcode/image/fbee5292-66cd-4899-ab4d-9ca0c7a971e0/29eaacb6-9eef-480a-bc91-dcf05ffdd00c.svg",
      "owner_id": "f2fe924e-8404-4f7d-abeb-5f69957159f9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cebb485c-8b00-4ebe-a553-7c8a96e23468' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cebb485c-8b00-4ebe-a553-7c8a96e23468",
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
    "id": "cebb485c-8b00-4ebe-a553-7c8a96e23468",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:45:10+00:00",
      "updated_at": "2022-05-24T07:45:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bd4276dd77fd5b2f52ab40fc89f93de5/barcode/image/cebb485c-8b00-4ebe-a553-7c8a96e23468/5ee1cb98-3439-427b-b7b2-35d6166c582d.svg",
      "owner_id": "8c3a86fd-c863-4881-9ade-d606265f192c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f5415a85-f515-43b5-839f-06619d62651b' \
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