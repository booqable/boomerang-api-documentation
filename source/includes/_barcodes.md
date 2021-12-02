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
      "id": "b482af23-604d-4082-84d7-e8c7de273ac6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T15:11:07+00:00",
        "updated_at": "2021-12-02T15:11:07+00:00",
        "number": "http://bqbl.it/b482af23-604d-4082-84d7-e8c7de273ac6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dbd3239907294e29e680f71e0c071f4f/barcode/image/b482af23-604d-4082-84d7-e8c7de273ac6/e5a71ed7-55a4-4f92-9479-feabceeba004.svg",
        "owner_id": "a60839a9-51e3-4a80-aa9b-3ca613518ff7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a60839a9-51e3-4a80-aa9b-3ca613518ff7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7e095c61-7be5-4fd2-8788-6f89a4f83a41&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7e095c61-7be5-4fd2-8788-6f89a4f83a41",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T15:11:07+00:00",
        "updated_at": "2021-12-02T15:11:07+00:00",
        "number": "http://bqbl.it/7e095c61-7be5-4fd2-8788-6f89a4f83a41",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a715c68bb0716557c977b2ff69f9b092/barcode/image/7e095c61-7be5-4fd2-8788-6f89a4f83a41/0475a633-269a-4c7b-aa2f-dbe5c2f24759.svg",
        "owner_id": "3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f"
          },
          "data": {
            "type": "customers",
            "id": "3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T15:11:07+00:00",
        "updated_at": "2021-12-02T15:11:07+00:00",
        "number": 1,
        "name": "Schroeder LLC",
        "email": "schroeder.llc@block.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3a5e7251-b4fb-42c4-806b-fd0f6c82cc9f&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7e095c61-7be5-4fd2-8788-6f89a4f83a41&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7e095c61-7be5-4fd2-8788-6f89a4f83a41&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7e095c61-7be5-4fd2-8788-6f89a4f83a41&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T15:10:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3fd083c7-e722-4af5-9681-1fa4ae4c72f7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3fd083c7-e722-4af5-9681-1fa4ae4c72f7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T15:11:08+00:00",
      "updated_at": "2021-12-02T15:11:08+00:00",
      "number": "http://bqbl.it/3fd083c7-e722-4af5-9681-1fa4ae4c72f7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d6eaf97bf6b0ac11e6aa3c09bf2e31b7/barcode/image/3fd083c7-e722-4af5-9681-1fa4ae4c72f7/aad51639-c54a-4517-8dc8-b37dbbe53072.svg",
      "owner_id": "9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f"
        },
        "data": {
          "type": "customers",
          "id": "9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f"
        }
      }
    }
  },
  "included": [
    {
      "id": "9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T15:11:08+00:00",
        "updated_at": "2021-12-02T15:11:08+00:00",
        "number": 1,
        "name": "West-Huel",
        "email": "huel_west@gerhold.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9a7bcf3b-437c-4e81-b6d1-bc5c76d8142f&filter[owner_type]=customers"
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
          "owner_id": "b585837a-892b-4e95-9f31-7bfcadf89edd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4c6b4552-e376-4df4-b6bc-67f1b0d5efc5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T15:11:08+00:00",
      "updated_at": "2021-12-02T15:11:08+00:00",
      "number": "http://bqbl.it/4c6b4552-e376-4df4-b6bc-67f1b0d5efc5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4c9453dc753e9dbc339f49b4036390c3/barcode/image/4c6b4552-e376-4df4-b6bc-67f1b0d5efc5/a53a7d71-8fca-4a46-b8c0-caff1d9640bd.svg",
      "owner_id": "b585837a-892b-4e95-9f31-7bfcadf89edd",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=b585837a-892b-4e95-9f31-7bfcadf89edd&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=b585837a-892b-4e95-9f31-7bfcadf89edd&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=b585837a-892b-4e95-9f31-7bfcadf89edd&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a3f2ed71-8ca5-4c6b-b15c-b1e12778275f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3f2ed71-8ca5-4c6b-b15c-b1e12778275f",
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
    "id": "a3f2ed71-8ca5-4c6b-b15c-b1e12778275f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T15:11:09+00:00",
      "updated_at": "2021-12-02T15:11:09+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b32d0c6cac1fee7674c2bc95ac730706/barcode/image/a3f2ed71-8ca5-4c6b-b15c-b1e12778275f/b85b0b86-db70-47b0-9dd5-81a9eb75913d.svg",
      "owner_id": "8ab8a4c8-ee36-4c65-a33d-731e7d92b097",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/04164314-1155-45eb-9e73-72b4bb7d25cf' \
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