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
      "id": "a68be99c-166c-4e31-b244-499febf8df8d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-12T10:12:33+00:00",
        "updated_at": "2022-01-12T10:12:33+00:00",
        "number": "http://bqbl.it/a68be99c-166c-4e31-b244-499febf8df8d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e60782e889aae773f4a963dda84181dc/barcode/image/a68be99c-166c-4e31-b244-499febf8df8d/43232f01-182d-45d8-95c2-e1fe23d79950.svg",
        "owner_id": "fbe46af3-78c9-4554-ac61-392a774aba66",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fbe46af3-78c9-4554-ac61-392a774aba66"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ad6ade2-15af-46d6-b2dd-5e34a17ee172&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8ad6ade2-15af-46d6-b2dd-5e34a17ee172",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-12T10:12:34+00:00",
        "updated_at": "2022-01-12T10:12:34+00:00",
        "number": "http://bqbl.it/8ad6ade2-15af-46d6-b2dd-5e34a17ee172",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6bce16e554dc3a25d101c3e8cb7776c4/barcode/image/8ad6ade2-15af-46d6-b2dd-5e34a17ee172/5400dc0e-6fc7-4067-a75c-f5df5d5d2684.svg",
        "owner_id": "23d96deb-10d3-4416-83df-8ad2862bed14",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/23d96deb-10d3-4416-83df-8ad2862bed14"
          },
          "data": {
            "type": "customers",
            "id": "23d96deb-10d3-4416-83df-8ad2862bed14"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "23d96deb-10d3-4416-83df-8ad2862bed14",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:12:34+00:00",
        "updated_at": "2022-01-12T10:12:34+00:00",
        "number": 1,
        "name": "Heller-Welch",
        "email": "heller.welch@toy.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=23d96deb-10d3-4416-83df-8ad2862bed14&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=23d96deb-10d3-4416-83df-8ad2862bed14&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=23d96deb-10d3-4416-83df-8ad2862bed14&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ad6ade2-15af-46d6-b2dd-5e34a17ee172&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ad6ade2-15af-46d6-b2dd-5e34a17ee172&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ad6ade2-15af-46d6-b2dd-5e34a17ee172&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T10:12:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/23008135-ba56-4019-a930-978c3cecce66?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "23008135-ba56-4019-a930-978c3cecce66",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T10:12:34+00:00",
      "updated_at": "2022-01-12T10:12:34+00:00",
      "number": "http://bqbl.it/23008135-ba56-4019-a930-978c3cecce66",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7786045d26f8be4b2c10249268e79b18/barcode/image/23008135-ba56-4019-a930-978c3cecce66/cc70187c-3d98-473b-91a8-dec041b195b4.svg",
      "owner_id": "22dd97ec-32cf-41ab-b76e-39e9b2f504f6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/22dd97ec-32cf-41ab-b76e-39e9b2f504f6"
        },
        "data": {
          "type": "customers",
          "id": "22dd97ec-32cf-41ab-b76e-39e9b2f504f6"
        }
      }
    }
  },
  "included": [
    {
      "id": "22dd97ec-32cf-41ab-b76e-39e9b2f504f6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:12:34+00:00",
        "updated_at": "2022-01-12T10:12:34+00:00",
        "number": 1,
        "name": "Schuster Inc",
        "email": "schuster.inc@zieme-kertzmann.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=22dd97ec-32cf-41ab-b76e-39e9b2f504f6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=22dd97ec-32cf-41ab-b76e-39e9b2f504f6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=22dd97ec-32cf-41ab-b76e-39e9b2f504f6&filter[owner_type]=customers"
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
          "owner_id": "ee8b6fe9-d26a-4214-9999-7f0b5a210db2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5b67632d-336c-480d-9b38-266bd7563ce3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T10:12:35+00:00",
      "updated_at": "2022-01-12T10:12:35+00:00",
      "number": "http://bqbl.it/5b67632d-336c-480d-9b38-266bd7563ce3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/516f0ae9680490bff67b8a254f2d6753/barcode/image/5b67632d-336c-480d-9b38-266bd7563ce3/a6742814-3d36-4c2b-adba-b5080370e1b1.svg",
      "owner_id": "ee8b6fe9-d26a-4214-9999-7f0b5a210db2",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ee8b6fe9-d26a-4214-9999-7f0b5a210db2&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ee8b6fe9-d26a-4214-9999-7f0b5a210db2&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ee8b6fe9-d26a-4214-9999-7f0b5a210db2&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6b04e4ce-7fbd-4855-bb1a-17dbebf864b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6b04e4ce-7fbd-4855-bb1a-17dbebf864b1",
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
    "id": "6b04e4ce-7fbd-4855-bb1a-17dbebf864b1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T10:12:35+00:00",
      "updated_at": "2022-01-12T10:12:36+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7934ba573ec3985fb27521c0fdb18b3c/barcode/image/6b04e4ce-7fbd-4855-bb1a-17dbebf864b1/4e95a541-90d8-469b-a151-e2aa64f0168a.svg",
      "owner_id": "24e1fec9-d2bf-412c-8fbc-55827fbeca9e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3eae2bb0-4bb0-4c9f-87a8-c85da51b24fc' \
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