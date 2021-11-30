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
      "id": "7bbeabc7-74ba-4085-90ce-0669d0a07b9a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-30T12:55:08+00:00",
        "updated_at": "2021-11-30T12:55:08+00:00",
        "number": "http://bqbl.it/7bbeabc7-74ba-4085-90ce-0669d0a07b9a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6a402a39bbfd1d0f0249877e06882765/barcode/image/7bbeabc7-74ba-4085-90ce-0669d0a07b9a/5e78987a-7305-4f16-9678-d84bacdf22c2.svg",
        "owner_id": "4c607d0b-129a-4873-b1f4-e8aa83bc0531",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4c607d0b-129a-4873-b1f4-e8aa83bc0531"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F84467dd0-91ea-4231-9cfb-f61c838dae17&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "84467dd0-91ea-4231-9cfb-f61c838dae17",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-30T12:55:08+00:00",
        "updated_at": "2021-11-30T12:55:08+00:00",
        "number": "http://bqbl.it/84467dd0-91ea-4231-9cfb-f61c838dae17",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c28e0df6005aebc4b5478d8919ce6ffe/barcode/image/84467dd0-91ea-4231-9cfb-f61c838dae17/d86f3107-27c1-454e-b649-cd8e0cf26af4.svg",
        "owner_id": "bc19b40e-a4c5-4f8d-83b5-0172b44b770f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bc19b40e-a4c5-4f8d-83b5-0172b44b770f"
          },
          "data": {
            "type": "customers",
            "id": "bc19b40e-a4c5-4f8d-83b5-0172b44b770f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bc19b40e-a4c5-4f8d-83b5-0172b44b770f",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-30T12:55:08+00:00",
        "updated_at": "2021-11-30T12:55:08+00:00",
        "number": 1,
        "name": "Ruecker, Halvorson and Toy",
        "email": "and.halvorson.toy.ruecker@welch.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=bc19b40e-a4c5-4f8d-83b5-0172b44b770f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bc19b40e-a4c5-4f8d-83b5-0172b44b770f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bc19b40e-a4c5-4f8d-83b5-0172b44b770f&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F84467dd0-91ea-4231-9cfb-f61c838dae17&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F84467dd0-91ea-4231-9cfb-f61c838dae17&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F84467dd0-91ea-4231-9cfb-f61c838dae17&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-30T12:54:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bbdc5b77-b085-421a-9f72-6857038a4682?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bbdc5b77-b085-421a-9f72-6857038a4682",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-30T12:55:09+00:00",
      "updated_at": "2021-11-30T12:55:09+00:00",
      "number": "http://bqbl.it/bbdc5b77-b085-421a-9f72-6857038a4682",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e296818c8b57b26dde2a300babeb7e18/barcode/image/bbdc5b77-b085-421a-9f72-6857038a4682/fbdf7a6e-7fde-4b05-8842-c915b514c149.svg",
      "owner_id": "e1c5f77c-86c5-4f21-8879-6d300108da6a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e1c5f77c-86c5-4f21-8879-6d300108da6a"
        },
        "data": {
          "type": "customers",
          "id": "e1c5f77c-86c5-4f21-8879-6d300108da6a"
        }
      }
    }
  },
  "included": [
    {
      "id": "e1c5f77c-86c5-4f21-8879-6d300108da6a",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-30T12:55:08+00:00",
        "updated_at": "2021-11-30T12:55:09+00:00",
        "number": 1,
        "name": "Cole and Sons",
        "email": "sons_cole_and@legros.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=e1c5f77c-86c5-4f21-8879-6d300108da6a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e1c5f77c-86c5-4f21-8879-6d300108da6a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e1c5f77c-86c5-4f21-8879-6d300108da6a&filter[owner_type]=customers"
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
          "owner_id": "234da8fe-e388-4c33-8c0f-bfe7547bd493",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dbd99314-1fa3-4b42-83e4-503a8289d35b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-30T12:55:09+00:00",
      "updated_at": "2021-11-30T12:55:09+00:00",
      "number": "http://bqbl.it/dbd99314-1fa3-4b42-83e4-503a8289d35b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c508a969210d3d12e1fcd9f2d68ba927/barcode/image/dbd99314-1fa3-4b42-83e4-503a8289d35b/efe48435-08c9-479e-94aa-638656c62bc4.svg",
      "owner_id": "234da8fe-e388-4c33-8c0f-bfe7547bd493",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=234da8fe-e388-4c33-8c0f-bfe7547bd493&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=234da8fe-e388-4c33-8c0f-bfe7547bd493&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=234da8fe-e388-4c33-8c0f-bfe7547bd493&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ad576145-5dfa-4af2-870c-c5bc37a3165e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ad576145-5dfa-4af2-870c-c5bc37a3165e",
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
    "id": "ad576145-5dfa-4af2-870c-c5bc37a3165e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-30T12:55:09+00:00",
      "updated_at": "2021-11-30T12:55:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2ed150cd233319c4f84eb285539f96e3/barcode/image/ad576145-5dfa-4af2-870c-c5bc37a3165e/dd44392f-8049-436a-9b7d-9a5d914c23c9.svg",
      "owner_id": "10875001-6d20-47d0-9eb0-4f00d3507ce4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/09c8ad73-39d9-496c-b6d6-fbc370ab3310' \
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