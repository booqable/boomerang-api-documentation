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
      "id": "71ea26e7-014c-482c-b1ef-723269f625fb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T08:57:00+00:00",
        "updated_at": "2023-03-09T08:57:00+00:00",
        "number": "http://bqbl.it/71ea26e7-014c-482c-b1ef-723269f625fb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c4812a7726cb36f7cccfce0d98891608/barcode/image/71ea26e7-014c-482c-b1ef-723269f625fb/b4061093-c17f-4245-96aa-feb826882af8.svg",
        "owner_id": "c230442f-f404-4aaa-9ae7-74cb945b6c41",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c230442f-f404-4aaa-9ae7-74cb945b6c41"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F11e2f12e-cd5d-4e64-85ef-cc023bb2247b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "11e2f12e-cd5d-4e64-85ef-cc023bb2247b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T08:57:00+00:00",
        "updated_at": "2023-03-09T08:57:00+00:00",
        "number": "http://bqbl.it/11e2f12e-cd5d-4e64-85ef-cc023bb2247b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/722679a0fc6675b19b31a37875744f15/barcode/image/11e2f12e-cd5d-4e64-85ef-cc023bb2247b/6218739e-ee08-4d69-843a-0b0b01b204a3.svg",
        "owner_id": "c9f5e269-1e72-4077-b642-7719ee6bc1b1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c9f5e269-1e72-4077-b642-7719ee6bc1b1"
          },
          "data": {
            "type": "customers",
            "id": "c9f5e269-1e72-4077-b642-7719ee6bc1b1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c9f5e269-1e72-4077-b642-7719ee6bc1b1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T08:57:00+00:00",
        "updated_at": "2023-03-09T08:57:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c9f5e269-1e72-4077-b642-7719ee6bc1b1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c9f5e269-1e72-4077-b642-7719ee6bc1b1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c9f5e269-1e72-4077-b642-7719ee6bc1b1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2NiNDNlOTctOGY0ZS00ZmRmLTgzYWMtMDc0N2FlZGE1MWJi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3cb43e97-8f4e-4fdf-83ac-0747aeda51bb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T08:57:01+00:00",
        "updated_at": "2023-03-09T08:57:01+00:00",
        "number": "http://bqbl.it/3cb43e97-8f4e-4fdf-83ac-0747aeda51bb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/36a580da0f7a3ea69c67f034f1241280/barcode/image/3cb43e97-8f4e-4fdf-83ac-0747aeda51bb/c6835174-7452-436a-bccd-a13fbfd96e23.svg",
        "owner_id": "83f02c27-a400-4bbe-9d1e-852c946bb3bb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/83f02c27-a400-4bbe-9d1e-852c946bb3bb"
          },
          "data": {
            "type": "customers",
            "id": "83f02c27-a400-4bbe-9d1e-852c946bb3bb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "83f02c27-a400-4bbe-9d1e-852c946bb3bb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T08:57:01+00:00",
        "updated_at": "2023-03-09T08:57:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=83f02c27-a400-4bbe-9d1e-852c946bb3bb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=83f02c27-a400-4bbe-9d1e-852c946bb3bb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=83f02c27-a400-4bbe-9d1e-852c946bb3bb&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T08:56:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2f7444a1-b16a-4bea-95c9-c220554068c1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2f7444a1-b16a-4bea-95c9-c220554068c1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T08:57:01+00:00",
      "updated_at": "2023-03-09T08:57:01+00:00",
      "number": "http://bqbl.it/2f7444a1-b16a-4bea-95c9-c220554068c1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3a794f5621e831bd9d1e53d2888efdb8/barcode/image/2f7444a1-b16a-4bea-95c9-c220554068c1/91bc9019-82bb-44bd-9ea4-bcb12d8158fb.svg",
      "owner_id": "9bfdf31a-ce47-418f-9514-4424be824c59",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9bfdf31a-ce47-418f-9514-4424be824c59"
        },
        "data": {
          "type": "customers",
          "id": "9bfdf31a-ce47-418f-9514-4424be824c59"
        }
      }
    }
  },
  "included": [
    {
      "id": "9bfdf31a-ce47-418f-9514-4424be824c59",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T08:57:01+00:00",
        "updated_at": "2023-03-09T08:57:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9bfdf31a-ce47-418f-9514-4424be824c59&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9bfdf31a-ce47-418f-9514-4424be824c59&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9bfdf31a-ce47-418f-9514-4424be824c59&filter[owner_type]=customers"
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
          "owner_id": "6a416691-878e-40a9-aa74-49f70d36158c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "124af0f1-7565-4839-92bf-21d5302d9ab1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T08:57:02+00:00",
      "updated_at": "2023-03-09T08:57:02+00:00",
      "number": "http://bqbl.it/124af0f1-7565-4839-92bf-21d5302d9ab1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/792dcd4026817299d64a4e8ff3095c8d/barcode/image/124af0f1-7565-4839-92bf-21d5302d9ab1/75ba3af7-b1e1-44df-a48f-8bf12383b5fa.svg",
      "owner_id": "6a416691-878e-40a9-aa74-49f70d36158c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/77072c22-e1a8-4026-81cb-cc19b9b72898' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "77072c22-e1a8-4026-81cb-cc19b9b72898",
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
    "id": "77072c22-e1a8-4026-81cb-cc19b9b72898",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T08:57:02+00:00",
      "updated_at": "2023-03-09T08:57:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/116e62bb8f7af098dee787007ae9fd8a/barcode/image/77072c22-e1a8-4026-81cb-cc19b9b72898/edfe44d2-b858-4e0c-a4d6-d8c790502b3a.svg",
      "owner_id": "67aa0215-2d4e-4cbb-a35e-6ac294c180ae",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d7876260-20cb-465f-bc08-ee55fae2c8da' \
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