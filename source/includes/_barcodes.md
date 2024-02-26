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
`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/c77526d1-0cc0-4bf3-9ea6-49824cbfda7c' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3e1f0e07-790c-461d-b909-aa2ecda595bd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3e1f0e07-790c-461d-b909-aa2ecda595bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-26T09:14:33+00:00",
        "updated_at": "2024-02-26T09:14:33+00:00",
        "number": "http://bqbl.it/3e1f0e07-790c-461d-b909-aa2ecda595bd",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-21.lvh.me:/barcodes/3e1f0e07-790c-461d-b909-aa2ecda595bd/image",
        "owner_id": "a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76"
          },
          "data": {
            "type": "customers",
            "id": "a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-26T09:14:33+00:00",
        "updated_at": "2024-02-26T09:14:33+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-3@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a02f1e8e-b39c-4ee8-b2fe-0e62e826cd76&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmQ0NGZiOGEtOTY0My00YzUzLTg3OGQtNDNmYzU5ZTY0Mzk3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6d44fb8a-9643-4c53-878d-43fc59e64397",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-26T09:14:34+00:00",
        "updated_at": "2024-02-26T09:14:34+00:00",
        "number": "http://bqbl.it/6d44fb8a-9643-4c53-878d-43fc59e64397",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-22.lvh.me:/barcodes/6d44fb8a-9643-4c53-878d-43fc59e64397/image",
        "owner_id": "e7c6e773-86aa-4f67-b036-cb19a5ebe1ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e7c6e773-86aa-4f67-b036-cb19a5ebe1ec"
          },
          "data": {
            "type": "customers",
            "id": "e7c6e773-86aa-4f67-b036-cb19a5ebe1ec"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e7c6e773-86aa-4f67-b036-cb19a5ebe1ec",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-26T09:14:34+00:00",
        "updated_at": "2024-02-26T09:14:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
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
            "related": "api/boomerang/properties?filter[owner_id]=e7c6e773-86aa-4f67-b036-cb19a5ebe1ec&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e7c6e773-86aa-4f67-b036-cb19a5ebe1ec&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e7c6e773-86aa-4f67-b036-cb19a5ebe1ec&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "09d05bad-d114-4158-9614-76867a8a1825",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-26T09:14:34+00:00",
        "updated_at": "2024-02-26T09:14:34+00:00",
        "number": "http://bqbl.it/09d05bad-d114-4158-9614-76867a8a1825",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-23.lvh.me:/barcodes/09d05bad-d114-4158-9614-76867a8a1825/image",
        "owner_id": "76bc279a-98b5-4b76-b2f2-295cadb894d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/76bc279a-98b5-4b76-b2f2-295cadb894d7"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


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
          "owner_id": "cc047d1f-7d03-486c-88a0-796738622ef3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "478fa3f7-43a9-4884-bd3f-60554079c2df",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-26T09:14:35+00:00",
      "updated_at": "2024-02-26T09:14:35+00:00",
      "number": "http://bqbl.it/478fa3f7-43a9-4884-bd3f-60554079c2df",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-24.lvh.me:/barcodes/478fa3f7-43a9-4884-bd3f-60554079c2df/image",
      "owner_id": "cc047d1f-7d03-486c-88a0-796738622ef3",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d73694b7-c1b8-4e53-bb2f-3fc9ef775ef6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d73694b7-c1b8-4e53-bb2f-3fc9ef775ef6",
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
    "id": "d73694b7-c1b8-4e53-bb2f-3fc9ef775ef6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-26T09:14:35+00:00",
      "updated_at": "2024-02-26T09:14:35+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-25.lvh.me:/barcodes/d73694b7-c1b8-4e53-bb2f-3fc9ef775ef6/image",
      "owner_id": "02c714e4-0d13-4734-bc24-c4284779f149",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/168b0ae1-5dc2-4203-a301-3250b9910d1f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "168b0ae1-5dc2-4203-a301-3250b9910d1f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-26T09:14:36+00:00",
      "updated_at": "2024-02-26T09:14:36+00:00",
      "number": "http://bqbl.it/168b0ae1-5dc2-4203-a301-3250b9910d1f",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-26.lvh.me:/barcodes/168b0ae1-5dc2-4203-a301-3250b9910d1f/image",
      "owner_id": "8f09a966-bb32-4c4e-8670-4ddc03080f32",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8f09a966-bb32-4c4e-8670-4ddc03080f32"
        },
        "data": {
          "type": "customers",
          "id": "8f09a966-bb32-4c4e-8670-4ddc03080f32"
        }
      }
    }
  },
  "included": [
    {
      "id": "8f09a966-bb32-4c4e-8670-4ddc03080f32",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-26T09:14:36+00:00",
        "updated_at": "2024-02-26T09:14:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-10@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=8f09a966-bb32-4c4e-8670-4ddc03080f32&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8f09a966-bb32-4c4e-8670-4ddc03080f32&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8f09a966-bb32-4c4e-8670-4ddc03080f32&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner`





