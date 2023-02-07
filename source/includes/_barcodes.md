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
      "id": "ff7cb2fb-d431-4b98-a613-5d68ca6e3cb0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:59:41+00:00",
        "updated_at": "2023-02-07T14:59:41+00:00",
        "number": "http://bqbl.it/ff7cb2fb-d431-4b98-a613-5d68ca6e3cb0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e0933a4e5dc79a08ed41ac646cb31286/barcode/image/ff7cb2fb-d431-4b98-a613-5d68ca6e3cb0/14533900-b5c3-4b50-8934-6a0110071ccf.svg",
        "owner_id": "78a4c96c-caa8-4160-b1e1-210e7bfc8dc0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/78a4c96c-caa8-4160-b1e1-210e7bfc8dc0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd14fb5a1-4253-4415-b4bb-b94613993651&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d14fb5a1-4253-4415-b4bb-b94613993651",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:59:42+00:00",
        "updated_at": "2023-02-07T14:59:42+00:00",
        "number": "http://bqbl.it/d14fb5a1-4253-4415-b4bb-b94613993651",
        "barcode_type": "qr_code",
        "image_url": "/uploads/431b09fecd0e2ca30af74dc177dc9202/barcode/image/d14fb5a1-4253-4415-b4bb-b94613993651/cd3e13bb-6435-4511-a9d9-56c1841f26d8.svg",
        "owner_id": "877730be-9cfc-47c1-a75f-db657fe334e6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/877730be-9cfc-47c1-a75f-db657fe334e6"
          },
          "data": {
            "type": "customers",
            "id": "877730be-9cfc-47c1-a75f-db657fe334e6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "877730be-9cfc-47c1-a75f-db657fe334e6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:59:42+00:00",
        "updated_at": "2023-02-07T14:59:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=877730be-9cfc-47c1-a75f-db657fe334e6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=877730be-9cfc-47c1-a75f-db657fe334e6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=877730be-9cfc-47c1-a75f-db657fe334e6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmE1YjdiNGMtMWI0OC00Y2IzLTg4ODItOTVjMGQzNmM0YjRi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6a5b7b4c-1b48-4cb3-8882-95c0d36c4b4b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:59:42+00:00",
        "updated_at": "2023-02-07T14:59:42+00:00",
        "number": "http://bqbl.it/6a5b7b4c-1b48-4cb3-8882-95c0d36c4b4b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b29f9cc07dd49d47720560209bed58ca/barcode/image/6a5b7b4c-1b48-4cb3-8882-95c0d36c4b4b/ab539599-0d30-434b-8c22-c63439d65861.svg",
        "owner_id": "5f2f547c-305d-4721-93c3-a1b433d6ed51",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5f2f547c-305d-4721-93c3-a1b433d6ed51"
          },
          "data": {
            "type": "customers",
            "id": "5f2f547c-305d-4721-93c3-a1b433d6ed51"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5f2f547c-305d-4721-93c3-a1b433d6ed51",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:59:42+00:00",
        "updated_at": "2023-02-07T14:59:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5f2f547c-305d-4721-93c3-a1b433d6ed51&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5f2f547c-305d-4721-93c3-a1b433d6ed51&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5f2f547c-305d-4721-93c3-a1b433d6ed51&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:59:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4754c78d-7570-43f6-bf35-f64e86032d3d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4754c78d-7570-43f6-bf35-f64e86032d3d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:59:43+00:00",
      "updated_at": "2023-02-07T14:59:43+00:00",
      "number": "http://bqbl.it/4754c78d-7570-43f6-bf35-f64e86032d3d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/59b6b33640b676f4012dcf1c608d41ea/barcode/image/4754c78d-7570-43f6-bf35-f64e86032d3d/bcad262e-8b0f-4345-af3f-367714e4b737.svg",
      "owner_id": "34b24387-593f-44c9-b8ea-32aa3d9508c4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/34b24387-593f-44c9-b8ea-32aa3d9508c4"
        },
        "data": {
          "type": "customers",
          "id": "34b24387-593f-44c9-b8ea-32aa3d9508c4"
        }
      }
    }
  },
  "included": [
    {
      "id": "34b24387-593f-44c9-b8ea-32aa3d9508c4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:59:43+00:00",
        "updated_at": "2023-02-07T14:59:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=34b24387-593f-44c9-b8ea-32aa3d9508c4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=34b24387-593f-44c9-b8ea-32aa3d9508c4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=34b24387-593f-44c9-b8ea-32aa3d9508c4&filter[owner_type]=customers"
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
          "owner_id": "fe2699fb-4a6f-4834-8b94-cbf26dcc0cc7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "863e201d-2400-43ee-9df4-d809d8e4cdfd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:59:43+00:00",
      "updated_at": "2023-02-07T14:59:43+00:00",
      "number": "http://bqbl.it/863e201d-2400-43ee-9df4-d809d8e4cdfd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/557042f878f143df5d4dc8090250daf0/barcode/image/863e201d-2400-43ee-9df4-d809d8e4cdfd/ea48b3eb-56c0-488f-954a-bcb69d137dde.svg",
      "owner_id": "fe2699fb-4a6f-4834-8b94-cbf26dcc0cc7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/839c840e-91a0-4f7c-aacb-7359e85cc9a9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "839c840e-91a0-4f7c-aacb-7359e85cc9a9",
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
    "id": "839c840e-91a0-4f7c-aacb-7359e85cc9a9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:59:44+00:00",
      "updated_at": "2023-02-07T14:59:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1fc0413793202e8c189e1150392a5125/barcode/image/839c840e-91a0-4f7c-aacb-7359e85cc9a9/27fad4c3-16cb-4c37-a095-32c910c2e3fd.svg",
      "owner_id": "ab708249-54b9-4901-bad7-6ef46ca5c00f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c1b81efa-e832-4054-98f9-2d868c4fe04b' \
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