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
      "id": "f3c75882-6167-4dfa-b7ed-304160ad8091",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-18T15:14:16+00:00",
        "updated_at": "2021-11-18T15:14:16+00:00",
        "number": "http://bqbl.it/f3c75882-6167-4dfa-b7ed-304160ad8091",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e5c35b0da520857602ca4e80001fce08/barcode/image/f3c75882-6167-4dfa-b7ed-304160ad8091/5b5ec177-e43e-4797-857e-a4b5a286d11a.svg",
        "owner_id": "73425244-c43a-4468-851e-68dc89cbdf41",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/73425244-c43a-4468-851e-68dc89cbdf41"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe1cc4112-55aa-40c5-b562-b98651d2548a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e1cc4112-55aa-40c5-b562-b98651d2548a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-18T15:14:16+00:00",
        "updated_at": "2021-11-18T15:14:16+00:00",
        "number": "http://bqbl.it/e1cc4112-55aa-40c5-b562-b98651d2548a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a54df8022891d116da2585de3dc0a787/barcode/image/e1cc4112-55aa-40c5-b562-b98651d2548a/8e356df8-41da-4556-9e50-5314079a902c.svg",
        "owner_id": "52654018-7b9c-440b-b5b5-86ba8dded1fc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/52654018-7b9c-440b-b5b5-86ba8dded1fc"
          },
          "data": {
            "type": "customers",
            "id": "52654018-7b9c-440b-b5b5-86ba8dded1fc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "52654018-7b9c-440b-b5b5-86ba8dded1fc",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-18T15:14:16+00:00",
        "updated_at": "2021-11-18T15:14:16+00:00",
        "number": 1,
        "name": "Kris-Kassulke",
        "email": "kris.kassulke@gerhold-stokes.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=52654018-7b9c-440b-b5b5-86ba8dded1fc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=52654018-7b9c-440b-b5b5-86ba8dded1fc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=52654018-7b9c-440b-b5b5-86ba8dded1fc&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe1cc4112-55aa-40c5-b562-b98651d2548a&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe1cc4112-55aa-40c5-b562-b98651d2548a&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe1cc4112-55aa-40c5-b562-b98651d2548a&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-18T15:14:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9d3d2b53-6b30-43d3-85b6-fe53b9303e46?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9d3d2b53-6b30-43d3-85b6-fe53b9303e46",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T15:14:17+00:00",
      "updated_at": "2021-11-18T15:14:17+00:00",
      "number": "http://bqbl.it/9d3d2b53-6b30-43d3-85b6-fe53b9303e46",
      "barcode_type": "qr_code",
      "image_url": "/uploads/38f3b122f9774469bc367a19565d8c5c/barcode/image/9d3d2b53-6b30-43d3-85b6-fe53b9303e46/0bcdb3c3-8586-444e-b16c-31121b0fb41f.svg",
      "owner_id": "cb75c47a-380e-46aa-8a0f-61de25183287",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/cb75c47a-380e-46aa-8a0f-61de25183287"
        },
        "data": {
          "type": "customers",
          "id": "cb75c47a-380e-46aa-8a0f-61de25183287"
        }
      }
    }
  },
  "included": [
    {
      "id": "cb75c47a-380e-46aa-8a0f-61de25183287",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-18T15:14:17+00:00",
        "updated_at": "2021-11-18T15:14:17+00:00",
        "number": 1,
        "name": "McClure-Stanton",
        "email": "stanton_mcclure@kling.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=cb75c47a-380e-46aa-8a0f-61de25183287&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cb75c47a-380e-46aa-8a0f-61de25183287&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cb75c47a-380e-46aa-8a0f-61de25183287&filter[owner_type]=customers"
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
          "owner_id": "39e05d94-32a5-4cc0-8d12-8bba28d04caf",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cad31911-c51e-4947-b769-84d43abedc04",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T15:14:17+00:00",
      "updated_at": "2021-11-18T15:14:17+00:00",
      "number": "http://bqbl.it/cad31911-c51e-4947-b769-84d43abedc04",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7bffde29989be771431394de01f7a99d/barcode/image/cad31911-c51e-4947-b769-84d43abedc04/c30dc645-e063-49bd-9cf5-2e7a6b26701d.svg",
      "owner_id": "39e05d94-32a5-4cc0-8d12-8bba28d04caf",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=39e05d94-32a5-4cc0-8d12-8bba28d04caf&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=39e05d94-32a5-4cc0-8d12-8bba28d04caf&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=39e05d94-32a5-4cc0-8d12-8bba28d04caf&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bc1ceacd-b3ab-4f87-b021-be732fcd97cd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bc1ceacd-b3ab-4f87-b021-be732fcd97cd",
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
    "id": "bc1ceacd-b3ab-4f87-b021-be732fcd97cd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T15:14:18+00:00",
      "updated_at": "2021-11-18T15:14:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7d55a41d9b4dc9abf1b2b5bf65b9b8d4/barcode/image/bc1ceacd-b3ab-4f87-b021-be732fcd97cd/7eae527d-a582-40af-8bbf-a2cf12439ebc.svg",
      "owner_id": "d77dffd9-0466-446b-a0a4-7aa5ca6ef41e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/da89ffc9-d569-440d-9a66-737581c3ea9f' \
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