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
`PUT /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b0d12ab7-9651-4564-bc2e-92019738f772' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b0d12ab7-9651-4564-bc2e-92019738f772",
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
    "id": "b0d12ab7-9651-4564-bc2e-92019738f772",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-07T18:43:29+00:00",
      "updated_at": "2023-12-07T18:43:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-289.shop.lvh.me:/barcodes/b0d12ab7-9651-4564-bc2e-92019738f772/image",
      "owner_id": "b528d88b-b218-4ac4-8803-b6f14d1bea92",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


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
          "owner_id": "745ccc50-e3ff-4c0a-ae59-be1983f9bc9d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a5e7d91d-6a47-4d6a-8086-672ebc2c2833",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-07T18:43:29+00:00",
      "updated_at": "2023-12-07T18:43:29+00:00",
      "number": "http://bqbl.it/a5e7d91d-6a47-4d6a-8086-672ebc2c2833",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-290.shop.lvh.me:/barcodes/a5e7d91d-6a47-4d6a-8086-672ebc2c2833/image",
      "owner_id": "745ccc50-e3ff-4c0a-ae59-be1983f9bc9d",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/9b3a69fc-6f22-4949-a03c-652715d98c61?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9b3a69fc-6f22-4949-a03c-652715d98c61",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-07T18:43:30+00:00",
      "updated_at": "2023-12-07T18:43:30+00:00",
      "number": "http://bqbl.it/9b3a69fc-6f22-4949-a03c-652715d98c61",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-291.shop.lvh.me:/barcodes/9b3a69fc-6f22-4949-a03c-652715d98c61/image",
      "owner_id": "0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5"
        },
        "data": {
          "type": "customers",
          "id": "0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5"
        }
      }
    }
  },
  "included": [
    {
      "id": "0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-07T18:43:30+00:00",
        "updated_at": "2023-12-07T18:43:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-77@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d19f0c6-ce71-4fdd-8b75-3e4f56e194c5&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d15de35-f2dc-46b1-8a62-7333542d3dbb' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Listing barcodes



> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTMxMjRmOWEtOWJiNi00YTQ1LWE1NzctNGRjYzY2MDlhOTJh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a3124f9a-9bb6-4a45-a577-4dcc6609a92a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-07T18:43:32+00:00",
        "updated_at": "2023-12-07T18:43:32+00:00",
        "number": "http://bqbl.it/a3124f9a-9bb6-4a45-a577-4dcc6609a92a",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-293.shop.lvh.me:/barcodes/a3124f9a-9bb6-4a45-a577-4dcc6609a92a/image",
        "owner_id": "1e33a7b4-7d51-4476-ad75-c83a690cd99e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1e33a7b4-7d51-4476-ad75-c83a690cd99e"
          },
          "data": {
            "type": "customers",
            "id": "1e33a7b4-7d51-4476-ad75-c83a690cd99e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1e33a7b4-7d51-4476-ad75-c83a690cd99e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-07T18:43:32+00:00",
        "updated_at": "2023-12-07T18:43:32+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-80@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=1e33a7b4-7d51-4476-ad75-c83a690cd99e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1e33a7b4-7d51-4476-ad75-c83a690cd99e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1e33a7b4-7d51-4476-ad75-c83a690cd99e&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "7093ace1-3f6d-44e0-bb62-aa15454960d0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-07T18:43:33+00:00",
        "updated_at": "2023-12-07T18:43:33+00:00",
        "number": "http://bqbl.it/7093ace1-3f6d-44e0-bb62-aa15454960d0",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-294.shop.lvh.me:/barcodes/7093ace1-3f6d-44e0-bb62-aa15454960d0/image",
        "owner_id": "1dc2fb48-5e70-4ce4-8c0b-ecd196a1ad7c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1dc2fb48-5e70-4ce4-8c0b-ecd196a1ad7c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe0d380b4-29fd-47ef-85fe-a3a73dd08ed1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e0d380b4-29fd-47ef-85fe-a3a73dd08ed1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-07T18:43:34+00:00",
        "updated_at": "2023-12-07T18:43:34+00:00",
        "number": "http://bqbl.it/e0d380b4-29fd-47ef-85fe-a3a73dd08ed1",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-295.shop.lvh.me:/barcodes/e0d380b4-29fd-47ef-85fe-a3a73dd08ed1/image",
        "owner_id": "eaec2a3a-f70d-48cc-9ce0-00198bcef5a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/eaec2a3a-f70d-48cc-9ce0-00198bcef5a0"
          },
          "data": {
            "type": "customers",
            "id": "eaec2a3a-f70d-48cc-9ce0-00198bcef5a0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "eaec2a3a-f70d-48cc-9ce0-00198bcef5a0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-07T18:43:34+00:00",
        "updated_at": "2023-12-07T18:43:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-82@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=eaec2a3a-f70d-48cc-9ce0-00198bcef5a0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=eaec2a3a-f70d-48cc-9ce0-00198bcef5a0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=eaec2a3a-f70d-48cc-9ce0-00198bcef5a0&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`





