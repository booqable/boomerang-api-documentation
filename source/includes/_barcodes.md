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
      "id": "a4410805-763a-4230-aa47-6edbb88a1c55",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-10T13:50:05+00:00",
        "updated_at": "2022-01-10T13:50:05+00:00",
        "number": "http://bqbl.it/a4410805-763a-4230-aa47-6edbb88a1c55",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ecf327449dee41ab75a65b49d594531b/barcode/image/a4410805-763a-4230-aa47-6edbb88a1c55/e92ef1e7-83ec-401b-8f75-5fe0c11817f1.svg",
        "owner_id": "d0b4abb9-e481-4dcc-94cc-bec19ea7ec6f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d0b4abb9-e481-4dcc-94cc-bec19ea7ec6f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa258f324-e210-455d-a8b8-59070a4a6825&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a258f324-e210-455d-a8b8-59070a4a6825",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-10T13:50:06+00:00",
        "updated_at": "2022-01-10T13:50:06+00:00",
        "number": "http://bqbl.it/a258f324-e210-455d-a8b8-59070a4a6825",
        "barcode_type": "qr_code",
        "image_url": "/uploads/43257f9c7361c0571d88ab95d81b35f5/barcode/image/a258f324-e210-455d-a8b8-59070a4a6825/90486155-9888-4f76-b4cf-b980851f609c.svg",
        "owner_id": "906bbde2-7476-490b-b4b1-9690d81255f5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/906bbde2-7476-490b-b4b1-9690d81255f5"
          },
          "data": {
            "type": "customers",
            "id": "906bbde2-7476-490b-b4b1-9690d81255f5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "906bbde2-7476-490b-b4b1-9690d81255f5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-10T13:50:06+00:00",
        "updated_at": "2022-01-10T13:50:06+00:00",
        "number": 1,
        "name": "Quitzon, Gusikowski and Auer",
        "email": "and.gusikowski.auer.quitzon@rippin.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=906bbde2-7476-490b-b4b1-9690d81255f5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=906bbde2-7476-490b-b4b1-9690d81255f5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=906bbde2-7476-490b-b4b1-9690d81255f5&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa258f324-e210-455d-a8b8-59070a4a6825&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa258f324-e210-455d-a8b8-59070a4a6825&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa258f324-e210-455d-a8b8-59070a4a6825&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-10T13:49:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/37a36a80-06ac-4e56-b45c-44ebbabc996a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "37a36a80-06ac-4e56-b45c-44ebbabc996a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-10T13:50:07+00:00",
      "updated_at": "2022-01-10T13:50:07+00:00",
      "number": "http://bqbl.it/37a36a80-06ac-4e56-b45c-44ebbabc996a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e53280d0d9cd078b658744ac3f7ec3be/barcode/image/37a36a80-06ac-4e56-b45c-44ebbabc996a/73138aa6-31fc-4350-8a8f-65403e338650.svg",
      "owner_id": "6df2005e-6f81-4883-a0a1-7b8a38301fa9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6df2005e-6f81-4883-a0a1-7b8a38301fa9"
        },
        "data": {
          "type": "customers",
          "id": "6df2005e-6f81-4883-a0a1-7b8a38301fa9"
        }
      }
    }
  },
  "included": [
    {
      "id": "6df2005e-6f81-4883-a0a1-7b8a38301fa9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-10T13:50:07+00:00",
        "updated_at": "2022-01-10T13:50:07+00:00",
        "number": 1,
        "name": "Gibson, Conroy and Emard",
        "email": "and.emard.gibson.conroy@mclaughlin.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=6df2005e-6f81-4883-a0a1-7b8a38301fa9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6df2005e-6f81-4883-a0a1-7b8a38301fa9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6df2005e-6f81-4883-a0a1-7b8a38301fa9&filter[owner_type]=customers"
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
          "owner_id": "1a058d6a-908b-47ea-b353-937bba20d9ef",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d683cbea-a878-4797-8172-4d588395b9d3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-10T13:50:08+00:00",
      "updated_at": "2022-01-10T13:50:08+00:00",
      "number": "http://bqbl.it/d683cbea-a878-4797-8172-4d588395b9d3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/38ecc5a37d411a217a8a9fff445d0ec0/barcode/image/d683cbea-a878-4797-8172-4d588395b9d3/19048c23-39ce-4cdb-a868-da0cba853e57.svg",
      "owner_id": "1a058d6a-908b-47ea-b353-937bba20d9ef",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=1a058d6a-908b-47ea-b353-937bba20d9ef&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=1a058d6a-908b-47ea-b353-937bba20d9ef&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=1a058d6a-908b-47ea-b353-937bba20d9ef&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/82fac7cf-131b-452c-9063-e12970cf9663' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "82fac7cf-131b-452c-9063-e12970cf9663",
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
    "id": "82fac7cf-131b-452c-9063-e12970cf9663",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-10T13:50:08+00:00",
      "updated_at": "2022-01-10T13:50:09+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6c5250c65551d53265fac8bfdd51bd76/barcode/image/82fac7cf-131b-452c-9063-e12970cf9663/0b5ce2b9-24a6-4be8-9b3a-2b44cca0d353.svg",
      "owner_id": "db90b7fa-7868-4e0d-81cb-0efa46c47daa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/33b8da65-7eb9-445f-9dc2-c91fab9022ad' \
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