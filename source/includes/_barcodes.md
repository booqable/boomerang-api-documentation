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
      "id": "819dc042-701b-45b1-aef3-74ce5134431c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-15T09:34:09+00:00",
        "updated_at": "2022-06-15T09:34:09+00:00",
        "number": "http://bqbl.it/819dc042-701b-45b1-aef3-74ce5134431c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/67cb73064ff64f712df54d2947db0cc6/barcode/image/819dc042-701b-45b1-aef3-74ce5134431c/479c2f01-5b51-46e7-9d49-c6dd88f5168b.svg",
        "owner_id": "adc13773-a890-4009-aceb-2f2a1e5060ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/adc13773-a890-4009-aceb-2f2a1e5060ec"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6cf3feaa-52f6-4f57-8783-c28ff57736af&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6cf3feaa-52f6-4f57-8783-c28ff57736af",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-15T09:34:09+00:00",
        "updated_at": "2022-06-15T09:34:09+00:00",
        "number": "http://bqbl.it/6cf3feaa-52f6-4f57-8783-c28ff57736af",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b76e01cf3ea2e085f6af4d01662659bc/barcode/image/6cf3feaa-52f6-4f57-8783-c28ff57736af/aa019239-7f47-4989-9276-d10da28f3b03.svg",
        "owner_id": "4ff3cec5-340c-4550-95d3-c372e845f258",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4ff3cec5-340c-4550-95d3-c372e845f258"
          },
          "data": {
            "type": "customers",
            "id": "4ff3cec5-340c-4550-95d3-c372e845f258"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4ff3cec5-340c-4550-95d3-c372e845f258",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-15T09:34:09+00:00",
        "updated_at": "2022-06-15T09:34:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Toy LLC",
        "email": "toy.llc@mohr.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=4ff3cec5-340c-4550-95d3-c372e845f258&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4ff3cec5-340c-4550-95d3-c372e845f258&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4ff3cec5-340c-4550-95d3-c372e845f258&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmJkNDk5ZjMtMTAzNC00MmMwLTkxYmEtYWFlMDRhYmZiZGQ5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2bd499f3-1034-42c0-91ba-aae04abfbdd9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-15T09:34:10+00:00",
        "updated_at": "2022-06-15T09:34:10+00:00",
        "number": "http://bqbl.it/2bd499f3-1034-42c0-91ba-aae04abfbdd9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3e845b7c4260d32d831df553eb11eff1/barcode/image/2bd499f3-1034-42c0-91ba-aae04abfbdd9/af8c35d0-6bd2-4649-aee1-1fbc1187d6fe.svg",
        "owner_id": "3734779a-8b47-48a8-83eb-dd3b0313c198",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3734779a-8b47-48a8-83eb-dd3b0313c198"
          },
          "data": {
            "type": "customers",
            "id": "3734779a-8b47-48a8-83eb-dd3b0313c198"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3734779a-8b47-48a8-83eb-dd3b0313c198",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-15T09:34:09+00:00",
        "updated_at": "2022-06-15T09:34:10+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Klein-Douglas",
        "email": "klein.douglas@marks.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=3734779a-8b47-48a8-83eb-dd3b0313c198&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3734779a-8b47-48a8-83eb-dd3b0313c198&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3734779a-8b47-48a8-83eb-dd3b0313c198&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-15T09:33:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5ca5bce7-7cb5-4b42-b943-5c0ef71670b3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5ca5bce7-7cb5-4b42-b943-5c0ef71670b3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-15T09:34:10+00:00",
      "updated_at": "2022-06-15T09:34:10+00:00",
      "number": "http://bqbl.it/5ca5bce7-7cb5-4b42-b943-5c0ef71670b3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c9e4094ca37494540bac73b4fb28bd43/barcode/image/5ca5bce7-7cb5-4b42-b943-5c0ef71670b3/1a1e35b7-bb74-4031-bf60-e294e3602ecf.svg",
      "owner_id": "c3c83d86-6620-48a7-bc06-0e3f227e2780",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c3c83d86-6620-48a7-bc06-0e3f227e2780"
        },
        "data": {
          "type": "customers",
          "id": "c3c83d86-6620-48a7-bc06-0e3f227e2780"
        }
      }
    }
  },
  "included": [
    {
      "id": "c3c83d86-6620-48a7-bc06-0e3f227e2780",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-15T09:34:10+00:00",
        "updated_at": "2022-06-15T09:34:10+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Rolfson-Dibbert",
        "email": "rolfson_dibbert@denesik-emard.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=c3c83d86-6620-48a7-bc06-0e3f227e2780&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c3c83d86-6620-48a7-bc06-0e3f227e2780&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c3c83d86-6620-48a7-bc06-0e3f227e2780&filter[owner_type]=customers"
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
          "owner_id": "b5251aef-8d81-48b9-8511-1cb4635ef1dc",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7f959050-0db8-4b19-9d9e-77e0a2233a4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-15T09:34:10+00:00",
      "updated_at": "2022-06-15T09:34:10+00:00",
      "number": "http://bqbl.it/7f959050-0db8-4b19-9d9e-77e0a2233a4a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2a0f2ac40a3edebc374c76bb796627ff/barcode/image/7f959050-0db8-4b19-9d9e-77e0a2233a4a/cfb7cfa4-58a3-4690-8f73-09ff8aaf086f.svg",
      "owner_id": "b5251aef-8d81-48b9-8511-1cb4635ef1dc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/90f76008-7da0-48f9-9503-0e86e37b0608' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "90f76008-7da0-48f9-9503-0e86e37b0608",
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
    "id": "90f76008-7da0-48f9-9503-0e86e37b0608",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-15T09:34:11+00:00",
      "updated_at": "2022-06-15T09:34:11+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f12c7ab9ee89b03394e357889548ba4f/barcode/image/90f76008-7da0-48f9-9503-0e86e37b0608/fa7c6d1b-640b-4462-a8ec-9b36e466144a.svg",
      "owner_id": "28934da0-76d3-4e51-a3c4-626bbb1bbc10",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/374e67df-ca1b-4ad2-94ec-85b7ddfd91e9' \
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