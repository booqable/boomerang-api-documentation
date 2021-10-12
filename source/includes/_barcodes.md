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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


## Relationships
A barcodes has the following relationships:

Name | Description
- | -
`owner` | **Customer**<br>Associated Owner


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
      "id": "83bc324f-3ba0-4703-a6cd-104f577e7c37",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-12T14:54:08+00:00",
        "updated_at": "2021-10-12T14:54:08+00:00",
        "number": "http://bqbl.it/83bc324f-3ba0-4703-a6cd-104f577e7c37",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9a15eea2cff25f4a68773969c28fed3c/barcode/image/83bc324f-3ba0-4703-a6cd-104f577e7c37/a483e75c-c8db-4f1c-9424-2b0054e304f9.svg",
        "owner_id": "1ecf9f82-9448-4215-b218-58d830c43d82",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1ecf9f82-9448-4215-b218-58d830c43d82"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd37d3664-5d91-4bc8-8e4b-c32db4e7b0a3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d37d3664-5d91-4bc8-8e4b-c32db4e7b0a3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-12T14:54:09+00:00",
        "updated_at": "2021-10-12T14:54:09+00:00",
        "number": "http://bqbl.it/d37d3664-5d91-4bc8-8e4b-c32db4e7b0a3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b059d2249263178e6d95692d469e9bc/barcode/image/d37d3664-5d91-4bc8-8e4b-c32db4e7b0a3/6db75e19-c71e-450b-be8a-61c8efb63726.svg",
        "owner_id": "f711001a-d8e4-4e43-808b-dd985d71745b",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f711001a-d8e4-4e43-808b-dd985d71745b"
          },
          "data": {
            "type": "customers",
            "id": "f711001a-d8e4-4e43-808b-dd985d71745b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f711001a-d8e4-4e43-808b-dd985d71745b",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-12T14:54:09+00:00",
        "updated_at": "2021-10-12T14:54:09+00:00",
        "number": 1,
        "name": "Harber-Paucek",
        "email": "harber_paucek@dickens-flatley.com",
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f711001a-d8e4-4e43-808b-dd985d71745b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-12T14:54:04Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


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
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode

> How to fetch a barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d699402-08dc-433a-af1f-49c33b8ce688?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1d699402-08dc-433a-af1f-49c33b8ce688",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-12T14:54:09+00:00",
      "updated_at": "2021-10-12T14:54:09+00:00",
      "number": "http://bqbl.it/1d699402-08dc-433a-af1f-49c33b8ce688",
      "barcode_type": "qr_code",
      "image_url": "/uploads/115da891db4858feafb85f620edc12ed/barcode/image/1d699402-08dc-433a-af1f-49c33b8ce688/e923627c-51c2-409f-9659-2dd5401dfa57.svg",
      "owner_id": "a89593c6-6f7a-403a-addd-e6756b3485f2",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a89593c6-6f7a-403a-addd-e6756b3485f2"
        },
        "data": {
          "type": "customers",
          "id": "a89593c6-6f7a-403a-addd-e6756b3485f2"
        }
      }
    }
  },
  "included": [
    {
      "id": "a89593c6-6f7a-403a-addd-e6756b3485f2",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-12T14:54:09+00:00",
        "updated_at": "2021-10-12T14:54:09+00:00",
        "number": 1,
        "name": "Bayer-Reinger",
        "email": "bayer_reinger@leannon.io",
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a89593c6-6f7a-403a-addd-e6756b3485f2"
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
          "owner_id": "c1c15e26-fdfb-454c-a78b-ebbbbfdeb385",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1d0a8a0b-8b22-464f-a261-bcb795898678",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-12T14:54:10+00:00",
      "updated_at": "2021-10-12T14:54:10+00:00",
      "number": "http://bqbl.it/1d0a8a0b-8b22-464f-a261-bcb795898678",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8616c0f27aed3f878b3872a20dad4b4f/barcode/image/1d0a8a0b-8b22-464f-a261-bcb795898678/6516641f-2602-428f-b4f6-9400ae767837.svg",
      "owner_id": "c1c15e26-fdfb-454c-a78b-ebbbbfdeb385",
      "owner_type": "Customer"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode

> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/4b3dc53f-b55e-41f3-ae29-cf95e62f0a5b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4b3dc53f-b55e-41f3-ae29-cf95e62f0a5b",
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
    "id": "4b3dc53f-b55e-41f3-ae29-cf95e62f0a5b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-12T14:54:10+00:00",
      "updated_at": "2021-10-12T14:54:11+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f738750065f7a8f14195072041a6e652/barcode/image/4b3dc53f-b55e-41f3-ae29-cf95e62f0a5b/6aef1352-1273-47b3-83d1-4cfa6d999f5e.svg",
      "owner_id": "f7ab6fda-1e3e-41d1-b2d4-507e7799e135",
      "owner_type": "Customer"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode

> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/efdf2ede-c5e4-44f2-8e0f-94e77c98406d' \
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