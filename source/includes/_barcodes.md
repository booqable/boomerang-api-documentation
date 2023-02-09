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
      "id": "93d80e6d-b5c6-4028-821a-e80d9aab21d8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T13:05:25+00:00",
        "updated_at": "2023-02-09T13:05:25+00:00",
        "number": "http://bqbl.it/93d80e6d-b5c6-4028-821a-e80d9aab21d8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/234b2d4b9444351326dd72c1b08ec4f2/barcode/image/93d80e6d-b5c6-4028-821a-e80d9aab21d8/8f262e77-e607-48db-a62d-896d01ae8de4.svg",
        "owner_id": "a7f0bf94-4237-4a6b-a47e-0663ac0b3c10",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a7f0bf94-4237-4a6b-a47e-0663ac0b3c10"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2415d979-a32e-4f0f-a002-839d9669ae1a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2415d979-a32e-4f0f-a002-839d9669ae1a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T13:05:26+00:00",
        "updated_at": "2023-02-09T13:05:26+00:00",
        "number": "http://bqbl.it/2415d979-a32e-4f0f-a002-839d9669ae1a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dab002a9433b9a523bb44efbdb22c816/barcode/image/2415d979-a32e-4f0f-a002-839d9669ae1a/9fc179ea-b305-43c0-a1b7-05aaaab76ab0.svg",
        "owner_id": "177464a0-35ce-4efb-8ca8-45c23a1f3346",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/177464a0-35ce-4efb-8ca8-45c23a1f3346"
          },
          "data": {
            "type": "customers",
            "id": "177464a0-35ce-4efb-8ca8-45c23a1f3346"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "177464a0-35ce-4efb-8ca8-45c23a1f3346",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T13:05:25+00:00",
        "updated_at": "2023-02-09T13:05:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=177464a0-35ce-4efb-8ca8-45c23a1f3346&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=177464a0-35ce-4efb-8ca8-45c23a1f3346&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=177464a0-35ce-4efb-8ca8-45c23a1f3346&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmU0ZTE5ZTItOGI1ZC00YTI0LTk5NmUtYzY3OTQyZjZjNDk2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2e4e19e2-8b5d-4a24-996e-c67942f6c496",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T13:05:26+00:00",
        "updated_at": "2023-02-09T13:05:26+00:00",
        "number": "http://bqbl.it/2e4e19e2-8b5d-4a24-996e-c67942f6c496",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b7d5d4eedf1a436969875e49d95902e/barcode/image/2e4e19e2-8b5d-4a24-996e-c67942f6c496/f2cfb550-a8fb-4b30-a3ae-912c8b116060.svg",
        "owner_id": "8722a297-34b2-485f-81b0-9774f8bc09be",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8722a297-34b2-485f-81b0-9774f8bc09be"
          },
          "data": {
            "type": "customers",
            "id": "8722a297-34b2-485f-81b0-9774f8bc09be"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8722a297-34b2-485f-81b0-9774f8bc09be",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T13:05:26+00:00",
        "updated_at": "2023-02-09T13:05:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8722a297-34b2-485f-81b0-9774f8bc09be&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8722a297-34b2-485f-81b0-9774f8bc09be&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8722a297-34b2-485f-81b0-9774f8bc09be&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T13:05:02Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/26d3dff7-011a-4a55-b9f3-3078782a4ad3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "26d3dff7-011a-4a55-b9f3-3078782a4ad3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T13:05:27+00:00",
      "updated_at": "2023-02-09T13:05:27+00:00",
      "number": "http://bqbl.it/26d3dff7-011a-4a55-b9f3-3078782a4ad3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/57955d7d77c6bda01337751b645ca28c/barcode/image/26d3dff7-011a-4a55-b9f3-3078782a4ad3/d6237748-293d-4f56-8c7c-caba4e1f546d.svg",
      "owner_id": "26d4cdcd-5925-4fa4-8adf-6a2b149797b4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/26d4cdcd-5925-4fa4-8adf-6a2b149797b4"
        },
        "data": {
          "type": "customers",
          "id": "26d4cdcd-5925-4fa4-8adf-6a2b149797b4"
        }
      }
    }
  },
  "included": [
    {
      "id": "26d4cdcd-5925-4fa4-8adf-6a2b149797b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T13:05:27+00:00",
        "updated_at": "2023-02-09T13:05:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=26d4cdcd-5925-4fa4-8adf-6a2b149797b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=26d4cdcd-5925-4fa4-8adf-6a2b149797b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=26d4cdcd-5925-4fa4-8adf-6a2b149797b4&filter[owner_type]=customers"
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
          "owner_id": "9295c186-a1ba-460b-8f6a-ab2a536ba898",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5f54a81f-cd8d-4461-8a33-9d3dfb4976dd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T13:05:27+00:00",
      "updated_at": "2023-02-09T13:05:27+00:00",
      "number": "http://bqbl.it/5f54a81f-cd8d-4461-8a33-9d3dfb4976dd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e44ef4a93e0e56cfa048b096eb2d0172/barcode/image/5f54a81f-cd8d-4461-8a33-9d3dfb4976dd/4941dd8e-6393-4133-94e8-db8522529a51.svg",
      "owner_id": "9295c186-a1ba-460b-8f6a-ab2a536ba898",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a3de0d65-52e6-4a49-aa90-55b94870b783' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3de0d65-52e6-4a49-aa90-55b94870b783",
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
    "id": "a3de0d65-52e6-4a49-aa90-55b94870b783",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T13:05:28+00:00",
      "updated_at": "2023-02-09T13:05:28+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4acff1250631c4491030a5c62d6ed764/barcode/image/a3de0d65-52e6-4a49-aa90-55b94870b783/1c069a4d-4b7f-4544-b8f6-e46c6920e724.svg",
      "owner_id": "72f256b8-55ad-4090-a167-1b7c27a0ab07",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f9fba7ca-d82a-4981-a50b-4f019bc92467' \
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