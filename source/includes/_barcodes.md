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
      "id": "c38ea73b-0deb-4544-a452-602341863c7f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T21:13:14+00:00",
        "updated_at": "2022-07-14T21:13:14+00:00",
        "number": "http://bqbl.it/c38ea73b-0deb-4544-a452-602341863c7f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/19712ee054b2e0129a2b85c57eb3881d/barcode/image/c38ea73b-0deb-4544-a452-602341863c7f/f7b4a20c-3dce-430e-9fe4-a538bb627f21.svg",
        "owner_id": "47df5d01-04df-44cf-a977-1c100aba51f6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/47df5d01-04df-44cf-a977-1c100aba51f6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd9ebd2d0-8d6e-42ee-939d-179e57d2e612&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d9ebd2d0-8d6e-42ee-939d-179e57d2e612",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T21:13:14+00:00",
        "updated_at": "2022-07-14T21:13:14+00:00",
        "number": "http://bqbl.it/d9ebd2d0-8d6e-42ee-939d-179e57d2e612",
        "barcode_type": "qr_code",
        "image_url": "/uploads/992200262aba72d1b550ba7beb0a1ab7/barcode/image/d9ebd2d0-8d6e-42ee-939d-179e57d2e612/73836941-7a2c-434c-8732-2b16207b8836.svg",
        "owner_id": "8a0620b5-e490-4bf4-9db0-8e8cc61953e0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8a0620b5-e490-4bf4-9db0-8e8cc61953e0"
          },
          "data": {
            "type": "customers",
            "id": "8a0620b5-e490-4bf4-9db0-8e8cc61953e0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8a0620b5-e490-4bf4-9db0-8e8cc61953e0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T21:13:14+00:00",
        "updated_at": "2022-07-14T21:13:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Romaguera, Murazik and Jacobi",
        "email": "jacobi_murazik_and_romaguera@mckenzie.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=8a0620b5-e490-4bf4-9db0-8e8cc61953e0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a0620b5-e490-4bf4-9db0-8e8cc61953e0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a0620b5-e490-4bf4-9db0-8e8cc61953e0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGI4MDg4ZGQtODJiMS00MmI1LTlmMzAtNzZjNTE5Mzg4MWI4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "db8088dd-82b1-42b5-9f30-76c5193881b8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T21:13:15+00:00",
        "updated_at": "2022-07-14T21:13:15+00:00",
        "number": "http://bqbl.it/db8088dd-82b1-42b5-9f30-76c5193881b8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f8ca9641c7f08395f21dcc7cc2e00c6e/barcode/image/db8088dd-82b1-42b5-9f30-76c5193881b8/8d720f8e-497a-43c7-b379-e9c6d946a7c7.svg",
        "owner_id": "e2b7aafd-31ef-47e9-89f7-10712a896e28",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e2b7aafd-31ef-47e9-89f7-10712a896e28"
          },
          "data": {
            "type": "customers",
            "id": "e2b7aafd-31ef-47e9-89f7-10712a896e28"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e2b7aafd-31ef-47e9-89f7-10712a896e28",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T21:13:14+00:00",
        "updated_at": "2022-07-14T21:13:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Denesik LLC",
        "email": "denesik.llc@gorczany.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=e2b7aafd-31ef-47e9-89f7-10712a896e28&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e2b7aafd-31ef-47e9-89f7-10712a896e28&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e2b7aafd-31ef-47e9-89f7-10712a896e28&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T21:12:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5db2e26e-5c4e-4616-b962-8ff8794e7d0a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5db2e26e-5c4e-4616-b962-8ff8794e7d0a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T21:13:15+00:00",
      "updated_at": "2022-07-14T21:13:15+00:00",
      "number": "http://bqbl.it/5db2e26e-5c4e-4616-b962-8ff8794e7d0a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/30784c3f700def8885a3d757756b99f3/barcode/image/5db2e26e-5c4e-4616-b962-8ff8794e7d0a/49d989f8-64c0-4e23-b5e1-6d8060576844.svg",
      "owner_id": "455344ad-3dd4-498a-afe8-86af376e84cf",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/455344ad-3dd4-498a-afe8-86af376e84cf"
        },
        "data": {
          "type": "customers",
          "id": "455344ad-3dd4-498a-afe8-86af376e84cf"
        }
      }
    }
  },
  "included": [
    {
      "id": "455344ad-3dd4-498a-afe8-86af376e84cf",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T21:13:15+00:00",
        "updated_at": "2022-07-14T21:13:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Larson-Cremin",
        "email": "cremin_larson@kris.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=455344ad-3dd4-498a-afe8-86af376e84cf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=455344ad-3dd4-498a-afe8-86af376e84cf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=455344ad-3dd4-498a-afe8-86af376e84cf&filter[owner_type]=customers"
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
          "owner_id": "6078848e-b64e-495e-a3ba-8d25aad1df4f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "26f93c8f-a409-4be6-bf1a-0eb4ada25bb5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T21:13:15+00:00",
      "updated_at": "2022-07-14T21:13:15+00:00",
      "number": "http://bqbl.it/26f93c8f-a409-4be6-bf1a-0eb4ada25bb5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1362563f7b05158beb881d9c6f096d05/barcode/image/26f93c8f-a409-4be6-bf1a-0eb4ada25bb5/1da65b85-ef78-4abb-8fd5-ebf0f2b04434.svg",
      "owner_id": "6078848e-b64e-495e-a3ba-8d25aad1df4f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/37b289b9-0b92-430b-8bc8-2108df7515e7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "37b289b9-0b92-430b-8bc8-2108df7515e7",
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
    "id": "37b289b9-0b92-430b-8bc8-2108df7515e7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T21:13:16+00:00",
      "updated_at": "2022-07-14T21:13:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5d86c4943240eacf6bcab1c56ac56e67/barcode/image/37b289b9-0b92-430b-8bc8-2108df7515e7/a58f2dce-223c-4b27-a616-b0575714a6ea.svg",
      "owner_id": "bb80d02a-4652-449d-ab94-9caa90d89e84",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cf963447-0f23-4996-98f0-5d5de380e9d3' \
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