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
      "id": "3c7bf6c4-a130-4f0a-b8ec-41e6e3dbf791",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T14:28:19+00:00",
        "updated_at": "2022-10-13T14:28:19+00:00",
        "number": "http://bqbl.it/3c7bf6c4-a130-4f0a-b8ec-41e6e3dbf791",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1744cda92d5e520c5ca0ac45e30bee04/barcode/image/3c7bf6c4-a130-4f0a-b8ec-41e6e3dbf791/0f2c2190-e36a-41e8-9b24-93f91a453d8b.svg",
        "owner_id": "406055c0-3126-4b20-ab56-b89669be162f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/406055c0-3126-4b20-ab56-b89669be162f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F21044e05-ce23-4f8b-a469-4230cf291cd6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "21044e05-ce23-4f8b-a469-4230cf291cd6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T14:28:19+00:00",
        "updated_at": "2022-10-13T14:28:19+00:00",
        "number": "http://bqbl.it/21044e05-ce23-4f8b-a469-4230cf291cd6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cc1719f549c1167724cbf969ac884186/barcode/image/21044e05-ce23-4f8b-a469-4230cf291cd6/fcbe3853-0feb-4f17-b138-e7560703c850.svg",
        "owner_id": "c7265211-1843-4481-b7b8-f4fca27c26c8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c7265211-1843-4481-b7b8-f4fca27c26c8"
          },
          "data": {
            "type": "customers",
            "id": "c7265211-1843-4481-b7b8-f4fca27c26c8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c7265211-1843-4481-b7b8-f4fca27c26c8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T14:28:19+00:00",
        "updated_at": "2022-10-13T14:28:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c7265211-1843-4481-b7b8-f4fca27c26c8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c7265211-1843-4481-b7b8-f4fca27c26c8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c7265211-1843-4481-b7b8-f4fca27c26c8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmE1YTcwZGQtNjQ2OS00Yjk0LThiMzEtOGViYjc3NjZiZGMw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6a5a70dd-6469-4b94-8b31-8ebb7766bdc0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T14:28:20+00:00",
        "updated_at": "2022-10-13T14:28:20+00:00",
        "number": "http://bqbl.it/6a5a70dd-6469-4b94-8b31-8ebb7766bdc0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/953f30701b042df2a9ab4f84aad7c7a0/barcode/image/6a5a70dd-6469-4b94-8b31-8ebb7766bdc0/1fdcba04-afbf-4124-990d-7a100ee2a35e.svg",
        "owner_id": "ed71b367-c618-45e2-a424-bcef885f9ec1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ed71b367-c618-45e2-a424-bcef885f9ec1"
          },
          "data": {
            "type": "customers",
            "id": "ed71b367-c618-45e2-a424-bcef885f9ec1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ed71b367-c618-45e2-a424-bcef885f9ec1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T14:28:20+00:00",
        "updated_at": "2022-10-13T14:28:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ed71b367-c618-45e2-a424-bcef885f9ec1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ed71b367-c618-45e2-a424-bcef885f9ec1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ed71b367-c618-45e2-a424-bcef885f9ec1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T14:28:02Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0980d451-e78a-46f0-9329-33e4588c57f0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0980d451-e78a-46f0-9329-33e4588c57f0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T14:28:20+00:00",
      "updated_at": "2022-10-13T14:28:20+00:00",
      "number": "http://bqbl.it/0980d451-e78a-46f0-9329-33e4588c57f0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e52950e38d76f2ff32b4ba84f97096e2/barcode/image/0980d451-e78a-46f0-9329-33e4588c57f0/b11d12d3-4f82-4053-bf63-42de35fcb265.svg",
      "owner_id": "f3d877ce-7a52-4402-836f-72b159f7b0fc",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f3d877ce-7a52-4402-836f-72b159f7b0fc"
        },
        "data": {
          "type": "customers",
          "id": "f3d877ce-7a52-4402-836f-72b159f7b0fc"
        }
      }
    }
  },
  "included": [
    {
      "id": "f3d877ce-7a52-4402-836f-72b159f7b0fc",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T14:28:20+00:00",
        "updated_at": "2022-10-13T14:28:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f3d877ce-7a52-4402-836f-72b159f7b0fc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f3d877ce-7a52-4402-836f-72b159f7b0fc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f3d877ce-7a52-4402-836f-72b159f7b0fc&filter[owner_type]=customers"
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
          "owner_id": "e20657e3-a066-4aa5-a15d-e606ae90c06d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0f4d39df-7c00-4d77-8657-a45090a7c75f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T14:28:21+00:00",
      "updated_at": "2022-10-13T14:28:21+00:00",
      "number": "http://bqbl.it/0f4d39df-7c00-4d77-8657-a45090a7c75f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a751f617bb6b55f609d2775283e0d6fa/barcode/image/0f4d39df-7c00-4d77-8657-a45090a7c75f/3877c247-3d43-4d7a-b34c-33da6d0ccd5d.svg",
      "owner_id": "e20657e3-a066-4aa5-a15d-e606ae90c06d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/44e4a0c8-04a5-45e2-873b-d3b6f4d52dff' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "44e4a0c8-04a5-45e2-873b-d3b6f4d52dff",
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
    "id": "44e4a0c8-04a5-45e2-873b-d3b6f4d52dff",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T14:28:22+00:00",
      "updated_at": "2022-10-13T14:28:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e4f86f5ed3407dfac65c4fdd01e8e321/barcode/image/44e4a0c8-04a5-45e2-873b-d3b6f4d52dff/d94319f0-0db2-4779-85b5-1b99ef72b59d.svg",
      "owner_id": "ea2eb794-7280-442a-b050-8ca43fce2365",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fe22a419-0648-4767-a1fa-d3ab148a82d5' \
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