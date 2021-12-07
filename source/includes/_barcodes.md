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
      "id": "ece169e7-9fee-40e9-8888-ad1defa16bab",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-07T11:00:47+00:00",
        "updated_at": "2021-12-07T11:00:47+00:00",
        "number": "http://bqbl.it/ece169e7-9fee-40e9-8888-ad1defa16bab",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a9769318a0adb025583d0ed73f330f39/barcode/image/ece169e7-9fee-40e9-8888-ad1defa16bab/0c0cd53d-8d00-4837-b745-f51dd848760f.svg",
        "owner_id": "d58d7a67-fe8a-410d-98ce-74c66fde8ab3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d58d7a67-fe8a-410d-98ce-74c66fde8ab3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1ffa4bea-b56e-4cb3-979a-c01dcebf8e13&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1ffa4bea-b56e-4cb3-979a-c01dcebf8e13",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-07T11:00:48+00:00",
        "updated_at": "2021-12-07T11:00:48+00:00",
        "number": "http://bqbl.it/1ffa4bea-b56e-4cb3-979a-c01dcebf8e13",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ee162ad080e4711be2e01fd6f5a68f5c/barcode/image/1ffa4bea-b56e-4cb3-979a-c01dcebf8e13/5545a1da-2d3f-4990-8ee6-4bfd95018fab.svg",
        "owner_id": "b071e113-473f-493d-9f7c-b458e202ea37",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b071e113-473f-493d-9f7c-b458e202ea37"
          },
          "data": {
            "type": "customers",
            "id": "b071e113-473f-493d-9f7c-b458e202ea37"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b071e113-473f-493d-9f7c-b458e202ea37",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-07T11:00:48+00:00",
        "updated_at": "2021-12-07T11:00:48+00:00",
        "number": 1,
        "name": "Bartoletti-Christiansen",
        "email": "bartoletti.christiansen@gerlach.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=b071e113-473f-493d-9f7c-b458e202ea37&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b071e113-473f-493d-9f7c-b458e202ea37&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b071e113-473f-493d-9f7c-b458e202ea37&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1ffa4bea-b56e-4cb3-979a-c01dcebf8e13&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1ffa4bea-b56e-4cb3-979a-c01dcebf8e13&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1ffa4bea-b56e-4cb3-979a-c01dcebf8e13&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-07T11:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d1b6e2ac-1252-4338-8ce8-c6092b91d68d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d1b6e2ac-1252-4338-8ce8-c6092b91d68d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-07T11:00:48+00:00",
      "updated_at": "2021-12-07T11:00:48+00:00",
      "number": "http://bqbl.it/d1b6e2ac-1252-4338-8ce8-c6092b91d68d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/19e0770825c3afa38492a9f7d9e686ca/barcode/image/d1b6e2ac-1252-4338-8ce8-c6092b91d68d/c721a248-ca3a-46c8-b7ab-6b96353ba670.svg",
      "owner_id": "86b1320e-cbab-49af-b38c-cef10e9b25e7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/86b1320e-cbab-49af-b38c-cef10e9b25e7"
        },
        "data": {
          "type": "customers",
          "id": "86b1320e-cbab-49af-b38c-cef10e9b25e7"
        }
      }
    }
  },
  "included": [
    {
      "id": "86b1320e-cbab-49af-b38c-cef10e9b25e7",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-07T11:00:48+00:00",
        "updated_at": "2021-12-07T11:00:48+00:00",
        "number": 1,
        "name": "MacGyver and Sons",
        "email": "sons_and_macgyver@strosin.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=86b1320e-cbab-49af-b38c-cef10e9b25e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=86b1320e-cbab-49af-b38c-cef10e9b25e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=86b1320e-cbab-49af-b38c-cef10e9b25e7&filter[owner_type]=customers"
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
          "owner_id": "df985f5f-8530-4532-9b7d-e605d8610af3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "175a33a2-df34-424c-a803-a0459fe2a42b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-07T11:00:49+00:00",
      "updated_at": "2021-12-07T11:00:49+00:00",
      "number": "http://bqbl.it/175a33a2-df34-424c-a803-a0459fe2a42b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0e062732ecc1849a2cf629c9a4f2745c/barcode/image/175a33a2-df34-424c-a803-a0459fe2a42b/4473245d-7c7a-4f29-9297-7fe5714a6754.svg",
      "owner_id": "df985f5f-8530-4532-9b7d-e605d8610af3",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=df985f5f-8530-4532-9b7d-e605d8610af3&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=df985f5f-8530-4532-9b7d-e605d8610af3&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=df985f5f-8530-4532-9b7d-e605d8610af3&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4d6e8ec4-9d25-4714-b20e-57578dc70025' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4d6e8ec4-9d25-4714-b20e-57578dc70025",
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
    "id": "4d6e8ec4-9d25-4714-b20e-57578dc70025",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-07T11:00:49+00:00",
      "updated_at": "2021-12-07T11:00:50+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8368a7660008551ceb7d3d04b2aab1d3/barcode/image/4d6e8ec4-9d25-4714-b20e-57578dc70025/94ab5bb2-942e-4521-90a5-8c535099c3f5.svg",
      "owner_id": "1d9a42e3-1171-4430-8a9e-3afa89fb1f30",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5a2d26fd-be5b-4cd6-b7c4-9ff85a263301' \
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