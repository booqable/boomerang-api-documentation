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
      "id": "9b7a9e01-8e2e-4d2c-a56a-21d7a31a9e61",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T14:15:41+00:00",
        "updated_at": "2023-03-01T14:15:41+00:00",
        "number": "http://bqbl.it/9b7a9e01-8e2e-4d2c-a56a-21d7a31a9e61",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3cbdfa7a2523168e5cad61ef4dde9447/barcode/image/9b7a9e01-8e2e-4d2c-a56a-21d7a31a9e61/b46c0bd9-8d30-47c8-ba57-4280f44fd968.svg",
        "owner_id": "818cad7a-2c0f-4173-aa9b-e50599c78ec3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/818cad7a-2c0f-4173-aa9b-e50599c78ec3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F30d24f92-a00e-4ea0-b01f-5db102ea27aa&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "30d24f92-a00e-4ea0-b01f-5db102ea27aa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T14:15:41+00:00",
        "updated_at": "2023-03-01T14:15:41+00:00",
        "number": "http://bqbl.it/30d24f92-a00e-4ea0-b01f-5db102ea27aa",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1afe0b21f2859f3aa666a13ab89a6ed/barcode/image/30d24f92-a00e-4ea0-b01f-5db102ea27aa/656c812c-04e9-4946-b0d8-59f68f469889.svg",
        "owner_id": "1a646660-a367-4a1a-ad1b-30819358949c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1a646660-a367-4a1a-ad1b-30819358949c"
          },
          "data": {
            "type": "customers",
            "id": "1a646660-a367-4a1a-ad1b-30819358949c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1a646660-a367-4a1a-ad1b-30819358949c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T14:15:41+00:00",
        "updated_at": "2023-03-01T14:15:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1a646660-a367-4a1a-ad1b-30819358949c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1a646660-a367-4a1a-ad1b-30819358949c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1a646660-a367-4a1a-ad1b-30819358949c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmU3NWVkZjUtYjFlOC00Njk4LThjMDItYjFhZDgxNDk3YWY4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2e75edf5-b1e8-4698-8c02-b1ad81497af8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T14:15:42+00:00",
        "updated_at": "2023-03-01T14:15:42+00:00",
        "number": "http://bqbl.it/2e75edf5-b1e8-4698-8c02-b1ad81497af8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bd19b148074065b54d29821945999251/barcode/image/2e75edf5-b1e8-4698-8c02-b1ad81497af8/08112f6e-fb18-42c7-8ad3-077733a9e928.svg",
        "owner_id": "ca1553d5-151d-4286-9707-d850b450921e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ca1553d5-151d-4286-9707-d850b450921e"
          },
          "data": {
            "type": "customers",
            "id": "ca1553d5-151d-4286-9707-d850b450921e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ca1553d5-151d-4286-9707-d850b450921e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T14:15:42+00:00",
        "updated_at": "2023-03-01T14:15:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ca1553d5-151d-4286-9707-d850b450921e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ca1553d5-151d-4286-9707-d850b450921e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ca1553d5-151d-4286-9707-d850b450921e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:15:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5f80f6b7-c9eb-49a5-a65d-44613bebe17b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f80f6b7-c9eb-49a5-a65d-44613bebe17b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T14:15:43+00:00",
      "updated_at": "2023-03-01T14:15:43+00:00",
      "number": "http://bqbl.it/5f80f6b7-c9eb-49a5-a65d-44613bebe17b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/84e22d649d71ef776349ad8e55761c7f/barcode/image/5f80f6b7-c9eb-49a5-a65d-44613bebe17b/16c3df83-c4b7-44bc-b038-53efef868147.svg",
      "owner_id": "3d29e6ce-4fe8-4ed1-90b7-595cce679e42",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3d29e6ce-4fe8-4ed1-90b7-595cce679e42"
        },
        "data": {
          "type": "customers",
          "id": "3d29e6ce-4fe8-4ed1-90b7-595cce679e42"
        }
      }
    }
  },
  "included": [
    {
      "id": "3d29e6ce-4fe8-4ed1-90b7-595cce679e42",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T14:15:43+00:00",
        "updated_at": "2023-03-01T14:15:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3d29e6ce-4fe8-4ed1-90b7-595cce679e42&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3d29e6ce-4fe8-4ed1-90b7-595cce679e42&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3d29e6ce-4fe8-4ed1-90b7-595cce679e42&filter[owner_type]=customers"
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
          "owner_id": "a44c110a-16ea-4571-888b-0df39c639b3f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "18cfa698-5a9f-432d-8ad5-d65a91756041",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T14:15:44+00:00",
      "updated_at": "2023-03-01T14:15:44+00:00",
      "number": "http://bqbl.it/18cfa698-5a9f-432d-8ad5-d65a91756041",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ad6e7c81a006e8f2ff5f847d5a67e057/barcode/image/18cfa698-5a9f-432d-8ad5-d65a91756041/e629e8ef-096b-472b-b3a1-e4b8079f5bf4.svg",
      "owner_id": "a44c110a-16ea-4571-888b-0df39c639b3f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f9363229-00ba-4395-b05e-488c2f095181' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f9363229-00ba-4395-b05e-488c2f095181",
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
    "id": "f9363229-00ba-4395-b05e-488c2f095181",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T14:15:44+00:00",
      "updated_at": "2023-03-01T14:15:44+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7c5e8b0933390e78202ab4c082abd8ce/barcode/image/f9363229-00ba-4395-b05e-488c2f095181/0b8cbb10-23c7-4580-92eb-67ecdab22beb.svg",
      "owner_id": "95f4059e-f193-4b75-aa82-96c42609f7bb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/843f394d-f745-4701-9b67-4fc59cfd865c' \
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