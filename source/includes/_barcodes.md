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
      "id": "4cfbdb4b-9662-454a-bd15-85b1041e87f2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T09:44:09+00:00",
        "updated_at": "2023-02-08T09:44:09+00:00",
        "number": "http://bqbl.it/4cfbdb4b-9662-454a-bd15-85b1041e87f2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/758f6a839d19ffefff05ccee47d5d385/barcode/image/4cfbdb4b-9662-454a-bd15-85b1041e87f2/41ae4fa0-2115-4766-a18e-17480b57db23.svg",
        "owner_id": "c0b45361-ebf6-4488-96dc-8aa1b12204b3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c0b45361-ebf6-4488-96dc-8aa1b12204b3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F83e7bcd2-1764-485d-a214-91b6903735f3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "83e7bcd2-1764-485d-a214-91b6903735f3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T09:44:10+00:00",
        "updated_at": "2023-02-08T09:44:10+00:00",
        "number": "http://bqbl.it/83e7bcd2-1764-485d-a214-91b6903735f3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c6507742144c9ef2dd020267e417c15b/barcode/image/83e7bcd2-1764-485d-a214-91b6903735f3/dc532e6c-b337-41ed-b312-6ec225632850.svg",
        "owner_id": "c628ad45-86ac-427e-873a-d87095f5de7a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c628ad45-86ac-427e-873a-d87095f5de7a"
          },
          "data": {
            "type": "customers",
            "id": "c628ad45-86ac-427e-873a-d87095f5de7a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c628ad45-86ac-427e-873a-d87095f5de7a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T09:44:10+00:00",
        "updated_at": "2023-02-08T09:44:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c628ad45-86ac-427e-873a-d87095f5de7a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c628ad45-86ac-427e-873a-d87095f5de7a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c628ad45-86ac-427e-873a-d87095f5de7a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGU4Mzg0NjAtNDY3YS00OWMwLWE3YjAtYTNmZjkyMTg5ODNm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4e838460-467a-49c0-a7b0-a3ff9218983f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T09:44:11+00:00",
        "updated_at": "2023-02-08T09:44:11+00:00",
        "number": "http://bqbl.it/4e838460-467a-49c0-a7b0-a3ff9218983f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ecceef7200d68428be97a2cbacb80dae/barcode/image/4e838460-467a-49c0-a7b0-a3ff9218983f/22669aeb-0e6e-415b-9677-c1068752d14a.svg",
        "owner_id": "272ed220-c716-4fcf-86bf-1cf8bc4a3a3f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/272ed220-c716-4fcf-86bf-1cf8bc4a3a3f"
          },
          "data": {
            "type": "customers",
            "id": "272ed220-c716-4fcf-86bf-1cf8bc4a3a3f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "272ed220-c716-4fcf-86bf-1cf8bc4a3a3f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T09:44:11+00:00",
        "updated_at": "2023-02-08T09:44:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=272ed220-c716-4fcf-86bf-1cf8bc4a3a3f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=272ed220-c716-4fcf-86bf-1cf8bc4a3a3f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=272ed220-c716-4fcf-86bf-1cf8bc4a3a3f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:43:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df103a67-3291-4c3e-abd1-b09e4697bab4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df103a67-3291-4c3e-abd1-b09e4697bab4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T09:44:11+00:00",
      "updated_at": "2023-02-08T09:44:11+00:00",
      "number": "http://bqbl.it/df103a67-3291-4c3e-abd1-b09e4697bab4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6723e6c9cebec956f076838a9e437cfb/barcode/image/df103a67-3291-4c3e-abd1-b09e4697bab4/47a0e907-da9a-4c22-afd9-ae171b0b1f19.svg",
      "owner_id": "d243d4f0-9520-4770-982b-19b388465673",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d243d4f0-9520-4770-982b-19b388465673"
        },
        "data": {
          "type": "customers",
          "id": "d243d4f0-9520-4770-982b-19b388465673"
        }
      }
    }
  },
  "included": [
    {
      "id": "d243d4f0-9520-4770-982b-19b388465673",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T09:44:11+00:00",
        "updated_at": "2023-02-08T09:44:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d243d4f0-9520-4770-982b-19b388465673&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d243d4f0-9520-4770-982b-19b388465673&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d243d4f0-9520-4770-982b-19b388465673&filter[owner_type]=customers"
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
          "owner_id": "e8e3d69e-9054-4132-8d6a-f1760332c0ae",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a8644274-a69d-42e4-aa41-8cd1dc16ca42",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T09:44:12+00:00",
      "updated_at": "2023-02-08T09:44:12+00:00",
      "number": "http://bqbl.it/a8644274-a69d-42e4-aa41-8cd1dc16ca42",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e01f7da47b76698533eac4827d2fb2e/barcode/image/a8644274-a69d-42e4-aa41-8cd1dc16ca42/83e1a9f3-9d29-4333-95e3-04ce10e6877f.svg",
      "owner_id": "e8e3d69e-9054-4132-8d6a-f1760332c0ae",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/83ed1d72-edc0-4f9c-b0de-0e9097397c4a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "83ed1d72-edc0-4f9c-b0de-0e9097397c4a",
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
    "id": "83ed1d72-edc0-4f9c-b0de-0e9097397c4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T09:44:12+00:00",
      "updated_at": "2023-02-08T09:44:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f167be0785c7adcc8f83e844a28398a0/barcode/image/83ed1d72-edc0-4f9c-b0de-0e9097397c4a/e34b6995-068c-4dfd-866d-1a9b70786619.svg",
      "owner_id": "b24a0e17-e88b-4a6a-807a-435f45f075c1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9eba48ce-2232-4a84-a994-43e13fe7b108' \
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