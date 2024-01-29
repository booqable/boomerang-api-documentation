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

`DELETE /api/boomerang/barcodes/{id}`

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

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
      "id": "6669b043-a8cd-4f18-a5a5-ce6d0bd52d5d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-29T09:18:19+00:00",
        "updated_at": "2024-01-29T09:18:19+00:00",
        "number": "http://bqbl.it/6669b043-a8cd-4f18-a5a5-ce6d0bd52d5d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-157.shop.lvh.me:/barcodes/6669b043-a8cd-4f18-a5a5-ce6d0bd52d5d/image",
        "owner_id": "95bdd5c6-d90f-4c48-b464-22068e4c115f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/95bdd5c6-d90f-4c48-b464-22068e4c115f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F17f22247-09cb-42ae-9546-560e56af0228&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "17f22247-09cb-42ae-9546-560e56af0228",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-29T09:18:20+00:00",
        "updated_at": "2024-01-29T09:18:20+00:00",
        "number": "http://bqbl.it/17f22247-09cb-42ae-9546-560e56af0228",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-158.shop.lvh.me:/barcodes/17f22247-09cb-42ae-9546-560e56af0228/image",
        "owner_id": "ba5a72ce-aadd-42c9-bf31-fbd9bf12157a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ba5a72ce-aadd-42c9-bf31-fbd9bf12157a"
          },
          "data": {
            "type": "customers",
            "id": "ba5a72ce-aadd-42c9-bf31-fbd9bf12157a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ba5a72ce-aadd-42c9-bf31-fbd9bf12157a",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-29T09:18:20+00:00",
        "updated_at": "2024-01-29T09:18:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-39@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=ba5a72ce-aadd-42c9-bf31-fbd9bf12157a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ba5a72ce-aadd-42c9-bf31-fbd9bf12157a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ba5a72ce-aadd-42c9-bf31-fbd9bf12157a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOWM1NzMzYmYtMzI3Mi00NDY2LWFlYmEtZjA1ZTAzMjU3Y2M4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9c5733bf-3272-4466-aeba-f05e03257cc8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-29T09:18:21+00:00",
        "updated_at": "2024-01-29T09:18:21+00:00",
        "number": "http://bqbl.it/9c5733bf-3272-4466-aeba-f05e03257cc8",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-159.shop.lvh.me:/barcodes/9c5733bf-3272-4466-aeba-f05e03257cc8/image",
        "owner_id": "bb6b2383-68bf-476e-83bd-f524a5b6308c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bb6b2383-68bf-476e-83bd-f524a5b6308c"
          },
          "data": {
            "type": "customers",
            "id": "bb6b2383-68bf-476e-83bd-f524a5b6308c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bb6b2383-68bf-476e-83bd-f524a5b6308c",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-29T09:18:21+00:00",
        "updated_at": "2024-01-29T09:18:21+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-41@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=bb6b2383-68bf-476e-83bd-f524a5b6308c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bb6b2383-68bf-476e-83bd-f524a5b6308c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bb6b2383-68bf-476e-83bd-f524a5b6308c&filter[owner_type]=customers"
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/0c79e18b-2c9c-4e22-bdd0-89b78dbc079d' \
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
## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/30693b0d-fe3b-4db2-b411-7c5be0891924' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "30693b0d-fe3b-4db2-b411-7c5be0891924",
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
    "id": "30693b0d-fe3b-4db2-b411-7c5be0891924",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-29T09:18:22+00:00",
      "updated_at": "2024-01-29T09:18:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-161.shop.lvh.me:/barcodes/30693b0d-fe3b-4db2-b411-7c5be0891924/image",
      "owner_id": "2eafbb40-1dae-4eb9-b94b-5a466d34fd3f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/61a35c15-c73d-47e5-ad9c-0736cb4ede65?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "61a35c15-c73d-47e5-ad9c-0736cb4ede65",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-29T09:18:23+00:00",
      "updated_at": "2024-01-29T09:18:23+00:00",
      "number": "http://bqbl.it/61a35c15-c73d-47e5-ad9c-0736cb4ede65",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-162.shop.lvh.me:/barcodes/61a35c15-c73d-47e5-ad9c-0736cb4ede65/image",
      "owner_id": "24d162c6-495b-44ca-aa65-1b6f625f486d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/24d162c6-495b-44ca-aa65-1b6f625f486d"
        },
        "data": {
          "type": "customers",
          "id": "24d162c6-495b-44ca-aa65-1b6f625f486d"
        }
      }
    }
  },
  "included": [
    {
      "id": "24d162c6-495b-44ca-aa65-1b6f625f486d",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-29T09:18:23+00:00",
        "updated_at": "2024-01-29T09:18:23+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-44@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=24d162c6-495b-44ca-aa65-1b6f625f486d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=24d162c6-495b-44ca-aa65-1b6f625f486d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=24d162c6-495b-44ca-aa65-1b6f625f486d&filter[owner_type]=customers"
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
          "owner_id": "b4d37639-f52b-41f2-917d-e481172d9be6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "da813fb0-97ca-45a0-8393-d905549b2f3a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-29T09:18:24+00:00",
      "updated_at": "2024-01-29T09:18:24+00:00",
      "number": "http://bqbl.it/da813fb0-97ca-45a0-8393-d905549b2f3a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-163.shop.lvh.me:/barcodes/da813fb0-97ca-45a0-8393-d905549b2f3a/image",
      "owner_id": "b4d37639-f52b-41f2-917d-e481172d9be6",
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





