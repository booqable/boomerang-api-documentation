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
      "id": "2f2d2d07-227f-49ad-9443-6ec3b29f8e2a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-29T09:02:18+00:00",
        "updated_at": "2021-11-29T09:02:18+00:00",
        "number": "http://bqbl.it/2f2d2d07-227f-49ad-9443-6ec3b29f8e2a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63f5032568c923c898118fa915f12a15/barcode/image/2f2d2d07-227f-49ad-9443-6ec3b29f8e2a/3cc5be2c-03c2-4f31-be53-cde120321b48.svg",
        "owner_id": "710aafb6-c243-4c35-b0ad-0cd4697452d3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/710aafb6-c243-4c35-b0ad-0cd4697452d3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fcb165607-6696-4607-a02d-a33fbf38278d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cb165607-6696-4607-a02d-a33fbf38278d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-29T09:02:19+00:00",
        "updated_at": "2021-11-29T09:02:19+00:00",
        "number": "http://bqbl.it/cb165607-6696-4607-a02d-a33fbf38278d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1253542467ff73fc879c5c716b9bffcc/barcode/image/cb165607-6696-4607-a02d-a33fbf38278d/d9841c39-948f-409c-ab73-3e4b57e4b522.svg",
        "owner_id": "1a31469b-4d8a-4870-b452-f8994bf5963a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1a31469b-4d8a-4870-b452-f8994bf5963a"
          },
          "data": {
            "type": "customers",
            "id": "1a31469b-4d8a-4870-b452-f8994bf5963a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1a31469b-4d8a-4870-b452-f8994bf5963a",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-29T09:02:18+00:00",
        "updated_at": "2021-11-29T09:02:19+00:00",
        "number": 1,
        "name": "Spinka Inc",
        "email": "spinka_inc@vandervort.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=1a31469b-4d8a-4870-b452-f8994bf5963a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1a31469b-4d8a-4870-b452-f8994bf5963a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1a31469b-4d8a-4870-b452-f8994bf5963a&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fcb165607-6696-4607-a02d-a33fbf38278d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fcb165607-6696-4607-a02d-a33fbf38278d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fcb165607-6696-4607-a02d-a33fbf38278d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-29T09:02:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1116bbf4-5d74-4125-bc2e-79d5b14832af?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1116bbf4-5d74-4125-bc2e-79d5b14832af",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-29T09:02:19+00:00",
      "updated_at": "2021-11-29T09:02:19+00:00",
      "number": "http://bqbl.it/1116bbf4-5d74-4125-bc2e-79d5b14832af",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7ac2b5e49848aa9bdd4117842abc3866/barcode/image/1116bbf4-5d74-4125-bc2e-79d5b14832af/0d4e9fd6-ba06-4c47-8ec4-479e8179dff0.svg",
      "owner_id": "e962231a-5c1e-44c0-bea6-9e4759817fd8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e962231a-5c1e-44c0-bea6-9e4759817fd8"
        },
        "data": {
          "type": "customers",
          "id": "e962231a-5c1e-44c0-bea6-9e4759817fd8"
        }
      }
    }
  },
  "included": [
    {
      "id": "e962231a-5c1e-44c0-bea6-9e4759817fd8",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-29T09:02:19+00:00",
        "updated_at": "2021-11-29T09:02:19+00:00",
        "number": 1,
        "name": "Ruecker and Sons",
        "email": "sons.ruecker.and@schuppe.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=e962231a-5c1e-44c0-bea6-9e4759817fd8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e962231a-5c1e-44c0-bea6-9e4759817fd8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e962231a-5c1e-44c0-bea6-9e4759817fd8&filter[owner_type]=customers"
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
          "owner_id": "3721c431-3d18-4bed-abbb-74f8fd9f73a2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b35247e2-8d74-4a31-91c6-9e0d816eaa4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-29T09:02:20+00:00",
      "updated_at": "2021-11-29T09:02:20+00:00",
      "number": "http://bqbl.it/b35247e2-8d74-4a31-91c6-9e0d816eaa4a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54714a0bfbca1eaf0eeb646ac19cc6c7/barcode/image/b35247e2-8d74-4a31-91c6-9e0d816eaa4a/b28c465d-96a7-4b65-a22a-a0d7fbdf0d44.svg",
      "owner_id": "3721c431-3d18-4bed-abbb-74f8fd9f73a2",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3721c431-3d18-4bed-abbb-74f8fd9f73a2&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3721c431-3d18-4bed-abbb-74f8fd9f73a2&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3721c431-3d18-4bed-abbb-74f8fd9f73a2&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/63939531-be1a-4552-972e-b977c944a721' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "63939531-be1a-4552-972e-b977c944a721",
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
    "id": "63939531-be1a-4552-972e-b977c944a721",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-29T09:02:20+00:00",
      "updated_at": "2021-11-29T09:02:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0659a5092c451a6a0477b6c5eff7f322/barcode/image/63939531-be1a-4552-972e-b977c944a721/a8ce3fc2-5f37-42f1-ac4d-2ba65b0d5a7e.svg",
      "owner_id": "3403b055-7f6a-46c5-bcce-eed7b541b000",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d1f9698d-b418-441e-b19f-68d367f55438' \
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