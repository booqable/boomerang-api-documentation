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
      "id": "3f5ec547-b55a-4acd-a1cc-d25147b840d3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-10T11:15:02+00:00",
        "updated_at": "2023-02-10T11:15:02+00:00",
        "number": "http://bqbl.it/3f5ec547-b55a-4acd-a1cc-d25147b840d3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/20a865726c33ca5273c9e2aab601b17e/barcode/image/3f5ec547-b55a-4acd-a1cc-d25147b840d3/1426c042-b67a-42c2-bb32-211927036430.svg",
        "owner_id": "c6ec7249-4a43-4853-a850-a1d60d8c4de4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c6ec7249-4a43-4853-a850-a1d60d8c4de4"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa92ba57d-7a6a-4970-b8e8-0aff29b165d2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a92ba57d-7a6a-4970-b8e8-0aff29b165d2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-10T11:15:02+00:00",
        "updated_at": "2023-02-10T11:15:02+00:00",
        "number": "http://bqbl.it/a92ba57d-7a6a-4970-b8e8-0aff29b165d2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f9bd5790fb6c0b38aae1f68403722d74/barcode/image/a92ba57d-7a6a-4970-b8e8-0aff29b165d2/8d9ba9fe-b371-4cdb-bc13-8b4333a53fd1.svg",
        "owner_id": "075267c5-909a-4c88-8929-eda8f044c1a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/075267c5-909a-4c88-8929-eda8f044c1a0"
          },
          "data": {
            "type": "customers",
            "id": "075267c5-909a-4c88-8929-eda8f044c1a0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "075267c5-909a-4c88-8929-eda8f044c1a0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-10T11:15:02+00:00",
        "updated_at": "2023-02-10T11:15:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=075267c5-909a-4c88-8929-eda8f044c1a0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=075267c5-909a-4c88-8929-eda8f044c1a0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=075267c5-909a-4c88-8929-eda8f044c1a0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjlkYzdmYjMtODcwZS00MTgzLWJmZmMtNmYzYzYxZDI3N2Rj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b9dc7fb3-870e-4183-bffc-6f3c61d277dc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-10T11:15:03+00:00",
        "updated_at": "2023-02-10T11:15:03+00:00",
        "number": "http://bqbl.it/b9dc7fb3-870e-4183-bffc-6f3c61d277dc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b27873ec9326151e306cd671007fc7f4/barcode/image/b9dc7fb3-870e-4183-bffc-6f3c61d277dc/52b77524-9160-4e66-ae5e-119bb3f0bf3b.svg",
        "owner_id": "0d99334f-3411-4d09-89a3-ab5a42035eb1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0d99334f-3411-4d09-89a3-ab5a42035eb1"
          },
          "data": {
            "type": "customers",
            "id": "0d99334f-3411-4d09-89a3-ab5a42035eb1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0d99334f-3411-4d09-89a3-ab5a42035eb1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-10T11:15:03+00:00",
        "updated_at": "2023-02-10T11:15:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d99334f-3411-4d09-89a3-ab5a42035eb1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d99334f-3411-4d09-89a3-ab5a42035eb1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d99334f-3411-4d09-89a3-ab5a42035eb1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-10T11:14:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1cce03d6-c85f-4747-bb20-fa69c1723801?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1cce03d6-c85f-4747-bb20-fa69c1723801",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-10T11:15:03+00:00",
      "updated_at": "2023-02-10T11:15:03+00:00",
      "number": "http://bqbl.it/1cce03d6-c85f-4747-bb20-fa69c1723801",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b38f0544a15c93200901a5712d02aad6/barcode/image/1cce03d6-c85f-4747-bb20-fa69c1723801/950794fb-dbfa-43ac-a9ec-2f5843c61767.svg",
      "owner_id": "770e8d87-d933-4841-bfa1-dfabf7d74ca7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/770e8d87-d933-4841-bfa1-dfabf7d74ca7"
        },
        "data": {
          "type": "customers",
          "id": "770e8d87-d933-4841-bfa1-dfabf7d74ca7"
        }
      }
    }
  },
  "included": [
    {
      "id": "770e8d87-d933-4841-bfa1-dfabf7d74ca7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-10T11:15:03+00:00",
        "updated_at": "2023-02-10T11:15:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=770e8d87-d933-4841-bfa1-dfabf7d74ca7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=770e8d87-d933-4841-bfa1-dfabf7d74ca7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=770e8d87-d933-4841-bfa1-dfabf7d74ca7&filter[owner_type]=customers"
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
          "owner_id": "4f5a235b-0e8f-4a0b-8cd3-679d287dac2f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b7f9dab6-d053-4c17-8ed1-151b3f319b18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-10T11:15:04+00:00",
      "updated_at": "2023-02-10T11:15:04+00:00",
      "number": "http://bqbl.it/b7f9dab6-d053-4c17-8ed1-151b3f319b18",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e212b945d79a0c9bb3bf00131a33b99d/barcode/image/b7f9dab6-d053-4c17-8ed1-151b3f319b18/2bc982f7-7911-42fb-8c01-3cc1999776ee.svg",
      "owner_id": "4f5a235b-0e8f-4a0b-8cd3-679d287dac2f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c26f313c-04fb-4852-bf87-2dff7bebfe24' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c26f313c-04fb-4852-bf87-2dff7bebfe24",
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
    "id": "c26f313c-04fb-4852-bf87-2dff7bebfe24",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-10T11:15:04+00:00",
      "updated_at": "2023-02-10T11:15:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d8e986c3ffe3dc7a26e3cbfd0b1bed35/barcode/image/c26f313c-04fb-4852-bf87-2dff7bebfe24/1f9b4c96-0eda-4046-a2d7-aea9fa889442.svg",
      "owner_id": "91f2f156-380d-4e9f-b946-819f85fcd6cd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4008cc33-3707-4d3b-9662-ef8363be5d8e' \
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