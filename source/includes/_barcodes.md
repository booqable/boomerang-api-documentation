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
      "id": "7050218f-e033-4fa8-b18f-79cf735e4e2b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T18:48:39+00:00",
        "updated_at": "2022-10-25T18:48:39+00:00",
        "number": "http://bqbl.it/7050218f-e033-4fa8-b18f-79cf735e4e2b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/daf35e3e1864bf086312d8696228b40f/barcode/image/7050218f-e033-4fa8-b18f-79cf735e4e2b/42144be0-b686-4a43-b50b-ed01bf743994.svg",
        "owner_id": "2a38237a-2eda-494e-b747-cc2a67e90762",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2a38237a-2eda-494e-b747-cc2a67e90762"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F236e5d69-33e3-44be-902d-fe139f9d0e68&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "236e5d69-33e3-44be-902d-fe139f9d0e68",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T18:48:39+00:00",
        "updated_at": "2022-10-25T18:48:39+00:00",
        "number": "http://bqbl.it/236e5d69-33e3-44be-902d-fe139f9d0e68",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c97cf039554fddd4ed529b310708640c/barcode/image/236e5d69-33e3-44be-902d-fe139f9d0e68/fb23af6f-9f5d-4824-962a-d1c5cfe00aba.svg",
        "owner_id": "22d3104d-d1f0-477b-9d3e-b7238fcc8872",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/22d3104d-d1f0-477b-9d3e-b7238fcc8872"
          },
          "data": {
            "type": "customers",
            "id": "22d3104d-d1f0-477b-9d3e-b7238fcc8872"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "22d3104d-d1f0-477b-9d3e-b7238fcc8872",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T18:48:39+00:00",
        "updated_at": "2022-10-25T18:48:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=22d3104d-d1f0-477b-9d3e-b7238fcc8872&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=22d3104d-d1f0-477b-9d3e-b7238fcc8872&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=22d3104d-d1f0-477b-9d3e-b7238fcc8872&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODE5NDRkZjUtODE4YS00NDEyLWJlNzUtM2UxMDU3OGExNzYw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "81944df5-818a-4412-be75-3e10578a1760",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T18:48:39+00:00",
        "updated_at": "2022-10-25T18:48:39+00:00",
        "number": "http://bqbl.it/81944df5-818a-4412-be75-3e10578a1760",
        "barcode_type": "qr_code",
        "image_url": "/uploads/623c4c14ea2badc342c2478f30dd2539/barcode/image/81944df5-818a-4412-be75-3e10578a1760/e68699da-dc6a-4d11-87d5-4ce8d205ac77.svg",
        "owner_id": "8ada7ebc-fc3d-4058-83a3-874f1751015e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8ada7ebc-fc3d-4058-83a3-874f1751015e"
          },
          "data": {
            "type": "customers",
            "id": "8ada7ebc-fc3d-4058-83a3-874f1751015e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8ada7ebc-fc3d-4058-83a3-874f1751015e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T18:48:39+00:00",
        "updated_at": "2022-10-25T18:48:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8ada7ebc-fc3d-4058-83a3-874f1751015e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8ada7ebc-fc3d-4058-83a3-874f1751015e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8ada7ebc-fc3d-4058-83a3-874f1751015e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T18:48:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7e48289c-c088-4737-bd9e-a0b432925da6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7e48289c-c088-4737-bd9e-a0b432925da6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T18:48:40+00:00",
      "updated_at": "2022-10-25T18:48:40+00:00",
      "number": "http://bqbl.it/7e48289c-c088-4737-bd9e-a0b432925da6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/97107d8ca6eed74a94eb0ab80075d9c2/barcode/image/7e48289c-c088-4737-bd9e-a0b432925da6/210c86a2-99b7-4d80-a60f-73f02ebeef5f.svg",
      "owner_id": "6a6c2cb2-5ecc-475f-a238-b8960907b01a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6a6c2cb2-5ecc-475f-a238-b8960907b01a"
        },
        "data": {
          "type": "customers",
          "id": "6a6c2cb2-5ecc-475f-a238-b8960907b01a"
        }
      }
    }
  },
  "included": [
    {
      "id": "6a6c2cb2-5ecc-475f-a238-b8960907b01a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T18:48:40+00:00",
        "updated_at": "2022-10-25T18:48:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6a6c2cb2-5ecc-475f-a238-b8960907b01a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6a6c2cb2-5ecc-475f-a238-b8960907b01a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6a6c2cb2-5ecc-475f-a238-b8960907b01a&filter[owner_type]=customers"
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
          "owner_id": "840c24fe-edb4-4446-9545-b7db6ab9c205",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9ab3fc41-66f6-4587-b99b-f59a48d2ff79",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T18:48:40+00:00",
      "updated_at": "2022-10-25T18:48:40+00:00",
      "number": "http://bqbl.it/9ab3fc41-66f6-4587-b99b-f59a48d2ff79",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f395f2a4ec3076b099f78bc585a9a023/barcode/image/9ab3fc41-66f6-4587-b99b-f59a48d2ff79/193d0fab-092a-4131-9236-335a30bed30a.svg",
      "owner_id": "840c24fe-edb4-4446-9545-b7db6ab9c205",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4d7277ef-695f-4190-9152-663ba0bd9d95' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4d7277ef-695f-4190-9152-663ba0bd9d95",
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
    "id": "4d7277ef-695f-4190-9152-663ba0bd9d95",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T18:48:41+00:00",
      "updated_at": "2022-10-25T18:48:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54f7ff77e9ae4d1bc4ba4963d55e55e6/barcode/image/4d7277ef-695f-4190-9152-663ba0bd9d95/9ed5abd0-5f36-44e6-b859-e3f9914a6935.svg",
      "owner_id": "bfded20c-10b0-40d3-a24b-d62b2a5dbe5f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7b03d0a2-2192-4145-ac5f-401cf71cc01f' \
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