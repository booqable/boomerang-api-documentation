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
      "id": "3f7701de-9130-48c1-bfe1-c21b6e0b8d67",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T10:19:13+00:00",
        "updated_at": "2023-01-26T10:19:13+00:00",
        "number": "http://bqbl.it/3f7701de-9130-48c1-bfe1-c21b6e0b8d67",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7e5a1406c54374fd3f3d99e4ea933f45/barcode/image/3f7701de-9130-48c1-bfe1-c21b6e0b8d67/449b9718-1295-459f-b63d-8d88b0541cce.svg",
        "owner_id": "6e9c6004-89c3-4ea3-a0dd-6556be22bcd5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6e9c6004-89c3-4ea3-a0dd-6556be22bcd5"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F655aa465-0472-4c87-8de7-d7049f580141&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "655aa465-0472-4c87-8de7-d7049f580141",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T10:19:14+00:00",
        "updated_at": "2023-01-26T10:19:14+00:00",
        "number": "http://bqbl.it/655aa465-0472-4c87-8de7-d7049f580141",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6ad2342f7712654406d54a90e1b48159/barcode/image/655aa465-0472-4c87-8de7-d7049f580141/86bad132-0b23-4fbb-85d8-d16a781ef197.svg",
        "owner_id": "480c02b7-0aaa-4538-a533-00e17c6a34f8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/480c02b7-0aaa-4538-a533-00e17c6a34f8"
          },
          "data": {
            "type": "customers",
            "id": "480c02b7-0aaa-4538-a533-00e17c6a34f8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "480c02b7-0aaa-4538-a533-00e17c6a34f8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T10:19:14+00:00",
        "updated_at": "2023-01-26T10:19:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=480c02b7-0aaa-4538-a533-00e17c6a34f8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=480c02b7-0aaa-4538-a533-00e17c6a34f8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=480c02b7-0aaa-4538-a533-00e17c6a34f8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjJlMjgyNWItZTMwMi00ZTIyLWIxNmYtYzhjMjRhMGViYzJk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "62e2825b-e302-4e22-b16f-c8c24a0ebc2d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-26T10:19:15+00:00",
        "updated_at": "2023-01-26T10:19:15+00:00",
        "number": "http://bqbl.it/62e2825b-e302-4e22-b16f-c8c24a0ebc2d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8ff250fe7a056f7a296311895574a443/barcode/image/62e2825b-e302-4e22-b16f-c8c24a0ebc2d/7efc40ec-794f-42e1-87bb-448af4af2e5a.svg",
        "owner_id": "96c238be-6597-4b25-ae7b-f14f804e6f31",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96c238be-6597-4b25-ae7b-f14f804e6f31"
          },
          "data": {
            "type": "customers",
            "id": "96c238be-6597-4b25-ae7b-f14f804e6f31"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "96c238be-6597-4b25-ae7b-f14f804e6f31",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T10:19:15+00:00",
        "updated_at": "2023-01-26T10:19:15+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=96c238be-6597-4b25-ae7b-f14f804e6f31&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=96c238be-6597-4b25-ae7b-f14f804e6f31&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=96c238be-6597-4b25-ae7b-f14f804e6f31&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T10:18:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c2a548ee-7da4-4917-a379-dea465d46f00?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c2a548ee-7da4-4917-a379-dea465d46f00",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T10:19:15+00:00",
      "updated_at": "2023-01-26T10:19:15+00:00",
      "number": "http://bqbl.it/c2a548ee-7da4-4917-a379-dea465d46f00",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0e8f97c6e6b135c66371f5c7a45ad2d5/barcode/image/c2a548ee-7da4-4917-a379-dea465d46f00/989c0d29-4ec9-4f37-8ccb-496edd273473.svg",
      "owner_id": "f27688be-6b37-48b2-a625-60cd981a8a5d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f27688be-6b37-48b2-a625-60cd981a8a5d"
        },
        "data": {
          "type": "customers",
          "id": "f27688be-6b37-48b2-a625-60cd981a8a5d"
        }
      }
    }
  },
  "included": [
    {
      "id": "f27688be-6b37-48b2-a625-60cd981a8a5d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-26T10:19:15+00:00",
        "updated_at": "2023-01-26T10:19:15+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f27688be-6b37-48b2-a625-60cd981a8a5d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f27688be-6b37-48b2-a625-60cd981a8a5d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f27688be-6b37-48b2-a625-60cd981a8a5d&filter[owner_type]=customers"
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
          "owner_id": "7f178adb-3411-4563-824f-c4e4605832f9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "011887dd-8ea6-40c1-a90f-aae791e9419b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T10:19:16+00:00",
      "updated_at": "2023-01-26T10:19:16+00:00",
      "number": "http://bqbl.it/011887dd-8ea6-40c1-a90f-aae791e9419b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e1080ffbf3d53236b7b6b8e606690de6/barcode/image/011887dd-8ea6-40c1-a90f-aae791e9419b/f118159b-2c72-44c7-9122-843c87e37915.svg",
      "owner_id": "7f178adb-3411-4563-824f-c4e4605832f9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0f72c960-84a4-49a6-8b5f-74efe69b220b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0f72c960-84a4-49a6-8b5f-74efe69b220b",
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
    "id": "0f72c960-84a4-49a6-8b5f-74efe69b220b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-26T10:19:16+00:00",
      "updated_at": "2023-01-26T10:19:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/893476c07e1515c5327d9240c07bb6c9/barcode/image/0f72c960-84a4-49a6-8b5f-74efe69b220b/460873fe-5f92-4706-a26e-9a0bf9329513.svg",
      "owner_id": "a1d07df1-7404-432b-ad5a-c23c8541c87e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4d2156e-6337-4ad3-a2f8-5051ad19e1fd' \
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