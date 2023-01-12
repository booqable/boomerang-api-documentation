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
      "id": "4fa29c52-ce7e-46e3-b7cd-33671026185f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-12T14:26:24+00:00",
        "updated_at": "2023-01-12T14:26:24+00:00",
        "number": "http://bqbl.it/4fa29c52-ce7e-46e3-b7cd-33671026185f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a5ad49d44de53215387f3e5e787a0ddf/barcode/image/4fa29c52-ce7e-46e3-b7cd-33671026185f/7d7f1fa4-9b64-4f62-8acf-fcee707c22ec.svg",
        "owner_id": "829ad630-5591-445b-a2fb-a2958fe8a18b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/829ad630-5591-445b-a2fb-a2958fe8a18b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdfdaf76e-af3c-472a-acf0-3a9bb39619f2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dfdaf76e-af3c-472a-acf0-3a9bb39619f2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-12T14:26:25+00:00",
        "updated_at": "2023-01-12T14:26:25+00:00",
        "number": "http://bqbl.it/dfdaf76e-af3c-472a-acf0-3a9bb39619f2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d4320830da48400852613e6ce7280f57/barcode/image/dfdaf76e-af3c-472a-acf0-3a9bb39619f2/ffad10a2-97c0-48b8-989d-780e0ae667f2.svg",
        "owner_id": "233db370-5413-4bbf-913e-138c605dd2df",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/233db370-5413-4bbf-913e-138c605dd2df"
          },
          "data": {
            "type": "customers",
            "id": "233db370-5413-4bbf-913e-138c605dd2df"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "233db370-5413-4bbf-913e-138c605dd2df",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-12T14:26:25+00:00",
        "updated_at": "2023-01-12T14:26:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=233db370-5413-4bbf-913e-138c605dd2df&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=233db370-5413-4bbf-913e-138c605dd2df&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=233db370-5413-4bbf-913e-138c605dd2df&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmM4NmRhY2QtZGY5Yy00MzhkLWE4YWUtZTU2YzZhODg4Yjg0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2c86dacd-df9c-438d-a8ae-e56c6a888b84",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-12T14:26:25+00:00",
        "updated_at": "2023-01-12T14:26:25+00:00",
        "number": "http://bqbl.it/2c86dacd-df9c-438d-a8ae-e56c6a888b84",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6883fac98d3e8cf5c5e82f17b302b6c1/barcode/image/2c86dacd-df9c-438d-a8ae-e56c6a888b84/c5996674-4547-42b2-bd89-bfeb9ce8b60f.svg",
        "owner_id": "84189499-03c5-4a74-861e-8e7ce0b70f94",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/84189499-03c5-4a74-861e-8e7ce0b70f94"
          },
          "data": {
            "type": "customers",
            "id": "84189499-03c5-4a74-861e-8e7ce0b70f94"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "84189499-03c5-4a74-861e-8e7ce0b70f94",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-12T14:26:25+00:00",
        "updated_at": "2023-01-12T14:26:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=84189499-03c5-4a74-861e-8e7ce0b70f94&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=84189499-03c5-4a74-861e-8e7ce0b70f94&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=84189499-03c5-4a74-861e-8e7ce0b70f94&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-12T14:26:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a5085e1f-f560-4a9f-aab3-19ac34aa3824?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a5085e1f-f560-4a9f-aab3-19ac34aa3824",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-12T14:26:26+00:00",
      "updated_at": "2023-01-12T14:26:26+00:00",
      "number": "http://bqbl.it/a5085e1f-f560-4a9f-aab3-19ac34aa3824",
      "barcode_type": "qr_code",
      "image_url": "/uploads/60f3922bb5d3d9079b0d925f618c218c/barcode/image/a5085e1f-f560-4a9f-aab3-19ac34aa3824/fb2a5e16-dde9-40f9-a5b0-bf9a23aa09c0.svg",
      "owner_id": "cea866b3-9b87-474e-9a8b-0aa08567a14b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/cea866b3-9b87-474e-9a8b-0aa08567a14b"
        },
        "data": {
          "type": "customers",
          "id": "cea866b3-9b87-474e-9a8b-0aa08567a14b"
        }
      }
    }
  },
  "included": [
    {
      "id": "cea866b3-9b87-474e-9a8b-0aa08567a14b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-12T14:26:26+00:00",
        "updated_at": "2023-01-12T14:26:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cea866b3-9b87-474e-9a8b-0aa08567a14b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cea866b3-9b87-474e-9a8b-0aa08567a14b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cea866b3-9b87-474e-9a8b-0aa08567a14b&filter[owner_type]=customers"
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
          "owner_id": "9d221392-6463-4601-9de1-270953770257",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a85e47fa-9f99-4eee-a2f7-0188c925597c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-12T14:26:26+00:00",
      "updated_at": "2023-01-12T14:26:26+00:00",
      "number": "http://bqbl.it/a85e47fa-9f99-4eee-a2f7-0188c925597c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/19689399a12f3713deb25560c2a6abed/barcode/image/a85e47fa-9f99-4eee-a2f7-0188c925597c/987a8e84-022f-4bd7-a19c-df9f12bf2685.svg",
      "owner_id": "9d221392-6463-4601-9de1-270953770257",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b279c690-ad21-40f7-be8c-c025ca80c249' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b279c690-ad21-40f7-be8c-c025ca80c249",
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
    "id": "b279c690-ad21-40f7-be8c-c025ca80c249",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-12T14:26:27+00:00",
      "updated_at": "2023-01-12T14:26:27+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/210aafa63e390ba45909b38ca7f75a20/barcode/image/b279c690-ad21-40f7-be8c-c025ca80c249/2a85f8f9-4917-4b66-9ad4-d5bb4beedc7c.svg",
      "owner_id": "022e0d33-f766-46a5-a186-2fe0f63266e8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/acf72e97-6482-4eba-867c-a4ca40182574' \
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