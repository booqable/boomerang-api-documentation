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
      "id": "a1331c86-9dbd-4e36-8a54-d01e4ff23cc7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T08:44:16+00:00",
        "updated_at": "2023-02-28T08:44:16+00:00",
        "number": "http://bqbl.it/a1331c86-9dbd-4e36-8a54-d01e4ff23cc7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fd3cbb937cc0862a0a8acf025c8087f4/barcode/image/a1331c86-9dbd-4e36-8a54-d01e4ff23cc7/a580ef19-5883-4af8-a12d-e91ee00b3b42.svg",
        "owner_id": "d2b2cfd6-b23c-4b2c-9a62-d8679ef4b416",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d2b2cfd6-b23c-4b2c-9a62-d8679ef4b416"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7754afcc-ad5e-4a03-b4ba-fa14fd885afa&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7754afcc-ad5e-4a03-b4ba-fa14fd885afa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T08:44:16+00:00",
        "updated_at": "2023-02-28T08:44:16+00:00",
        "number": "http://bqbl.it/7754afcc-ad5e-4a03-b4ba-fa14fd885afa",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f2d2a66747103635b83769dc73b5cc33/barcode/image/7754afcc-ad5e-4a03-b4ba-fa14fd885afa/8fbca557-5464-4e75-8651-fa75210b0b42.svg",
        "owner_id": "77a74ccd-7b76-46bb-8979-721ba801d0c4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/77a74ccd-7b76-46bb-8979-721ba801d0c4"
          },
          "data": {
            "type": "customers",
            "id": "77a74ccd-7b76-46bb-8979-721ba801d0c4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "77a74ccd-7b76-46bb-8979-721ba801d0c4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T08:44:16+00:00",
        "updated_at": "2023-02-28T08:44:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=77a74ccd-7b76-46bb-8979-721ba801d0c4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=77a74ccd-7b76-46bb-8979-721ba801d0c4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=77a74ccd-7b76-46bb-8979-721ba801d0c4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDBkMjdiODUtYTYzYy00MTIwLTk5NTUtMmMzZTg1ZDVjOGU2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "00d27b85-a63c-4120-9955-2c3e85d5c8e6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T08:44:16+00:00",
        "updated_at": "2023-02-28T08:44:16+00:00",
        "number": "http://bqbl.it/00d27b85-a63c-4120-9955-2c3e85d5c8e6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8a482275eb9063b6c0712b1ee9006a5e/barcode/image/00d27b85-a63c-4120-9955-2c3e85d5c8e6/8d2ec7a2-f172-4e3e-92dc-535d183b3f12.svg",
        "owner_id": "7e319f8d-f0ef-4369-80b2-24c95d000685",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7e319f8d-f0ef-4369-80b2-24c95d000685"
          },
          "data": {
            "type": "customers",
            "id": "7e319f8d-f0ef-4369-80b2-24c95d000685"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7e319f8d-f0ef-4369-80b2-24c95d000685",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T08:44:16+00:00",
        "updated_at": "2023-02-28T08:44:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7e319f8d-f0ef-4369-80b2-24c95d000685&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7e319f8d-f0ef-4369-80b2-24c95d000685&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7e319f8d-f0ef-4369-80b2-24c95d000685&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T08:43:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7f3805f6-e2ad-4873-af07-8389b0c23673?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7f3805f6-e2ad-4873-af07-8389b0c23673",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T08:44:17+00:00",
      "updated_at": "2023-02-28T08:44:17+00:00",
      "number": "http://bqbl.it/7f3805f6-e2ad-4873-af07-8389b0c23673",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d006bee72b55d0bf0a5a9f928b0d326a/barcode/image/7f3805f6-e2ad-4873-af07-8389b0c23673/07c3d59e-e0a8-42a2-b41c-c50bbc39371d.svg",
      "owner_id": "17971cda-e67c-4a1d-afad-986068246f52",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/17971cda-e67c-4a1d-afad-986068246f52"
        },
        "data": {
          "type": "customers",
          "id": "17971cda-e67c-4a1d-afad-986068246f52"
        }
      }
    }
  },
  "included": [
    {
      "id": "17971cda-e67c-4a1d-afad-986068246f52",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T08:44:17+00:00",
        "updated_at": "2023-02-28T08:44:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=17971cda-e67c-4a1d-afad-986068246f52&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=17971cda-e67c-4a1d-afad-986068246f52&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=17971cda-e67c-4a1d-afad-986068246f52&filter[owner_type]=customers"
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
          "owner_id": "b42429e4-d1d4-430b-8fbf-1f36583dce32",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f4291da5-4f8f-4f39-90c7-c183319bb162",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T08:44:17+00:00",
      "updated_at": "2023-02-28T08:44:17+00:00",
      "number": "http://bqbl.it/f4291da5-4f8f-4f39-90c7-c183319bb162",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2c8804b6cc13e633ecc2fc6718b9181a/barcode/image/f4291da5-4f8f-4f39-90c7-c183319bb162/e3b11f94-a16d-43f1-9837-c01766e8893e.svg",
      "owner_id": "b42429e4-d1d4-430b-8fbf-1f36583dce32",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d2a3c501-8b47-4706-b476-37eb3f9fc606' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d2a3c501-8b47-4706-b476-37eb3f9fc606",
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
    "id": "d2a3c501-8b47-4706-b476-37eb3f9fc606",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T08:44:18+00:00",
      "updated_at": "2023-02-28T08:44:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5486a81b693f8dae60f356cef1ea9845/barcode/image/d2a3c501-8b47-4706-b476-37eb3f9fc606/905532f8-0c84-47dd-844c-bec542579376.svg",
      "owner_id": "d4be9d2a-8841-4989-96a5-42a79f8c8c03",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c5b61831-9e21-4b5b-96d8-3d0f2198f9b3' \
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