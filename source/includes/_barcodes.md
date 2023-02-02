# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

Note that when using URLs as numbers, it's advised to base64 encode the number before filtering.

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
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "a8620aec-9520-417c-bf86-1a541d44e68f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T08:00:53+00:00",
        "updated_at": "2023-02-02T08:00:53+00:00",
        "number": "http://bqbl.it/a8620aec-9520-417c-bf86-1a541d44e68f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c32cd73f5cb842153c22f55d9689caf5/barcode/image/a8620aec-9520-417c-bf86-1a541d44e68f/2470dec3-b5f9-4f73-9ab7-dd223cfe76d1.svg",
        "owner_id": "cd17250d-1687-4ce4-9718-6403771358f1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cd17250d-1687-4ce4-9718-6403771358f1"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F10db262c-3c46-4d9d-8a0e-cc2cecfcc4a2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "10db262c-3c46-4d9d-8a0e-cc2cecfcc4a2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T08:00:53+00:00",
        "updated_at": "2023-02-02T08:00:53+00:00",
        "number": "http://bqbl.it/10db262c-3c46-4d9d-8a0e-cc2cecfcc4a2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1acaa7e4f823b32708a9f3b76409ea40/barcode/image/10db262c-3c46-4d9d-8a0e-cc2cecfcc4a2/1065fce7-76c2-4d29-9333-9198f34b4228.svg",
        "owner_id": "9de1b485-14f1-4353-8ef2-2658cc34ccf1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9de1b485-14f1-4353-8ef2-2658cc34ccf1"
          },
          "data": {
            "type": "customers",
            "id": "9de1b485-14f1-4353-8ef2-2658cc34ccf1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9de1b485-14f1-4353-8ef2-2658cc34ccf1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T08:00:53+00:00",
        "updated_at": "2023-02-02T08:00:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=9de1b485-14f1-4353-8ef2-2658cc34ccf1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9de1b485-14f1-4353-8ef2-2658cc34ccf1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9de1b485-14f1-4353-8ef2-2658cc34ccf1&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjU1NDBlYzQtNTM2Mi00MjQyLTg3NmEtYTk2NmY0OGE0YTgx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f5540ec4-5362-4242-876a-a966f48a4a81",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T08:00:54+00:00",
        "updated_at": "2023-02-02T08:00:54+00:00",
        "number": "http://bqbl.it/f5540ec4-5362-4242-876a-a966f48a4a81",
        "barcode_type": "qr_code",
        "image_url": "/uploads/064c49c145d5d2574030e665a07fe4c4/barcode/image/f5540ec4-5362-4242-876a-a966f48a4a81/6e77fe6b-6dee-44ff-b0e9-df8f03324c18.svg",
        "owner_id": "41cfdaaa-73f5-4a69-8b7a-0bb8bec24712",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/41cfdaaa-73f5-4a69-8b7a-0bb8bec24712"
          },
          "data": {
            "type": "customers",
            "id": "41cfdaaa-73f5-4a69-8b7a-0bb8bec24712"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "41cfdaaa-73f5-4a69-8b7a-0bb8bec24712",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T08:00:54+00:00",
        "updated_at": "2023-02-02T08:00:54+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=41cfdaaa-73f5-4a69-8b7a-0bb8bec24712&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=41cfdaaa-73f5-4a69-8b7a-0bb8bec24712&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=41cfdaaa-73f5-4a69-8b7a-0bb8bec24712&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T08:00:35Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/84c6f2e3-545c-4b4d-acb5-f45deb89de81?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "84c6f2e3-545c-4b4d-acb5-f45deb89de81",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T08:00:54+00:00",
      "updated_at": "2023-02-02T08:00:54+00:00",
      "number": "http://bqbl.it/84c6f2e3-545c-4b4d-acb5-f45deb89de81",
      "barcode_type": "qr_code",
      "image_url": "/uploads/49ad79df4b2a6642a2d0dcd6aa615821/barcode/image/84c6f2e3-545c-4b4d-acb5-f45deb89de81/bf7f8657-9009-4c3b-a629-cc7177052cce.svg",
      "owner_id": "19a3e757-b92c-400a-8ac9-c464a7ae6cc7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/19a3e757-b92c-400a-8ac9-c464a7ae6cc7"
        },
        "data": {
          "type": "customers",
          "id": "19a3e757-b92c-400a-8ac9-c464a7ae6cc7"
        }
      }
    }
  },
  "included": [
    {
      "id": "19a3e757-b92c-400a-8ac9-c464a7ae6cc7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T08:00:54+00:00",
        "updated_at": "2023-02-02T08:00:54+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-5@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=19a3e757-b92c-400a-8ac9-c464a7ae6cc7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=19a3e757-b92c-400a-8ac9-c464a7ae6cc7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=19a3e757-b92c-400a-8ac9-c464a7ae6cc7&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "e297a174-ff36-4177-af9c-263cee13dd71",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "aa6b9c4b-a531-41a6-aa9c-2bfb819e60a4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T08:00:55+00:00",
      "updated_at": "2023-02-02T08:00:55+00:00",
      "number": "http://bqbl.it/aa6b9c4b-a531-41a6-aa9c-2bfb819e60a4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ec7d60ef406ffb423fdd92f077408c45/barcode/image/aa6b9c4b-a531-41a6-aa9c-2bfb819e60a4/2a81b946-e47e-49f7-a28a-5e076ec8a504.svg",
      "owner_id": "e297a174-ff36-4177-af9c-263cee13dd71",
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

`POST /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/aa0ecb6f-2bf8-4a9d-a23a-3a0e937cc6d8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aa0ecb6f-2bf8-4a9d-a23a-3a0e937cc6d8",
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
    "id": "aa0ecb6f-2bf8-4a9d-a23a-3a0e937cc6d8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T08:00:55+00:00",
      "updated_at": "2023-02-02T08:00:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1f61a262de1cde89d5de589ce536f3f6/barcode/image/aa0ecb6f-2bf8-4a9d-a23a-3a0e937cc6d8/9da79d60-b7ba-42ee-b3b1-d23edbd31fdc.svg",
      "owner_id": "64dec51d-73f3-4a36-bd1b-187a918ad6e2",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/ff8eafb7-407a-4905-8a95-3d208ec3753c' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes