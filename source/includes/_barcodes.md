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
      "id": "0461a6c2-73e8-4e48-a95f-f7442a23e857",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T11:08:57+00:00",
        "updated_at": "2023-02-03T11:08:57+00:00",
        "number": "http://bqbl.it/0461a6c2-73e8-4e48-a95f-f7442a23e857",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f6b4e9eaeda42d02eab70afdc9718789/barcode/image/0461a6c2-73e8-4e48-a95f-f7442a23e857/9f67cea5-468a-4386-9573-29486670c11f.svg",
        "owner_id": "af75eeba-8b89-4c9e-bf6c-d6c3a5b35283",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/af75eeba-8b89-4c9e-bf6c-d6c3a5b35283"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff51d0ece-d14a-44a1-a257-bc4aa292e1f8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f51d0ece-d14a-44a1-a257-bc4aa292e1f8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T11:08:59+00:00",
        "updated_at": "2023-02-03T11:08:59+00:00",
        "number": "http://bqbl.it/f51d0ece-d14a-44a1-a257-bc4aa292e1f8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e11060034ae7f154db0d36468ea43e11/barcode/image/f51d0ece-d14a-44a1-a257-bc4aa292e1f8/65dc353a-3e85-4931-a0ab-2bc321d3cf11.svg",
        "owner_id": "cc4d9ad6-4b06-488f-bf7b-684cb6c261e4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cc4d9ad6-4b06-488f-bf7b-684cb6c261e4"
          },
          "data": {
            "type": "customers",
            "id": "cc4d9ad6-4b06-488f-bf7b-684cb6c261e4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cc4d9ad6-4b06-488f-bf7b-684cb6c261e4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T11:08:59+00:00",
        "updated_at": "2023-02-03T11:08:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cc4d9ad6-4b06-488f-bf7b-684cb6c261e4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cc4d9ad6-4b06-488f-bf7b-684cb6c261e4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cc4d9ad6-4b06-488f-bf7b-684cb6c261e4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTdjYmMxNjctZDI5OS00YmUyLWI3ZTQtNDU0ZjJlMjBhYWVj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "57cbc167-d299-4be2-b7e4-454f2e20aaec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T11:09:03+00:00",
        "updated_at": "2023-02-03T11:09:03+00:00",
        "number": "http://bqbl.it/57cbc167-d299-4be2-b7e4-454f2e20aaec",
        "barcode_type": "qr_code",
        "image_url": "/uploads/edc155631bdab59b1210eae588375450/barcode/image/57cbc167-d299-4be2-b7e4-454f2e20aaec/eda697a6-2fbd-4df0-9bc3-37e56572fc2c.svg",
        "owner_id": "cc902859-111f-45e1-a486-a8f7db64f920",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cc902859-111f-45e1-a486-a8f7db64f920"
          },
          "data": {
            "type": "customers",
            "id": "cc902859-111f-45e1-a486-a8f7db64f920"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cc902859-111f-45e1-a486-a8f7db64f920",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T11:09:03+00:00",
        "updated_at": "2023-02-03T11:09:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cc902859-111f-45e1-a486-a8f7db64f920&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cc902859-111f-45e1-a486-a8f7db64f920&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cc902859-111f-45e1-a486-a8f7db64f920&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:08:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a7ba5dd4-4a66-4f5e-93b8-9aacfdfa830d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a7ba5dd4-4a66-4f5e-93b8-9aacfdfa830d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T11:09:04+00:00",
      "updated_at": "2023-02-03T11:09:04+00:00",
      "number": "http://bqbl.it/a7ba5dd4-4a66-4f5e-93b8-9aacfdfa830d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f32a47db4cde29d3091695ba6df1b005/barcode/image/a7ba5dd4-4a66-4f5e-93b8-9aacfdfa830d/5c0a34a9-08e7-4f40-bc75-e170e5b0846b.svg",
      "owner_id": "e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8"
        },
        "data": {
          "type": "customers",
          "id": "e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8"
        }
      }
    }
  },
  "included": [
    {
      "id": "e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T11:09:04+00:00",
        "updated_at": "2023-02-03T11:09:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e9f3ff83-cd09-4180-bc0e-d2e65fd4cab8&filter[owner_type]=customers"
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
          "owner_id": "528d8d34-f42c-4405-838e-7a06b48eaf8c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4aa962ee-4b2d-4653-94a7-c7e8b86b0a8a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T11:09:04+00:00",
      "updated_at": "2023-02-03T11:09:04+00:00",
      "number": "http://bqbl.it/4aa962ee-4b2d-4653-94a7-c7e8b86b0a8a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8415fb504f07040555401228bea74b4c/barcode/image/4aa962ee-4b2d-4653-94a7-c7e8b86b0a8a/a8ffc9fc-552b-4f25-a632-7dacdf9662f1.svg",
      "owner_id": "528d8d34-f42c-4405-838e-7a06b48eaf8c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1db3c2bc-6c57-4416-a815-9c6ab9baafcd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1db3c2bc-6c57-4416-a815-9c6ab9baafcd",
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
    "id": "1db3c2bc-6c57-4416-a815-9c6ab9baafcd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T11:09:05+00:00",
      "updated_at": "2023-02-03T11:09:05+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6cb014ece7cb35c49e284112d65d8ec8/barcode/image/1db3c2bc-6c57-4416-a815-9c6ab9baafcd/198251f3-7567-4ccf-9f06-efdb325e9bac.svg",
      "owner_id": "4a0243dd-53b8-47c4-8859-a97c2be9eabe",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2f70e7bc-7b6d-4a0a-ab2e-90667942da9e' \
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