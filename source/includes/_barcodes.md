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
      "id": "4d793c02-f1ae-4081-ab46-c7fb414b2de7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-10T08:36:20+00:00",
        "updated_at": "2023-03-10T08:36:20+00:00",
        "number": "http://bqbl.it/4d793c02-f1ae-4081-ab46-c7fb414b2de7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/024b4f5a433b3ffba4d75548ff796539/barcode/image/4d793c02-f1ae-4081-ab46-c7fb414b2de7/b6209549-8856-4456-8c70-082451690f92.svg",
        "owner_id": "2ff64edf-84e6-4404-a63a-692c2b50079c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2ff64edf-84e6-4404-a63a-692c2b50079c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdaa36487-60f1-4c13-a617-49b2ff51402a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "daa36487-60f1-4c13-a617-49b2ff51402a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-10T08:36:21+00:00",
        "updated_at": "2023-03-10T08:36:21+00:00",
        "number": "http://bqbl.it/daa36487-60f1-4c13-a617-49b2ff51402a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8acb3b3353b1dcd69fbf51420de058b1/barcode/image/daa36487-60f1-4c13-a617-49b2ff51402a/12dd46d8-2301-424f-b0c4-f1d55af501b6.svg",
        "owner_id": "a56da128-c598-4cb1-a4d2-9d6dab365b30",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a56da128-c598-4cb1-a4d2-9d6dab365b30"
          },
          "data": {
            "type": "customers",
            "id": "a56da128-c598-4cb1-a4d2-9d6dab365b30"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a56da128-c598-4cb1-a4d2-9d6dab365b30",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-10T08:36:21+00:00",
        "updated_at": "2023-03-10T08:36:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a56da128-c598-4cb1-a4d2-9d6dab365b30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a56da128-c598-4cb1-a4d2-9d6dab365b30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a56da128-c598-4cb1-a4d2-9d6dab365b30&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTI3MmQxOWEtY2E0NC00MTA1LWIzOGMtOTBmN2M1MjYxODc0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a272d19a-ca44-4105-b38c-90f7c5261874",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-10T08:36:21+00:00",
        "updated_at": "2023-03-10T08:36:21+00:00",
        "number": "http://bqbl.it/a272d19a-ca44-4105-b38c-90f7c5261874",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1e406c5d5ccbe6e0481a9dc948cb7e0/barcode/image/a272d19a-ca44-4105-b38c-90f7c5261874/3750edec-c2b0-4c44-950b-be5f212de035.svg",
        "owner_id": "14ad93e9-187b-44fc-a884-d64060d6a541",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/14ad93e9-187b-44fc-a884-d64060d6a541"
          },
          "data": {
            "type": "customers",
            "id": "14ad93e9-187b-44fc-a884-d64060d6a541"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "14ad93e9-187b-44fc-a884-d64060d6a541",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-10T08:36:21+00:00",
        "updated_at": "2023-03-10T08:36:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=14ad93e9-187b-44fc-a884-d64060d6a541&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=14ad93e9-187b-44fc-a884-d64060d6a541&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=14ad93e9-187b-44fc-a884-d64060d6a541&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-10T08:36:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c5ebf2e2-5801-4c99-98e9-8dbf2b25faff?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c5ebf2e2-5801-4c99-98e9-8dbf2b25faff",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-10T08:36:22+00:00",
      "updated_at": "2023-03-10T08:36:22+00:00",
      "number": "http://bqbl.it/c5ebf2e2-5801-4c99-98e9-8dbf2b25faff",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d1ca82897542281dedf2d3422d7aa9ba/barcode/image/c5ebf2e2-5801-4c99-98e9-8dbf2b25faff/8a7126e1-bba8-459b-9f92-29b13a28b4a0.svg",
      "owner_id": "8a6ac28c-8470-4b2e-bac2-da8bbd63e946",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8a6ac28c-8470-4b2e-bac2-da8bbd63e946"
        },
        "data": {
          "type": "customers",
          "id": "8a6ac28c-8470-4b2e-bac2-da8bbd63e946"
        }
      }
    }
  },
  "included": [
    {
      "id": "8a6ac28c-8470-4b2e-bac2-da8bbd63e946",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-10T08:36:22+00:00",
        "updated_at": "2023-03-10T08:36:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8a6ac28c-8470-4b2e-bac2-da8bbd63e946&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a6ac28c-8470-4b2e-bac2-da8bbd63e946&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a6ac28c-8470-4b2e-bac2-da8bbd63e946&filter[owner_type]=customers"
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
          "owner_id": "6c299f8b-78c2-4841-a9bd-99d4b042a6a3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ebddbaf4-7b5a-443b-9203-ac73dbca7aca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-10T08:36:22+00:00",
      "updated_at": "2023-03-10T08:36:22+00:00",
      "number": "http://bqbl.it/ebddbaf4-7b5a-443b-9203-ac73dbca7aca",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eb3c7856a320b7853b0a91fc0dbc6808/barcode/image/ebddbaf4-7b5a-443b-9203-ac73dbca7aca/3d091cbc-8b13-4630-bf4e-019e7c6cb250.svg",
      "owner_id": "6c299f8b-78c2-4841-a9bd-99d4b042a6a3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a3acc02b-e159-4550-bba7-4f932f0f9507' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3acc02b-e159-4550-bba7-4f932f0f9507",
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
    "id": "a3acc02b-e159-4550-bba7-4f932f0f9507",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-10T08:36:23+00:00",
      "updated_at": "2023-03-10T08:36:23+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0afacaae406f690ff200dacec83af7c8/barcode/image/a3acc02b-e159-4550-bba7-4f932f0f9507/efeda5f0-1cd7-4dd9-a70a-3131bf721c76.svg",
      "owner_id": "650499ac-4ba6-4413-942b-4d292d499201",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/79bc2910-893c-4453-87b9-2f60e70040ad' \
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