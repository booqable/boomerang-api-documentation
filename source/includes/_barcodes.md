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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
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
      "id": "e089d0d3-05fa-44f8-a608-dfde443cefe8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-08-19T07:55:26+00:00",
        "updated_at": "2022-08-19T07:55:26+00:00",
        "number": "http://bqbl.it/e089d0d3-05fa-44f8-a608-dfde443cefe8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4f1280c434d237a388cc502be48a647d/barcode/image/e089d0d3-05fa-44f8-a608-dfde443cefe8/23d22719-65b0-40aa-8429-ba80f5cf32fd.svg",
        "owner_id": "d56fdc46-eb5a-4816-ab7e-0747c5b1a044",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d56fdc46-eb5a-4816-ab7e-0747c5b1a044"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F063f19f9-1971-4a0b-9a76-7526a4a1ae61&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "063f19f9-1971-4a0b-9a76-7526a4a1ae61",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-08-19T07:55:26+00:00",
        "updated_at": "2022-08-19T07:55:26+00:00",
        "number": "http://bqbl.it/063f19f9-1971-4a0b-9a76-7526a4a1ae61",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3b6ac350ec17e0544e38485b7ade00b2/barcode/image/063f19f9-1971-4a0b-9a76-7526a4a1ae61/334874d7-a8a0-4b6c-9d07-bab0d53aa12d.svg",
        "owner_id": "b3d379e1-3214-44d7-b3ec-917aae0e4ec0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b3d379e1-3214-44d7-b3ec-917aae0e4ec0"
          },
          "data": {
            "type": "customers",
            "id": "b3d379e1-3214-44d7-b3ec-917aae0e4ec0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b3d379e1-3214-44d7-b3ec-917aae0e4ec0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-08-19T07:55:26+00:00",
        "updated_at": "2022-08-19T07:55:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b3d379e1-3214-44d7-b3ec-917aae0e4ec0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b3d379e1-3214-44d7-b3ec-917aae0e4ec0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b3d379e1-3214-44d7-b3ec-917aae0e4ec0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjBkMzNhMGItYWVmNi00YTBiLWIxNTUtMjY0NWIzOTU0ZWUy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "60d33a0b-aef6-4a0b-b155-2645b3954ee2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-08-19T07:55:27+00:00",
        "updated_at": "2022-08-19T07:55:27+00:00",
        "number": "http://bqbl.it/60d33a0b-aef6-4a0b-b155-2645b3954ee2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a3adc65d475a44f1241c5d24d748bb0c/barcode/image/60d33a0b-aef6-4a0b-b155-2645b3954ee2/21283a20-a025-4695-b973-7c16856034be.svg",
        "owner_id": "753bd173-1be9-413d-bf24-8f12b91ab98a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/753bd173-1be9-413d-bf24-8f12b91ab98a"
          },
          "data": {
            "type": "customers",
            "id": "753bd173-1be9-413d-bf24-8f12b91ab98a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "753bd173-1be9-413d-bf24-8f12b91ab98a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-08-19T07:55:27+00:00",
        "updated_at": "2022-08-19T07:55:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=753bd173-1be9-413d-bf24-8f12b91ab98a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=753bd173-1be9-413d-bf24-8f12b91ab98a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=753bd173-1be9-413d-bf24-8f12b91ab98a&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-19T07:55:05Z`
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
`number` | **String**<br>`eq`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dfe60bf1-12c6-42ca-8167-6a6ba5e007e3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dfe60bf1-12c6-42ca-8167-6a6ba5e007e3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-08-19T07:55:28+00:00",
      "updated_at": "2022-08-19T07:55:28+00:00",
      "number": "http://bqbl.it/dfe60bf1-12c6-42ca-8167-6a6ba5e007e3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e8e1d7001382eaaaeec56a29eae8cf99/barcode/image/dfe60bf1-12c6-42ca-8167-6a6ba5e007e3/89569640-c1a3-49f4-b78a-1c6724d0508b.svg",
      "owner_id": "fda0e7e4-2a7e-4657-a053-45952799628e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fda0e7e4-2a7e-4657-a053-45952799628e"
        },
        "data": {
          "type": "customers",
          "id": "fda0e7e4-2a7e-4657-a053-45952799628e"
        }
      }
    }
  },
  "included": [
    {
      "id": "fda0e7e4-2a7e-4657-a053-45952799628e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-08-19T07:55:28+00:00",
        "updated_at": "2022-08-19T07:55:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fda0e7e4-2a7e-4657-a053-45952799628e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fda0e7e4-2a7e-4657-a053-45952799628e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fda0e7e4-2a7e-4657-a053-45952799628e&filter[owner_type]=customers"
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
          "owner_id": "640336cb-966e-4db7-8bb2-4bd0589a89de",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8685c915-043f-448a-a328-d7df0ac8086f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-08-19T07:55:29+00:00",
      "updated_at": "2022-08-19T07:55:29+00:00",
      "number": "http://bqbl.it/8685c915-043f-448a-a328-d7df0ac8086f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a3f0d6191c2f4a7edfc9644f8c2a83b2/barcode/image/8685c915-043f-448a-a328-d7df0ac8086f/51ed704d-7d33-43e8-9bcd-f8697a0a93e7.svg",
      "owner_id": "640336cb-966e-4db7-8bb2-4bd0589a89de",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5a9c97a8-9a82-47e6-9374-0f43ecd2171f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5a9c97a8-9a82-47e6-9374-0f43ecd2171f",
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
    "id": "5a9c97a8-9a82-47e6-9374-0f43ecd2171f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-08-19T07:55:29+00:00",
      "updated_at": "2022-08-19T07:55:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/368602ba1ff48944e559c2ff41dc4853/barcode/image/5a9c97a8-9a82-47e6-9374-0f43ecd2171f/d4f781af-76be-457c-8d26-5f881f2204c4.svg",
      "owner_id": "a01fa764-607e-4073-b673-f8a6bb2071a9",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a5fe53d3-8b7a-48e8-afe8-8a101fdc3c15' \
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