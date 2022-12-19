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
      "id": "fc7e1c74-baa7-4b80-b4e4-3ea9e9436a6c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-19T08:45:53+00:00",
        "updated_at": "2022-12-19T08:45:53+00:00",
        "number": "http://bqbl.it/fc7e1c74-baa7-4b80-b4e4-3ea9e9436a6c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/deb7b633ac9b271e01f27f4362c7e6b6/barcode/image/fc7e1c74-baa7-4b80-b4e4-3ea9e9436a6c/d5d56de1-b8f5-4e25-9a81-519be2621177.svg",
        "owner_id": "f53af596-3742-4c21-804c-1918a5a44e06",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f53af596-3742-4c21-804c-1918a5a44e06"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F10bea528-b96b-413d-9d90-0cd71ebdfa71&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "10bea528-b96b-413d-9d90-0cd71ebdfa71",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-19T08:45:54+00:00",
        "updated_at": "2022-12-19T08:45:54+00:00",
        "number": "http://bqbl.it/10bea528-b96b-413d-9d90-0cd71ebdfa71",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a0b5d0d6d347a48071ea65547cd5b8f3/barcode/image/10bea528-b96b-413d-9d90-0cd71ebdfa71/f3d1a623-b939-4057-a96e-dbe2294994cb.svg",
        "owner_id": "7c519394-52f8-4a2d-bc25-7516d7d2a824",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7c519394-52f8-4a2d-bc25-7516d7d2a824"
          },
          "data": {
            "type": "customers",
            "id": "7c519394-52f8-4a2d-bc25-7516d7d2a824"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7c519394-52f8-4a2d-bc25-7516d7d2a824",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-19T08:45:53+00:00",
        "updated_at": "2022-12-19T08:45:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7c519394-52f8-4a2d-bc25-7516d7d2a824&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7c519394-52f8-4a2d-bc25-7516d7d2a824&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7c519394-52f8-4a2d-bc25-7516d7d2a824&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjQzODg0NmItYmIxMi00NGNjLTkyZGItODEwNWRjZjZjNmE4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f438846b-bb12-44cc-92db-8105dcf6c6a8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-19T08:45:54+00:00",
        "updated_at": "2022-12-19T08:45:54+00:00",
        "number": "http://bqbl.it/f438846b-bb12-44cc-92db-8105dcf6c6a8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7c5d9f42efbb133a6973d0f7c2d346db/barcode/image/f438846b-bb12-44cc-92db-8105dcf6c6a8/51d4db69-9032-4eec-9f26-c1913e04b03e.svg",
        "owner_id": "268ad0be-1f23-488a-8c12-a360e336eca4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/268ad0be-1f23-488a-8c12-a360e336eca4"
          },
          "data": {
            "type": "customers",
            "id": "268ad0be-1f23-488a-8c12-a360e336eca4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "268ad0be-1f23-488a-8c12-a360e336eca4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-19T08:45:54+00:00",
        "updated_at": "2022-12-19T08:45:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=268ad0be-1f23-488a-8c12-a360e336eca4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=268ad0be-1f23-488a-8c12-a360e336eca4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=268ad0be-1f23-488a-8c12-a360e336eca4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-19T08:45:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/708956a9-075f-42c3-aade-16a482465a56?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "708956a9-075f-42c3-aade-16a482465a56",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-19T08:45:54+00:00",
      "updated_at": "2022-12-19T08:45:54+00:00",
      "number": "http://bqbl.it/708956a9-075f-42c3-aade-16a482465a56",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3d7975f4b8d3fa7aaf26c339ebad8506/barcode/image/708956a9-075f-42c3-aade-16a482465a56/119a22bd-c9d3-4871-b822-938381a987bf.svg",
      "owner_id": "16122425-63d9-4cc5-bcb1-ffdc95ba53b3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/16122425-63d9-4cc5-bcb1-ffdc95ba53b3"
        },
        "data": {
          "type": "customers",
          "id": "16122425-63d9-4cc5-bcb1-ffdc95ba53b3"
        }
      }
    }
  },
  "included": [
    {
      "id": "16122425-63d9-4cc5-bcb1-ffdc95ba53b3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-19T08:45:54+00:00",
        "updated_at": "2022-12-19T08:45:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=16122425-63d9-4cc5-bcb1-ffdc95ba53b3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=16122425-63d9-4cc5-bcb1-ffdc95ba53b3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=16122425-63d9-4cc5-bcb1-ffdc95ba53b3&filter[owner_type]=customers"
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
          "owner_id": "dd0cdde3-bdc3-4115-b70f-b53e54c9f346",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e22708f8-f49a-4cc2-8d1a-fab931cdcf36",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-19T08:45:55+00:00",
      "updated_at": "2022-12-19T08:45:55+00:00",
      "number": "http://bqbl.it/e22708f8-f49a-4cc2-8d1a-fab931cdcf36",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d4d496aa726eaa4ca4a3092c5c2116f5/barcode/image/e22708f8-f49a-4cc2-8d1a-fab931cdcf36/6c2fd189-697a-4092-9b2f-24658ea62cb6.svg",
      "owner_id": "dd0cdde3-bdc3-4115-b70f-b53e54c9f346",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/15e4fc47-43a8-4f0a-843a-e8d93642e520' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "15e4fc47-43a8-4f0a-843a-e8d93642e520",
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
    "id": "15e4fc47-43a8-4f0a-843a-e8d93642e520",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-19T08:45:55+00:00",
      "updated_at": "2022-12-19T08:45:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eab18205b1182d9e95957c2c1089115e/barcode/image/15e4fc47-43a8-4f0a-843a-e8d93642e520/115515a3-1f96-4f2d-aaa7-2962cb0dc498.svg",
      "owner_id": "b635c05e-caa2-412c-99ac-8ea52ffffbd5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e99b13c1-5ba2-4154-b050-104cdbfd5866' \
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