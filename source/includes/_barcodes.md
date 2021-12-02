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
      "id": "f18d93da-1440-4f48-9263-fdcfc2435bc9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T23:48:29+00:00",
        "updated_at": "2021-12-02T23:48:29+00:00",
        "number": "http://bqbl.it/f18d93da-1440-4f48-9263-fdcfc2435bc9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dee55c97b7663f58652920b153a6b7e1/barcode/image/f18d93da-1440-4f48-9263-fdcfc2435bc9/5fbb05b5-f5fe-435a-8aab-1727e3f5e178.svg",
        "owner_id": "b29cf426-b9bc-44f5-ac1e-c6e7e8511872",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b29cf426-b9bc-44f5-ac1e-c6e7e8511872"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F69f53b81-4b9b-4cf9-87e9-33c35e185fe0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "69f53b81-4b9b-4cf9-87e9-33c35e185fe0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T23:48:29+00:00",
        "updated_at": "2021-12-02T23:48:29+00:00",
        "number": "http://bqbl.it/69f53b81-4b9b-4cf9-87e9-33c35e185fe0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/72a8ba56d2bc7b68e7a97f22356c0d3e/barcode/image/69f53b81-4b9b-4cf9-87e9-33c35e185fe0/4524e29a-4c77-4d62-92ad-c268e93a0374.svg",
        "owner_id": "c6c60911-e9e3-4f87-828b-df077ed450a3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c6c60911-e9e3-4f87-828b-df077ed450a3"
          },
          "data": {
            "type": "customers",
            "id": "c6c60911-e9e3-4f87-828b-df077ed450a3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c6c60911-e9e3-4f87-828b-df077ed450a3",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T23:48:29+00:00",
        "updated_at": "2021-12-02T23:48:29+00:00",
        "number": 1,
        "name": "Dicki Inc",
        "email": "dicki.inc@walsh.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=c6c60911-e9e3-4f87-828b-df077ed450a3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c6c60911-e9e3-4f87-828b-df077ed450a3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c6c60911-e9e3-4f87-828b-df077ed450a3&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F69f53b81-4b9b-4cf9-87e9-33c35e185fe0&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F69f53b81-4b9b-4cf9-87e9-33c35e185fe0&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F69f53b81-4b9b-4cf9-87e9-33c35e185fe0&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T23:48:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b6a1ef74-1ccb-4793-9c5e-c7f6a66cd34c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b6a1ef74-1ccb-4793-9c5e-c7f6a66cd34c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T23:48:30+00:00",
      "updated_at": "2021-12-02T23:48:30+00:00",
      "number": "http://bqbl.it/b6a1ef74-1ccb-4793-9c5e-c7f6a66cd34c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/61484e1d5c2ae46ace68a36bd7fba053/barcode/image/b6a1ef74-1ccb-4793-9c5e-c7f6a66cd34c/ed29199f-fe63-40e4-b9c4-5b496c061a05.svg",
      "owner_id": "064f95b3-f9af-43f9-b057-a255533df8c0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/064f95b3-f9af-43f9-b057-a255533df8c0"
        },
        "data": {
          "type": "customers",
          "id": "064f95b3-f9af-43f9-b057-a255533df8c0"
        }
      }
    }
  },
  "included": [
    {
      "id": "064f95b3-f9af-43f9-b057-a255533df8c0",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T23:48:30+00:00",
        "updated_at": "2021-12-02T23:48:30+00:00",
        "number": 1,
        "name": "Carroll, Jast and Kautzer",
        "email": "carroll.kautzer.jast.and@ruecker-rodriguez.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=064f95b3-f9af-43f9-b057-a255533df8c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=064f95b3-f9af-43f9-b057-a255533df8c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=064f95b3-f9af-43f9-b057-a255533df8c0&filter[owner_type]=customers"
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
          "owner_id": "4a32bf14-65eb-4b8b-8770-f5ba387a4162",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bfea7bb9-3299-4efb-a89e-1ccb000f2306",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T23:48:30+00:00",
      "updated_at": "2021-12-02T23:48:30+00:00",
      "number": "http://bqbl.it/bfea7bb9-3299-4efb-a89e-1ccb000f2306",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4a78086857ada240a26e5541fda8eb37/barcode/image/bfea7bb9-3299-4efb-a89e-1ccb000f2306/4c56c6c5-b2d1-4324-9387-667a607bd86e.svg",
      "owner_id": "4a32bf14-65eb-4b8b-8770-f5ba387a4162",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=4a32bf14-65eb-4b8b-8770-f5ba387a4162&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=4a32bf14-65eb-4b8b-8770-f5ba387a4162&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=4a32bf14-65eb-4b8b-8770-f5ba387a4162&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c94928e2-4916-4ac8-a9f7-7f4f9dc84ab9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c94928e2-4916-4ac8-a9f7-7f4f9dc84ab9",
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
    "id": "c94928e2-4916-4ac8-a9f7-7f4f9dc84ab9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T23:48:31+00:00",
      "updated_at": "2021-12-02T23:48:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fe1a8b61a24873073731bd3e6eb400b0/barcode/image/c94928e2-4916-4ac8-a9f7-7f4f9dc84ab9/cd847f8a-442a-48f6-a4a6-2a6b634fe601.svg",
      "owner_id": "83b16627-928d-4e68-90fc-00636d6a9304",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c3423273-e4d6-47d6-a73e-c9a48a633525' \
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