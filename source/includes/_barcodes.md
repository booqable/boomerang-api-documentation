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
      "id": "7ec15b70-56c7-4750-b00b-1bdf5c85e930",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T14:25:12+00:00",
        "updated_at": "2023-02-02T14:25:12+00:00",
        "number": "http://bqbl.it/7ec15b70-56c7-4750-b00b-1bdf5c85e930",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cd51d83e3c2002c492d98b36e70be91f/barcode/image/7ec15b70-56c7-4750-b00b-1bdf5c85e930/8a979433-aa3f-4d0a-8ad7-e0ae09931a65.svg",
        "owner_id": "8b10b60a-5e08-48fc-9d96-98954e9d01df",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8b10b60a-5e08-48fc-9d96-98954e9d01df"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7fcc2ab0-76a9-4b3b-9486-ae86942d4ce5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7fcc2ab0-76a9-4b3b-9486-ae86942d4ce5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T14:25:13+00:00",
        "updated_at": "2023-02-02T14:25:13+00:00",
        "number": "http://bqbl.it/7fcc2ab0-76a9-4b3b-9486-ae86942d4ce5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4eeed11bdda91b483462426d8249ecd1/barcode/image/7fcc2ab0-76a9-4b3b-9486-ae86942d4ce5/e0558f8a-a268-44b0-afac-c47c128a46dd.svg",
        "owner_id": "2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a"
          },
          "data": {
            "type": "customers",
            "id": "2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T14:25:13+00:00",
        "updated_at": "2023-02-02T14:25:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2804c8b2-68ff-4f7c-b69a-7dc9ed37fb1a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDI0YTFmNWMtOTk2OC00ZjA1LTlkMDUtNTUxMWEyYWZhODUz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "424a1f5c-9968-4f05-9d05-5511a2afa853",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T14:25:14+00:00",
        "updated_at": "2023-02-02T14:25:14+00:00",
        "number": "http://bqbl.it/424a1f5c-9968-4f05-9d05-5511a2afa853",
        "barcode_type": "qr_code",
        "image_url": "/uploads/785d77962fed9d36ecee60bb59e8c145/barcode/image/424a1f5c-9968-4f05-9d05-5511a2afa853/3d8de424-9d5b-4067-a745-812b5dd5dac1.svg",
        "owner_id": "2a6c4500-1ca1-4b55-9bfe-b42a71472149",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2a6c4500-1ca1-4b55-9bfe-b42a71472149"
          },
          "data": {
            "type": "customers",
            "id": "2a6c4500-1ca1-4b55-9bfe-b42a71472149"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2a6c4500-1ca1-4b55-9bfe-b42a71472149",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T14:25:13+00:00",
        "updated_at": "2023-02-02T14:25:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2a6c4500-1ca1-4b55-9bfe-b42a71472149&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2a6c4500-1ca1-4b55-9bfe-b42a71472149&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2a6c4500-1ca1-4b55-9bfe-b42a71472149&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:24:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e858022d-fce8-4551-afd8-a59b28e76147?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e858022d-fce8-4551-afd8-a59b28e76147",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T14:25:14+00:00",
      "updated_at": "2023-02-02T14:25:14+00:00",
      "number": "http://bqbl.it/e858022d-fce8-4551-afd8-a59b28e76147",
      "barcode_type": "qr_code",
      "image_url": "/uploads/22ae966dfbaace9a3927930cc9d614e9/barcode/image/e858022d-fce8-4551-afd8-a59b28e76147/068d9eb1-fba7-4a42-9561-edc1e1ea389d.svg",
      "owner_id": "448bf0c6-90e1-4a18-8333-949f1591520c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/448bf0c6-90e1-4a18-8333-949f1591520c"
        },
        "data": {
          "type": "customers",
          "id": "448bf0c6-90e1-4a18-8333-949f1591520c"
        }
      }
    }
  },
  "included": [
    {
      "id": "448bf0c6-90e1-4a18-8333-949f1591520c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T14:25:14+00:00",
        "updated_at": "2023-02-02T14:25:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=448bf0c6-90e1-4a18-8333-949f1591520c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=448bf0c6-90e1-4a18-8333-949f1591520c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=448bf0c6-90e1-4a18-8333-949f1591520c&filter[owner_type]=customers"
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
          "owner_id": "a01bb4cf-6cb0-45fe-8213-41f94639ad06",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "97001c2c-219c-4413-b3d4-91df484eda33",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T14:25:15+00:00",
      "updated_at": "2023-02-02T14:25:15+00:00",
      "number": "http://bqbl.it/97001c2c-219c-4413-b3d4-91df484eda33",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7705e876b2be40b8ffa60b94ef3cdd29/barcode/image/97001c2c-219c-4413-b3d4-91df484eda33/38af95b5-03cb-4eb6-96e7-18fe1719cca5.svg",
      "owner_id": "a01bb4cf-6cb0-45fe-8213-41f94639ad06",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0c16122c-ce4d-4a5b-b34f-f5b05ce2b549' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0c16122c-ce4d-4a5b-b34f-f5b05ce2b549",
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
    "id": "0c16122c-ce4d-4a5b-b34f-f5b05ce2b549",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T14:25:16+00:00",
      "updated_at": "2023-02-02T14:25:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fd5136ffea6ccf6a36185cfab739b663/barcode/image/0c16122c-ce4d-4a5b-b34f-f5b05ce2b549/9b813568-48c8-4015-85c7-8fe3cfb9f0cb.svg",
      "owner_id": "ea77121a-760a-4a4d-baaa-f536a87aafcf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/77db78cf-678f-43f9-8636-13534daf2d27' \
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