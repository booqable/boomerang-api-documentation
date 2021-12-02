# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "9d70b43f-502b-4772-981c-d44a52410f92",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T11:34:13+00:00",
        "updated_at": "2021-12-02T11:34:13+00:00",
        "number": "http://bqbl.it/9d70b43f-502b-4772-981c-d44a52410f92",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2e515ce5161056d234ae26d72120697c/barcode/image/9d70b43f-502b-4772-981c-d44a52410f92/1a0e8c15-2334-4db5-9306-59d6b94ac86b.svg",
        "owner_id": "50fb1ca4-2393-4b21-9971-16266a69af18",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/50fb1ca4-2393-4b21-9971-16266a69af18"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5d4e6e13-0dfc-4db5-b04b-effcf486ffbf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5d4e6e13-0dfc-4db5-b04b-effcf486ffbf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T11:34:14+00:00",
        "updated_at": "2021-12-02T11:34:14+00:00",
        "number": "http://bqbl.it/5d4e6e13-0dfc-4db5-b04b-effcf486ffbf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/14b8a3ce84a996a91f6b7ff4928dd222/barcode/image/5d4e6e13-0dfc-4db5-b04b-effcf486ffbf/06e8b91a-0cd7-4032-9bd1-73a0f0829bad.svg",
        "owner_id": "68130b02-76e2-4e5b-9291-d4e66b36af73",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/68130b02-76e2-4e5b-9291-d4e66b36af73"
          },
          "data": {
            "type": "customers",
            "id": "68130b02-76e2-4e5b-9291-d4e66b36af73"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "68130b02-76e2-4e5b-9291-d4e66b36af73",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T11:34:14+00:00",
        "updated_at": "2021-12-02T11:34:14+00:00",
        "number": 1,
        "name": "Dietrich-Doyle",
        "email": "doyle.dietrich@mosciski.co",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=68130b02-76e2-4e5b-9291-d4e66b36af73&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=68130b02-76e2-4e5b-9291-d4e66b36af73&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=68130b02-76e2-4e5b-9291-d4e66b36af73&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5d4e6e13-0dfc-4db5-b04b-effcf486ffbf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5d4e6e13-0dfc-4db5-b04b-effcf486ffbf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5d4e6e13-0dfc-4db5-b04b-effcf486ffbf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T11:34:02Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e8644711-9419-4c2d-aab0-694cef34e805?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e8644711-9419-4c2d-aab0-694cef34e805",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T11:34:14+00:00",
      "updated_at": "2021-12-02T11:34:14+00:00",
      "number": "http://bqbl.it/e8644711-9419-4c2d-aab0-694cef34e805",
      "barcode_type": "qr_code",
      "image_url": "/uploads/14debf526a10428e60a7fe7b001c2556/barcode/image/e8644711-9419-4c2d-aab0-694cef34e805/ffeae7fe-7634-4ce6-8bf7-7444ce0d0b73.svg",
      "owner_id": "b7648e53-e705-459c-9457-4bf2741d6391",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b7648e53-e705-459c-9457-4bf2741d6391"
        },
        "data": {
          "type": "customers",
          "id": "b7648e53-e705-459c-9457-4bf2741d6391"
        }
      }
    }
  },
  "included": [
    {
      "id": "b7648e53-e705-459c-9457-4bf2741d6391",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T11:34:14+00:00",
        "updated_at": "2021-12-02T11:34:14+00:00",
        "number": 1,
        "name": "Tillman-Stiedemann",
        "email": "tillman.stiedemann@fay-nicolas.name",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=b7648e53-e705-459c-9457-4bf2741d6391&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b7648e53-e705-459c-9457-4bf2741d6391&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b7648e53-e705-459c-9457-4bf2741d6391&filter[owner_type]=customers"
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
          "owner_id": "3e2dd7eb-7383-40c2-9625-a82ecccedbc6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "04bac775-e0be-4a9f-bbca-006b8ecd9398",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T11:34:15+00:00",
      "updated_at": "2021-12-02T11:34:15+00:00",
      "number": "http://bqbl.it/04bac775-e0be-4a9f-bbca-006b8ecd9398",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ef1a61d6e30d1e148f4a7fa4f6310c8e/barcode/image/04bac775-e0be-4a9f-bbca-006b8ecd9398/beea4651-b01c-4f7c-8392-1f74b06af81d.svg",
      "owner_id": "3e2dd7eb-7383-40c2-9625-a82ecccedbc6",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3e2dd7eb-7383-40c2-9625-a82ecccedbc6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3e2dd7eb-7383-40c2-9625-a82ecccedbc6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3e2dd7eb-7383-40c2-9625-a82ecccedbc6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/754b18c6-54f5-456e-b2e8-27d60181dad6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "754b18c6-54f5-456e-b2e8-27d60181dad6",
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
    "id": "754b18c6-54f5-456e-b2e8-27d60181dad6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T11:34:16+00:00",
      "updated_at": "2021-12-02T11:34:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/79837f3c89d8e48d5c219b87ed389981/barcode/image/754b18c6-54f5-456e-b2e8-27d60181dad6/bc5f5ea6-ec59-4760-bf6b-1f2b43767f4f.svg",
      "owner_id": "312e58f5-a8ba-4ed5-9193-0213a41ef0c8",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8351e829-f185-4c0b-b2cf-5d6072254c5d' \
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