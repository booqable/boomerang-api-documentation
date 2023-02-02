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
      "id": "7468f411-cb65-4089-a540-37ea9925fee1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T14:14:06+00:00",
        "updated_at": "2023-02-02T14:14:06+00:00",
        "number": "http://bqbl.it/7468f411-cb65-4089-a540-37ea9925fee1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/22275a64886f7e0c35ad6f060fa63dd0/barcode/image/7468f411-cb65-4089-a540-37ea9925fee1/b36aa18c-1a0c-459d-909f-88e10b6275c2.svg",
        "owner_id": "46ddeaf6-011c-4755-9182-e0466d6f08ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/46ddeaf6-011c-4755-9182-e0466d6f08ec"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1c2f0ed4-486b-4d1e-bc1e-a456d3614e5f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1c2f0ed4-486b-4d1e-bc1e-a456d3614e5f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T14:14:06+00:00",
        "updated_at": "2023-02-02T14:14:06+00:00",
        "number": "http://bqbl.it/1c2f0ed4-486b-4d1e-bc1e-a456d3614e5f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7d3dfffbd446a11ff60576b5c14ea9f8/barcode/image/1c2f0ed4-486b-4d1e-bc1e-a456d3614e5f/9b886b02-8fa2-4dcc-985c-eeeecca3289c.svg",
        "owner_id": "56191019-3ef1-4b93-bbef-7eb38e91ac5f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/56191019-3ef1-4b93-bbef-7eb38e91ac5f"
          },
          "data": {
            "type": "customers",
            "id": "56191019-3ef1-4b93-bbef-7eb38e91ac5f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "56191019-3ef1-4b93-bbef-7eb38e91ac5f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T14:14:06+00:00",
        "updated_at": "2023-02-02T14:14:06+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=56191019-3ef1-4b93-bbef-7eb38e91ac5f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=56191019-3ef1-4b93-bbef-7eb38e91ac5f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=56191019-3ef1-4b93-bbef-7eb38e91ac5f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWM4MWVlNDgtMzQwMy00MWZkLTlhOWUtMTc2ZDQzZTk0ZWRk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ec81ee48-3403-41fd-9a9e-176d43e94edd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T14:14:07+00:00",
        "updated_at": "2023-02-02T14:14:07+00:00",
        "number": "http://bqbl.it/ec81ee48-3403-41fd-9a9e-176d43e94edd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/90ba1248e534e446a89c5d17c753bd36/barcode/image/ec81ee48-3403-41fd-9a9e-176d43e94edd/f4d15f04-00a3-41cb-a4fe-5a05bd7ec342.svg",
        "owner_id": "c23973e3-e3ca-4db6-b417-85a875682c60",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c23973e3-e3ca-4db6-b417-85a875682c60"
          },
          "data": {
            "type": "customers",
            "id": "c23973e3-e3ca-4db6-b417-85a875682c60"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c23973e3-e3ca-4db6-b417-85a875682c60",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T14:14:07+00:00",
        "updated_at": "2023-02-02T14:14:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c23973e3-e3ca-4db6-b417-85a875682c60&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c23973e3-e3ca-4db6-b417-85a875682c60&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c23973e3-e3ca-4db6-b417-85a875682c60&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:13:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/44d80269-9765-4466-bd2c-a7975517124e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44d80269-9765-4466-bd2c-a7975517124e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T14:14:07+00:00",
      "updated_at": "2023-02-02T14:14:07+00:00",
      "number": "http://bqbl.it/44d80269-9765-4466-bd2c-a7975517124e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c2019325ce9dad8305958941bb5e8a3e/barcode/image/44d80269-9765-4466-bd2c-a7975517124e/5173c2bc-2ee5-4f3c-aa84-2f074aa77a49.svg",
      "owner_id": "33df492b-5b2e-45b5-8468-f413982761f7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/33df492b-5b2e-45b5-8468-f413982761f7"
        },
        "data": {
          "type": "customers",
          "id": "33df492b-5b2e-45b5-8468-f413982761f7"
        }
      }
    }
  },
  "included": [
    {
      "id": "33df492b-5b2e-45b5-8468-f413982761f7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T14:14:07+00:00",
        "updated_at": "2023-02-02T14:14:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=33df492b-5b2e-45b5-8468-f413982761f7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=33df492b-5b2e-45b5-8468-f413982761f7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=33df492b-5b2e-45b5-8468-f413982761f7&filter[owner_type]=customers"
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
          "owner_id": "4734ed4d-6efc-4033-b885-7b21d05d4ca1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2dcd42cf-5841-487a-9830-dfb7068b7106",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T14:14:09+00:00",
      "updated_at": "2023-02-02T14:14:09+00:00",
      "number": "http://bqbl.it/2dcd42cf-5841-487a-9830-dfb7068b7106",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1278ef91ecf8278afa8fb1f3c3b6c7af/barcode/image/2dcd42cf-5841-487a-9830-dfb7068b7106/cd81df3f-7ea3-4f59-93be-af3a349e2883.svg",
      "owner_id": "4734ed4d-6efc-4033-b885-7b21d05d4ca1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4a13838-7761-432d-a6f5-88c099152367' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c4a13838-7761-432d-a6f5-88c099152367",
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
    "id": "c4a13838-7761-432d-a6f5-88c099152367",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T14:14:09+00:00",
      "updated_at": "2023-02-02T14:14:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2a0a723c2993a027e40de1f94e6295bd/barcode/image/c4a13838-7761-432d-a6f5-88c099152367/a8eba8e9-0604-4a31-9a5f-04581c62d18d.svg",
      "owner_id": "2105af04-7289-4269-9818-5781c731099d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b6c4a0bf-7113-4f72-b908-899987c30b1b' \
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