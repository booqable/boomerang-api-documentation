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
      "id": "e9894088-68be-488e-85d7-2bae6533e801",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T16:26:29+00:00",
        "updated_at": "2023-01-05T16:26:29+00:00",
        "number": "http://bqbl.it/e9894088-68be-488e-85d7-2bae6533e801",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b2036b64d6cc6099cc9d2aa4bcf0c8d2/barcode/image/e9894088-68be-488e-85d7-2bae6533e801/5544f87d-280f-4b22-bbc5-b49f8575a96f.svg",
        "owner_id": "a965fb9f-481e-4c83-9090-de7eee89cc2a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a965fb9f-481e-4c83-9090-de7eee89cc2a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbdc57245-c053-4852-a556-eb758c7d0feb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bdc57245-c053-4852-a556-eb758c7d0feb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T16:26:30+00:00",
        "updated_at": "2023-01-05T16:26:30+00:00",
        "number": "http://bqbl.it/bdc57245-c053-4852-a556-eb758c7d0feb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/716a4eb3e2da5778e430e55087f5ae22/barcode/image/bdc57245-c053-4852-a556-eb758c7d0feb/a3d70f58-2d15-44db-80d9-f9f59b40d77b.svg",
        "owner_id": "604b9373-ad3d-4907-8e6c-29423a79f3c7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/604b9373-ad3d-4907-8e6c-29423a79f3c7"
          },
          "data": {
            "type": "customers",
            "id": "604b9373-ad3d-4907-8e6c-29423a79f3c7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "604b9373-ad3d-4907-8e6c-29423a79f3c7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T16:26:30+00:00",
        "updated_at": "2023-01-05T16:26:30+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=604b9373-ad3d-4907-8e6c-29423a79f3c7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=604b9373-ad3d-4907-8e6c-29423a79f3c7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=604b9373-ad3d-4907-8e6c-29423a79f3c7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjEyZTUyNmMtYjMxZC00YWUwLTliNjItOGRmYmQ5YTViZWE3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "612e526c-b31d-4ae0-9b62-8dfbd9a5bea7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T16:26:30+00:00",
        "updated_at": "2023-01-05T16:26:30+00:00",
        "number": "http://bqbl.it/612e526c-b31d-4ae0-9b62-8dfbd9a5bea7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/62dd1f96ca4cdcdcf51c8e4d11069ff8/barcode/image/612e526c-b31d-4ae0-9b62-8dfbd9a5bea7/7d1a5823-e0bc-4718-9b11-d087081c4efc.svg",
        "owner_id": "96e9f8b5-ec84-46ef-82a0-81110b304d36",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96e9f8b5-ec84-46ef-82a0-81110b304d36"
          },
          "data": {
            "type": "customers",
            "id": "96e9f8b5-ec84-46ef-82a0-81110b304d36"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "96e9f8b5-ec84-46ef-82a0-81110b304d36",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T16:26:30+00:00",
        "updated_at": "2023-01-05T16:26:30+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=96e9f8b5-ec84-46ef-82a0-81110b304d36&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=96e9f8b5-ec84-46ef-82a0-81110b304d36&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=96e9f8b5-ec84-46ef-82a0-81110b304d36&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T16:26:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/41804882-6706-4aa8-a845-1a9f1ec845ed?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "41804882-6706-4aa8-a845-1a9f1ec845ed",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T16:26:31+00:00",
      "updated_at": "2023-01-05T16:26:31+00:00",
      "number": "http://bqbl.it/41804882-6706-4aa8-a845-1a9f1ec845ed",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7ac376d81a27c0b2b7ecd19308af887a/barcode/image/41804882-6706-4aa8-a845-1a9f1ec845ed/2a88cf58-4440-4a8a-9e35-2becfe2d6e92.svg",
      "owner_id": "0d26a1c1-3a05-44fb-8470-dd2bcec0ff05",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0d26a1c1-3a05-44fb-8470-dd2bcec0ff05"
        },
        "data": {
          "type": "customers",
          "id": "0d26a1c1-3a05-44fb-8470-dd2bcec0ff05"
        }
      }
    }
  },
  "included": [
    {
      "id": "0d26a1c1-3a05-44fb-8470-dd2bcec0ff05",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T16:26:31+00:00",
        "updated_at": "2023-01-05T16:26:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d26a1c1-3a05-44fb-8470-dd2bcec0ff05&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d26a1c1-3a05-44fb-8470-dd2bcec0ff05&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d26a1c1-3a05-44fb-8470-dd2bcec0ff05&filter[owner_type]=customers"
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
          "owner_id": "12fb6190-ceba-49b5-a602-7a8da3018040",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "784347a4-0d35-48d9-b095-664bc5ed113d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T16:26:31+00:00",
      "updated_at": "2023-01-05T16:26:31+00:00",
      "number": "http://bqbl.it/784347a4-0d35-48d9-b095-664bc5ed113d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/03e4419324ed5c4d9bcedac7f637a4f0/barcode/image/784347a4-0d35-48d9-b095-664bc5ed113d/7645b92f-d61c-479f-8aa7-b5f2ef542dd8.svg",
      "owner_id": "12fb6190-ceba-49b5-a602-7a8da3018040",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e98731bf-9da8-42df-8f36-4689202fc0e4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e98731bf-9da8-42df-8f36-4689202fc0e4",
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
    "id": "e98731bf-9da8-42df-8f36-4689202fc0e4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T16:26:32+00:00",
      "updated_at": "2023-01-05T16:26:32+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d6956c8b9f138ddb5ea9063643616c11/barcode/image/e98731bf-9da8-42df-8f36-4689202fc0e4/11cd1780-f818-4445-8d2b-4e4b22bb7af8.svg",
      "owner_id": "8c69b922-40f8-4be9-809f-82d0841efbc2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3a942fde-c9be-4edc-84d9-f8e0c2b14860' \
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