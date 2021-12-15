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
      "id": "e09a3175-691c-48e3-9f23-d34539d816da",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-15T11:43:27+00:00",
        "updated_at": "2021-12-15T11:43:27+00:00",
        "number": "http://bqbl.it/e09a3175-691c-48e3-9f23-d34539d816da",
        "barcode_type": "qr_code",
        "image_url": "/uploads/45bd3b6d53a070ff80edc8da3fec6f19/barcode/image/e09a3175-691c-48e3-9f23-d34539d816da/f6dcccea-b257-4880-aa5d-f7f138f69a8e.svg",
        "owner_id": "bf2138d0-e5db-4403-b612-a761587d6c4d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bf2138d0-e5db-4403-b612-a761587d6c4d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9269c7f-79a0-486a-a43b-fbcc84a79e0d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b9269c7f-79a0-486a-a43b-fbcc84a79e0d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-15T11:43:28+00:00",
        "updated_at": "2021-12-15T11:43:28+00:00",
        "number": "http://bqbl.it/b9269c7f-79a0-486a-a43b-fbcc84a79e0d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7c665b14957d0dc374fcdafe50ae16f4/barcode/image/b9269c7f-79a0-486a-a43b-fbcc84a79e0d/0e5de4e7-ed73-42a6-a12b-786c28461632.svg",
        "owner_id": "419d82b1-3f36-4f6d-bf7b-54e364dda57e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/419d82b1-3f36-4f6d-bf7b-54e364dda57e"
          },
          "data": {
            "type": "customers",
            "id": "419d82b1-3f36-4f6d-bf7b-54e364dda57e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "419d82b1-3f36-4f6d-bf7b-54e364dda57e",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-15T11:43:28+00:00",
        "updated_at": "2021-12-15T11:43:28+00:00",
        "number": 1,
        "name": "Mayer, Greenholt and Waelchi",
        "email": "greenholt.and.waelchi.mayer@hilpert-parker.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=419d82b1-3f36-4f6d-bf7b-54e364dda57e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=419d82b1-3f36-4f6d-bf7b-54e364dda57e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=419d82b1-3f36-4f6d-bf7b-54e364dda57e&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9269c7f-79a0-486a-a43b-fbcc84a79e0d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9269c7f-79a0-486a-a43b-fbcc84a79e0d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9269c7f-79a0-486a-a43b-fbcc84a79e0d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-15T11:43:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0a1fcb21-6d75-42ab-8175-54443c1dc509?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0a1fcb21-6d75-42ab-8175-54443c1dc509",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-15T11:43:29+00:00",
      "updated_at": "2021-12-15T11:43:29+00:00",
      "number": "http://bqbl.it/0a1fcb21-6d75-42ab-8175-54443c1dc509",
      "barcode_type": "qr_code",
      "image_url": "/uploads/02501c1e36260b02be75bb7b65493ec8/barcode/image/0a1fcb21-6d75-42ab-8175-54443c1dc509/56150c48-ce8a-4daf-9986-6b79dc9e78d9.svg",
      "owner_id": "b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8"
        },
        "data": {
          "type": "customers",
          "id": "b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8"
        }
      }
    }
  },
  "included": [
    {
      "id": "b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-15T11:43:29+00:00",
        "updated_at": "2021-12-15T11:43:29+00:00",
        "number": 1,
        "name": "Kautzer-Cruickshank",
        "email": "cruickshank.kautzer@quitzon.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b0e2a6fe-fccc-4dfd-a9f9-bfc6480477a8&filter[owner_type]=customers"
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
          "owner_id": "35bdaaed-89ef-4332-9416-c2bff51e18e6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "62199d5c-7e3a-47ca-90be-d72f9a3ced90",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-15T11:43:29+00:00",
      "updated_at": "2021-12-15T11:43:29+00:00",
      "number": "http://bqbl.it/62199d5c-7e3a-47ca-90be-d72f9a3ced90",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f97a13005a94323f42b4010d2f51e73d/barcode/image/62199d5c-7e3a-47ca-90be-d72f9a3ced90/d72d4772-d0d8-4bb3-add6-8dcdae0f3958.svg",
      "owner_id": "35bdaaed-89ef-4332-9416-c2bff51e18e6",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=35bdaaed-89ef-4332-9416-c2bff51e18e6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=35bdaaed-89ef-4332-9416-c2bff51e18e6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=35bdaaed-89ef-4332-9416-c2bff51e18e6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/06bd4dee-6877-46cd-a6fd-cce1488ee4a1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "06bd4dee-6877-46cd-a6fd-cce1488ee4a1",
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
    "id": "06bd4dee-6877-46cd-a6fd-cce1488ee4a1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-15T11:43:30+00:00",
      "updated_at": "2021-12-15T11:43:30+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eeb935338b2a878bff8565a1702b8a21/barcode/image/06bd4dee-6877-46cd-a6fd-cce1488ee4a1/4b2e798c-4705-4953-9443-2e0ab383cdc0.svg",
      "owner_id": "a585d392-e9fc-4aa3-9e4e-97af280292f7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5b1fafa4-0a49-47c6-a52c-e87be63f5bba' \
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