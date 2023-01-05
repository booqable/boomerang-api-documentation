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
      "id": "4a80342c-ba48-467e-9c0f-1715a65d4df8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:01:49+00:00",
        "updated_at": "2023-01-05T13:01:49+00:00",
        "number": "http://bqbl.it/4a80342c-ba48-467e-9c0f-1715a65d4df8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/60d84d93b83a639608376554864e86c5/barcode/image/4a80342c-ba48-467e-9c0f-1715a65d4df8/cdfb8103-be64-46b3-b0ab-cd995079462f.svg",
        "owner_id": "d2562528-63ee-42bd-a196-5754b0ecd3ad",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d2562528-63ee-42bd-a196-5754b0ecd3ad"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe9db3aef-de2e-4e2a-9910-98d97597da6b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e9db3aef-de2e-4e2a-9910-98d97597da6b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:01:50+00:00",
        "updated_at": "2023-01-05T13:01:50+00:00",
        "number": "http://bqbl.it/e9db3aef-de2e-4e2a-9910-98d97597da6b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/de5a67f5572636a8f7e41a9d297bcd54/barcode/image/e9db3aef-de2e-4e2a-9910-98d97597da6b/bbcb7263-76fa-40b2-ab7c-cebba98f13fd.svg",
        "owner_id": "01f24b62-110f-4304-b696-6e0d4a765c6c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/01f24b62-110f-4304-b696-6e0d4a765c6c"
          },
          "data": {
            "type": "customers",
            "id": "01f24b62-110f-4304-b696-6e0d4a765c6c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "01f24b62-110f-4304-b696-6e0d4a765c6c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:01:50+00:00",
        "updated_at": "2023-01-05T13:01:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=01f24b62-110f-4304-b696-6e0d4a765c6c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=01f24b62-110f-4304-b696-6e0d4a765c6c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=01f24b62-110f-4304-b696-6e0d4a765c6c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzIxOWNkOTAtNzQ3NC00M2UyLTliZjktZGU1NjdlZDljZWYy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7219cd90-7474-43e2-9bf9-de567ed9cef2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-05T13:01:50+00:00",
        "updated_at": "2023-01-05T13:01:50+00:00",
        "number": "http://bqbl.it/7219cd90-7474-43e2-9bf9-de567ed9cef2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d96ec5f32082315e21518a4e49090731/barcode/image/7219cd90-7474-43e2-9bf9-de567ed9cef2/decfdd79-a822-4b38-9db2-3fc71b38a5db.svg",
        "owner_id": "d49bca45-6813-428b-9e16-ce975c9f9202",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d49bca45-6813-428b-9e16-ce975c9f9202"
          },
          "data": {
            "type": "customers",
            "id": "d49bca45-6813-428b-9e16-ce975c9f9202"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d49bca45-6813-428b-9e16-ce975c9f9202",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:01:50+00:00",
        "updated_at": "2023-01-05T13:01:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d49bca45-6813-428b-9e16-ce975c9f9202&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d49bca45-6813-428b-9e16-ce975c9f9202&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d49bca45-6813-428b-9e16-ce975c9f9202&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:01:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6b1165fb-e1be-4f96-95f1-7776ece2cda2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b1165fb-e1be-4f96-95f1-7776ece2cda2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:01:51+00:00",
      "updated_at": "2023-01-05T13:01:51+00:00",
      "number": "http://bqbl.it/6b1165fb-e1be-4f96-95f1-7776ece2cda2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8bc1bf8e930c2bdc11f7c1cb88c3c441/barcode/image/6b1165fb-e1be-4f96-95f1-7776ece2cda2/de3d7531-9f6f-4a9a-877c-1ca3c032f790.svg",
      "owner_id": "b1a23492-d689-402d-9707-edf0a8b1efe4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b1a23492-d689-402d-9707-edf0a8b1efe4"
        },
        "data": {
          "type": "customers",
          "id": "b1a23492-d689-402d-9707-edf0a8b1efe4"
        }
      }
    }
  },
  "included": [
    {
      "id": "b1a23492-d689-402d-9707-edf0a8b1efe4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-05T13:01:51+00:00",
        "updated_at": "2023-01-05T13:01:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b1a23492-d689-402d-9707-edf0a8b1efe4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b1a23492-d689-402d-9707-edf0a8b1efe4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b1a23492-d689-402d-9707-edf0a8b1efe4&filter[owner_type]=customers"
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
          "owner_id": "0556430c-6c6b-46a4-9f47-0dc0f2d52c9c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1d6952cf-b7ce-481b-99f8-35161ddcc043",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:01:52+00:00",
      "updated_at": "2023-01-05T13:01:52+00:00",
      "number": "http://bqbl.it/1d6952cf-b7ce-481b-99f8-35161ddcc043",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0b6a56ecc5e9d3668e383cd9266a3ff2/barcode/image/1d6952cf-b7ce-481b-99f8-35161ddcc043/0cb19424-0591-40de-9865-60bb97a47ac7.svg",
      "owner_id": "0556430c-6c6b-46a4-9f47-0dc0f2d52c9c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a01901ba-2880-48ae-b613-49ac04012cf1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a01901ba-2880-48ae-b613-49ac04012cf1",
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
    "id": "a01901ba-2880-48ae-b613-49ac04012cf1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-05T13:01:53+00:00",
      "updated_at": "2023-01-05T13:01:53+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/42a8f5afad8b8af6150f6ef9acae9d6b/barcode/image/a01901ba-2880-48ae-b613-49ac04012cf1/5a7d461a-2e4b-4641-be52-9c9e6b40be6c.svg",
      "owner_id": "cd760004-2129-42da-b475-f867065e6bff",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/25f1e3e5-82e5-4878-bc45-fa9ad9a3a68e' \
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