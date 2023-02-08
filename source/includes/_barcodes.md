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
      "id": "5ddfc60f-0d23-4294-b845-6ad52eb5105e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T14:58:18+00:00",
        "updated_at": "2023-02-08T14:58:18+00:00",
        "number": "http://bqbl.it/5ddfc60f-0d23-4294-b845-6ad52eb5105e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/db5ae93236a863fad6b9363d4ef48904/barcode/image/5ddfc60f-0d23-4294-b845-6ad52eb5105e/e16ffab6-9f7c-4a71-9e75-4e6e3c72d932.svg",
        "owner_id": "d0c96e10-0c9c-441a-94c3-11ab96b5d96c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d0c96e10-0c9c-441a-94c3-11ab96b5d96c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F733610c9-39b8-47a3-af8d-be3636074f28&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "733610c9-39b8-47a3-af8d-be3636074f28",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T14:58:19+00:00",
        "updated_at": "2023-02-08T14:58:19+00:00",
        "number": "http://bqbl.it/733610c9-39b8-47a3-af8d-be3636074f28",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b4559bc02ad48380706d3d61ab6ccdd/barcode/image/733610c9-39b8-47a3-af8d-be3636074f28/e5b47a82-a1ab-42c1-a34b-c1004879fc1a.svg",
        "owner_id": "0d02b2f6-8421-4222-9cf9-022835ebbde7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0d02b2f6-8421-4222-9cf9-022835ebbde7"
          },
          "data": {
            "type": "customers",
            "id": "0d02b2f6-8421-4222-9cf9-022835ebbde7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0d02b2f6-8421-4222-9cf9-022835ebbde7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T14:58:19+00:00",
        "updated_at": "2023-02-08T14:58:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d02b2f6-8421-4222-9cf9-022835ebbde7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d02b2f6-8421-4222-9cf9-022835ebbde7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d02b2f6-8421-4222-9cf9-022835ebbde7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDAzYTA2MjMtNTcwOC00ZDkwLTg0YmQtZGVmZjViNzM1MmMw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d03a0623-5708-4d90-84bd-deff5b7352c0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T14:58:19+00:00",
        "updated_at": "2023-02-08T14:58:19+00:00",
        "number": "http://bqbl.it/d03a0623-5708-4d90-84bd-deff5b7352c0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/db1df455478874442c6f571bfb3cf250/barcode/image/d03a0623-5708-4d90-84bd-deff5b7352c0/7cb0a0d6-2f32-426b-b3af-d0e063b7548d.svg",
        "owner_id": "f4c40ce8-8414-4790-84c0-697dc4e99f8b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f4c40ce8-8414-4790-84c0-697dc4e99f8b"
          },
          "data": {
            "type": "customers",
            "id": "f4c40ce8-8414-4790-84c0-697dc4e99f8b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f4c40ce8-8414-4790-84c0-697dc4e99f8b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T14:58:19+00:00",
        "updated_at": "2023-02-08T14:58:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f4c40ce8-8414-4790-84c0-697dc4e99f8b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f4c40ce8-8414-4790-84c0-697dc4e99f8b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f4c40ce8-8414-4790-84c0-697dc4e99f8b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:57:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b1279910-be97-4734-a50e-960ee214d4d0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b1279910-be97-4734-a50e-960ee214d4d0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T14:58:20+00:00",
      "updated_at": "2023-02-08T14:58:20+00:00",
      "number": "http://bqbl.it/b1279910-be97-4734-a50e-960ee214d4d0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4c0ea4e756ac783211a5a0dc271fdbd7/barcode/image/b1279910-be97-4734-a50e-960ee214d4d0/713e0430-abb0-4b03-96ad-23416086ba05.svg",
      "owner_id": "c1aa7dc7-6350-44f9-922c-5a923b87c51c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c1aa7dc7-6350-44f9-922c-5a923b87c51c"
        },
        "data": {
          "type": "customers",
          "id": "c1aa7dc7-6350-44f9-922c-5a923b87c51c"
        }
      }
    }
  },
  "included": [
    {
      "id": "c1aa7dc7-6350-44f9-922c-5a923b87c51c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T14:58:20+00:00",
        "updated_at": "2023-02-08T14:58:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c1aa7dc7-6350-44f9-922c-5a923b87c51c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c1aa7dc7-6350-44f9-922c-5a923b87c51c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c1aa7dc7-6350-44f9-922c-5a923b87c51c&filter[owner_type]=customers"
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
          "owner_id": "cfd19511-eb30-4ea2-9b84-d3d5c30fe984",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0181a8ca-57c9-43b8-bd6a-1024b4d73214",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T14:58:20+00:00",
      "updated_at": "2023-02-08T14:58:20+00:00",
      "number": "http://bqbl.it/0181a8ca-57c9-43b8-bd6a-1024b4d73214",
      "barcode_type": "qr_code",
      "image_url": "/uploads/da3af169ef5b6f20626d2ba0927cfb50/barcode/image/0181a8ca-57c9-43b8-bd6a-1024b4d73214/6ef66d62-a286-4225-ab25-cdf20eb6da54.svg",
      "owner_id": "cfd19511-eb30-4ea2-9b84-d3d5c30fe984",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1afbecef-7ae4-4989-a17a-fd653f202bfc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1afbecef-7ae4-4989-a17a-fd653f202bfc",
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
    "id": "1afbecef-7ae4-4989-a17a-fd653f202bfc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T14:58:22+00:00",
      "updated_at": "2023-02-08T14:58:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/49a80b34bb96948e4cf29672cc020413/barcode/image/1afbecef-7ae4-4989-a17a-fd653f202bfc/31da5141-33e0-43ca-95d9-49895eed4924.svg",
      "owner_id": "cb615903-4a7e-4480-8b6c-65592577c27b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ff28b6be-5a38-4a3c-9384-dff8a3926e80' \
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