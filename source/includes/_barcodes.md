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
      "id": "0d4b5b9e-bea1-4d3b-a589-b290d1754715",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T13:08:33+00:00",
        "updated_at": "2023-02-03T13:08:33+00:00",
        "number": "http://bqbl.it/0d4b5b9e-bea1-4d3b-a589-b290d1754715",
        "barcode_type": "qr_code",
        "image_url": "/uploads/26696e9616fad8fdbb733860fa66d007/barcode/image/0d4b5b9e-bea1-4d3b-a589-b290d1754715/82a40acf-ed4d-413e-8e76-605a86200dfd.svg",
        "owner_id": "c1dc65fc-c517-4f96-a112-08c303e43967",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c1dc65fc-c517-4f96-a112-08c303e43967"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6dfca72a-572f-4a63-a6c8-d52f5a2ed732&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6dfca72a-572f-4a63-a6c8-d52f5a2ed732",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T13:08:33+00:00",
        "updated_at": "2023-02-03T13:08:33+00:00",
        "number": "http://bqbl.it/6dfca72a-572f-4a63-a6c8-d52f5a2ed732",
        "barcode_type": "qr_code",
        "image_url": "/uploads/59ddf6516a3f44cba7b6c5ed0e33340d/barcode/image/6dfca72a-572f-4a63-a6c8-d52f5a2ed732/71d2901b-16b8-412e-943c-d2b2ff4d7c31.svg",
        "owner_id": "a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7"
          },
          "data": {
            "type": "customers",
            "id": "a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T13:08:33+00:00",
        "updated_at": "2023-02-03T13:08:33+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a918e7af-d11c-4fa9-bc22-df7ea4e7e1d7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjgxMDAyN2EtODU3My00MGViLTg3Y2QtODcxOTQ2ODAxMWJm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f810027a-8573-40eb-87cd-8719468011bf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T13:08:34+00:00",
        "updated_at": "2023-02-03T13:08:34+00:00",
        "number": "http://bqbl.it/f810027a-8573-40eb-87cd-8719468011bf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6b8be600c6f3e9e396c63e671d9bba58/barcode/image/f810027a-8573-40eb-87cd-8719468011bf/839f33d9-af26-44ea-a932-f4345d990b96.svg",
        "owner_id": "5efa5e39-af82-46e4-b3e3-da8fcbee28be",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5efa5e39-af82-46e4-b3e3-da8fcbee28be"
          },
          "data": {
            "type": "customers",
            "id": "5efa5e39-af82-46e4-b3e3-da8fcbee28be"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5efa5e39-af82-46e4-b3e3-da8fcbee28be",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T13:08:34+00:00",
        "updated_at": "2023-02-03T13:08:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5efa5e39-af82-46e4-b3e3-da8fcbee28be&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5efa5e39-af82-46e4-b3e3-da8fcbee28be&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5efa5e39-af82-46e4-b3e3-da8fcbee28be&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T13:08:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d2421ab2-1cde-4998-9811-2d51416f58ef?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d2421ab2-1cde-4998-9811-2d51416f58ef",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T13:08:34+00:00",
      "updated_at": "2023-02-03T13:08:34+00:00",
      "number": "http://bqbl.it/d2421ab2-1cde-4998-9811-2d51416f58ef",
      "barcode_type": "qr_code",
      "image_url": "/uploads/caf28c364bc3bd3d943fe08fc651a2e3/barcode/image/d2421ab2-1cde-4998-9811-2d51416f58ef/3d087acf-3d48-4da5-831a-6f0a0b3ed8fe.svg",
      "owner_id": "883983fa-969b-4018-8c55-0e6d24badd73",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/883983fa-969b-4018-8c55-0e6d24badd73"
        },
        "data": {
          "type": "customers",
          "id": "883983fa-969b-4018-8c55-0e6d24badd73"
        }
      }
    }
  },
  "included": [
    {
      "id": "883983fa-969b-4018-8c55-0e6d24badd73",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T13:08:34+00:00",
        "updated_at": "2023-02-03T13:08:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=883983fa-969b-4018-8c55-0e6d24badd73&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=883983fa-969b-4018-8c55-0e6d24badd73&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=883983fa-969b-4018-8c55-0e6d24badd73&filter[owner_type]=customers"
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
          "owner_id": "b7aa7aad-be81-4425-956b-1b6bcb540e62",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5247cac1-ad03-4f7f-be90-c7d297386c5f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T13:08:35+00:00",
      "updated_at": "2023-02-03T13:08:35+00:00",
      "number": "http://bqbl.it/5247cac1-ad03-4f7f-be90-c7d297386c5f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5b10a63236e115d37806bd4d8c14949a/barcode/image/5247cac1-ad03-4f7f-be90-c7d297386c5f/63388e2b-4580-4211-8886-0ee4c5c6f901.svg",
      "owner_id": "b7aa7aad-be81-4425-956b-1b6bcb540e62",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df3ff934-9c87-483b-9307-9eb63fe8527d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "df3ff934-9c87-483b-9307-9eb63fe8527d",
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
    "id": "df3ff934-9c87-483b-9307-9eb63fe8527d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T13:08:35+00:00",
      "updated_at": "2023-02-03T13:08:35+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4b410a8b07ac7b7ed41cae359dc73e81/barcode/image/df3ff934-9c87-483b-9307-9eb63fe8527d/1ac2dcbc-e89e-4147-9687-17b9aa2c3308.svg",
      "owner_id": "b2b2eec2-2d87-41c0-8db4-b32b73e34932",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/85f57db9-7603-4379-b54d-5db66b93c748' \
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