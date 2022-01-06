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
      "id": "3d8d1162-3aaa-4cfb-8ba7-c9544734b8d1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-06T14:32:01+00:00",
        "updated_at": "2022-01-06T14:32:01+00:00",
        "number": "http://bqbl.it/3d8d1162-3aaa-4cfb-8ba7-c9544734b8d1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ac6fb12af335f60a26748b7591b490ac/barcode/image/3d8d1162-3aaa-4cfb-8ba7-c9544734b8d1/36893db2-3718-49fe-8d49-b45272a76fb9.svg",
        "owner_id": "2c6a6586-8b37-4ddb-af09-11b050e15b44",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2c6a6586-8b37-4ddb-af09-11b050e15b44"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5377c962-e34d-44dc-bf3d-110a49898ac6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5377c962-e34d-44dc-bf3d-110a49898ac6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-06T14:32:02+00:00",
        "updated_at": "2022-01-06T14:32:02+00:00",
        "number": "http://bqbl.it/5377c962-e34d-44dc-bf3d-110a49898ac6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e859a894240de62d08d55d9c3ac3ba1e/barcode/image/5377c962-e34d-44dc-bf3d-110a49898ac6/4ce82660-16fc-4d14-853e-634289c062e2.svg",
        "owner_id": "96621c36-df78-41b6-a281-d1c7fc0c6e8f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96621c36-df78-41b6-a281-d1c7fc0c6e8f"
          },
          "data": {
            "type": "customers",
            "id": "96621c36-df78-41b6-a281-d1c7fc0c6e8f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "96621c36-df78-41b6-a281-d1c7fc0c6e8f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-06T14:32:02+00:00",
        "updated_at": "2022-01-06T14:32:02+00:00",
        "number": 1,
        "name": "Hilll, Herzog and Cole",
        "email": "herzog.cole.hilll.and@harris-kreiger.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=96621c36-df78-41b6-a281-d1c7fc0c6e8f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=96621c36-df78-41b6-a281-d1c7fc0c6e8f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=96621c36-df78-41b6-a281-d1c7fc0c6e8f&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5377c962-e34d-44dc-bf3d-110a49898ac6&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5377c962-e34d-44dc-bf3d-110a49898ac6&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5377c962-e34d-44dc-bf3d-110a49898ac6&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-06T14:31:48Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/238aca4f-5671-45e3-933a-9d067e692ee8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "238aca4f-5671-45e3-933a-9d067e692ee8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-06T14:32:03+00:00",
      "updated_at": "2022-01-06T14:32:03+00:00",
      "number": "http://bqbl.it/238aca4f-5671-45e3-933a-9d067e692ee8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/14ae0ea6fc0f9068077c823376f56ee4/barcode/image/238aca4f-5671-45e3-933a-9d067e692ee8/369c3116-bab6-4c14-bfe7-4e8e04368a46.svg",
      "owner_id": "e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f"
        },
        "data": {
          "type": "customers",
          "id": "e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f"
        }
      }
    }
  },
  "included": [
    {
      "id": "e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-06T14:32:03+00:00",
        "updated_at": "2022-01-06T14:32:03+00:00",
        "number": 1,
        "name": "West-Rippin",
        "email": "west_rippin@weimann.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e3b4e8e5-1e0e-4361-a11a-a8eaff312c6f&filter[owner_type]=customers"
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
          "owner_id": "f96e7708-a91c-4a72-ba79-aa09eab8a008",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "24d1d574-3994-4f84-9bac-40206a35c883",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-06T14:32:04+00:00",
      "updated_at": "2022-01-06T14:32:04+00:00",
      "number": "http://bqbl.it/24d1d574-3994-4f84-9bac-40206a35c883",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a6f083e9aed24978b12d66fc52cb6dac/barcode/image/24d1d574-3994-4f84-9bac-40206a35c883/9f78f7a9-124a-4d61-ae6b-f399fbff5984.svg",
      "owner_id": "f96e7708-a91c-4a72-ba79-aa09eab8a008",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=f96e7708-a91c-4a72-ba79-aa09eab8a008&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=f96e7708-a91c-4a72-ba79-aa09eab8a008&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=f96e7708-a91c-4a72-ba79-aa09eab8a008&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d5bddf6-1b0d-476a-94f6-127fb420e906' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1d5bddf6-1b0d-476a-94f6-127fb420e906",
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
    "id": "1d5bddf6-1b0d-476a-94f6-127fb420e906",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-06T14:32:04+00:00",
      "updated_at": "2022-01-06T14:32:05+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7f4864fbc74feb6bc740023c41f8407f/barcode/image/1d5bddf6-1b0d-476a-94f6-127fb420e906/0ba833c1-94ce-4458-978f-59ce9c73e25b.svg",
      "owner_id": "5f7b3834-3800-40d7-8264-96587a32d5bb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/de6f2ca5-b4d1-4162-9ae1-2eec2fca46db' \
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