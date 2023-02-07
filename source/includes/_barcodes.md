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
      "id": "c9357237-fcbb-4cd2-bc38-be4ee7c2dea9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T10:56:50+00:00",
        "updated_at": "2023-02-07T10:56:50+00:00",
        "number": "http://bqbl.it/c9357237-fcbb-4cd2-bc38-be4ee7c2dea9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a73c53b7bd8ac60853d81218921eebc7/barcode/image/c9357237-fcbb-4cd2-bc38-be4ee7c2dea9/21089e85-4370-4a7b-a16c-fbfb3fb646c1.svg",
        "owner_id": "bdf10815-3fb1-4363-98c3-a28c469e35b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bdf10815-3fb1-4363-98c3-a28c469e35b2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F727d6cc2-bef1-4005-bc2a-8530e0ca289e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "727d6cc2-bef1-4005-bc2a-8530e0ca289e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T10:56:51+00:00",
        "updated_at": "2023-02-07T10:56:51+00:00",
        "number": "http://bqbl.it/727d6cc2-bef1-4005-bc2a-8530e0ca289e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/509b25154276cb3dc9d9cdc3d960983d/barcode/image/727d6cc2-bef1-4005-bc2a-8530e0ca289e/32a661e3-2dcc-40d4-b462-f1fe92c237fe.svg",
        "owner_id": "cdb252a9-1609-4427-a8ee-09359c17f1ea",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cdb252a9-1609-4427-a8ee-09359c17f1ea"
          },
          "data": {
            "type": "customers",
            "id": "cdb252a9-1609-4427-a8ee-09359c17f1ea"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cdb252a9-1609-4427-a8ee-09359c17f1ea",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T10:56:51+00:00",
        "updated_at": "2023-02-07T10:56:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cdb252a9-1609-4427-a8ee-09359c17f1ea&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cdb252a9-1609-4427-a8ee-09359c17f1ea&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cdb252a9-1609-4427-a8ee-09359c17f1ea&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2U4OWM1NmUtNzFmYi00YWQ3LTlkOTUtOWM1NjIyNWY4MDhl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3e89c56e-71fb-4ad7-9d95-9c56225f808e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T10:56:51+00:00",
        "updated_at": "2023-02-07T10:56:51+00:00",
        "number": "http://bqbl.it/3e89c56e-71fb-4ad7-9d95-9c56225f808e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/632b5e5ff1b9f6f26a9a0da260b78c09/barcode/image/3e89c56e-71fb-4ad7-9d95-9c56225f808e/ab0648d0-e7df-42f3-9a96-10505da89e66.svg",
        "owner_id": "1fed1e22-0a9d-43e0-971e-f97476270c35",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1fed1e22-0a9d-43e0-971e-f97476270c35"
          },
          "data": {
            "type": "customers",
            "id": "1fed1e22-0a9d-43e0-971e-f97476270c35"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1fed1e22-0a9d-43e0-971e-f97476270c35",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T10:56:51+00:00",
        "updated_at": "2023-02-07T10:56:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1fed1e22-0a9d-43e0-971e-f97476270c35&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1fed1e22-0a9d-43e0-971e-f97476270c35&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1fed1e22-0a9d-43e0-971e-f97476270c35&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:56:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3e39e643-92b2-40f7-a352-d2b9a6723664?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3e39e643-92b2-40f7-a352-d2b9a6723664",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T10:56:52+00:00",
      "updated_at": "2023-02-07T10:56:52+00:00",
      "number": "http://bqbl.it/3e39e643-92b2-40f7-a352-d2b9a6723664",
      "barcode_type": "qr_code",
      "image_url": "/uploads/857a94a8a11fc794e9e78d97f1e5e7bb/barcode/image/3e39e643-92b2-40f7-a352-d2b9a6723664/a1393fb0-0f56-4514-9065-d5d5f0c56a5a.svg",
      "owner_id": "e7a5c691-9e7d-46d2-a5fa-710750e899a7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e7a5c691-9e7d-46d2-a5fa-710750e899a7"
        },
        "data": {
          "type": "customers",
          "id": "e7a5c691-9e7d-46d2-a5fa-710750e899a7"
        }
      }
    }
  },
  "included": [
    {
      "id": "e7a5c691-9e7d-46d2-a5fa-710750e899a7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T10:56:52+00:00",
        "updated_at": "2023-02-07T10:56:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e7a5c691-9e7d-46d2-a5fa-710750e899a7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e7a5c691-9e7d-46d2-a5fa-710750e899a7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e7a5c691-9e7d-46d2-a5fa-710750e899a7&filter[owner_type]=customers"
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
          "owner_id": "f04b83ee-4e16-4a3b-bde4-71c564d2ca78",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "679465aa-798d-4be2-a149-b7109e42fd7d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T10:56:52+00:00",
      "updated_at": "2023-02-07T10:56:52+00:00",
      "number": "http://bqbl.it/679465aa-798d-4be2-a149-b7109e42fd7d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6e84bda205aa9e9f5dff2a0e7ca88fe6/barcode/image/679465aa-798d-4be2-a149-b7109e42fd7d/1a2e1170-39de-48b7-978a-3100c337ae83.svg",
      "owner_id": "f04b83ee-4e16-4a3b-bde4-71c564d2ca78",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a1cb2d32-7ec1-4533-af82-681f28012e34' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a1cb2d32-7ec1-4533-af82-681f28012e34",
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
    "id": "a1cb2d32-7ec1-4533-af82-681f28012e34",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T10:56:53+00:00",
      "updated_at": "2023-02-07T10:56:53+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1fe6c6e765668860a34b34461d092c25/barcode/image/a1cb2d32-7ec1-4533-af82-681f28012e34/3de2bbf6-c5de-4222-acdb-6816e6cd28b3.svg",
      "owner_id": "c9692228-d311-44b6-9dcf-6221c6309ad2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2989340e-3fec-4db2-9236-2507d720e93c' \
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