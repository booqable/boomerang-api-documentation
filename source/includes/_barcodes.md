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
      "id": "dea17594-f3d9-4474-8e8d-df4477df461a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-08T11:24:29+00:00",
        "updated_at": "2021-12-08T11:24:29+00:00",
        "number": "http://bqbl.it/dea17594-f3d9-4474-8e8d-df4477df461a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cd53bf4f279ec215047bc5189ca44981/barcode/image/dea17594-f3d9-4474-8e8d-df4477df461a/c41d8b01-76a5-4de0-bb22-1b2ee5bdbcee.svg",
        "owner_id": "6282485e-0459-4179-be00-b8d2e838d2a1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6282485e-0459-4179-be00-b8d2e838d2a1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1bf2f3d4-e3a0-4d91-afc4-95be45e68c78&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1bf2f3d4-e3a0-4d91-afc4-95be45e68c78",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-08T11:24:30+00:00",
        "updated_at": "2021-12-08T11:24:30+00:00",
        "number": "http://bqbl.it/1bf2f3d4-e3a0-4d91-afc4-95be45e68c78",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c2eb5daa963032b564954456d0e35522/barcode/image/1bf2f3d4-e3a0-4d91-afc4-95be45e68c78/9dad82bf-be12-48ab-bf8c-b01ce26f771f.svg",
        "owner_id": "72c31574-34fb-4d27-b3e2-bcae7c4d0551",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/72c31574-34fb-4d27-b3e2-bcae7c4d0551"
          },
          "data": {
            "type": "customers",
            "id": "72c31574-34fb-4d27-b3e2-bcae7c4d0551"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "72c31574-34fb-4d27-b3e2-bcae7c4d0551",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-08T11:24:30+00:00",
        "updated_at": "2021-12-08T11:24:30+00:00",
        "number": 1,
        "name": "Boyer Inc",
        "email": "inc.boyer@lockman.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=72c31574-34fb-4d27-b3e2-bcae7c4d0551&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=72c31574-34fb-4d27-b3e2-bcae7c4d0551&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=72c31574-34fb-4d27-b3e2-bcae7c4d0551&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1bf2f3d4-e3a0-4d91-afc4-95be45e68c78&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1bf2f3d4-e3a0-4d91-afc4-95be45e68c78&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1bf2f3d4-e3a0-4d91-afc4-95be45e68c78&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T11:24:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9f866a1-a9e1-43fc-ab98-7e42575e4bf8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a9f866a1-a9e1-43fc-ab98-7e42575e4bf8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-08T11:24:30+00:00",
      "updated_at": "2021-12-08T11:24:30+00:00",
      "number": "http://bqbl.it/a9f866a1-a9e1-43fc-ab98-7e42575e4bf8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c6ba1fdf05757c605ed29d1cc6ef1700/barcode/image/a9f866a1-a9e1-43fc-ab98-7e42575e4bf8/53fdde0a-d4d3-421c-905f-515239bd2da7.svg",
      "owner_id": "23ea5700-e53b-4590-a91e-9710dbda3dc7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/23ea5700-e53b-4590-a91e-9710dbda3dc7"
        },
        "data": {
          "type": "customers",
          "id": "23ea5700-e53b-4590-a91e-9710dbda3dc7"
        }
      }
    }
  },
  "included": [
    {
      "id": "23ea5700-e53b-4590-a91e-9710dbda3dc7",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-08T11:24:30+00:00",
        "updated_at": "2021-12-08T11:24:30+00:00",
        "number": 1,
        "name": "Baumbach, Waelchi and Cronin",
        "email": "and_baumbach_cronin_waelchi@tromp.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=23ea5700-e53b-4590-a91e-9710dbda3dc7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=23ea5700-e53b-4590-a91e-9710dbda3dc7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=23ea5700-e53b-4590-a91e-9710dbda3dc7&filter[owner_type]=customers"
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
          "owner_id": "93bd0795-f52f-4f46-9545-e3f3597e6acf",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2f775fad-0529-4939-8490-e2f661cfb7dd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-08T11:24:31+00:00",
      "updated_at": "2021-12-08T11:24:31+00:00",
      "number": "http://bqbl.it/2f775fad-0529-4939-8490-e2f661cfb7dd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8dedf7f5f769da37e0a73f55282d7d2b/barcode/image/2f775fad-0529-4939-8490-e2f661cfb7dd/e71d62c8-d5db-4cd7-9e76-1df111af4286.svg",
      "owner_id": "93bd0795-f52f-4f46-9545-e3f3597e6acf",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=93bd0795-f52f-4f46-9545-e3f3597e6acf&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=93bd0795-f52f-4f46-9545-e3f3597e6acf&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=93bd0795-f52f-4f46-9545-e3f3597e6acf&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d4611b0d-8c62-433c-9153-fe3d2126bc5f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d4611b0d-8c62-433c-9153-fe3d2126bc5f",
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
    "id": "d4611b0d-8c62-433c-9153-fe3d2126bc5f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-08T11:24:31+00:00",
      "updated_at": "2021-12-08T11:24:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fb6ed35df2ef6fc0a15b112e19b926be/barcode/image/d4611b0d-8c62-433c-9153-fe3d2126bc5f/8dda3c59-9b2b-4525-833e-11ab6918cfb4.svg",
      "owner_id": "48eb7510-074e-4523-97dd-0085f4f2762c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd389bac-f360-4af8-b2e7-57eaae1bc618' \
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