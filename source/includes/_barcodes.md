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
      "id": "cef3fad9-5590-4126-9d94-bbc45468b9a3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T13:18:06+00:00",
        "updated_at": "2023-02-01T13:18:06+00:00",
        "number": "http://bqbl.it/cef3fad9-5590-4126-9d94-bbc45468b9a3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1f5f9959f0844b9e1b5dcb014157a07c/barcode/image/cef3fad9-5590-4126-9d94-bbc45468b9a3/5d445cc1-589a-4e65-93f9-9d84a11bb051.svg",
        "owner_id": "133937e3-d43b-4140-99f9-30a10be58e4b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/133937e3-d43b-4140-99f9-30a10be58e4b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa4b2cd8d-847c-43bb-8eec-73388aca2a4d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a4b2cd8d-847c-43bb-8eec-73388aca2a4d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T13:18:07+00:00",
        "updated_at": "2023-02-01T13:18:07+00:00",
        "number": "http://bqbl.it/a4b2cd8d-847c-43bb-8eec-73388aca2a4d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b56c35f0be2bfc14c9db3c3df074ef22/barcode/image/a4b2cd8d-847c-43bb-8eec-73388aca2a4d/b17f5ab4-4d3a-4619-afc7-767a85e9955a.svg",
        "owner_id": "c93e2b29-04f3-44cd-b505-3774cd3c0e82",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c93e2b29-04f3-44cd-b505-3774cd3c0e82"
          },
          "data": {
            "type": "customers",
            "id": "c93e2b29-04f3-44cd-b505-3774cd3c0e82"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c93e2b29-04f3-44cd-b505-3774cd3c0e82",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T13:18:06+00:00",
        "updated_at": "2023-02-01T13:18:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c93e2b29-04f3-44cd-b505-3774cd3c0e82&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c93e2b29-04f3-44cd-b505-3774cd3c0e82&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c93e2b29-04f3-44cd-b505-3774cd3c0e82&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGYwN2MzMzEtNTkzNC00NjA1LWIyODAtMTE0NWU5MDBhODIx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8f07c331-5934-4605-b280-1145e900a821",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T13:18:07+00:00",
        "updated_at": "2023-02-01T13:18:07+00:00",
        "number": "http://bqbl.it/8f07c331-5934-4605-b280-1145e900a821",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f6ad671d983df54a9858a6708aed771c/barcode/image/8f07c331-5934-4605-b280-1145e900a821/b03c88d1-1506-431f-80c3-c2b6d4b42aa2.svg",
        "owner_id": "130cd591-58e6-4f5c-ac49-72e6a3f1f6d8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/130cd591-58e6-4f5c-ac49-72e6a3f1f6d8"
          },
          "data": {
            "type": "customers",
            "id": "130cd591-58e6-4f5c-ac49-72e6a3f1f6d8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "130cd591-58e6-4f5c-ac49-72e6a3f1f6d8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T13:18:07+00:00",
        "updated_at": "2023-02-01T13:18:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=130cd591-58e6-4f5c-ac49-72e6a3f1f6d8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=130cd591-58e6-4f5c-ac49-72e6a3f1f6d8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=130cd591-58e6-4f5c-ac49-72e6a3f1f6d8&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T13:17:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/31c93917-1b33-4c20-b97a-c3259cb49025?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "31c93917-1b33-4c20-b97a-c3259cb49025",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T13:18:08+00:00",
      "updated_at": "2023-02-01T13:18:08+00:00",
      "number": "http://bqbl.it/31c93917-1b33-4c20-b97a-c3259cb49025",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b6700f8b8d3f11d334964cde3f3a3b5a/barcode/image/31c93917-1b33-4c20-b97a-c3259cb49025/25004a03-b80f-43b6-b406-fb63419220c5.svg",
      "owner_id": "5bd65f62-b528-4269-8112-de8bcbd34c45",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5bd65f62-b528-4269-8112-de8bcbd34c45"
        },
        "data": {
          "type": "customers",
          "id": "5bd65f62-b528-4269-8112-de8bcbd34c45"
        }
      }
    }
  },
  "included": [
    {
      "id": "5bd65f62-b528-4269-8112-de8bcbd34c45",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T13:18:07+00:00",
        "updated_at": "2023-02-01T13:18:08+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5bd65f62-b528-4269-8112-de8bcbd34c45&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5bd65f62-b528-4269-8112-de8bcbd34c45&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5bd65f62-b528-4269-8112-de8bcbd34c45&filter[owner_type]=customers"
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
          "owner_id": "292f8663-bf64-41aa-b324-f86ee61f7272",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2c30851d-4020-4e42-ba0b-baffcef482fb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T13:18:08+00:00",
      "updated_at": "2023-02-01T13:18:08+00:00",
      "number": "http://bqbl.it/2c30851d-4020-4e42-ba0b-baffcef482fb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/159799014eb58336ef4c346c766381ed/barcode/image/2c30851d-4020-4e42-ba0b-baffcef482fb/20b1d2d8-1375-4cc5-82ec-6205856d10f6.svg",
      "owner_id": "292f8663-bf64-41aa-b324-f86ee61f7272",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/be087ae0-8a1f-4b7f-ac67-29f6219c6419' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "be087ae0-8a1f-4b7f-ac67-29f6219c6419",
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
    "id": "be087ae0-8a1f-4b7f-ac67-29f6219c6419",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T13:18:10+00:00",
      "updated_at": "2023-02-01T13:18:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/29d93cf455ab8458f0f25b6162171d95/barcode/image/be087ae0-8a1f-4b7f-ac67-29f6219c6419/39045142-d9af-43fb-be5c-7518f66cf296.svg",
      "owner_id": "6fe4835e-93d4-481c-bd05-b574c3492836",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8326fc29-ab11-482f-89c0-9345d5a37f22' \
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