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
      "id": "75d8f59f-50e6-4ffd-a9cb-806525dbe097",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T11:06:09+00:00",
        "updated_at": "2023-02-09T11:06:09+00:00",
        "number": "http://bqbl.it/75d8f59f-50e6-4ffd-a9cb-806525dbe097",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b650479d9832e37f20b1a3cd9e5dcef/barcode/image/75d8f59f-50e6-4ffd-a9cb-806525dbe097/16024337-b663-46f3-9bad-61af919ab5af.svg",
        "owner_id": "72157e59-0196-44b4-8333-8dcd8175fe5e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/72157e59-0196-44b4-8333-8dcd8175fe5e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F09e71da6-cc6b-4118-8764-643f05779d5b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "09e71da6-cc6b-4118-8764-643f05779d5b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T11:06:10+00:00",
        "updated_at": "2023-02-09T11:06:10+00:00",
        "number": "http://bqbl.it/09e71da6-cc6b-4118-8764-643f05779d5b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b6443031f1a14844a41deac7e7dbfe5/barcode/image/09e71da6-cc6b-4118-8764-643f05779d5b/83dcb842-fad9-486e-8f84-e701dff3b43f.svg",
        "owner_id": "1cfd54af-43ee-48ca-899a-5090372a7a16",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1cfd54af-43ee-48ca-899a-5090372a7a16"
          },
          "data": {
            "type": "customers",
            "id": "1cfd54af-43ee-48ca-899a-5090372a7a16"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1cfd54af-43ee-48ca-899a-5090372a7a16",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T11:06:10+00:00",
        "updated_at": "2023-02-09T11:06:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1cfd54af-43ee-48ca-899a-5090372a7a16&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1cfd54af-43ee-48ca-899a-5090372a7a16&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1cfd54af-43ee-48ca-899a-5090372a7a16&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzRjODM5YTktODBiNy00NDNiLWFlOTctZTA3ZjQ4ZjM4Mjli&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "34c839a9-80b7-443b-ae97-e07f48f3829b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T11:06:11+00:00",
        "updated_at": "2023-02-09T11:06:11+00:00",
        "number": "http://bqbl.it/34c839a9-80b7-443b-ae97-e07f48f3829b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d2f50fc72d474aa2e52aee19d30582e0/barcode/image/34c839a9-80b7-443b-ae97-e07f48f3829b/b5109694-9aa5-4203-8411-70df96cd7634.svg",
        "owner_id": "1466b0f4-4f9f-4420-9b74-66499a32d3b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1466b0f4-4f9f-4420-9b74-66499a32d3b2"
          },
          "data": {
            "type": "customers",
            "id": "1466b0f4-4f9f-4420-9b74-66499a32d3b2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1466b0f4-4f9f-4420-9b74-66499a32d3b2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T11:06:11+00:00",
        "updated_at": "2023-02-09T11:06:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1466b0f4-4f9f-4420-9b74-66499a32d3b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1466b0f4-4f9f-4420-9b74-66499a32d3b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1466b0f4-4f9f-4420-9b74-66499a32d3b2&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T11:05:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cfaa4166-d18a-4da7-af6e-68f8b5f0de18?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cfaa4166-d18a-4da7-af6e-68f8b5f0de18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T11:06:12+00:00",
      "updated_at": "2023-02-09T11:06:12+00:00",
      "number": "http://bqbl.it/cfaa4166-d18a-4da7-af6e-68f8b5f0de18",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e1a7976277ba87db3e5900deac5db82/barcode/image/cfaa4166-d18a-4da7-af6e-68f8b5f0de18/5a0bb551-3cc2-45c4-adcc-3e19f5ea4c46.svg",
      "owner_id": "7ab15248-40a5-4592-8d8a-9c249fca3867",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7ab15248-40a5-4592-8d8a-9c249fca3867"
        },
        "data": {
          "type": "customers",
          "id": "7ab15248-40a5-4592-8d8a-9c249fca3867"
        }
      }
    }
  },
  "included": [
    {
      "id": "7ab15248-40a5-4592-8d8a-9c249fca3867",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T11:06:11+00:00",
        "updated_at": "2023-02-09T11:06:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ab15248-40a5-4592-8d8a-9c249fca3867&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ab15248-40a5-4592-8d8a-9c249fca3867&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7ab15248-40a5-4592-8d8a-9c249fca3867&filter[owner_type]=customers"
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
          "owner_id": "9fbcf45f-df95-4c4d-9ee6-7197038dea2c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bd3758a6-c980-49ba-b68c-cc9d8f6d9597",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T11:06:12+00:00",
      "updated_at": "2023-02-09T11:06:12+00:00",
      "number": "http://bqbl.it/bd3758a6-c980-49ba-b68c-cc9d8f6d9597",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8fd991c529923d9160d71395edd08d26/barcode/image/bd3758a6-c980-49ba-b68c-cc9d8f6d9597/c1934396-022e-474b-98a1-d35030590795.svg",
      "owner_id": "9fbcf45f-df95-4c4d-9ee6-7197038dea2c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ac459d0b-24b6-4de3-aed3-8f2ee74e1003' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ac459d0b-24b6-4de3-aed3-8f2ee74e1003",
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
    "id": "ac459d0b-24b6-4de3-aed3-8f2ee74e1003",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T11:06:13+00:00",
      "updated_at": "2023-02-09T11:06:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6eb2e19302d618088a44e6eba20f957a/barcode/image/ac459d0b-24b6-4de3-aed3-8f2ee74e1003/cf40f3b5-c69b-4e86-bfdf-3632ee81fb36.svg",
      "owner_id": "f15211bf-486e-4bf3-abf3-8c7b96676bc8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0cc16391-e04f-484b-9964-d8fd6c17b937' \
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