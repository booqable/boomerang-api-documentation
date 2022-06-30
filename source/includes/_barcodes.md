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
      "id": "ae0f4ece-d6d3-4d4c-b63d-4a23415a2e89",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T13:10:05+00:00",
        "updated_at": "2022-06-30T13:10:05+00:00",
        "number": "http://bqbl.it/ae0f4ece-d6d3-4d4c-b63d-4a23415a2e89",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bc921aa0a3f0cd53174825ac9b13d5d4/barcode/image/ae0f4ece-d6d3-4d4c-b63d-4a23415a2e89/1ea02897-3d7c-475a-990b-da4e89ca2668.svg",
        "owner_id": "f6f63647-535d-4c5a-8187-cfa871a9a2e6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f6f63647-535d-4c5a-8187-cfa871a9a2e6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb3a479f3-1a6d-4f2d-b23a-5f056c5c5604&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b3a479f3-1a6d-4f2d-b23a-5f056c5c5604",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T13:10:05+00:00",
        "updated_at": "2022-06-30T13:10:05+00:00",
        "number": "http://bqbl.it/b3a479f3-1a6d-4f2d-b23a-5f056c5c5604",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3139c9fcb690b12d1bf41dd7e4caf1a0/barcode/image/b3a479f3-1a6d-4f2d-b23a-5f056c5c5604/3bcf9deb-9247-40f6-8dbf-88784107d444.svg",
        "owner_id": "a8618ae3-1c6f-467b-ad85-773ea7baec49",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a8618ae3-1c6f-467b-ad85-773ea7baec49"
          },
          "data": {
            "type": "customers",
            "id": "a8618ae3-1c6f-467b-ad85-773ea7baec49"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a8618ae3-1c6f-467b-ad85-773ea7baec49",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T13:10:05+00:00",
        "updated_at": "2022-06-30T13:10:05+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Williamson, Bergstrom and Mann",
        "email": "mann.and.bergstrom.williamson@sporer.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=a8618ae3-1c6f-467b-ad85-773ea7baec49&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a8618ae3-1c6f-467b-ad85-773ea7baec49&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a8618ae3-1c6f-467b-ad85-773ea7baec49&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDMzYzEwMTMtZjFjYy00MTcyLWJlMDItNGJmODQ0Yjc0N2I0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "433c1013-f1cc-4172-be02-4bf844b747b4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T13:10:06+00:00",
        "updated_at": "2022-06-30T13:10:06+00:00",
        "number": "http://bqbl.it/433c1013-f1cc-4172-be02-4bf844b747b4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e3e84ecde521fdb012d65764e9d67b65/barcode/image/433c1013-f1cc-4172-be02-4bf844b747b4/62b86666-73f7-4277-a49e-5a69dc3396ef.svg",
        "owner_id": "17172f02-3902-4734-97a0-3b10597ffeb0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/17172f02-3902-4734-97a0-3b10597ffeb0"
          },
          "data": {
            "type": "customers",
            "id": "17172f02-3902-4734-97a0-3b10597ffeb0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "17172f02-3902-4734-97a0-3b10597ffeb0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T13:10:06+00:00",
        "updated_at": "2022-06-30T13:10:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Turcotte LLC",
        "email": "llc.turcotte@herman.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=17172f02-3902-4734-97a0-3b10597ffeb0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=17172f02-3902-4734-97a0-3b10597ffeb0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=17172f02-3902-4734-97a0-3b10597ffeb0&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T13:09:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df0415d1-8fab-483a-b184-348cdde80c5f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df0415d1-8fab-483a-b184-348cdde80c5f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T13:10:07+00:00",
      "updated_at": "2022-06-30T13:10:07+00:00",
      "number": "http://bqbl.it/df0415d1-8fab-483a-b184-348cdde80c5f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db5aa004d47091edab3ae17318abdec5/barcode/image/df0415d1-8fab-483a-b184-348cdde80c5f/7d316d5b-aba4-42dd-8510-f9edd08fe89b.svg",
      "owner_id": "92e96570-4703-422c-9eaf-d1f196d7fd11",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/92e96570-4703-422c-9eaf-d1f196d7fd11"
        },
        "data": {
          "type": "customers",
          "id": "92e96570-4703-422c-9eaf-d1f196d7fd11"
        }
      }
    }
  },
  "included": [
    {
      "id": "92e96570-4703-422c-9eaf-d1f196d7fd11",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T13:10:07+00:00",
        "updated_at": "2022-06-30T13:10:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Larson-Corkery",
        "email": "corkery.larson@heller.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=92e96570-4703-422c-9eaf-d1f196d7fd11&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92e96570-4703-422c-9eaf-d1f196d7fd11&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92e96570-4703-422c-9eaf-d1f196d7fd11&filter[owner_type]=customers"
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
          "owner_id": "20815f44-ce25-440b-8c68-adc2fd5e9b89",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2ab1b78f-f927-4097-b95c-9a3567a1edcb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T13:10:07+00:00",
      "updated_at": "2022-06-30T13:10:07+00:00",
      "number": "http://bqbl.it/2ab1b78f-f927-4097-b95c-9a3567a1edcb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c6f8bdf4722fdcea338a389ba1a6d251/barcode/image/2ab1b78f-f927-4097-b95c-9a3567a1edcb/b1020b43-dde6-40c8-b7b7-19e9b8e25027.svg",
      "owner_id": "20815f44-ce25-440b-8c68-adc2fd5e9b89",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6bd64cd8-e706-4391-b179-7a11bebf62c3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6bd64cd8-e706-4391-b179-7a11bebf62c3",
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
    "id": "6bd64cd8-e706-4391-b179-7a11bebf62c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T13:10:08+00:00",
      "updated_at": "2022-06-30T13:10:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a3d927ee5e2f47df5414ce5f276ab5dd/barcode/image/6bd64cd8-e706-4391-b179-7a11bebf62c3/08d774ff-a6a8-4c23-b84c-3472c1898077.svg",
      "owner_id": "cc3030b2-d041-46d0-b03b-681f9b897a32",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4d8f0f3a-661a-4879-b5b7-8b2bfc41ae13' \
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