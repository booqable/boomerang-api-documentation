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
      "id": "0f71e58f-23a1-4a0f-8c2f-6d57ee4b1ff7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T11:19:31+00:00",
        "updated_at": "2023-02-16T11:19:31+00:00",
        "number": "http://bqbl.it/0f71e58f-23a1-4a0f-8c2f-6d57ee4b1ff7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/91ba436a5f34d08306799cdf10f37960/barcode/image/0f71e58f-23a1-4a0f-8c2f-6d57ee4b1ff7/9b371ec7-a102-475d-9915-978290d78b54.svg",
        "owner_id": "e347de91-755f-49ff-b992-5c8f804c7876",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e347de91-755f-49ff-b992-5c8f804c7876"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffeaa7c41-ee12-49bf-908e-e5a185957859&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "feaa7c41-ee12-49bf-908e-e5a185957859",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T11:19:32+00:00",
        "updated_at": "2023-02-16T11:19:32+00:00",
        "number": "http://bqbl.it/feaa7c41-ee12-49bf-908e-e5a185957859",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dbbc7a55fabed65c3b873452afa0d425/barcode/image/feaa7c41-ee12-49bf-908e-e5a185957859/26d45846-e622-42ed-905f-222c1bd8e6fd.svg",
        "owner_id": "84a5dbb9-fe94-444f-9da6-1cdb8cca068e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/84a5dbb9-fe94-444f-9da6-1cdb8cca068e"
          },
          "data": {
            "type": "customers",
            "id": "84a5dbb9-fe94-444f-9da6-1cdb8cca068e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "84a5dbb9-fe94-444f-9da6-1cdb8cca068e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T11:19:32+00:00",
        "updated_at": "2023-02-16T11:19:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=84a5dbb9-fe94-444f-9da6-1cdb8cca068e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=84a5dbb9-fe94-444f-9da6-1cdb8cca068e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=84a5dbb9-fe94-444f-9da6-1cdb8cca068e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjJkYjc2YjYtNzkwNi00MmViLWE3YWEtOGFkNzE1NmFkNTJk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "22db76b6-7906-42eb-a7aa-8ad7156ad52d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T11:19:32+00:00",
        "updated_at": "2023-02-16T11:19:32+00:00",
        "number": "http://bqbl.it/22db76b6-7906-42eb-a7aa-8ad7156ad52d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/473b014b9467adbbae8876ed35fd1ce5/barcode/image/22db76b6-7906-42eb-a7aa-8ad7156ad52d/9c6d3bae-05b9-4fb5-ba3a-2a8720383e6e.svg",
        "owner_id": "054ee937-8996-496a-98bc-7527c055684d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/054ee937-8996-496a-98bc-7527c055684d"
          },
          "data": {
            "type": "customers",
            "id": "054ee937-8996-496a-98bc-7527c055684d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "054ee937-8996-496a-98bc-7527c055684d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T11:19:32+00:00",
        "updated_at": "2023-02-16T11:19:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=054ee937-8996-496a-98bc-7527c055684d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=054ee937-8996-496a-98bc-7527c055684d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=054ee937-8996-496a-98bc-7527c055684d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T11:19:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0112ffa0-9a4a-46f4-93ce-d215b9daa850?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0112ffa0-9a4a-46f4-93ce-d215b9daa850",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T11:19:33+00:00",
      "updated_at": "2023-02-16T11:19:33+00:00",
      "number": "http://bqbl.it/0112ffa0-9a4a-46f4-93ce-d215b9daa850",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dc441154448690543afe916b86bd727a/barcode/image/0112ffa0-9a4a-46f4-93ce-d215b9daa850/a5d7d130-83e3-45fd-a00a-0c8ce93ac746.svg",
      "owner_id": "d80406d7-fac7-463f-a51c-2614e4a88339",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d80406d7-fac7-463f-a51c-2614e4a88339"
        },
        "data": {
          "type": "customers",
          "id": "d80406d7-fac7-463f-a51c-2614e4a88339"
        }
      }
    }
  },
  "included": [
    {
      "id": "d80406d7-fac7-463f-a51c-2614e4a88339",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T11:19:33+00:00",
        "updated_at": "2023-02-16T11:19:33+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d80406d7-fac7-463f-a51c-2614e4a88339&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d80406d7-fac7-463f-a51c-2614e4a88339&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d80406d7-fac7-463f-a51c-2614e4a88339&filter[owner_type]=customers"
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
          "owner_id": "88577361-bc1d-46bc-ba81-92e1f5261857",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "11aa5478-8ef4-4ff5-b1fe-bd6975301f5e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T11:19:33+00:00",
      "updated_at": "2023-02-16T11:19:33+00:00",
      "number": "http://bqbl.it/11aa5478-8ef4-4ff5-b1fe-bd6975301f5e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ef2583330f09bedfb78707cc8b02cc61/barcode/image/11aa5478-8ef4-4ff5-b1fe-bd6975301f5e/e1655ad1-2f7d-4d4f-9c4b-e08c2eeff3a9.svg",
      "owner_id": "88577361-bc1d-46bc-ba81-92e1f5261857",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/343e8fbb-18a6-49c6-8b1a-77cc7914609c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "343e8fbb-18a6-49c6-8b1a-77cc7914609c",
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
    "id": "343e8fbb-18a6-49c6-8b1a-77cc7914609c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T11:19:34+00:00",
      "updated_at": "2023-02-16T11:19:34+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/086984b9bbac0db01a7942cc37510145/barcode/image/343e8fbb-18a6-49c6-8b1a-77cc7914609c/703ab1c7-9ad3-41f0-9a5e-6e61a85d403f.svg",
      "owner_id": "9759655b-aedd-4635-b46b-bfbfd7c938cf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8f9cffd8-019e-40a0-bee9-4099835d540e' \
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