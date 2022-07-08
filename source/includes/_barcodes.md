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
      "id": "dd14b2dd-df46-41f6-9952-d0aafde4cef2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T11:43:39+00:00",
        "updated_at": "2022-07-08T11:43:39+00:00",
        "number": "http://bqbl.it/dd14b2dd-df46-41f6-9952-d0aafde4cef2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/10d5f894b1208861cd757448e92872b9/barcode/image/dd14b2dd-df46-41f6-9952-d0aafde4cef2/d62e6094-e405-4076-a93a-92c49cd49603.svg",
        "owner_id": "0543a733-96fd-434c-a1e4-bf007440de4f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0543a733-96fd-434c-a1e4-bf007440de4f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Faa00ef1f-f834-481c-b74a-06b1523d0cdf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "aa00ef1f-f834-481c-b74a-06b1523d0cdf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T11:43:39+00:00",
        "updated_at": "2022-07-08T11:43:39+00:00",
        "number": "http://bqbl.it/aa00ef1f-f834-481c-b74a-06b1523d0cdf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/899a7f35bfbcc15aa96a21057afa2c84/barcode/image/aa00ef1f-f834-481c-b74a-06b1523d0cdf/958d65fc-40dc-4b7c-bde2-9eb5c9b8db4f.svg",
        "owner_id": "bbb93ca0-9e87-4dc2-be1a-4fb394557b8b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bbb93ca0-9e87-4dc2-be1a-4fb394557b8b"
          },
          "data": {
            "type": "customers",
            "id": "bbb93ca0-9e87-4dc2-be1a-4fb394557b8b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bbb93ca0-9e87-4dc2-be1a-4fb394557b8b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T11:43:39+00:00",
        "updated_at": "2022-07-08T11:43:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hackett-Kuphal",
        "email": "hackett.kuphal@corkery.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=bbb93ca0-9e87-4dc2-be1a-4fb394557b8b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bbb93ca0-9e87-4dc2-be1a-4fb394557b8b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bbb93ca0-9e87-4dc2-be1a-4fb394557b8b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTBkNDczZWItMTJiZi00YTJiLWEwYjQtYWM5OWEyNWE5M2Fi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e0d473eb-12bf-4a2b-a0b4-ac99a25a93ab",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T11:43:40+00:00",
        "updated_at": "2022-07-08T11:43:40+00:00",
        "number": "http://bqbl.it/e0d473eb-12bf-4a2b-a0b4-ac99a25a93ab",
        "barcode_type": "qr_code",
        "image_url": "/uploads/47eec6fcc9e7e83fb73cabefa67fbf0e/barcode/image/e0d473eb-12bf-4a2b-a0b4-ac99a25a93ab/b869e66f-1f90-4232-ac97-8ee4e3944a4f.svg",
        "owner_id": "71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3"
          },
          "data": {
            "type": "customers",
            "id": "71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T11:43:40+00:00",
        "updated_at": "2022-07-08T11:43:40+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Dietrich Inc",
        "email": "dietrich_inc@rolfson.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=71cf1f8d-56ae-4cd0-b70d-5083d8a43ad3&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T11:43:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f43183d1-676a-4088-88c0-1587f0f3368e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f43183d1-676a-4088-88c0-1587f0f3368e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T11:43:40+00:00",
      "updated_at": "2022-07-08T11:43:40+00:00",
      "number": "http://bqbl.it/f43183d1-676a-4088-88c0-1587f0f3368e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6ccb3df5ed690838fa47f88c97f30bc8/barcode/image/f43183d1-676a-4088-88c0-1587f0f3368e/c58fa8df-e637-4dd3-8f2e-ef873385c2bc.svg",
      "owner_id": "aa2a230a-c9ed-4f13-938a-ee688628825d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/aa2a230a-c9ed-4f13-938a-ee688628825d"
        },
        "data": {
          "type": "customers",
          "id": "aa2a230a-c9ed-4f13-938a-ee688628825d"
        }
      }
    }
  },
  "included": [
    {
      "id": "aa2a230a-c9ed-4f13-938a-ee688628825d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T11:43:40+00:00",
        "updated_at": "2022-07-08T11:43:40+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Gleichner-Weber",
        "email": "weber_gleichner@leannon.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=aa2a230a-c9ed-4f13-938a-ee688628825d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aa2a230a-c9ed-4f13-938a-ee688628825d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aa2a230a-c9ed-4f13-938a-ee688628825d&filter[owner_type]=customers"
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
          "owner_id": "2a89ade1-bc74-4fae-8c81-3938b3938ae7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7f8e7b33-58ba-400b-9aa4-4bb751f0921e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T11:43:41+00:00",
      "updated_at": "2022-07-08T11:43:41+00:00",
      "number": "http://bqbl.it/7f8e7b33-58ba-400b-9aa4-4bb751f0921e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/effca8917bf434375eab0b8001058c31/barcode/image/7f8e7b33-58ba-400b-9aa4-4bb751f0921e/e1a3f6d0-8b0e-4941-9836-68bbe7edaa1c.svg",
      "owner_id": "2a89ade1-bc74-4fae-8c81-3938b3938ae7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b43eed1e-233f-4702-82df-26d20f5f6f90' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b43eed1e-233f-4702-82df-26d20f5f6f90",
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
    "id": "b43eed1e-233f-4702-82df-26d20f5f6f90",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T11:43:41+00:00",
      "updated_at": "2022-07-08T11:43:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d3a084d9e727dd5453af21cdf8052352/barcode/image/b43eed1e-233f-4702-82df-26d20f5f6f90/1703b855-8687-4ac4-8891-737611fd66a8.svg",
      "owner_id": "d30ee53b-0940-4308-a89e-ef7fe147d019",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3a35578c-6de3-4d88-a349-b708abd3c0d9' \
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