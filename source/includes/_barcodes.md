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
      "id": "2c44cbe1-ca8e-4a02-a287-efba5fb9ffc9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-15T13:21:21+00:00",
        "updated_at": "2023-02-15T13:21:21+00:00",
        "number": "http://bqbl.it/2c44cbe1-ca8e-4a02-a287-efba5fb9ffc9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5dd42ea931605eb62b64f088b3bb0920/barcode/image/2c44cbe1-ca8e-4a02-a287-efba5fb9ffc9/8e110c88-81bd-42ab-82ee-e88bcc29f253.svg",
        "owner_id": "e467598a-abcc-416b-8780-706802751fc9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e467598a-abcc-416b-8780-706802751fc9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fec30ba22-981d-4307-a747-d4f77701c5cf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ec30ba22-981d-4307-a747-d4f77701c5cf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-15T13:21:22+00:00",
        "updated_at": "2023-02-15T13:21:22+00:00",
        "number": "http://bqbl.it/ec30ba22-981d-4307-a747-d4f77701c5cf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a0de11dad449a9e26ef630b6d5311863/barcode/image/ec30ba22-981d-4307-a747-d4f77701c5cf/ea3d4d87-5f29-4aba-8f32-f4833a65af49.svg",
        "owner_id": "53626524-7efc-4da9-8e14-f2b5a2bd5292",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/53626524-7efc-4da9-8e14-f2b5a2bd5292"
          },
          "data": {
            "type": "customers",
            "id": "53626524-7efc-4da9-8e14-f2b5a2bd5292"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "53626524-7efc-4da9-8e14-f2b5a2bd5292",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-15T13:21:22+00:00",
        "updated_at": "2023-02-15T13:21:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=53626524-7efc-4da9-8e14-f2b5a2bd5292&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=53626524-7efc-4da9-8e14-f2b5a2bd5292&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=53626524-7efc-4da9-8e14-f2b5a2bd5292&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzRlMDQzMGMtM2FjYy00NjQzLWFhYjYtMzllNTViOGFhMDZh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "34e0430c-3acc-4643-aab6-39e55b8aa06a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-15T13:21:23+00:00",
        "updated_at": "2023-02-15T13:21:23+00:00",
        "number": "http://bqbl.it/34e0430c-3acc-4643-aab6-39e55b8aa06a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cd0c520f4b127cc771aaeeecc15625ec/barcode/image/34e0430c-3acc-4643-aab6-39e55b8aa06a/1925d763-3773-4b9c-a036-c2e438107193.svg",
        "owner_id": "6e671a76-28f8-4a38-8ebe-a45688f1696f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6e671a76-28f8-4a38-8ebe-a45688f1696f"
          },
          "data": {
            "type": "customers",
            "id": "6e671a76-28f8-4a38-8ebe-a45688f1696f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6e671a76-28f8-4a38-8ebe-a45688f1696f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-15T13:21:23+00:00",
        "updated_at": "2023-02-15T13:21:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6e671a76-28f8-4a38-8ebe-a45688f1696f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6e671a76-28f8-4a38-8ebe-a45688f1696f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6e671a76-28f8-4a38-8ebe-a45688f1696f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-15T13:21:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f136ebb0-5870-40c7-8e40-a4632ad2904a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f136ebb0-5870-40c7-8e40-a4632ad2904a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-15T13:21:24+00:00",
      "updated_at": "2023-02-15T13:21:24+00:00",
      "number": "http://bqbl.it/f136ebb0-5870-40c7-8e40-a4632ad2904a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/26900c450fa491c3ff92f07aa25c382f/barcode/image/f136ebb0-5870-40c7-8e40-a4632ad2904a/91f6bafb-a214-429f-b06c-c58f0c191aad.svg",
      "owner_id": "50d017b6-32e7-4278-a1d2-2de0a3efeaf0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/50d017b6-32e7-4278-a1d2-2de0a3efeaf0"
        },
        "data": {
          "type": "customers",
          "id": "50d017b6-32e7-4278-a1d2-2de0a3efeaf0"
        }
      }
    }
  },
  "included": [
    {
      "id": "50d017b6-32e7-4278-a1d2-2de0a3efeaf0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-15T13:21:24+00:00",
        "updated_at": "2023-02-15T13:21:24+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=50d017b6-32e7-4278-a1d2-2de0a3efeaf0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=50d017b6-32e7-4278-a1d2-2de0a3efeaf0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=50d017b6-32e7-4278-a1d2-2de0a3efeaf0&filter[owner_type]=customers"
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
          "owner_id": "ebb0bea7-5fee-4fc1-930f-c68b5b14db4d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "481f66dc-b7b7-41cf-97ef-7f35d46de59e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-15T13:21:26+00:00",
      "updated_at": "2023-02-15T13:21:26+00:00",
      "number": "http://bqbl.it/481f66dc-b7b7-41cf-97ef-7f35d46de59e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a11d43eacd3bb3269c42f097529a88b7/barcode/image/481f66dc-b7b7-41cf-97ef-7f35d46de59e/a13e4d37-373d-44d4-a3d5-cc8a047a33bd.svg",
      "owner_id": "ebb0bea7-5fee-4fc1-930f-c68b5b14db4d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/007e19e1-d2c5-417e-8226-2db174355e4b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "007e19e1-d2c5-417e-8226-2db174355e4b",
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
    "id": "007e19e1-d2c5-417e-8226-2db174355e4b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-15T13:21:26+00:00",
      "updated_at": "2023-02-15T13:21:26+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/71c9b725d3b89372ef7301a9942b287b/barcode/image/007e19e1-d2c5-417e-8226-2db174355e4b/4fe7b793-156f-4852-a6ae-ad5ef41797c9.svg",
      "owner_id": "0a4777cf-8b7d-41f5-bee4-e45d070ceca9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/409087d9-bf14-4bcc-8bad-817cb210128e' \
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