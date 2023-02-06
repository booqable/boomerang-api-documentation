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
      "id": "7f7e391f-e6dd-47f2-9b5d-c92f89ab5014",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T19:28:26+00:00",
        "updated_at": "2023-02-06T19:28:26+00:00",
        "number": "http://bqbl.it/7f7e391f-e6dd-47f2-9b5d-c92f89ab5014",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3ff4f91d8411d3adfd034341cce128f1/barcode/image/7f7e391f-e6dd-47f2-9b5d-c92f89ab5014/65138623-b429-44cd-aa1c-3fc993e36dfb.svg",
        "owner_id": "2ae2ad2d-b524-430c-bfcf-b7003a25b32b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2ae2ad2d-b524-430c-bfcf-b7003a25b32b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0077d0dc-b38c-4bde-983f-e357310a04f9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0077d0dc-b38c-4bde-983f-e357310a04f9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T19:28:26+00:00",
        "updated_at": "2023-02-06T19:28:26+00:00",
        "number": "http://bqbl.it/0077d0dc-b38c-4bde-983f-e357310a04f9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a4bdf3cc17832015700a8fc93307e5fd/barcode/image/0077d0dc-b38c-4bde-983f-e357310a04f9/0f3c39ee-405e-4517-bce7-5328e9d39990.svg",
        "owner_id": "7ac87749-052e-4031-9034-984e5d2dfcc1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7ac87749-052e-4031-9034-984e5d2dfcc1"
          },
          "data": {
            "type": "customers",
            "id": "7ac87749-052e-4031-9034-984e5d2dfcc1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7ac87749-052e-4031-9034-984e5d2dfcc1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T19:28:26+00:00",
        "updated_at": "2023-02-06T19:28:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ac87749-052e-4031-9034-984e5d2dfcc1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ac87749-052e-4031-9034-984e5d2dfcc1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7ac87749-052e-4031-9034-984e5d2dfcc1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMWRjNGFjOTItNzVkYi00MzkxLThlZDMtYjA5NGE2ODQ2NzRh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1dc4ac92-75db-4391-8ed3-b094a684674a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T19:28:27+00:00",
        "updated_at": "2023-02-06T19:28:27+00:00",
        "number": "http://bqbl.it/1dc4ac92-75db-4391-8ed3-b094a684674a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a34d93aa60359e7b2ef382a6166d41be/barcode/image/1dc4ac92-75db-4391-8ed3-b094a684674a/0f50d9f5-955a-4ed7-8d27-4c1895f4f3aa.svg",
        "owner_id": "2faf4a66-f3cb-4178-b8ad-b230c3a8efdc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2faf4a66-f3cb-4178-b8ad-b230c3a8efdc"
          },
          "data": {
            "type": "customers",
            "id": "2faf4a66-f3cb-4178-b8ad-b230c3a8efdc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2faf4a66-f3cb-4178-b8ad-b230c3a8efdc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T19:28:27+00:00",
        "updated_at": "2023-02-06T19:28:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2faf4a66-f3cb-4178-b8ad-b230c3a8efdc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2faf4a66-f3cb-4178-b8ad-b230c3a8efdc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2faf4a66-f3cb-4178-b8ad-b230c3a8efdc&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T19:28:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cac82a89-3bb9-4cb7-89c8-0a22ed2ffa61?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cac82a89-3bb9-4cb7-89c8-0a22ed2ffa61",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T19:28:27+00:00",
      "updated_at": "2023-02-06T19:28:27+00:00",
      "number": "http://bqbl.it/cac82a89-3bb9-4cb7-89c8-0a22ed2ffa61",
      "barcode_type": "qr_code",
      "image_url": "/uploads/75ee2aa588844cdb46483a5e251921be/barcode/image/cac82a89-3bb9-4cb7-89c8-0a22ed2ffa61/859476bb-1b3d-429c-88de-9a14b60b283c.svg",
      "owner_id": "a618a498-71d0-4937-b5bf-8b6427e6c4c4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a618a498-71d0-4937-b5bf-8b6427e6c4c4"
        },
        "data": {
          "type": "customers",
          "id": "a618a498-71d0-4937-b5bf-8b6427e6c4c4"
        }
      }
    }
  },
  "included": [
    {
      "id": "a618a498-71d0-4937-b5bf-8b6427e6c4c4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T19:28:27+00:00",
        "updated_at": "2023-02-06T19:28:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a618a498-71d0-4937-b5bf-8b6427e6c4c4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a618a498-71d0-4937-b5bf-8b6427e6c4c4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a618a498-71d0-4937-b5bf-8b6427e6c4c4&filter[owner_type]=customers"
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
          "owner_id": "5ca8186e-e335-4021-8542-dbf74b50ae9d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0737c7b2-5b11-4229-81a7-7ea8a28b79f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T19:28:28+00:00",
      "updated_at": "2023-02-06T19:28:28+00:00",
      "number": "http://bqbl.it/0737c7b2-5b11-4229-81a7-7ea8a28b79f9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/011661fffc0a1760567cd6f3c6027866/barcode/image/0737c7b2-5b11-4229-81a7-7ea8a28b79f9/830c6e6f-d2d6-4d5f-b844-5d91d3151619.svg",
      "owner_id": "5ca8186e-e335-4021-8542-dbf74b50ae9d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5bfe6012-084b-4015-9d6f-c726790a4a1d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5bfe6012-084b-4015-9d6f-c726790a4a1d",
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
    "id": "5bfe6012-084b-4015-9d6f-c726790a4a1d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T19:28:28+00:00",
      "updated_at": "2023-02-06T19:28:28+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e9b77a1240f152854fb5f68da31f66e0/barcode/image/5bfe6012-084b-4015-9d6f-c726790a4a1d/d672a44d-ba28-4cc3-81e0-e379e170be5d.svg",
      "owner_id": "216186a0-a544-4508-b3d6-d3a3d43b2a37",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/34df0182-7ae8-4acd-a1bb-ba483bd36bb0' \
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