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

`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

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


## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F66d5b4a9-1e92-4e37-8bde-b09137656062&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "66d5b4a9-1e92-4e37-8bde-b09137656062",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-15T09:27:52+00:00",
        "updated_at": "2024-04-15T09:27:52+00:00",
        "number": "http://bqbl.it/66d5b4a9-1e92-4e37-8bde-b09137656062",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-229.lvh.me:/barcodes/66d5b4a9-1e92-4e37-8bde-b09137656062/image",
        "owner_id": "061d8026-a40a-4a9f-8cad-f12b752bc3e6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/061d8026-a40a-4a9f-8cad-f12b752bc3e6"
          },
          "data": {
            "type": "customers",
            "id": "061d8026-a40a-4a9f-8cad-f12b752bc3e6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "061d8026-a40a-4a9f-8cad-f12b752bc3e6",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-15T09:27:52+00:00",
        "updated_at": "2024-04-15T09:27:52+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-65@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=061d8026-a40a-4a9f-8cad-f12b752bc3e6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=061d8026-a40a-4a9f-8cad-f12b752bc3e6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=061d8026-a40a-4a9f-8cad-f12b752bc3e6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTc1YjNhMjYtOWEzMC00ZTlhLWE3OTUtM2JlNTg1NDllOTEy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a75b3a26-9a30-4e9a-a795-3be58549e912",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-15T09:27:53+00:00",
        "updated_at": "2024-04-15T09:27:53+00:00",
        "number": "http://bqbl.it/a75b3a26-9a30-4e9a-a795-3be58549e912",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-230.lvh.me:/barcodes/a75b3a26-9a30-4e9a-a795-3be58549e912/image",
        "owner_id": "9c76ebae-26ef-4691-b464-cbd747f1fb07",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9c76ebae-26ef-4691-b464-cbd747f1fb07"
          },
          "data": {
            "type": "customers",
            "id": "9c76ebae-26ef-4691-b464-cbd747f1fb07"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9c76ebae-26ef-4691-b464-cbd747f1fb07",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-15T09:27:53+00:00",
        "updated_at": "2024-04-15T09:27:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-67@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=9c76ebae-26ef-4691-b464-cbd747f1fb07&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9c76ebae-26ef-4691-b464-cbd747f1fb07&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9c76ebae-26ef-4691-b464-cbd747f1fb07&filter[owner_type]=customers"
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
      "id": "0db95860-9624-4fb3-8eff-8ac465a58dcd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-15T09:27:53+00:00",
        "updated_at": "2024-04-15T09:27:53+00:00",
        "number": "http://bqbl.it/0db95860-9624-4fb3-8eff-8ac465a58dcd",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-231.lvh.me:/barcodes/0db95860-9624-4fb3-8eff-8ac465a58dcd/image",
        "owner_id": "0c378061-893d-48a7-8c38-13022c4e8462",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0c378061-893d-48a7-8c38-13022c4e8462"
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
          "owner_id": "efb9272f-9f41-4e61-81fd-2b785652d700",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "efa9b99b-5101-477c-9109-27fa50d51736",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-15T09:27:54+00:00",
      "updated_at": "2024-04-15T09:27:54+00:00",
      "number": "http://bqbl.it/efa9b99b-5101-477c-9109-27fa50d51736",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-232.lvh.me:/barcodes/efa9b99b-5101-477c-9109-27fa50d51736/image",
      "owner_id": "efb9272f-9f41-4e61-81fd-2b785652d700",
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b27d037b-ce1b-4e4c-8a57-f081b8855178' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b27d037b-ce1b-4e4c-8a57-f081b8855178",
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
    "id": "b27d037b-ce1b-4e4c-8a57-f081b8855178",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-15T09:27:55+00:00",
      "updated_at": "2024-04-15T09:27:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-233.lvh.me:/barcodes/b27d037b-ce1b-4e4c-8a57-f081b8855178/image",
      "owner_id": "ca064645-d31e-41fe-868e-0b70f0675ac1",
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






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/8162cc16-4295-413e-9d6d-8239e17000cf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8162cc16-4295-413e-9d6d-8239e17000cf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-15T09:27:55+00:00",
      "updated_at": "2024-04-15T09:27:55+00:00",
      "number": "http://bqbl.it/8162cc16-4295-413e-9d6d-8239e17000cf",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-234.lvh.me:/barcodes/8162cc16-4295-413e-9d6d-8239e17000cf/image",
      "owner_id": "c06323ad-cc4f-47b5-bb20-e8d7c6292907",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c06323ad-cc4f-47b5-bb20-e8d7c6292907"
        },
        "data": {
          "type": "customers",
          "id": "c06323ad-cc4f-47b5-bb20-e8d7c6292907"
        }
      }
    }
  },
  "included": [
    {
      "id": "c06323ad-cc4f-47b5-bb20-e8d7c6292907",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-15T09:27:55+00:00",
        "updated_at": "2024-04-15T09:27:55+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-72@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=c06323ad-cc4f-47b5-bb20-e8d7c6292907&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c06323ad-cc4f-47b5-bb20-e8d7c6292907&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c06323ad-cc4f-47b5-bb20-e8d7c6292907&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a19a7ae4-b500-40a5-b2a5-ff509a66e32d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a19a7ae4-b500-40a5-b2a5-ff509a66e32d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-15T09:27:56+00:00",
      "updated_at": "2024-04-15T09:27:56+00:00",
      "number": "http://bqbl.it/a19a7ae4-b500-40a5-b2a5-ff509a66e32d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-235.lvh.me:/barcodes/a19a7ae4-b500-40a5-b2a5-ff509a66e32d/image",
      "owner_id": "2d52e9a3-d494-4ab5-add4-a6f49a64594f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2d52e9a3-d494-4ab5-add4-a6f49a64594f"
        }
      }
    }
  },
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