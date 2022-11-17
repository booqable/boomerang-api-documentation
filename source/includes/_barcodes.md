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
      "id": "65cc1c1d-1ef1-47cc-a36e-df1fff1fb719",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-17T10:15:56+00:00",
        "updated_at": "2022-11-17T10:15:56+00:00",
        "number": "http://bqbl.it/65cc1c1d-1ef1-47cc-a36e-df1fff1fb719",
        "barcode_type": "qr_code",
        "image_url": "/uploads/673408983614eb3af137bcb7dbabe284/barcode/image/65cc1c1d-1ef1-47cc-a36e-df1fff1fb719/c02f1f1f-6fb7-4678-b6bf-c0f7ecd84d36.svg",
        "owner_id": "04b83257-45eb-48d2-8dc1-723ebdd74aba",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/04b83257-45eb-48d2-8dc1-723ebdd74aba"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F237c14da-c13a-4eac-9a6f-ad0315d8ac6d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "237c14da-c13a-4eac-9a6f-ad0315d8ac6d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-17T10:15:56+00:00",
        "updated_at": "2022-11-17T10:15:56+00:00",
        "number": "http://bqbl.it/237c14da-c13a-4eac-9a6f-ad0315d8ac6d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/da70f9fc71c1b93e80ac69d79a8a1dc2/barcode/image/237c14da-c13a-4eac-9a6f-ad0315d8ac6d/b8bf364a-f1a2-47dc-b49d-8ce623d31c6d.svg",
        "owner_id": "2d4dc2db-4da4-4bde-9ab8-4fb44999eea0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2d4dc2db-4da4-4bde-9ab8-4fb44999eea0"
          },
          "data": {
            "type": "customers",
            "id": "2d4dc2db-4da4-4bde-9ab8-4fb44999eea0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2d4dc2db-4da4-4bde-9ab8-4fb44999eea0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-17T10:15:56+00:00",
        "updated_at": "2022-11-17T10:15:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2d4dc2db-4da4-4bde-9ab8-4fb44999eea0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2d4dc2db-4da4-4bde-9ab8-4fb44999eea0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2d4dc2db-4da4-4bde-9ab8-4fb44999eea0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGQ1ZjcwZTgtMTIzYy00ZmVlLTljZDQtOGZiMWJkMGJjNDlk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4d5f70e8-123c-4fee-9cd4-8fb1bd0bc49d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-17T10:15:57+00:00",
        "updated_at": "2022-11-17T10:15:57+00:00",
        "number": "http://bqbl.it/4d5f70e8-123c-4fee-9cd4-8fb1bd0bc49d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7dd73f49e9b5f87b29784465a2281895/barcode/image/4d5f70e8-123c-4fee-9cd4-8fb1bd0bc49d/1b462047-741e-4b00-8dbf-b0a64adc9363.svg",
        "owner_id": "f7c6bdf2-dcff-4402-8220-2c922aab85cc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f7c6bdf2-dcff-4402-8220-2c922aab85cc"
          },
          "data": {
            "type": "customers",
            "id": "f7c6bdf2-dcff-4402-8220-2c922aab85cc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f7c6bdf2-dcff-4402-8220-2c922aab85cc",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-17T10:15:57+00:00",
        "updated_at": "2022-11-17T10:15:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f7c6bdf2-dcff-4402-8220-2c922aab85cc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7c6bdf2-dcff-4402-8220-2c922aab85cc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f7c6bdf2-dcff-4402-8220-2c922aab85cc&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T10:15:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/892b90d5-01d7-4c1c-9e86-612317549854?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "892b90d5-01d7-4c1c-9e86-612317549854",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-17T10:15:57+00:00",
      "updated_at": "2022-11-17T10:15:57+00:00",
      "number": "http://bqbl.it/892b90d5-01d7-4c1c-9e86-612317549854",
      "barcode_type": "qr_code",
      "image_url": "/uploads/32183aee763f63837f985079b7d1745a/barcode/image/892b90d5-01d7-4c1c-9e86-612317549854/df4c3b57-ed92-4b8c-84f0-86aac4542645.svg",
      "owner_id": "436b5a85-352e-45c2-a1be-557cb46a06b8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/436b5a85-352e-45c2-a1be-557cb46a06b8"
        },
        "data": {
          "type": "customers",
          "id": "436b5a85-352e-45c2-a1be-557cb46a06b8"
        }
      }
    }
  },
  "included": [
    {
      "id": "436b5a85-352e-45c2-a1be-557cb46a06b8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-17T10:15:57+00:00",
        "updated_at": "2022-11-17T10:15:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=436b5a85-352e-45c2-a1be-557cb46a06b8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=436b5a85-352e-45c2-a1be-557cb46a06b8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=436b5a85-352e-45c2-a1be-557cb46a06b8&filter[owner_type]=customers"
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
          "owner_id": "d72e3125-164d-4a2a-af0d-cce26ea917fa",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2439e982-8b61-4a8f-9b44-74de2ecd5fcf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-17T10:15:58+00:00",
      "updated_at": "2022-11-17T10:15:58+00:00",
      "number": "http://bqbl.it/2439e982-8b61-4a8f-9b44-74de2ecd5fcf",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e1d48364d2cc34632aa7a6d79e36fca3/barcode/image/2439e982-8b61-4a8f-9b44-74de2ecd5fcf/44519b33-4913-49eb-b645-81ed25913f68.svg",
      "owner_id": "d72e3125-164d-4a2a-af0d-cce26ea917fa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3214ee5c-d2db-4602-8382-78250bb0a2b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3214ee5c-d2db-4602-8382-78250bb0a2b1",
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
    "id": "3214ee5c-d2db-4602-8382-78250bb0a2b1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-17T10:15:58+00:00",
      "updated_at": "2022-11-17T10:15:59+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/706f2e059d29abd32f72e12a856c9200/barcode/image/3214ee5c-d2db-4602-8382-78250bb0a2b1/0298c5d2-c070-4718-bc74-fc89acd5cd87.svg",
      "owner_id": "12929d75-9d3d-4a12-a445-c2e32427cc24",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/16afb96e-98bc-4d66-8229-85dc23ea4448' \
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