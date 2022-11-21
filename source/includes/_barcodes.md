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
      "id": "7d64e71d-1c33-4ea0-b089-1b8d4a050abf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-21T10:28:22+00:00",
        "updated_at": "2022-11-21T10:28:22+00:00",
        "number": "http://bqbl.it/7d64e71d-1c33-4ea0-b089-1b8d4a050abf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dc2352894bae827a510a08f89c19b53e/barcode/image/7d64e71d-1c33-4ea0-b089-1b8d4a050abf/4e7cb26e-6ef9-4d39-84f4-3f7286a2c0dd.svg",
        "owner_id": "8599251d-6671-485c-826a-f036974705f2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8599251d-6671-485c-826a-f036974705f2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5f5eeb18-2e0b-47fb-80af-6d7dc2dd4614&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5f5eeb18-2e0b-47fb-80af-6d7dc2dd4614",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-21T10:28:23+00:00",
        "updated_at": "2022-11-21T10:28:23+00:00",
        "number": "http://bqbl.it/5f5eeb18-2e0b-47fb-80af-6d7dc2dd4614",
        "barcode_type": "qr_code",
        "image_url": "/uploads/31c4f60713fc09114ac885f6372f84af/barcode/image/5f5eeb18-2e0b-47fb-80af-6d7dc2dd4614/b11de9b5-4284-4eb8-92bc-a223e5e5ad68.svg",
        "owner_id": "dda3b9d2-01a5-4683-a93c-04abf014ab07",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dda3b9d2-01a5-4683-a93c-04abf014ab07"
          },
          "data": {
            "type": "customers",
            "id": "dda3b9d2-01a5-4683-a93c-04abf014ab07"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dda3b9d2-01a5-4683-a93c-04abf014ab07",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-21T10:28:22+00:00",
        "updated_at": "2022-11-21T10:28:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=dda3b9d2-01a5-4683-a93c-04abf014ab07&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dda3b9d2-01a5-4683-a93c-04abf014ab07&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dda3b9d2-01a5-4683-a93c-04abf014ab07&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTYyNjdhMTItOTUwNi00NGE0LThiNWQtMmMzMDY2ODc0Yzdk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "56267a12-9506-44a4-8b5d-2c3066874c7d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-21T10:28:23+00:00",
        "updated_at": "2022-11-21T10:28:23+00:00",
        "number": "http://bqbl.it/56267a12-9506-44a4-8b5d-2c3066874c7d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5972643d3d66290a328f712d22373415/barcode/image/56267a12-9506-44a4-8b5d-2c3066874c7d/f0b93f01-29f5-42b6-9caa-c46d3ae01e3e.svg",
        "owner_id": "a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9"
          },
          "data": {
            "type": "customers",
            "id": "a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-21T10:28:23+00:00",
        "updated_at": "2022-11-21T10:28:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a807b07f-f4b4-4ac1-ba2d-aa1d2fa017d9&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-21T10:28:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0adc55d9-5b67-4f6a-a0c2-f3a3e410ddd3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0adc55d9-5b67-4f6a-a0c2-f3a3e410ddd3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-21T10:28:23+00:00",
      "updated_at": "2022-11-21T10:28:23+00:00",
      "number": "http://bqbl.it/0adc55d9-5b67-4f6a-a0c2-f3a3e410ddd3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5045762e0bb119a8cf36ae7572c8d077/barcode/image/0adc55d9-5b67-4f6a-a0c2-f3a3e410ddd3/83ab82ef-8ec8-4681-8346-5b5ab8392ae2.svg",
      "owner_id": "f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b"
        },
        "data": {
          "type": "customers",
          "id": "f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b"
        }
      }
    }
  },
  "included": [
    {
      "id": "f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-21T10:28:23+00:00",
        "updated_at": "2022-11-21T10:28:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f9b7b710-d0d7-4f2c-83db-c6e8c8e09c5b&filter[owner_type]=customers"
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
          "owner_id": "b279dc16-346f-4844-9f70-a10d5ca6b56d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ac54f20b-b391-4df3-8432-84757d023c41",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-21T10:28:24+00:00",
      "updated_at": "2022-11-21T10:28:24+00:00",
      "number": "http://bqbl.it/ac54f20b-b391-4df3-8432-84757d023c41",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bb7d0070bcd9d2b2eb206a842012f102/barcode/image/ac54f20b-b391-4df3-8432-84757d023c41/7fceaa82-3825-4cdc-9e1e-a5832297eb9b.svg",
      "owner_id": "b279dc16-346f-4844-9f70-a10d5ca6b56d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/607911b5-de6a-439b-9995-21dc8199fe68' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "607911b5-de6a-439b-9995-21dc8199fe68",
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
    "id": "607911b5-de6a-439b-9995-21dc8199fe68",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-21T10:28:24+00:00",
      "updated_at": "2022-11-21T10:28:24+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5e46c7a7af42757ffbec0c8d57adabc5/barcode/image/607911b5-de6a-439b-9995-21dc8199fe68/aae0af05-b92e-4962-a90f-8c26dbb8c122.svg",
      "owner_id": "e054785b-4e1e-44a4-8c2e-3ec5df2e1411",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/278e1986-afc1-4d27-a2de-6be16596ad75' \
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