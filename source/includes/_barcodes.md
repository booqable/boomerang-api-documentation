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
      "id": "c8b375c6-797b-4274-ae20-c5bb9d1d214a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-04T15:37:40+00:00",
        "updated_at": "2022-11-04T15:37:40+00:00",
        "number": "http://bqbl.it/c8b375c6-797b-4274-ae20-c5bb9d1d214a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/28884f17012bc28d5436089cb40cd58c/barcode/image/c8b375c6-797b-4274-ae20-c5bb9d1d214a/d745364e-4a80-45db-bbf8-01f26cc775e1.svg",
        "owner_id": "2c209d91-3250-44e2-9aa1-4397fba47666",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2c209d91-3250-44e2-9aa1-4397fba47666"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F176396c1-da44-4c5c-ad10-dffaa60518cd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "176396c1-da44-4c5c-ad10-dffaa60518cd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-04T15:37:40+00:00",
        "updated_at": "2022-11-04T15:37:40+00:00",
        "number": "http://bqbl.it/176396c1-da44-4c5c-ad10-dffaa60518cd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5d912ecd183b4ceaa9e353db0c60f008/barcode/image/176396c1-da44-4c5c-ad10-dffaa60518cd/b1aa95e2-984c-46b3-92a3-2e6957d4fdfb.svg",
        "owner_id": "5388a646-df66-45d2-a806-4593c253b355",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5388a646-df66-45d2-a806-4593c253b355"
          },
          "data": {
            "type": "customers",
            "id": "5388a646-df66-45d2-a806-4593c253b355"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5388a646-df66-45d2-a806-4593c253b355",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-04T15:37:40+00:00",
        "updated_at": "2022-11-04T15:37:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5388a646-df66-45d2-a806-4593c253b355&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5388a646-df66-45d2-a806-4593c253b355&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5388a646-df66-45d2-a806-4593c253b355&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGJjNjA2ZTgtMWExMy00MmE4LThmYTItZjZhZGRhMTAwNGE3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dbc606e8-1a13-42a8-8fa2-f6adda1004a7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-04T15:37:41+00:00",
        "updated_at": "2022-11-04T15:37:41+00:00",
        "number": "http://bqbl.it/dbc606e8-1a13-42a8-8fa2-f6adda1004a7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4a8af0057456b8371e7a01aa9a4f1b7f/barcode/image/dbc606e8-1a13-42a8-8fa2-f6adda1004a7/e4726384-91f8-4a85-b75a-f59d94ca0136.svg",
        "owner_id": "e438cc0c-cd8c-4b92-acd0-64a057ba717d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e438cc0c-cd8c-4b92-acd0-64a057ba717d"
          },
          "data": {
            "type": "customers",
            "id": "e438cc0c-cd8c-4b92-acd0-64a057ba717d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e438cc0c-cd8c-4b92-acd0-64a057ba717d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-04T15:37:41+00:00",
        "updated_at": "2022-11-04T15:37:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e438cc0c-cd8c-4b92-acd0-64a057ba717d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e438cc0c-cd8c-4b92-acd0-64a057ba717d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e438cc0c-cd8c-4b92-acd0-64a057ba717d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:37:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/73acb441-5312-4759-b2e9-bdee76299bcc?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "73acb441-5312-4759-b2e9-bdee76299bcc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-04T15:37:41+00:00",
      "updated_at": "2022-11-04T15:37:41+00:00",
      "number": "http://bqbl.it/73acb441-5312-4759-b2e9-bdee76299bcc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/833d7ca314950b6d61739b1aac82dd0b/barcode/image/73acb441-5312-4759-b2e9-bdee76299bcc/7b40672c-9d1d-4e81-ae14-336c7f683fcc.svg",
      "owner_id": "92089f1a-4470-4daf-8ebe-0894f47b875d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/92089f1a-4470-4daf-8ebe-0894f47b875d"
        },
        "data": {
          "type": "customers",
          "id": "92089f1a-4470-4daf-8ebe-0894f47b875d"
        }
      }
    }
  },
  "included": [
    {
      "id": "92089f1a-4470-4daf-8ebe-0894f47b875d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-04T15:37:41+00:00",
        "updated_at": "2022-11-04T15:37:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=92089f1a-4470-4daf-8ebe-0894f47b875d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92089f1a-4470-4daf-8ebe-0894f47b875d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92089f1a-4470-4daf-8ebe-0894f47b875d&filter[owner_type]=customers"
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
          "owner_id": "25be48fc-5181-49e1-b174-4ceb4dcdeac6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9d99428f-d6c0-4e1a-9e4f-38f202137397",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-04T15:37:42+00:00",
      "updated_at": "2022-11-04T15:37:42+00:00",
      "number": "http://bqbl.it/9d99428f-d6c0-4e1a-9e4f-38f202137397",
      "barcode_type": "qr_code",
      "image_url": "/uploads/502dea7378d7eb5b7ef6cb938d543ea8/barcode/image/9d99428f-d6c0-4e1a-9e4f-38f202137397/0eeddfd1-01eb-48c1-b10b-6e0284449883.svg",
      "owner_id": "25be48fc-5181-49e1-b174-4ceb4dcdeac6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/234aca9c-2fe8-425b-9220-74042eba961b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "234aca9c-2fe8-425b-9220-74042eba961b",
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
    "id": "234aca9c-2fe8-425b-9220-74042eba961b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-04T15:37:42+00:00",
      "updated_at": "2022-11-04T15:37:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e6ad78609843776e3ef48b6e15c69283/barcode/image/234aca9c-2fe8-425b-9220-74042eba961b/7383f78d-1c8d-4332-9869-01b03778dfbd.svg",
      "owner_id": "6347d2d9-966a-46c0-9963-9da370d618fd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/afe08075-ff54-4394-adb3-fe615d5d6338' \
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