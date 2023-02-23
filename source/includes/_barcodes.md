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
      "id": "b66b5871-137a-4c9e-b8cc-2002a0c1271d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T13:49:39+00:00",
        "updated_at": "2023-02-23T13:49:39+00:00",
        "number": "http://bqbl.it/b66b5871-137a-4c9e-b8cc-2002a0c1271d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/89bd475227c1fb7485f35ecd34ca1e05/barcode/image/b66b5871-137a-4c9e-b8cc-2002a0c1271d/7927ab6e-c6f0-4eb4-b423-72bc6f10f414.svg",
        "owner_id": "b53c56dd-f5e7-4c16-9589-446c673a1816",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b53c56dd-f5e7-4c16-9589-446c673a1816"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F35553589-c478-4426-b4f3-19c1915e0999&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "35553589-c478-4426-b4f3-19c1915e0999",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T13:49:39+00:00",
        "updated_at": "2023-02-23T13:49:39+00:00",
        "number": "http://bqbl.it/35553589-c478-4426-b4f3-19c1915e0999",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a6783b65bd2df7c100410b05da403d2e/barcode/image/35553589-c478-4426-b4f3-19c1915e0999/ad983640-3f16-44a7-9eb0-ecb3cd1cd08a.svg",
        "owner_id": "dff0b998-3d9b-4227-8232-2d78f48b8ff8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dff0b998-3d9b-4227-8232-2d78f48b8ff8"
          },
          "data": {
            "type": "customers",
            "id": "dff0b998-3d9b-4227-8232-2d78f48b8ff8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dff0b998-3d9b-4227-8232-2d78f48b8ff8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T13:49:39+00:00",
        "updated_at": "2023-02-23T13:49:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=dff0b998-3d9b-4227-8232-2d78f48b8ff8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dff0b998-3d9b-4227-8232-2d78f48b8ff8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dff0b998-3d9b-4227-8232-2d78f48b8ff8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWNiNTg1ZDctNjA3ZC00MjRhLWJiZjEtOWY4NzEwMjc4ZDM2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "acb585d7-607d-424a-bbf1-9f8710278d36",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T13:49:40+00:00",
        "updated_at": "2023-02-23T13:49:40+00:00",
        "number": "http://bqbl.it/acb585d7-607d-424a-bbf1-9f8710278d36",
        "barcode_type": "qr_code",
        "image_url": "/uploads/55c3fb07fc66c09c06fa16fb34cc8462/barcode/image/acb585d7-607d-424a-bbf1-9f8710278d36/5e4d12c8-dec9-4587-a5f7-b8f580a70658.svg",
        "owner_id": "1780b61f-c5b0-428e-991e-6946a15d94a4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1780b61f-c5b0-428e-991e-6946a15d94a4"
          },
          "data": {
            "type": "customers",
            "id": "1780b61f-c5b0-428e-991e-6946a15d94a4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1780b61f-c5b0-428e-991e-6946a15d94a4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T13:49:40+00:00",
        "updated_at": "2023-02-23T13:49:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1780b61f-c5b0-428e-991e-6946a15d94a4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1780b61f-c5b0-428e-991e-6946a15d94a4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1780b61f-c5b0-428e-991e-6946a15d94a4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:49:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f71e9efc-48dc-49fe-a1b5-419da8c14522?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f71e9efc-48dc-49fe-a1b5-419da8c14522",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T13:49:40+00:00",
      "updated_at": "2023-02-23T13:49:40+00:00",
      "number": "http://bqbl.it/f71e9efc-48dc-49fe-a1b5-419da8c14522",
      "barcode_type": "qr_code",
      "image_url": "/uploads/05faa8c81fa7c750bb2bcaaa74c83474/barcode/image/f71e9efc-48dc-49fe-a1b5-419da8c14522/765a8bb5-4acc-4cde-ad60-034cdd4d70ac.svg",
      "owner_id": "c9ba524d-daca-435b-a388-242bcd2fa62a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c9ba524d-daca-435b-a388-242bcd2fa62a"
        },
        "data": {
          "type": "customers",
          "id": "c9ba524d-daca-435b-a388-242bcd2fa62a"
        }
      }
    }
  },
  "included": [
    {
      "id": "c9ba524d-daca-435b-a388-242bcd2fa62a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T13:49:40+00:00",
        "updated_at": "2023-02-23T13:49:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c9ba524d-daca-435b-a388-242bcd2fa62a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c9ba524d-daca-435b-a388-242bcd2fa62a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c9ba524d-daca-435b-a388-242bcd2fa62a&filter[owner_type]=customers"
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
          "owner_id": "9d6b33c2-8eb7-40ac-971a-2f7816736330",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "143e97d5-a8f4-44ff-bd51-63634542e2c0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T13:49:41+00:00",
      "updated_at": "2023-02-23T13:49:41+00:00",
      "number": "http://bqbl.it/143e97d5-a8f4-44ff-bd51-63634542e2c0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/04da889a7bb798dbe067d1f4de446909/barcode/image/143e97d5-a8f4-44ff-bd51-63634542e2c0/ce982f53-8b73-4d17-b4c4-d21812bbf8fb.svg",
      "owner_id": "9d6b33c2-8eb7-40ac-971a-2f7816736330",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/00af32b9-e626-47a9-902d-f933331504f5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "00af32b9-e626-47a9-902d-f933331504f5",
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
    "id": "00af32b9-e626-47a9-902d-f933331504f5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T13:49:42+00:00",
      "updated_at": "2023-02-23T13:49:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/803230a6948871fb11206714c3410189/barcode/image/00af32b9-e626-47a9-902d-f933331504f5/95188ef4-5b5d-4b60-af66-3ac1ceba7f15.svg",
      "owner_id": "a983fc12-05c0-4d26-9786-d6ace24e4a46",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/74f9e955-abfe-4413-9fd4-7bf1615a9c6b' \
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