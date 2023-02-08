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
      "id": "9e0115dc-08e5-4f34-bae3-360819c410b7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T08:34:42+00:00",
        "updated_at": "2023-02-08T08:34:42+00:00",
        "number": "http://bqbl.it/9e0115dc-08e5-4f34-bae3-360819c410b7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/68813ced8c5b15fba17b6cb1b2f8390d/barcode/image/9e0115dc-08e5-4f34-bae3-360819c410b7/445e4db2-a414-4bea-a680-18320e387c59.svg",
        "owner_id": "14834e1c-a258-4506-b1ca-97474a9d7a9b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/14834e1c-a258-4506-b1ca-97474a9d7a9b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb2591acc-39e8-47a4-8919-6c54ce86a205&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b2591acc-39e8-47a4-8919-6c54ce86a205",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T08:34:42+00:00",
        "updated_at": "2023-02-08T08:34:42+00:00",
        "number": "http://bqbl.it/b2591acc-39e8-47a4-8919-6c54ce86a205",
        "barcode_type": "qr_code",
        "image_url": "/uploads/53fcdacaa6958333a8c830507aa81716/barcode/image/b2591acc-39e8-47a4-8919-6c54ce86a205/a1f1926d-95a8-4a88-a3c0-5fcc5afe4651.svg",
        "owner_id": "0c7840c1-0dd9-401e-8c08-5a8d17e3057f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0c7840c1-0dd9-401e-8c08-5a8d17e3057f"
          },
          "data": {
            "type": "customers",
            "id": "0c7840c1-0dd9-401e-8c08-5a8d17e3057f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0c7840c1-0dd9-401e-8c08-5a8d17e3057f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T08:34:42+00:00",
        "updated_at": "2023-02-08T08:34:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0c7840c1-0dd9-401e-8c08-5a8d17e3057f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0c7840c1-0dd9-401e-8c08-5a8d17e3057f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0c7840c1-0dd9-401e-8c08-5a8d17e3057f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmFjZjkyYzAtYmVjNi00MTBiLTkzNmYtOTdhNDI0MTZmNDVj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2acf92c0-bec6-410b-936f-97a42416f45c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T08:34:45+00:00",
        "updated_at": "2023-02-08T08:34:45+00:00",
        "number": "http://bqbl.it/2acf92c0-bec6-410b-936f-97a42416f45c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fac4459c6079b451459f9035b6d08aa9/barcode/image/2acf92c0-bec6-410b-936f-97a42416f45c/a60b70ea-3765-4311-aabb-304b70165bc1.svg",
        "owner_id": "8ccb6c72-cc30-4c30-8599-672fe0736590",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8ccb6c72-cc30-4c30-8599-672fe0736590"
          },
          "data": {
            "type": "customers",
            "id": "8ccb6c72-cc30-4c30-8599-672fe0736590"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8ccb6c72-cc30-4c30-8599-672fe0736590",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T08:34:45+00:00",
        "updated_at": "2023-02-08T08:34:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8ccb6c72-cc30-4c30-8599-672fe0736590&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8ccb6c72-cc30-4c30-8599-672fe0736590&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8ccb6c72-cc30-4c30-8599-672fe0736590&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:34:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/32ae8ac5-a3ce-492e-bb22-3dac5d07c6af?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "32ae8ac5-a3ce-492e-bb22-3dac5d07c6af",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T08:34:45+00:00",
      "updated_at": "2023-02-08T08:34:45+00:00",
      "number": "http://bqbl.it/32ae8ac5-a3ce-492e-bb22-3dac5d07c6af",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54ee50a35a372c010d4a66cb62959b12/barcode/image/32ae8ac5-a3ce-492e-bb22-3dac5d07c6af/4dbd7a6c-b91e-4975-9926-7abfae0ff524.svg",
      "owner_id": "1181c18b-70f2-4059-82ed-42933daf4c8f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1181c18b-70f2-4059-82ed-42933daf4c8f"
        },
        "data": {
          "type": "customers",
          "id": "1181c18b-70f2-4059-82ed-42933daf4c8f"
        }
      }
    }
  },
  "included": [
    {
      "id": "1181c18b-70f2-4059-82ed-42933daf4c8f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T08:34:45+00:00",
        "updated_at": "2023-02-08T08:34:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1181c18b-70f2-4059-82ed-42933daf4c8f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1181c18b-70f2-4059-82ed-42933daf4c8f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1181c18b-70f2-4059-82ed-42933daf4c8f&filter[owner_type]=customers"
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
          "owner_id": "8b981b80-1138-4c6e-88e3-36ab2db57664",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "542b4da8-eb0d-47ae-8b08-052d1364a5e1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T08:34:46+00:00",
      "updated_at": "2023-02-08T08:34:46+00:00",
      "number": "http://bqbl.it/542b4da8-eb0d-47ae-8b08-052d1364a5e1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c32fa0ace42fdd932fa64527fd61fe3a/barcode/image/542b4da8-eb0d-47ae-8b08-052d1364a5e1/d19721bc-38ff-4b45-895b-3ff2ca971aa5.svg",
      "owner_id": "8b981b80-1138-4c6e-88e3-36ab2db57664",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6e583223-a82e-42e5-b0bb-f62a5e21bf70' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6e583223-a82e-42e5-b0bb-f62a5e21bf70",
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
    "id": "6e583223-a82e-42e5-b0bb-f62a5e21bf70",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T08:34:47+00:00",
      "updated_at": "2023-02-08T08:34:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6a0920171bfb8624980f8df8442813d2/barcode/image/6e583223-a82e-42e5-b0bb-f62a5e21bf70/982da553-109c-4ea6-a5f7-d94f6710a709.svg",
      "owner_id": "b90b9333-4a9e-4aa0-9141-4e62136accdc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/59b69b30-dcf4-4b64-b1a8-e9c6d75ecb95' \
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