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
      "id": "38b81b4d-5acc-4b5d-905a-64f1ad6eeffc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:07:56+00:00",
        "updated_at": "2023-01-05T13:07:56+00:00",
        "number": "http://bqbl.it/38b81b4d-5acc-4b5d-905a-64f1ad6eeffc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/92824aa74ddc4cd704eccae6b0bf5c06/barcode/image/38b81b4d-5acc-4b5d-905a-64f1ad6eeffc/82f435fb-a376-4fb2-81af-cf6ed0c8a95e.svg",
        "owner_id": "8082d812-0ac2-42a2-9d15-b082e2a4026a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8082d812-0ac2-42a2-9d15-b082e2a4026a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ecf5269-6d0f-4904-a75f-d217b3f02825&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8ecf5269-6d0f-4904-a75f-d217b3f02825",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:07:56+00:00",
        "updated_at": "2023-01-05T13:07:56+00:00",
        "number": "http://bqbl.it/8ecf5269-6d0f-4904-a75f-d217b3f02825",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ba28268d3d6ebc17ec3c5e81066754d2/barcode/image/8ecf5269-6d0f-4904-a75f-d217b3f02825/92b92e13-db3d-439a-9bd5-c9243374fcf1.svg",
        "owner_id": "5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835"
          },
          "data": {
            "type": "customers",
            "id": "5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:07:56+00:00",
        "updated_at": "2023-01-05T13:07:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5ace2f4d-0bcd-443a-9b0f-f0f6b05d0835&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTlkMzk1MzMtOGM4Mi00M2Q2LTg4MGYtYjY5ZDA2M2MzMDA1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "59d39533-8c82-43d6-880f-b69d063c3005",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:07:57+00:00",
        "updated_at": "2023-01-05T13:07:57+00:00",
        "number": "http://bqbl.it/59d39533-8c82-43d6-880f-b69d063c3005",
        "barcode_type": "qr_code",
        "image_url": "/uploads/66c048c3be7b440ed4b7280fe81c9ee2/barcode/image/59d39533-8c82-43d6-880f-b69d063c3005/eb54e10e-106e-49db-8c80-ff394f77400a.svg",
        "owner_id": "f419446f-6eef-40eb-846b-440d0ece5ebc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f419446f-6eef-40eb-846b-440d0ece5ebc"
          },
          "data": {
            "type": "customers",
            "id": "f419446f-6eef-40eb-846b-440d0ece5ebc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f419446f-6eef-40eb-846b-440d0ece5ebc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:07:57+00:00",
        "updated_at": "2023-01-05T13:07:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f419446f-6eef-40eb-846b-440d0ece5ebc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f419446f-6eef-40eb-846b-440d0ece5ebc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f419446f-6eef-40eb-846b-440d0ece5ebc&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:07:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3f66cdd7-8fcb-470d-a5ba-d9c69d83558b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3f66cdd7-8fcb-470d-a5ba-d9c69d83558b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:07:58+00:00",
      "updated_at": "2023-01-05T13:07:58+00:00",
      "number": "http://bqbl.it/3f66cdd7-8fcb-470d-a5ba-d9c69d83558b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/340dc4f12dd38fe13052f784036d6e9c/barcode/image/3f66cdd7-8fcb-470d-a5ba-d9c69d83558b/9e947206-ef72-49a6-ae1f-4af9bfd43c77.svg",
      "owner_id": "6a90d800-d71d-444b-bb91-b3769f9aa990",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6a90d800-d71d-444b-bb91-b3769f9aa990"
        },
        "data": {
          "type": "customers",
          "id": "6a90d800-d71d-444b-bb91-b3769f9aa990"
        }
      }
    }
  },
  "included": [
    {
      "id": "6a90d800-d71d-444b-bb91-b3769f9aa990",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:07:58+00:00",
        "updated_at": "2023-01-05T13:07:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6a90d800-d71d-444b-bb91-b3769f9aa990&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6a90d800-d71d-444b-bb91-b3769f9aa990&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6a90d800-d71d-444b-bb91-b3769f9aa990&filter[owner_type]=customers"
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
          "owner_id": "630438f2-9272-4a64-98fd-c7904d00c1e3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b80305c2-9be0-4463-8e68-f0b823dc8bf4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:07:59+00:00",
      "updated_at": "2023-01-05T13:07:59+00:00",
      "number": "http://bqbl.it/b80305c2-9be0-4463-8e68-f0b823dc8bf4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d495cdd665bd855c657f8fd8af74cf20/barcode/image/b80305c2-9be0-4463-8e68-f0b823dc8bf4/b93caa65-512c-41c6-9523-06267331a03e.svg",
      "owner_id": "630438f2-9272-4a64-98fd-c7904d00c1e3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5e66fa9a-5c08-40c0-8958-74c6a6e8537e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5e66fa9a-5c08-40c0-8958-74c6a6e8537e",
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
    "id": "5e66fa9a-5c08-40c0-8958-74c6a6e8537e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:08:01+00:00",
      "updated_at": "2023-01-05T13:08:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a5b341d171ca23cc400fd08aa6249196/barcode/image/5e66fa9a-5c08-40c0-8958-74c6a6e8537e/1c179590-8af8-45e6-90f3-57973ee33716.svg",
      "owner_id": "418ae0c0-0bb7-4534-8c13-efd28391a7c9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/464ab027-075b-4460-ae41-e6c9bfbf8bbe' \
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