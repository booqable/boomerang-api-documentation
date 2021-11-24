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
      "id": "a9305492-d6e0-499e-b9eb-7eff0ec14fb6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-24T18:21:05+00:00",
        "updated_at": "2021-11-24T18:21:05+00:00",
        "number": "http://bqbl.it/a9305492-d6e0-499e-b9eb-7eff0ec14fb6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0e287fd392fb19deb73643614e9947d5/barcode/image/a9305492-d6e0-499e-b9eb-7eff0ec14fb6/add8535e-924d-425c-96c2-5a5fa4a926cd.svg",
        "owner_id": "cb06bb90-5b3a-4943-a6d3-8cdd6d9889ba",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cb06bb90-5b3a-4943-a6d3-8cdd6d9889ba"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F044a5d79-8c6f-4ffe-ac76-498efc99b3c7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "044a5d79-8c6f-4ffe-ac76-498efc99b3c7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-24T18:21:06+00:00",
        "updated_at": "2021-11-24T18:21:06+00:00",
        "number": "http://bqbl.it/044a5d79-8c6f-4ffe-ac76-498efc99b3c7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/433ffd7616f44dc0d4c34200cede4926/barcode/image/044a5d79-8c6f-4ffe-ac76-498efc99b3c7/f517da5c-242a-4d42-93bc-9136e7871101.svg",
        "owner_id": "e01aea98-0325-4d82-83e3-bbfa053b728b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e01aea98-0325-4d82-83e3-bbfa053b728b"
          },
          "data": {
            "type": "customers",
            "id": "e01aea98-0325-4d82-83e3-bbfa053b728b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e01aea98-0325-4d82-83e3-bbfa053b728b",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-24T18:21:06+00:00",
        "updated_at": "2021-11-24T18:21:06+00:00",
        "number": 1,
        "name": "Pfannerstill, Keeling and Keeling",
        "email": "keeling_keeling_and_pfannerstill@rowe.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=e01aea98-0325-4d82-83e3-bbfa053b728b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e01aea98-0325-4d82-83e3-bbfa053b728b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e01aea98-0325-4d82-83e3-bbfa053b728b&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F044a5d79-8c6f-4ffe-ac76-498efc99b3c7&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F044a5d79-8c6f-4ffe-ac76-498efc99b3c7&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F044a5d79-8c6f-4ffe-ac76-498efc99b3c7&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-24T18:20:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1ee9a360-151d-46f2-8055-803a454f5c5f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1ee9a360-151d-46f2-8055-803a454f5c5f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-24T18:21:06+00:00",
      "updated_at": "2021-11-24T18:21:06+00:00",
      "number": "http://bqbl.it/1ee9a360-151d-46f2-8055-803a454f5c5f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d76d303ecefd988b77283b3a3636080c/barcode/image/1ee9a360-151d-46f2-8055-803a454f5c5f/fbc7b45e-c5f7-4d01-8a9e-861c425b220f.svg",
      "owner_id": "17b866e7-6f1b-4666-811a-2b1727f5f05c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/17b866e7-6f1b-4666-811a-2b1727f5f05c"
        },
        "data": {
          "type": "customers",
          "id": "17b866e7-6f1b-4666-811a-2b1727f5f05c"
        }
      }
    }
  },
  "included": [
    {
      "id": "17b866e7-6f1b-4666-811a-2b1727f5f05c",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-24T18:21:06+00:00",
        "updated_at": "2021-11-24T18:21:06+00:00",
        "number": 1,
        "name": "Nicolas, Tromp and Kemmer",
        "email": "kemmer.and.nicolas.tromp@swift-gulgowski.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=17b866e7-6f1b-4666-811a-2b1727f5f05c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=17b866e7-6f1b-4666-811a-2b1727f5f05c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=17b866e7-6f1b-4666-811a-2b1727f5f05c&filter[owner_type]=customers"
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
          "owner_id": "929e214d-7177-42d9-b815-781f750b9739",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4eb03ee8-1cee-4574-9680-2955cd0e99c5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-24T18:21:07+00:00",
      "updated_at": "2021-11-24T18:21:07+00:00",
      "number": "http://bqbl.it/4eb03ee8-1cee-4574-9680-2955cd0e99c5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c984c5ed73d72b43bf148f05b513d74c/barcode/image/4eb03ee8-1cee-4574-9680-2955cd0e99c5/c649d59a-5e01-4fa3-988b-67068c48d4c0.svg",
      "owner_id": "929e214d-7177-42d9-b815-781f750b9739",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=929e214d-7177-42d9-b815-781f750b9739&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=929e214d-7177-42d9-b815-781f750b9739&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=929e214d-7177-42d9-b815-781f750b9739&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1534ed56-f89d-43ae-af7f-5baac55d2399' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1534ed56-f89d-43ae-af7f-5baac55d2399",
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
    "id": "1534ed56-f89d-43ae-af7f-5baac55d2399",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-24T18:21:07+00:00",
      "updated_at": "2021-11-24T18:21:07+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4d1689e52c3ebb3b2134de40bba10886/barcode/image/1534ed56-f89d-43ae-af7f-5baac55d2399/24bdde5d-e816-4446-bb9f-b7b27d2269e6.svg",
      "owner_id": "9e37b1bc-29b7-4eca-8017-32dfd7857cbb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c49e6fff-5299-41a4-a6ae-18ac92836d5b' \
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