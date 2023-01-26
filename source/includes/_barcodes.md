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
      "id": "6edceb1c-5789-4179-8ddc-e7d8a5c6bfc1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T08:08:16+00:00",
        "updated_at": "2023-01-26T08:08:16+00:00",
        "number": "http://bqbl.it/6edceb1c-5789-4179-8ddc-e7d8a5c6bfc1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/89a25b36055baf289cdc9eca247f3cda/barcode/image/6edceb1c-5789-4179-8ddc-e7d8a5c6bfc1/9144e266-6493-4937-992e-de95fcc07645.svg",
        "owner_id": "3c923f39-d208-45e5-baa0-fe346cdec8f6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3c923f39-d208-45e5-baa0-fe346cdec8f6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F18024266-1ff9-4a5c-af7a-32d4dac5aa1b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "18024266-1ff9-4a5c-af7a-32d4dac5aa1b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T08:08:16+00:00",
        "updated_at": "2023-01-26T08:08:16+00:00",
        "number": "http://bqbl.it/18024266-1ff9-4a5c-af7a-32d4dac5aa1b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0685ba245c7f9bd2524ccf446ff094c0/barcode/image/18024266-1ff9-4a5c-af7a-32d4dac5aa1b/e01ea95b-a9ae-4f3d-ac84-8e388bb3f64d.svg",
        "owner_id": "9fad3501-9c47-484c-bb74-c23ab694e660",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9fad3501-9c47-484c-bb74-c23ab694e660"
          },
          "data": {
            "type": "customers",
            "id": "9fad3501-9c47-484c-bb74-c23ab694e660"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9fad3501-9c47-484c-bb74-c23ab694e660",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T08:08:16+00:00",
        "updated_at": "2023-01-26T08:08:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9fad3501-9c47-484c-bb74-c23ab694e660&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9fad3501-9c47-484c-bb74-c23ab694e660&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9fad3501-9c47-484c-bb74-c23ab694e660&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMGJiYWQyNjAtYTE5NS00ZmQ2LThiYzEtMDNjNGQ5YTFlNWEx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0bbad260-a195-4fd6-8bc1-03c4d9a1e5a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T08:08:17+00:00",
        "updated_at": "2023-01-26T08:08:17+00:00",
        "number": "http://bqbl.it/0bbad260-a195-4fd6-8bc1-03c4d9a1e5a1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f813152ddd43d5ee538468b200d1c1b4/barcode/image/0bbad260-a195-4fd6-8bc1-03c4d9a1e5a1/bd13d644-40f8-4d83-8c62-3de07183b128.svg",
        "owner_id": "5d3f4aca-ebe0-4c38-b927-6c882006b870",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5d3f4aca-ebe0-4c38-b927-6c882006b870"
          },
          "data": {
            "type": "customers",
            "id": "5d3f4aca-ebe0-4c38-b927-6c882006b870"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5d3f4aca-ebe0-4c38-b927-6c882006b870",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T08:08:17+00:00",
        "updated_at": "2023-01-26T08:08:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5d3f4aca-ebe0-4c38-b927-6c882006b870&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5d3f4aca-ebe0-4c38-b927-6c882006b870&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5d3f4aca-ebe0-4c38-b927-6c882006b870&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T08:07:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/126adfc6-e5e1-412d-8035-c87d9c4c6ad5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "126adfc6-e5e1-412d-8035-c87d9c4c6ad5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T08:08:17+00:00",
      "updated_at": "2023-01-26T08:08:17+00:00",
      "number": "http://bqbl.it/126adfc6-e5e1-412d-8035-c87d9c4c6ad5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/08731fe96fd8a882984089fa231057b6/barcode/image/126adfc6-e5e1-412d-8035-c87d9c4c6ad5/cd77b6d7-787a-4b04-a536-81e18c8836ba.svg",
      "owner_id": "982d5234-3d94-491b-a7e0-1898db32239b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/982d5234-3d94-491b-a7e0-1898db32239b"
        },
        "data": {
          "type": "customers",
          "id": "982d5234-3d94-491b-a7e0-1898db32239b"
        }
      }
    }
  },
  "included": [
    {
      "id": "982d5234-3d94-491b-a7e0-1898db32239b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T08:08:17+00:00",
        "updated_at": "2023-01-26T08:08:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=982d5234-3d94-491b-a7e0-1898db32239b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=982d5234-3d94-491b-a7e0-1898db32239b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=982d5234-3d94-491b-a7e0-1898db32239b&filter[owner_type]=customers"
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
          "owner_id": "0021d1c5-cfe5-4303-8999-072d99d6bca1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "558b9257-0f1b-4434-9a9f-b1012c077c58",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T08:08:18+00:00",
      "updated_at": "2023-01-26T08:08:18+00:00",
      "number": "http://bqbl.it/558b9257-0f1b-4434-9a9f-b1012c077c58",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0387f592669a2f573ea4f650f90692cf/barcode/image/558b9257-0f1b-4434-9a9f-b1012c077c58/f7a7a7eb-3a91-4ca3-a0ac-8f8d65b56025.svg",
      "owner_id": "0021d1c5-cfe5-4303-8999-072d99d6bca1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df297353-d674-4b5e-a081-0141a36d75c6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "df297353-d674-4b5e-a081-0141a36d75c6",
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
    "id": "df297353-d674-4b5e-a081-0141a36d75c6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T08:08:18+00:00",
      "updated_at": "2023-01-26T08:08:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b98cf664c4c629ba31466912c51a4c06/barcode/image/df297353-d674-4b5e-a081-0141a36d75c6/5935776f-cfa6-4508-9057-550b1af5f50c.svg",
      "owner_id": "058786e6-0861-4b4d-80bc-8a5f4820b617",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2c362e1f-3cab-424f-9a19-ea00edb9c052' \
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