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
      "id": "d6ca754f-44d1-4115-a598-99c16c2e5b44",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T16:17:00+00:00",
        "updated_at": "2023-02-08T16:17:00+00:00",
        "number": "http://bqbl.it/d6ca754f-44d1-4115-a598-99c16c2e5b44",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3e87fff31cd9a4bf51bad8c97b47abbc/barcode/image/d6ca754f-44d1-4115-a598-99c16c2e5b44/e215133b-6d8b-4972-8f02-4fce53d38cff.svg",
        "owner_id": "4445ffe7-c361-48ee-b2ee-29a143318bc3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4445ffe7-c361-48ee-b2ee-29a143318bc3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F60405761-ae1b-4084-a9e5-060b67d51640&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "60405761-ae1b-4084-a9e5-060b67d51640",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T16:17:01+00:00",
        "updated_at": "2023-02-08T16:17:01+00:00",
        "number": "http://bqbl.it/60405761-ae1b-4084-a9e5-060b67d51640",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f08cd79ca17fc13212242df5d0d70b65/barcode/image/60405761-ae1b-4084-a9e5-060b67d51640/08d8cdcb-27d4-4d93-8ebe-42f86d6b82f6.svg",
        "owner_id": "aa70fa94-1ed0-44de-af38-3ee7206356c5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aa70fa94-1ed0-44de-af38-3ee7206356c5"
          },
          "data": {
            "type": "customers",
            "id": "aa70fa94-1ed0-44de-af38-3ee7206356c5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aa70fa94-1ed0-44de-af38-3ee7206356c5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T16:17:01+00:00",
        "updated_at": "2023-02-08T16:17:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=aa70fa94-1ed0-44de-af38-3ee7206356c5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aa70fa94-1ed0-44de-af38-3ee7206356c5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aa70fa94-1ed0-44de-af38-3ee7206356c5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZmRkNTA1OTAtYjJkOS00YTlhLWJkMWItMDljYzdlMWJiNmNj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fdd50590-b2d9-4a9a-bd1b-09cc7e1bb6cc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T16:17:02+00:00",
        "updated_at": "2023-02-08T16:17:02+00:00",
        "number": "http://bqbl.it/fdd50590-b2d9-4a9a-bd1b-09cc7e1bb6cc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1a8a10ed29585e441ca7451b7829c8b6/barcode/image/fdd50590-b2d9-4a9a-bd1b-09cc7e1bb6cc/91226d35-22bb-4d05-aed7-606f012c3ef5.svg",
        "owner_id": "b0dae0f6-9e53-48e3-82ab-3c9f888465d6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0dae0f6-9e53-48e3-82ab-3c9f888465d6"
          },
          "data": {
            "type": "customers",
            "id": "b0dae0f6-9e53-48e3-82ab-3c9f888465d6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b0dae0f6-9e53-48e3-82ab-3c9f888465d6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T16:17:02+00:00",
        "updated_at": "2023-02-08T16:17:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b0dae0f6-9e53-48e3-82ab-3c9f888465d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b0dae0f6-9e53-48e3-82ab-3c9f888465d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b0dae0f6-9e53-48e3-82ab-3c9f888465d6&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T16:16:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c19676bd-affd-4c82-adbf-3a798d7eba0b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c19676bd-affd-4c82-adbf-3a798d7eba0b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T16:17:03+00:00",
      "updated_at": "2023-02-08T16:17:03+00:00",
      "number": "http://bqbl.it/c19676bd-affd-4c82-adbf-3a798d7eba0b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6f5bd19a5e4371ac499db50049f2d261/barcode/image/c19676bd-affd-4c82-adbf-3a798d7eba0b/7d86eba6-f3e5-499b-a3ac-d8b366ea9637.svg",
      "owner_id": "f80b46f6-9a07-42a0-9c79-d5830685841c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f80b46f6-9a07-42a0-9c79-d5830685841c"
        },
        "data": {
          "type": "customers",
          "id": "f80b46f6-9a07-42a0-9c79-d5830685841c"
        }
      }
    }
  },
  "included": [
    {
      "id": "f80b46f6-9a07-42a0-9c79-d5830685841c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T16:17:03+00:00",
        "updated_at": "2023-02-08T16:17:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f80b46f6-9a07-42a0-9c79-d5830685841c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f80b46f6-9a07-42a0-9c79-d5830685841c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f80b46f6-9a07-42a0-9c79-d5830685841c&filter[owner_type]=customers"
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
          "owner_id": "ff937f39-c341-465f-99e7-273bad4095b6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bc113e6a-e1c1-4ff3-a91b-3b324d8b2810",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T16:17:03+00:00",
      "updated_at": "2023-02-08T16:17:03+00:00",
      "number": "http://bqbl.it/bc113e6a-e1c1-4ff3-a91b-3b324d8b2810",
      "barcode_type": "qr_code",
      "image_url": "/uploads/16059d66d3abe5a58f754f246004dac3/barcode/image/bc113e6a-e1c1-4ff3-a91b-3b324d8b2810/d82cd894-1ebb-437a-b1dc-01aceb89ff0b.svg",
      "owner_id": "ff937f39-c341-465f-99e7-273bad4095b6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df225710-83cc-49e0-a8ec-f174519ab2d1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "df225710-83cc-49e0-a8ec-f174519ab2d1",
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
    "id": "df225710-83cc-49e0-a8ec-f174519ab2d1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T16:17:04+00:00",
      "updated_at": "2023-02-08T16:17:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cece9d703e458a952757787f702392da/barcode/image/df225710-83cc-49e0-a8ec-f174519ab2d1/b76ddd0b-338d-42a1-9ca5-98f1c82fdde4.svg",
      "owner_id": "afe5571a-bdac-4c74-8296-90e7370e85d0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/373e69af-ff02-4c0e-8079-073b28a09ab7' \
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