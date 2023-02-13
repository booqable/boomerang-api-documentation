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
      "id": "ea6f4aaa-d9ab-4254-81c0-4e4d60ca874a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:52:17+00:00",
        "updated_at": "2023-02-13T12:52:17+00:00",
        "number": "http://bqbl.it/ea6f4aaa-d9ab-4254-81c0-4e4d60ca874a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dc94cfeef473cf3c6242407561d076d4/barcode/image/ea6f4aaa-d9ab-4254-81c0-4e4d60ca874a/c4783612-0d93-4751-afd1-acd332eae78d.svg",
        "owner_id": "ba659462-f6dc-4477-8a04-ebf2baedb750",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ba659462-f6dc-4477-8a04-ebf2baedb750"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4fdc0968-2bc9-40ef-aef9-7f4ca4092a9e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4fdc0968-2bc9-40ef-aef9-7f4ca4092a9e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:52:18+00:00",
        "updated_at": "2023-02-13T12:52:18+00:00",
        "number": "http://bqbl.it/4fdc0968-2bc9-40ef-aef9-7f4ca4092a9e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a74b9aad6cb4f442461c5d5cf90f7b15/barcode/image/4fdc0968-2bc9-40ef-aef9-7f4ca4092a9e/6c3999fc-3ece-4675-8c2f-a99eb47db6ab.svg",
        "owner_id": "e5260d66-e092-4b15-9f8c-f02e488ee8c3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e5260d66-e092-4b15-9f8c-f02e488ee8c3"
          },
          "data": {
            "type": "customers",
            "id": "e5260d66-e092-4b15-9f8c-f02e488ee8c3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e5260d66-e092-4b15-9f8c-f02e488ee8c3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:52:18+00:00",
        "updated_at": "2023-02-13T12:52:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e5260d66-e092-4b15-9f8c-f02e488ee8c3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e5260d66-e092-4b15-9f8c-f02e488ee8c3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e5260d66-e092-4b15-9f8c-f02e488ee8c3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzhmNjE0ZjItMTk4NC00OTJkLTk5NjctMDRlYjQ4Y2IzOWE2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "38f614f2-1984-492d-9967-04eb48cb39a6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:52:18+00:00",
        "updated_at": "2023-02-13T12:52:18+00:00",
        "number": "http://bqbl.it/38f614f2-1984-492d-9967-04eb48cb39a6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2480d9b7fdab06b8b0f815a94663e649/barcode/image/38f614f2-1984-492d-9967-04eb48cb39a6/e0a53db3-ae81-41a1-85e2-82f8a2274d97.svg",
        "owner_id": "70620dbd-20f3-4b72-8db3-7437acca6e5d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/70620dbd-20f3-4b72-8db3-7437acca6e5d"
          },
          "data": {
            "type": "customers",
            "id": "70620dbd-20f3-4b72-8db3-7437acca6e5d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "70620dbd-20f3-4b72-8db3-7437acca6e5d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:52:18+00:00",
        "updated_at": "2023-02-13T12:52:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=70620dbd-20f3-4b72-8db3-7437acca6e5d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=70620dbd-20f3-4b72-8db3-7437acca6e5d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=70620dbd-20f3-4b72-8db3-7437acca6e5d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:51:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e8c3cf34-c123-443f-8b9d-f5bb641cf3cb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e8c3cf34-c123-443f-8b9d-f5bb641cf3cb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:52:19+00:00",
      "updated_at": "2023-02-13T12:52:19+00:00",
      "number": "http://bqbl.it/e8c3cf34-c123-443f-8b9d-f5bb641cf3cb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/14d07ff6a9497a0425a516e4e19d9165/barcode/image/e8c3cf34-c123-443f-8b9d-f5bb641cf3cb/923cf042-9d25-4685-921a-a85b3b60a43f.svg",
      "owner_id": "730ff405-8aaf-4273-a946-519918693ae1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/730ff405-8aaf-4273-a946-519918693ae1"
        },
        "data": {
          "type": "customers",
          "id": "730ff405-8aaf-4273-a946-519918693ae1"
        }
      }
    }
  },
  "included": [
    {
      "id": "730ff405-8aaf-4273-a946-519918693ae1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:52:19+00:00",
        "updated_at": "2023-02-13T12:52:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=730ff405-8aaf-4273-a946-519918693ae1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=730ff405-8aaf-4273-a946-519918693ae1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=730ff405-8aaf-4273-a946-519918693ae1&filter[owner_type]=customers"
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
          "owner_id": "4ca987c9-e62d-4632-be5d-af6c66638941",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d0061456-6586-4613-b0a7-9db3e81efbde",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:52:20+00:00",
      "updated_at": "2023-02-13T12:52:20+00:00",
      "number": "http://bqbl.it/d0061456-6586-4613-b0a7-9db3e81efbde",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ebaff803284629eb2befc20616c9c696/barcode/image/d0061456-6586-4613-b0a7-9db3e81efbde/23f785f0-618f-4588-83f3-a9d542f69010.svg",
      "owner_id": "4ca987c9-e62d-4632-be5d-af6c66638941",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/30511870-2c01-4a2a-84dd-41862218e73d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "30511870-2c01-4a2a-84dd-41862218e73d",
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
    "id": "30511870-2c01-4a2a-84dd-41862218e73d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:52:20+00:00",
      "updated_at": "2023-02-13T12:52:20+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6799c72fdf64f43e0c38a271eeb291c8/barcode/image/30511870-2c01-4a2a-84dd-41862218e73d/b33b7ff2-9d87-49ef-a579-7e090dcfc015.svg",
      "owner_id": "1fd92c8b-4a14-40ef-9fec-ebc4b5ae2948",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/037b8292-aec2-4dd2-90fe-19cee98e8a2b' \
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