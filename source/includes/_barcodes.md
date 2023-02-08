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
      "id": "dded78fa-403f-4ea6-a94b-17ea09d3a1bb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T15:17:38+00:00",
        "updated_at": "2023-02-08T15:17:38+00:00",
        "number": "http://bqbl.it/dded78fa-403f-4ea6-a94b-17ea09d3a1bb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1ac345d916e6913f93ebc0f53e5ccabb/barcode/image/dded78fa-403f-4ea6-a94b-17ea09d3a1bb/30ef3b27-85ad-4f48-bc33-e795a60911eb.svg",
        "owner_id": "0f1e9501-b6f9-47cf-980f-2671a5fd823f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0f1e9501-b6f9-47cf-980f-2671a5fd823f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffbf36a57-5189-4343-8507-8ff55365eb50&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fbf36a57-5189-4343-8507-8ff55365eb50",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T15:17:39+00:00",
        "updated_at": "2023-02-08T15:17:39+00:00",
        "number": "http://bqbl.it/fbf36a57-5189-4343-8507-8ff55365eb50",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b15fed6bb6cba6958feed4017030bbb9/barcode/image/fbf36a57-5189-4343-8507-8ff55365eb50/d4738db3-0e4d-450f-9f33-7e2731432571.svg",
        "owner_id": "a00b1862-4c34-4b0f-af8d-e066709469c0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a00b1862-4c34-4b0f-af8d-e066709469c0"
          },
          "data": {
            "type": "customers",
            "id": "a00b1862-4c34-4b0f-af8d-e066709469c0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a00b1862-4c34-4b0f-af8d-e066709469c0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T15:17:39+00:00",
        "updated_at": "2023-02-08T15:17:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a00b1862-4c34-4b0f-af8d-e066709469c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a00b1862-4c34-4b0f-af8d-e066709469c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a00b1862-4c34-4b0f-af8d-e066709469c0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTg5YWY2ZDYtNjY2MS00ZWU3LWFmOGUtNzhiYTgwYjg1NTc3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e89af6d6-6661-4ee7-af8e-78ba80b85577",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T15:17:42+00:00",
        "updated_at": "2023-02-08T15:17:42+00:00",
        "number": "http://bqbl.it/e89af6d6-6661-4ee7-af8e-78ba80b85577",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3ee764b97d39430c104e045562f1c9e9/barcode/image/e89af6d6-6661-4ee7-af8e-78ba80b85577/bdf6c913-7e5c-4037-a846-db458b08d9f3.svg",
        "owner_id": "0b6d8d58-a12f-47c3-b28c-675f287e4b33",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0b6d8d58-a12f-47c3-b28c-675f287e4b33"
          },
          "data": {
            "type": "customers",
            "id": "0b6d8d58-a12f-47c3-b28c-675f287e4b33"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0b6d8d58-a12f-47c3-b28c-675f287e4b33",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T15:17:42+00:00",
        "updated_at": "2023-02-08T15:17:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0b6d8d58-a12f-47c3-b28c-675f287e4b33&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0b6d8d58-a12f-47c3-b28c-675f287e4b33&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0b6d8d58-a12f-47c3-b28c-675f287e4b33&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T15:17:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/10f90a7a-a9c2-4932-b5c0-87b54230a11a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "10f90a7a-a9c2-4932-b5c0-87b54230a11a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T15:17:42+00:00",
      "updated_at": "2023-02-08T15:17:42+00:00",
      "number": "http://bqbl.it/10f90a7a-a9c2-4932-b5c0-87b54230a11a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2890299be5242e2d9f38df16d075bad1/barcode/image/10f90a7a-a9c2-4932-b5c0-87b54230a11a/ed37fcab-916c-459f-980b-4b7b953f0450.svg",
      "owner_id": "043ce29f-3e36-41b6-8181-974c10c9eb4f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/043ce29f-3e36-41b6-8181-974c10c9eb4f"
        },
        "data": {
          "type": "customers",
          "id": "043ce29f-3e36-41b6-8181-974c10c9eb4f"
        }
      }
    }
  },
  "included": [
    {
      "id": "043ce29f-3e36-41b6-8181-974c10c9eb4f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T15:17:42+00:00",
        "updated_at": "2023-02-08T15:17:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=043ce29f-3e36-41b6-8181-974c10c9eb4f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=043ce29f-3e36-41b6-8181-974c10c9eb4f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=043ce29f-3e36-41b6-8181-974c10c9eb4f&filter[owner_type]=customers"
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
          "owner_id": "9e4850b2-5c9f-4193-9e06-2157142ff59a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8534291b-c3bb-42a9-b56f-29770ad5b2ee",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T15:17:43+00:00",
      "updated_at": "2023-02-08T15:17:43+00:00",
      "number": "http://bqbl.it/8534291b-c3bb-42a9-b56f-29770ad5b2ee",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e6e8a8b4b422f71b126b432b9f8510d4/barcode/image/8534291b-c3bb-42a9-b56f-29770ad5b2ee/a3cf5229-8455-4393-9204-db62d23b4809.svg",
      "owner_id": "9e4850b2-5c9f-4193-9e06-2157142ff59a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/03fb56e1-aa8e-43a7-85f7-bd4be6f004a2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "03fb56e1-aa8e-43a7-85f7-bd4be6f004a2",
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
    "id": "03fb56e1-aa8e-43a7-85f7-bd4be6f004a2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T15:17:44+00:00",
      "updated_at": "2023-02-08T15:17:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1fca7256a91dc5ed852714bfe391a47b/barcode/image/03fb56e1-aa8e-43a7-85f7-bd4be6f004a2/96dbb7e6-ebc2-47d2-bed2-b5eed30c23d0.svg",
      "owner_id": "db445a8b-46cb-4439-a07a-7cdffedb1720",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dfcf291e-4b1a-4d6e-ad51-43246ec821b4' \
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