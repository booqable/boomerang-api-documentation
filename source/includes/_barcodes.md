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
      "id": "c6a155c0-078b-4584-9fff-a77139607507",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-05T12:39:01+00:00",
        "updated_at": "2022-01-05T12:39:01+00:00",
        "number": "http://bqbl.it/c6a155c0-078b-4584-9fff-a77139607507",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a182e4e1c7bfc4f3e5ab03e85eb6a963/barcode/image/c6a155c0-078b-4584-9fff-a77139607507/954d55e4-183a-49cb-b936-2f972840a339.svg",
        "owner_id": "1ed8506e-2c25-4bac-a0e6-8cfa580315d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1ed8506e-2c25-4bac-a0e6-8cfa580315d7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F491a6530-df55-4ff6-913e-0329fcf9c548&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "491a6530-df55-4ff6-913e-0329fcf9c548",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-05T12:39:02+00:00",
        "updated_at": "2022-01-05T12:39:02+00:00",
        "number": "http://bqbl.it/491a6530-df55-4ff6-913e-0329fcf9c548",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3ec224b3623ccb26e6f1e80ade83db00/barcode/image/491a6530-df55-4ff6-913e-0329fcf9c548/b670ffc9-c6b8-4169-a7fa-b7344f3d85b0.svg",
        "owner_id": "ff640a41-0594-465d-97c0-90c3120f68a8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ff640a41-0594-465d-97c0-90c3120f68a8"
          },
          "data": {
            "type": "customers",
            "id": "ff640a41-0594-465d-97c0-90c3120f68a8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ff640a41-0594-465d-97c0-90c3120f68a8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-05T12:39:02+00:00",
        "updated_at": "2022-01-05T12:39:02+00:00",
        "number": 1,
        "name": "Rice and Sons",
        "email": "sons_rice_and@greenfelder.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=ff640a41-0594-465d-97c0-90c3120f68a8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ff640a41-0594-465d-97c0-90c3120f68a8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ff640a41-0594-465d-97c0-90c3120f68a8&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F491a6530-df55-4ff6-913e-0329fcf9c548&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F491a6530-df55-4ff6-913e-0329fcf9c548&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F491a6530-df55-4ff6-913e-0329fcf9c548&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-05T12:38:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4d7c57f6-0d84-49e2-8367-212a187cb73c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4d7c57f6-0d84-49e2-8367-212a187cb73c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-05T12:39:03+00:00",
      "updated_at": "2022-01-05T12:39:03+00:00",
      "number": "http://bqbl.it/4d7c57f6-0d84-49e2-8367-212a187cb73c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8fc4fa9902c79a87c37af2b2f15f6208/barcode/image/4d7c57f6-0d84-49e2-8367-212a187cb73c/af3b340d-acc4-40ee-b891-515166b82975.svg",
      "owner_id": "ed39b639-8331-4e7e-abf1-9305e143fc26",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ed39b639-8331-4e7e-abf1-9305e143fc26"
        },
        "data": {
          "type": "customers",
          "id": "ed39b639-8331-4e7e-abf1-9305e143fc26"
        }
      }
    }
  },
  "included": [
    {
      "id": "ed39b639-8331-4e7e-abf1-9305e143fc26",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-05T12:39:02+00:00",
        "updated_at": "2022-01-05T12:39:03+00:00",
        "number": 1,
        "name": "Powlowski-Cole",
        "email": "cole_powlowski@volkman.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=ed39b639-8331-4e7e-abf1-9305e143fc26&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ed39b639-8331-4e7e-abf1-9305e143fc26&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ed39b639-8331-4e7e-abf1-9305e143fc26&filter[owner_type]=customers"
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
          "owner_id": "3be61501-8cfc-4f1f-a3f1-1a175b41bbdd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "86651db5-abbc-4408-aafc-101865520789",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-05T12:39:03+00:00",
      "updated_at": "2022-01-05T12:39:03+00:00",
      "number": "http://bqbl.it/86651db5-abbc-4408-aafc-101865520789",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bd3f01fcab6234c89933c3cb4d9578b9/barcode/image/86651db5-abbc-4408-aafc-101865520789/dd36b7d6-7a90-467b-9964-0a83140d664b.svg",
      "owner_id": "3be61501-8cfc-4f1f-a3f1-1a175b41bbdd",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3be61501-8cfc-4f1f-a3f1-1a175b41bbdd&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3be61501-8cfc-4f1f-a3f1-1a175b41bbdd&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=3be61501-8cfc-4f1f-a3f1-1a175b41bbdd&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1130b072-9d89-4f2e-aec3-2a08263e547c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1130b072-9d89-4f2e-aec3-2a08263e547c",
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
    "id": "1130b072-9d89-4f2e-aec3-2a08263e547c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-05T12:39:04+00:00",
      "updated_at": "2022-01-05T12:39:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c457d6db72b2ccb53c3bfac06de2eb95/barcode/image/1130b072-9d89-4f2e-aec3-2a08263e547c/aa4e7ffb-a716-4511-951e-7ab11741085b.svg",
      "owner_id": "ba568dc8-c29e-479f-acc0-e75afff3f758",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6d2cb425-1ff3-4692-a480-36b6fdfb8c71' \
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