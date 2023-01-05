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
      "id": "630faa3a-bb8f-424a-a118-fd4789780afd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:42:26+00:00",
        "updated_at": "2023-01-05T13:42:26+00:00",
        "number": "http://bqbl.it/630faa3a-bb8f-424a-a118-fd4789780afd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3c9f85c1feb5a3b9965b6edde1b36917/barcode/image/630faa3a-bb8f-424a-a118-fd4789780afd/eee75a43-bbd3-428d-9bef-ce37b4f984e3.svg",
        "owner_id": "f2e191e6-21d1-4d7f-a019-2d91377bf6a2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f2e191e6-21d1-4d7f-a019-2d91377bf6a2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc85e490e-5f2c-49e6-800e-5d315a93dc89&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c85e490e-5f2c-49e6-800e-5d315a93dc89",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:42:27+00:00",
        "updated_at": "2023-01-05T13:42:27+00:00",
        "number": "http://bqbl.it/c85e490e-5f2c-49e6-800e-5d315a93dc89",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a17e698d0a746b17eb471d7ee7f85624/barcode/image/c85e490e-5f2c-49e6-800e-5d315a93dc89/2a63ed1c-42a2-46b5-8b16-385ebee0971f.svg",
        "owner_id": "2c7abd7f-fc41-43a3-aad7-b56bb913d6c0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2c7abd7f-fc41-43a3-aad7-b56bb913d6c0"
          },
          "data": {
            "type": "customers",
            "id": "2c7abd7f-fc41-43a3-aad7-b56bb913d6c0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2c7abd7f-fc41-43a3-aad7-b56bb913d6c0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:42:26+00:00",
        "updated_at": "2023-01-05T13:42:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2c7abd7f-fc41-43a3-aad7-b56bb913d6c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2c7abd7f-fc41-43a3-aad7-b56bb913d6c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2c7abd7f-fc41-43a3-aad7-b56bb913d6c0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjM2MjQ1ZWEtODA0OS00NjVkLTg0ZDAtYTEzMjg2NWNiZTM1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "636245ea-8049-465d-84d0-a132865cbe35",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:42:27+00:00",
        "updated_at": "2023-01-05T13:42:27+00:00",
        "number": "http://bqbl.it/636245ea-8049-465d-84d0-a132865cbe35",
        "barcode_type": "qr_code",
        "image_url": "/uploads/161c4e2c75f02f57ddf1778fb13db711/barcode/image/636245ea-8049-465d-84d0-a132865cbe35/f98c0dfa-2be0-4fff-af34-1e330f6918d4.svg",
        "owner_id": "18e700da-4a57-4e8e-ad22-ed26b99372e5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/18e700da-4a57-4e8e-ad22-ed26b99372e5"
          },
          "data": {
            "type": "customers",
            "id": "18e700da-4a57-4e8e-ad22-ed26b99372e5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "18e700da-4a57-4e8e-ad22-ed26b99372e5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:42:27+00:00",
        "updated_at": "2023-01-05T13:42:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=18e700da-4a57-4e8e-ad22-ed26b99372e5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=18e700da-4a57-4e8e-ad22-ed26b99372e5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=18e700da-4a57-4e8e-ad22-ed26b99372e5&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8d649abd-ebc1-461e-a2a3-7bb695c81e19?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8d649abd-ebc1-461e-a2a3-7bb695c81e19",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:42:28+00:00",
      "updated_at": "2023-01-05T13:42:28+00:00",
      "number": "http://bqbl.it/8d649abd-ebc1-461e-a2a3-7bb695c81e19",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8dd50ef55efb24c5080461302cff8178/barcode/image/8d649abd-ebc1-461e-a2a3-7bb695c81e19/ef7719d6-9af2-4552-ae74-f2cba00d4b1a.svg",
      "owner_id": "ff20cd8d-ff64-40e1-943a-228422d89284",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ff20cd8d-ff64-40e1-943a-228422d89284"
        },
        "data": {
          "type": "customers",
          "id": "ff20cd8d-ff64-40e1-943a-228422d89284"
        }
      }
    }
  },
  "included": [
    {
      "id": "ff20cd8d-ff64-40e1-943a-228422d89284",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:42:28+00:00",
        "updated_at": "2023-01-05T13:42:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ff20cd8d-ff64-40e1-943a-228422d89284&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ff20cd8d-ff64-40e1-943a-228422d89284&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ff20cd8d-ff64-40e1-943a-228422d89284&filter[owner_type]=customers"
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
          "owner_id": "e89647a9-4d5d-4fe8-bb9d-dd694050ea3f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "888bc4e8-c373-40e6-91da-38eb47b51251",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:42:28+00:00",
      "updated_at": "2023-01-05T13:42:28+00:00",
      "number": "http://bqbl.it/888bc4e8-c373-40e6-91da-38eb47b51251",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7c2f9cf50023e2dfc3c85834b729b810/barcode/image/888bc4e8-c373-40e6-91da-38eb47b51251/7910ae89-2b73-4bbc-8b99-16f6cf8d8ffe.svg",
      "owner_id": "e89647a9-4d5d-4fe8-bb9d-dd694050ea3f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/32b3f921-3c8c-443d-af67-4b0bb33b6a92' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "32b3f921-3c8c-443d-af67-4b0bb33b6a92",
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
    "id": "32b3f921-3c8c-443d-af67-4b0bb33b6a92",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:42:29+00:00",
      "updated_at": "2023-01-05T13:42:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/607f25947fcb5ef73340dad46b1a64fd/barcode/image/32b3f921-3c8c-443d-af67-4b0bb33b6a92/2b4495ef-4400-437a-b2c7-244cc9bb2200.svg",
      "owner_id": "60e15e62-b44e-4057-8cd0-4264792156d2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/12b04b45-592a-44d3-b2db-2173afe085cb' \
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