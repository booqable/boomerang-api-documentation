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
      "id": "24b8a65c-2f2e-4045-8f27-49702164e2ad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T08:34:18+00:00",
        "updated_at": "2023-02-08T08:34:18+00:00",
        "number": "http://bqbl.it/24b8a65c-2f2e-4045-8f27-49702164e2ad",
        "barcode_type": "qr_code",
        "image_url": "/uploads/40efeff51f74011d16244fc96485753c/barcode/image/24b8a65c-2f2e-4045-8f27-49702164e2ad/ed3a8774-8448-4447-a594-ccf66fac52d4.svg",
        "owner_id": "a72c7b14-b89d-4a33-959a-62c45f90fb1e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a72c7b14-b89d-4a33-959a-62c45f90fb1e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F558e75df-98e1-40d7-8f02-101518683e06&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "558e75df-98e1-40d7-8f02-101518683e06",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T08:34:18+00:00",
        "updated_at": "2023-02-08T08:34:18+00:00",
        "number": "http://bqbl.it/558e75df-98e1-40d7-8f02-101518683e06",
        "barcode_type": "qr_code",
        "image_url": "/uploads/26dec88da3125c1448427bc6534b1660/barcode/image/558e75df-98e1-40d7-8f02-101518683e06/be56728e-9e2f-4588-baa2-f4e23fe44cb9.svg",
        "owner_id": "ded3cc0a-992c-46a4-9392-f72fca468772",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ded3cc0a-992c-46a4-9392-f72fca468772"
          },
          "data": {
            "type": "customers",
            "id": "ded3cc0a-992c-46a4-9392-f72fca468772"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ded3cc0a-992c-46a4-9392-f72fca468772",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T08:34:18+00:00",
        "updated_at": "2023-02-08T08:34:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ded3cc0a-992c-46a4-9392-f72fca468772&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ded3cc0a-992c-46a4-9392-f72fca468772&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ded3cc0a-992c-46a4-9392-f72fca468772&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWZhMTRjNGMtN2U5Ni00ZDI0LWJlODUtYjU4ZTc1ODNkY2U1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "efa14c4c-7e96-4d24-be85-b58e7583dce5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T08:34:19+00:00",
        "updated_at": "2023-02-08T08:34:19+00:00",
        "number": "http://bqbl.it/efa14c4c-7e96-4d24-be85-b58e7583dce5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6224eafba6e20cfb76517dbab3496f7f/barcode/image/efa14c4c-7e96-4d24-be85-b58e7583dce5/8907da2b-a6ae-4e39-b09f-c5559b1ce95f.svg",
        "owner_id": "6c19a5df-3f19-4a0f-88d6-5930e074757c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6c19a5df-3f19-4a0f-88d6-5930e074757c"
          },
          "data": {
            "type": "customers",
            "id": "6c19a5df-3f19-4a0f-88d6-5930e074757c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6c19a5df-3f19-4a0f-88d6-5930e074757c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T08:34:19+00:00",
        "updated_at": "2023-02-08T08:34:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6c19a5df-3f19-4a0f-88d6-5930e074757c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6c19a5df-3f19-4a0f-88d6-5930e074757c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6c19a5df-3f19-4a0f-88d6-5930e074757c&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:33:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4b500ebc-3aa0-4a6a-9a51-d9a939859753?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4b500ebc-3aa0-4a6a-9a51-d9a939859753",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T08:34:19+00:00",
      "updated_at": "2023-02-08T08:34:19+00:00",
      "number": "http://bqbl.it/4b500ebc-3aa0-4a6a-9a51-d9a939859753",
      "barcode_type": "qr_code",
      "image_url": "/uploads/593e9e6ac47b4cd11c371f76a3f23ce4/barcode/image/4b500ebc-3aa0-4a6a-9a51-d9a939859753/58bc5e24-dab3-4a68-a5d6-5c88206b1d12.svg",
      "owner_id": "17635e71-d13f-44d6-b102-f8e57dee7465",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/17635e71-d13f-44d6-b102-f8e57dee7465"
        },
        "data": {
          "type": "customers",
          "id": "17635e71-d13f-44d6-b102-f8e57dee7465"
        }
      }
    }
  },
  "included": [
    {
      "id": "17635e71-d13f-44d6-b102-f8e57dee7465",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T08:34:19+00:00",
        "updated_at": "2023-02-08T08:34:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=17635e71-d13f-44d6-b102-f8e57dee7465&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=17635e71-d13f-44d6-b102-f8e57dee7465&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=17635e71-d13f-44d6-b102-f8e57dee7465&filter[owner_type]=customers"
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
          "owner_id": "54fd192a-43fe-40fc-9968-f0118b616406",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2fb2e643-d562-444a-ade5-33612bebe671",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T08:34:20+00:00",
      "updated_at": "2023-02-08T08:34:20+00:00",
      "number": "http://bqbl.it/2fb2e643-d562-444a-ade5-33612bebe671",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9fde313b4d387938f9b97d561ae6e6f6/barcode/image/2fb2e643-d562-444a-ade5-33612bebe671/84a142e5-583e-4879-b778-29d394aee182.svg",
      "owner_id": "54fd192a-43fe-40fc-9968-f0118b616406",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/54ad2ee5-de99-4070-a471-ef5e675fcbfd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "54ad2ee5-de99-4070-a471-ef5e675fcbfd",
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
    "id": "54ad2ee5-de99-4070-a471-ef5e675fcbfd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T08:34:20+00:00",
      "updated_at": "2023-02-08T08:34:20+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/592a2591c8bb119f9fd28a120f2f5eb8/barcode/image/54ad2ee5-de99-4070-a471-ef5e675fcbfd/0b4f2c49-a01a-4e55-85d5-238ba31b0d96.svg",
      "owner_id": "0fafd0be-4714-4a32-aeb6-14e2ca4b7d6b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/baad507f-ad14-4514-8628-fa292cc4e212' \
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