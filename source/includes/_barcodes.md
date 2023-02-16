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
      "id": "7ef339ae-4158-44b9-a6e4-dd14bac61692",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T08:11:55+00:00",
        "updated_at": "2023-02-16T08:11:55+00:00",
        "number": "http://bqbl.it/7ef339ae-4158-44b9-a6e4-dd14bac61692",
        "barcode_type": "qr_code",
        "image_url": "/uploads/df8384331de2312e770ab4e91d654d05/barcode/image/7ef339ae-4158-44b9-a6e4-dd14bac61692/71dbeaee-26a7-4d4e-b1b9-7876baf552cf.svg",
        "owner_id": "40d7cb88-541a-48c9-affb-40ebc29b0ccc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/40d7cb88-541a-48c9-affb-40ebc29b0ccc"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F21e63f2d-f655-40a6-8c4d-88c0bc5106fd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "21e63f2d-f655-40a6-8c4d-88c0bc5106fd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T08:11:55+00:00",
        "updated_at": "2023-02-16T08:11:55+00:00",
        "number": "http://bqbl.it/21e63f2d-f655-40a6-8c4d-88c0bc5106fd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/42525b17b774ddb508ab5bcbdfbbad7e/barcode/image/21e63f2d-f655-40a6-8c4d-88c0bc5106fd/e8222806-7bb9-4938-a60a-483ad131953c.svg",
        "owner_id": "90eea787-49ed-437e-be9c-52ceb2be2e2e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/90eea787-49ed-437e-be9c-52ceb2be2e2e"
          },
          "data": {
            "type": "customers",
            "id": "90eea787-49ed-437e-be9c-52ceb2be2e2e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "90eea787-49ed-437e-be9c-52ceb2be2e2e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T08:11:55+00:00",
        "updated_at": "2023-02-16T08:11:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=90eea787-49ed-437e-be9c-52ceb2be2e2e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=90eea787-49ed-437e-be9c-52ceb2be2e2e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=90eea787-49ed-437e-be9c-52ceb2be2e2e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTg0NDdlNTAtY2ZjZi00YzYxLWE4MjItYTg1ZWE4YWVkZGEz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "58447e50-cfcf-4c61-a822-a85ea8aedda3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T08:11:56+00:00",
        "updated_at": "2023-02-16T08:11:56+00:00",
        "number": "http://bqbl.it/58447e50-cfcf-4c61-a822-a85ea8aedda3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fb9ae0bb6884bab67c4561251bb13be2/barcode/image/58447e50-cfcf-4c61-a822-a85ea8aedda3/bd73be13-e2e2-4578-a7ce-d7f26ee02a1b.svg",
        "owner_id": "517fa471-fa8a-403f-ad58-a3726361012e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/517fa471-fa8a-403f-ad58-a3726361012e"
          },
          "data": {
            "type": "customers",
            "id": "517fa471-fa8a-403f-ad58-a3726361012e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "517fa471-fa8a-403f-ad58-a3726361012e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T08:11:56+00:00",
        "updated_at": "2023-02-16T08:11:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=517fa471-fa8a-403f-ad58-a3726361012e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=517fa471-fa8a-403f-ad58-a3726361012e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=517fa471-fa8a-403f-ad58-a3726361012e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T08:11:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/27df98fa-171b-49ef-bfa9-8d5286a3853b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "27df98fa-171b-49ef-bfa9-8d5286a3853b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T08:11:56+00:00",
      "updated_at": "2023-02-16T08:11:56+00:00",
      "number": "http://bqbl.it/27df98fa-171b-49ef-bfa9-8d5286a3853b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7f76649131d08bc240b2a0bfb22d20ec/barcode/image/27df98fa-171b-49ef-bfa9-8d5286a3853b/5211b8af-4f75-4e04-b10a-772ae2ae5d60.svg",
      "owner_id": "8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63"
        },
        "data": {
          "type": "customers",
          "id": "8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63"
        }
      }
    }
  },
  "included": [
    {
      "id": "8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T08:11:56+00:00",
        "updated_at": "2023-02-16T08:11:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8bcdb2aa-4ead-44c4-af0d-c08eb9adbb63&filter[owner_type]=customers"
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
          "owner_id": "c74c2d22-ba0a-4333-a0f9-c01117a7f6f5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a041111b-f143-4a96-8639-46df13a254d1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T08:11:57+00:00",
      "updated_at": "2023-02-16T08:11:57+00:00",
      "number": "http://bqbl.it/a041111b-f143-4a96-8639-46df13a254d1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/346e9f30854d1cfdc3c43b160ddf1f9c/barcode/image/a041111b-f143-4a96-8639-46df13a254d1/59a01755-8fef-4269-bf76-6dde9fa106cb.svg",
      "owner_id": "c74c2d22-ba0a-4333-a0f9-c01117a7f6f5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/98bdbcd1-a175-437f-a9ee-625c9fcaf27a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "98bdbcd1-a175-437f-a9ee-625c9fcaf27a",
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
    "id": "98bdbcd1-a175-437f-a9ee-625c9fcaf27a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T08:11:57+00:00",
      "updated_at": "2023-02-16T08:11:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4d0ba60fc0eb1d87d21d81482ea17ff7/barcode/image/98bdbcd1-a175-437f-a9ee-625c9fcaf27a/364b2300-e9e2-4329-bb0b-e3968c8a7e36.svg",
      "owner_id": "f2690a88-9605-40e2-8aa5-1d18a32c8bd2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e02187ff-c7cf-4f0e-8eb7-0bc486799bab' \
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