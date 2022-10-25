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
      "id": "07e14829-41ba-44ad-85c9-5197ee8d34c2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T19:09:01+00:00",
        "updated_at": "2022-10-25T19:09:01+00:00",
        "number": "http://bqbl.it/07e14829-41ba-44ad-85c9-5197ee8d34c2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6b2dddbe1d7c0e324395d5f9dcc527ff/barcode/image/07e14829-41ba-44ad-85c9-5197ee8d34c2/51c0ac62-50b2-44cf-bec3-13ef3048d50f.svg",
        "owner_id": "ea926c13-010c-4e71-af8d-b164d9d8063e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ea926c13-010c-4e71-af8d-b164d9d8063e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7ecee1d3-4367-4deb-a995-df1b8cec6567&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7ecee1d3-4367-4deb-a995-df1b8cec6567",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T19:09:02+00:00",
        "updated_at": "2022-10-25T19:09:02+00:00",
        "number": "http://bqbl.it/7ecee1d3-4367-4deb-a995-df1b8cec6567",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3d3d843398d8bea0220c223720c9aa1d/barcode/image/7ecee1d3-4367-4deb-a995-df1b8cec6567/b63ec4a5-9c2f-41a4-9a55-0325ff4d59ac.svg",
        "owner_id": "ae85632f-4990-43e1-ae4f-7e1942d9fdd7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ae85632f-4990-43e1-ae4f-7e1942d9fdd7"
          },
          "data": {
            "type": "customers",
            "id": "ae85632f-4990-43e1-ae4f-7e1942d9fdd7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ae85632f-4990-43e1-ae4f-7e1942d9fdd7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T19:09:02+00:00",
        "updated_at": "2022-10-25T19:09:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ae85632f-4990-43e1-ae4f-7e1942d9fdd7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ae85632f-4990-43e1-ae4f-7e1942d9fdd7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ae85632f-4990-43e1-ae4f-7e1942d9fdd7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzljZDY1YjItMmJiNC00YzRhLWI4YzUtNWE1ODhmYTYyYTQx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "79cd65b2-2bb4-4c4a-b8c5-5a588fa62a41",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T19:09:02+00:00",
        "updated_at": "2022-10-25T19:09:02+00:00",
        "number": "http://bqbl.it/79cd65b2-2bb4-4c4a-b8c5-5a588fa62a41",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f03f9bce0797e9f4266c9ba0802e29ce/barcode/image/79cd65b2-2bb4-4c4a-b8c5-5a588fa62a41/021cdd6c-0fe6-4e07-87fe-c36c5507b369.svg",
        "owner_id": "f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1"
          },
          "data": {
            "type": "customers",
            "id": "f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T19:09:02+00:00",
        "updated_at": "2022-10-25T19:09:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f0d3fa05-ef1e-40fe-b13b-3bd81e31fec1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T19:08:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b034d29b-4763-4f6c-a101-31f84ff40c5d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b034d29b-4763-4f6c-a101-31f84ff40c5d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T19:09:03+00:00",
      "updated_at": "2022-10-25T19:09:03+00:00",
      "number": "http://bqbl.it/b034d29b-4763-4f6c-a101-31f84ff40c5d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c3890a5a69ad0f986e23f308d218d6fe/barcode/image/b034d29b-4763-4f6c-a101-31f84ff40c5d/35849833-71d2-4e14-a544-a401d80ecd11.svg",
      "owner_id": "fddc0a2e-4a9f-4d47-a96b-857c21fa8549",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fddc0a2e-4a9f-4d47-a96b-857c21fa8549"
        },
        "data": {
          "type": "customers",
          "id": "fddc0a2e-4a9f-4d47-a96b-857c21fa8549"
        }
      }
    }
  },
  "included": [
    {
      "id": "fddc0a2e-4a9f-4d47-a96b-857c21fa8549",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T19:09:03+00:00",
        "updated_at": "2022-10-25T19:09:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fddc0a2e-4a9f-4d47-a96b-857c21fa8549&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fddc0a2e-4a9f-4d47-a96b-857c21fa8549&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fddc0a2e-4a9f-4d47-a96b-857c21fa8549&filter[owner_type]=customers"
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
          "owner_id": "67ff42b5-7e68-45e4-8cec-51b9bcdad72d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6caf5c4f-4389-4dc7-b25a-43cbfebb2cce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T19:09:03+00:00",
      "updated_at": "2022-10-25T19:09:03+00:00",
      "number": "http://bqbl.it/6caf5c4f-4389-4dc7-b25a-43cbfebb2cce",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4102fdf7344ac0754b7afb71fa66238e/barcode/image/6caf5c4f-4389-4dc7-b25a-43cbfebb2cce/eb6717ff-a011-4235-bdb8-a6813de7a67d.svg",
      "owner_id": "67ff42b5-7e68-45e4-8cec-51b9bcdad72d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/11afeec7-28c6-4ff3-a6fc-ff39b5dbb330' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "11afeec7-28c6-4ff3-a6fc-ff39b5dbb330",
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
    "id": "11afeec7-28c6-4ff3-a6fc-ff39b5dbb330",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T19:09:04+00:00",
      "updated_at": "2022-10-25T19:09:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ff34877dd1d35cc9b72c1072638189be/barcode/image/11afeec7-28c6-4ff3-a6fc-ff39b5dbb330/e910b226-0134-4596-aaa7-5a61db5778fc.svg",
      "owner_id": "2e65786e-48a6-4b62-a311-b3a0321e2a5b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/18469dab-6ad4-4673-9a60-6da2209d8db9' \
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