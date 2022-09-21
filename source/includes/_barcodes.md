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
      "id": "d67d2f0f-9525-4df2-b452-7ae9ce94cd1d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-21T09:04:44+00:00",
        "updated_at": "2022-09-21T09:04:44+00:00",
        "number": "http://bqbl.it/d67d2f0f-9525-4df2-b452-7ae9ce94cd1d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/aa8dab595e3b8af134975f200d718762/barcode/image/d67d2f0f-9525-4df2-b452-7ae9ce94cd1d/27329345-8830-41dd-b388-8e7158a6cbdf.svg",
        "owner_id": "61a693d0-a5cf-4a21-8621-6228e620c0fa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/61a693d0-a5cf-4a21-8621-6228e620c0fa"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F16f23135-95ad-4789-9c17-dda5f1bd9e1d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "16f23135-95ad-4789-9c17-dda5f1bd9e1d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-21T09:04:45+00:00",
        "updated_at": "2022-09-21T09:04:45+00:00",
        "number": "http://bqbl.it/16f23135-95ad-4789-9c17-dda5f1bd9e1d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f5442961b00c36ff88de3119cf7656a2/barcode/image/16f23135-95ad-4789-9c17-dda5f1bd9e1d/046d8f1f-c2d4-4934-9602-104836a0ba13.svg",
        "owner_id": "e55917dd-67ef-4aef-ab8b-d974f3261b02",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e55917dd-67ef-4aef-ab8b-d974f3261b02"
          },
          "data": {
            "type": "customers",
            "id": "e55917dd-67ef-4aef-ab8b-d974f3261b02"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e55917dd-67ef-4aef-ab8b-d974f3261b02",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-21T09:04:45+00:00",
        "updated_at": "2022-09-21T09:04:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e55917dd-67ef-4aef-ab8b-d974f3261b02&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e55917dd-67ef-4aef-ab8b-d974f3261b02&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e55917dd-67ef-4aef-ab8b-d974f3261b02&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTIwOGYxMDgtZDBlMy00MjVjLTg0MjItYmNiYTI2MDUyNDk0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e208f108-d0e3-425c-8422-bcba26052494",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-21T09:04:46+00:00",
        "updated_at": "2022-09-21T09:04:46+00:00",
        "number": "http://bqbl.it/e208f108-d0e3-425c-8422-bcba26052494",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f93ac732d1c7cfd7c09fe7155a842f6d/barcode/image/e208f108-d0e3-425c-8422-bcba26052494/994c7e5a-86d7-4c4c-8194-2071bee7d6dc.svg",
        "owner_id": "0aaad575-207e-4dbd-90a8-aebdc84134ab",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0aaad575-207e-4dbd-90a8-aebdc84134ab"
          },
          "data": {
            "type": "customers",
            "id": "0aaad575-207e-4dbd-90a8-aebdc84134ab"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0aaad575-207e-4dbd-90a8-aebdc84134ab",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-21T09:04:46+00:00",
        "updated_at": "2022-09-21T09:04:46+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0aaad575-207e-4dbd-90a8-aebdc84134ab&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0aaad575-207e-4dbd-90a8-aebdc84134ab&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0aaad575-207e-4dbd-90a8-aebdc84134ab&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-21T09:04:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6e9d2617-1991-44fb-8ae8-f6e36323d2ce?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6e9d2617-1991-44fb-8ae8-f6e36323d2ce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-21T09:04:47+00:00",
      "updated_at": "2022-09-21T09:04:47+00:00",
      "number": "http://bqbl.it/6e9d2617-1991-44fb-8ae8-f6e36323d2ce",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d9f248b7481739320cc8acaf953624d0/barcode/image/6e9d2617-1991-44fb-8ae8-f6e36323d2ce/50dba89c-41bd-4e2e-9cff-0d684366bd3d.svg",
      "owner_id": "7af3fd7f-8eea-458f-a06c-1980af5720b2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7af3fd7f-8eea-458f-a06c-1980af5720b2"
        },
        "data": {
          "type": "customers",
          "id": "7af3fd7f-8eea-458f-a06c-1980af5720b2"
        }
      }
    }
  },
  "included": [
    {
      "id": "7af3fd7f-8eea-458f-a06c-1980af5720b2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-21T09:04:47+00:00",
        "updated_at": "2022-09-21T09:04:47+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7af3fd7f-8eea-458f-a06c-1980af5720b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7af3fd7f-8eea-458f-a06c-1980af5720b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7af3fd7f-8eea-458f-a06c-1980af5720b2&filter[owner_type]=customers"
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
          "owner_id": "7e74afa3-2188-4e19-9113-dff45658007d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4bbecab9-6116-4467-ba60-9cc4a6ed4d98",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-21T09:04:48+00:00",
      "updated_at": "2022-09-21T09:04:48+00:00",
      "number": "http://bqbl.it/4bbecab9-6116-4467-ba60-9cc4a6ed4d98",
      "barcode_type": "qr_code",
      "image_url": "/uploads/87ddee71bbd1990a48e0613049f8f77b/barcode/image/4bbecab9-6116-4467-ba60-9cc4a6ed4d98/ee12cd84-5fb9-4922-9501-7b3995199398.svg",
      "owner_id": "7e74afa3-2188-4e19-9113-dff45658007d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/34d399dc-4768-483a-a3d9-e94ba9df8f42' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "34d399dc-4768-483a-a3d9-e94ba9df8f42",
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
    "id": "34d399dc-4768-483a-a3d9-e94ba9df8f42",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-21T09:04:49+00:00",
      "updated_at": "2022-09-21T09:04:49+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/456ea039f304dd6529d109d0783ae84c/barcode/image/34d399dc-4768-483a-a3d9-e94ba9df8f42/b108b8ab-07fa-462f-9741-5bd6c6573b3a.svg",
      "owner_id": "d839e48c-3d99-4065-b960-947fbe6e2f09",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99d47b04-bb22-4fae-a13b-03183581335b' \
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