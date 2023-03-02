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
      "id": "c2518b6c-3ebd-4837-93ba-11797650e675",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T11:07:14+00:00",
        "updated_at": "2023-03-02T11:07:14+00:00",
        "number": "http://bqbl.it/c2518b6c-3ebd-4837-93ba-11797650e675",
        "barcode_type": "qr_code",
        "image_url": "/uploads/29f8d578030b856e7fb47cd043c45370/barcode/image/c2518b6c-3ebd-4837-93ba-11797650e675/c69e7eed-633e-4233-84ad-fa9ce4ed4b8d.svg",
        "owner_id": "694e9f70-108a-4ace-94c6-d190733c8591",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/694e9f70-108a-4ace-94c6-d190733c8591"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3d1ecf5c-5ff6-465d-b6a6-cabfcb5ac846&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3d1ecf5c-5ff6-465d-b6a6-cabfcb5ac846",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T11:07:14+00:00",
        "updated_at": "2023-03-02T11:07:14+00:00",
        "number": "http://bqbl.it/3d1ecf5c-5ff6-465d-b6a6-cabfcb5ac846",
        "barcode_type": "qr_code",
        "image_url": "/uploads/88a8374bd693539d09c872fff0535a7e/barcode/image/3d1ecf5c-5ff6-465d-b6a6-cabfcb5ac846/1658785d-adee-4abf-bb62-2f3a4b703c8e.svg",
        "owner_id": "b7898320-cd7a-442f-9650-9566d8453933",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b7898320-cd7a-442f-9650-9566d8453933"
          },
          "data": {
            "type": "customers",
            "id": "b7898320-cd7a-442f-9650-9566d8453933"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b7898320-cd7a-442f-9650-9566d8453933",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T11:07:14+00:00",
        "updated_at": "2023-03-02T11:07:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b7898320-cd7a-442f-9650-9566d8453933&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b7898320-cd7a-442f-9650-9566d8453933&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b7898320-cd7a-442f-9650-9566d8453933&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOWU0NmE0M2UtMDNhNi00OTU2LWI2MTktMTNjNGVhOTY1NTNm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9e46a43e-03a6-4956-b619-13c4ea96553f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T11:07:15+00:00",
        "updated_at": "2023-03-02T11:07:15+00:00",
        "number": "http://bqbl.it/9e46a43e-03a6-4956-b619-13c4ea96553f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1bfcb7623f757e17cb3b0502c3cead53/barcode/image/9e46a43e-03a6-4956-b619-13c4ea96553f/3e3c29fc-b282-4c4a-8770-7008618d9e35.svg",
        "owner_id": "db137678-abcd-477d-b5c8-4bcbd5b8c841",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/db137678-abcd-477d-b5c8-4bcbd5b8c841"
          },
          "data": {
            "type": "customers",
            "id": "db137678-abcd-477d-b5c8-4bcbd5b8c841"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "db137678-abcd-477d-b5c8-4bcbd5b8c841",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T11:07:15+00:00",
        "updated_at": "2023-03-02T11:07:15+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=db137678-abcd-477d-b5c8-4bcbd5b8c841&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=db137678-abcd-477d-b5c8-4bcbd5b8c841&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=db137678-abcd-477d-b5c8-4bcbd5b8c841&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T11:06:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2a87ea5f-81c4-43f6-bdd3-b464dad79e90?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2a87ea5f-81c4-43f6-bdd3-b464dad79e90",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T11:07:17+00:00",
      "updated_at": "2023-03-02T11:07:17+00:00",
      "number": "http://bqbl.it/2a87ea5f-81c4-43f6-bdd3-b464dad79e90",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8eab40a1f28f5194177c264ad4d0af25/barcode/image/2a87ea5f-81c4-43f6-bdd3-b464dad79e90/98a03b73-e8cb-4066-8b25-ab187be32aae.svg",
      "owner_id": "885d016e-2e5c-44cb-94d9-17ce68fd4b3b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/885d016e-2e5c-44cb-94d9-17ce68fd4b3b"
        },
        "data": {
          "type": "customers",
          "id": "885d016e-2e5c-44cb-94d9-17ce68fd4b3b"
        }
      }
    }
  },
  "included": [
    {
      "id": "885d016e-2e5c-44cb-94d9-17ce68fd4b3b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T11:07:17+00:00",
        "updated_at": "2023-03-02T11:07:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=885d016e-2e5c-44cb-94d9-17ce68fd4b3b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=885d016e-2e5c-44cb-94d9-17ce68fd4b3b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=885d016e-2e5c-44cb-94d9-17ce68fd4b3b&filter[owner_type]=customers"
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
          "owner_id": "93e17e8d-94a7-461b-9084-bf5f37cc9c34",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1a5315b3-5e4e-45eb-85a0-ad5c0a503352",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T11:07:18+00:00",
      "updated_at": "2023-03-02T11:07:18+00:00",
      "number": "http://bqbl.it/1a5315b3-5e4e-45eb-85a0-ad5c0a503352",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4ad5d0ab0310ed18fdf868406ba5c896/barcode/image/1a5315b3-5e4e-45eb-85a0-ad5c0a503352/5624c440-148b-4cc2-a2dd-ce0d8c6ffb3c.svg",
      "owner_id": "93e17e8d-94a7-461b-9084-bf5f37cc9c34",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/beeaac79-de5e-4922-a71d-af0a78b1a8bb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "beeaac79-de5e-4922-a71d-af0a78b1a8bb",
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
    "id": "beeaac79-de5e-4922-a71d-af0a78b1a8bb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T11:07:19+00:00",
      "updated_at": "2023-03-02T11:07:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6ffdebfac10dc4030af9cc2daf823cc2/barcode/image/beeaac79-de5e-4922-a71d-af0a78b1a8bb/7b6eace2-ccb4-4163-b11c-305a7a6388d3.svg",
      "owner_id": "7385bea9-ac06-4eb6-bfc8-70bd2e0905ef",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/459274a3-3e28-4f3e-988a-45b1f120635f' \
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