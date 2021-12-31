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
      "id": "5e4da7a6-5654-4185-a70b-641776dde3d8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-30T11:20:40+00:00",
        "updated_at": "2021-12-30T11:20:40+00:00",
        "number": "http://bqbl.it/5e4da7a6-5654-4185-a70b-641776dde3d8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c7be8ed28c81286a73eecf1aa8dcf124/barcode/image/5e4da7a6-5654-4185-a70b-641776dde3d8/1964315e-4495-4986-a01d-566fca01ba9b.svg",
        "owner_id": "55675062-4691-4832-812c-8ef9cbf6a45c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/55675062-4691-4832-812c-8ef9cbf6a45c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd3a1069b-1029-41b4-b4ad-43a63bb7d9ca&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d3a1069b-1029-41b4-b4ad-43a63bb7d9ca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-30T11:20:41+00:00",
        "updated_at": "2021-12-30T11:20:41+00:00",
        "number": "http://bqbl.it/d3a1069b-1029-41b4-b4ad-43a63bb7d9ca",
        "barcode_type": "qr_code",
        "image_url": "/uploads/00f90a2b723245ec351da9fa03830ff0/barcode/image/d3a1069b-1029-41b4-b4ad-43a63bb7d9ca/eeaca9a5-5d62-440d-a007-406cf65f4628.svg",
        "owner_id": "c253d9c0-cdec-4ed3-b480-108c4364911a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c253d9c0-cdec-4ed3-b480-108c4364911a"
          },
          "data": {
            "type": "customers",
            "id": "c253d9c0-cdec-4ed3-b480-108c4364911a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c253d9c0-cdec-4ed3-b480-108c4364911a",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-30T11:20:41+00:00",
        "updated_at": "2021-12-30T11:20:41+00:00",
        "number": 1,
        "name": "Schaden-Reichel",
        "email": "schaden_reichel@dubuque.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=c253d9c0-cdec-4ed3-b480-108c4364911a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c253d9c0-cdec-4ed3-b480-108c4364911a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c253d9c0-cdec-4ed3-b480-108c4364911a&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd3a1069b-1029-41b4-b4ad-43a63bb7d9ca&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd3a1069b-1029-41b4-b4ad-43a63bb7d9ca&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd3a1069b-1029-41b4-b4ad-43a63bb7d9ca&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-30T11:20:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/17468ee2-f08d-4a87-93de-4d270ddd08bb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "17468ee2-f08d-4a87-93de-4d270ddd08bb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-30T11:20:41+00:00",
      "updated_at": "2021-12-30T11:20:41+00:00",
      "number": "http://bqbl.it/17468ee2-f08d-4a87-93de-4d270ddd08bb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d600f0bf33557c7eff6afc9d1bcb6f03/barcode/image/17468ee2-f08d-4a87-93de-4d270ddd08bb/c3a0111b-57ca-4229-ba1d-432751a0d3eb.svg",
      "owner_id": "3a7cbfa7-337b-457e-b0a4-3a83b0ca3465",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3a7cbfa7-337b-457e-b0a4-3a83b0ca3465"
        },
        "data": {
          "type": "customers",
          "id": "3a7cbfa7-337b-457e-b0a4-3a83b0ca3465"
        }
      }
    }
  },
  "included": [
    {
      "id": "3a7cbfa7-337b-457e-b0a4-3a83b0ca3465",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-30T11:20:41+00:00",
        "updated_at": "2021-12-30T11:20:41+00:00",
        "number": 1,
        "name": "Ankunding Group",
        "email": "group_ankunding@borer-fay.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=3a7cbfa7-337b-457e-b0a4-3a83b0ca3465&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3a7cbfa7-337b-457e-b0a4-3a83b0ca3465&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3a7cbfa7-337b-457e-b0a4-3a83b0ca3465&filter[owner_type]=customers"
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
          "owner_id": "9e000bbf-b68d-4a9f-9888-592b8895b80b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a4e711a4-58cd-43dc-9fec-80813308a35b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-30T11:20:42+00:00",
      "updated_at": "2021-12-30T11:20:42+00:00",
      "number": "http://bqbl.it/a4e711a4-58cd-43dc-9fec-80813308a35b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/38cf0c589bcadcad1cf47de9e5e83efb/barcode/image/a4e711a4-58cd-43dc-9fec-80813308a35b/ee517f39-a2a2-4972-9c58-1a36628736a8.svg",
      "owner_id": "9e000bbf-b68d-4a9f-9888-592b8895b80b",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=9e000bbf-b68d-4a9f-9888-592b8895b80b&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=9e000bbf-b68d-4a9f-9888-592b8895b80b&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=9e000bbf-b68d-4a9f-9888-592b8895b80b&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e65473c5-771c-48ae-8667-16ed07e2a6c3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e65473c5-771c-48ae-8667-16ed07e2a6c3",
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
    "id": "e65473c5-771c-48ae-8667-16ed07e2a6c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-30T11:20:43+00:00",
      "updated_at": "2021-12-30T11:20:43+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6459a5d00274911aa58bbeeb80ee79ae/barcode/image/e65473c5-771c-48ae-8667-16ed07e2a6c3/6eb85a24-1ac2-4bcc-ad42-f98628421aaa.svg",
      "owner_id": "6e445d4f-c7f7-4857-b51e-0f786b8c4996",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/45e4c962-855d-4378-bc8d-9d5d79704b0c' \
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