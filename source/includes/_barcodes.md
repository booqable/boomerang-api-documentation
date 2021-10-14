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
      "id": "1326a0d8-682a-4fb8-9e46-11f55805c1f5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-14T12:06:38+00:00",
        "updated_at": "2021-10-14T12:06:38+00:00",
        "number": "http://bqbl.it/1326a0d8-682a-4fb8-9e46-11f55805c1f5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63f23ad7d2db29b5cae732a8b12df3a0/barcode/image/1326a0d8-682a-4fb8-9e46-11f55805c1f5/79733b13-d3f8-4d01-8a6d-aa0a1be2de4a.svg",
        "owner_id": "c39b2906-f4cc-48ad-bdc0-864bb1662b7e",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c39b2906-f4cc-48ad-bdc0-864bb1662b7e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2fccfa56-cd93-4360-aead-feb273d91e7a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2fccfa56-cd93-4360-aead-feb273d91e7a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-14T12:06:39+00:00",
        "updated_at": "2021-10-14T12:06:39+00:00",
        "number": "http://bqbl.it/2fccfa56-cd93-4360-aead-feb273d91e7a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/daa9d82ded5ee224f59b9922ea82fec6/barcode/image/2fccfa56-cd93-4360-aead-feb273d91e7a/cb5e9ab9-d878-4f26-8a8b-22ae17b6b0e6.svg",
        "owner_id": "81804268-c20e-4d3d-a786-f3d3d20ddca8",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/81804268-c20e-4d3d-a786-f3d3d20ddca8"
          },
          "data": {
            "type": "customers",
            "id": "81804268-c20e-4d3d-a786-f3d3d20ddca8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "81804268-c20e-4d3d-a786-f3d3d20ddca8",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-14T12:06:39+00:00",
        "updated_at": "2021-10-14T12:06:39+00:00",
        "number": 1,
        "name": "Christiansen and Sons",
        "email": "sons.and.christiansen@ohara.biz",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=81804268-c20e-4d3d-a786-f3d3d20ddca8"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-14T12:06:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/78d62ddc-2ebe-4300-8bfb-fbe0923007a8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "78d62ddc-2ebe-4300-8bfb-fbe0923007a8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-14T12:06:40+00:00",
      "updated_at": "2021-10-14T12:06:40+00:00",
      "number": "http://bqbl.it/78d62ddc-2ebe-4300-8bfb-fbe0923007a8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/abd76e102d35a4971ccfcded95e46ad9/barcode/image/78d62ddc-2ebe-4300-8bfb-fbe0923007a8/69678ee1-ecc3-4def-a0b5-49587fe2881c.svg",
      "owner_id": "dec0c0b4-d1d8-4b1e-8fed-c8501c8b715c",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/dec0c0b4-d1d8-4b1e-8fed-c8501c8b715c"
        },
        "data": {
          "type": "customers",
          "id": "dec0c0b4-d1d8-4b1e-8fed-c8501c8b715c"
        }
      }
    }
  },
  "included": [
    {
      "id": "dec0c0b4-d1d8-4b1e-8fed-c8501c8b715c",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-14T12:06:40+00:00",
        "updated_at": "2021-10-14T12:06:40+00:00",
        "number": 1,
        "name": "Ondricka, Daniel and Konopelski",
        "email": "daniel_konopelski_ondricka_and@bechtelar-hirthe.com",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=dec0c0b4-d1d8-4b1e-8fed-c8501c8b715c"
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
          "owner_id": "36bc11c0-d438-4e65-b0ff-0decba695588",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "76721bb5-fe2c-4d0e-8bac-e0346d2af5c2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-14T12:06:40+00:00",
      "updated_at": "2021-10-14T12:06:40+00:00",
      "number": "http://bqbl.it/76721bb5-fe2c-4d0e-8bac-e0346d2af5c2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/933b13f5ed465f2a97e46a97b49f3e28/barcode/image/76721bb5-fe2c-4d0e-8bac-e0346d2af5c2/114b5862-85af-4101-98e3-6f1f6dead949.svg",
      "owner_id": "36bc11c0-d438-4e65-b0ff-0decba695588",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/591a225b-2c96-4fa0-b337-6b2f329fdd54' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "591a225b-2c96-4fa0-b337-6b2f329fdd54",
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
    "id": "591a225b-2c96-4fa0-b337-6b2f329fdd54",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-14T12:06:40+00:00",
      "updated_at": "2021-10-14T12:06:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f1a8c9e4cc1796ee4542e832c5ce3314/barcode/image/591a225b-2c96-4fa0-b337-6b2f329fdd54/f345d5d1-4553-4d21-81c8-7afc8aba74c8.svg",
      "owner_id": "daed3938-bb71-41b6-a297-9acd39d847db",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/12adefec-92eb-465e-ad04-89f117c0ff6d' \
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