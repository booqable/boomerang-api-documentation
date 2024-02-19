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
`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

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


## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/7082bafc-b95d-4361-bb8c-fadebb4d9b2a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7082bafc-b95d-4361-bb8c-fadebb4d9b2a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-19T09:17:56+00:00",
      "updated_at": "2024-02-19T09:17:56+00:00",
      "number": "http://bqbl.it/7082bafc-b95d-4361-bb8c-fadebb4d9b2a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-144.lvh.me:/barcodes/7082bafc-b95d-4361-bb8c-fadebb4d9b2a/image",
      "owner_id": "0d206d20-ef00-4d4e-a66e-e99317f0a3b8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0d206d20-ef00-4d4e-a66e-e99317f0a3b8"
        },
        "data": {
          "type": "customers",
          "id": "0d206d20-ef00-4d4e-a66e-e99317f0a3b8"
        }
      }
    }
  },
  "included": [
    {
      "id": "0d206d20-ef00-4d4e-a66e-e99317f0a3b8",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-19T09:17:56+00:00",
        "updated_at": "2024-02-19T09:17:56+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-51@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d206d20-ef00-4d4e-a66e-e99317f0a3b8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d206d20-ef00-4d4e-a66e-e99317f0a3b8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d206d20-ef00-4d4e-a66e-e99317f0a3b8&filter[owner_type]=customers"
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
          "owner_id": "768cde67-bf17-4ac9-9f9e-48d310dd7149",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d11c519d-a5c9-4397-b151-4c3482f29985",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-19T09:17:57+00:00",
      "updated_at": "2024-02-19T09:17:57+00:00",
      "number": "http://bqbl.it/d11c519d-a5c9-4397-b151-4c3482f29985",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-145.lvh.me:/barcodes/d11c519d-a5c9-4397-b151-4c3482f29985/image",
      "owner_id": "768cde67-bf17-4ac9-9f9e-48d310dd7149",
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






## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5aae217d-006b-4640-9452-58a0688fb5d5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5aae217d-006b-4640-9452-58a0688fb5d5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-19T09:17:58+00:00",
        "updated_at": "2024-02-19T09:17:58+00:00",
        "number": "http://bqbl.it/5aae217d-006b-4640-9452-58a0688fb5d5",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-146.lvh.me:/barcodes/5aae217d-006b-4640-9452-58a0688fb5d5/image",
        "owner_id": "bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5"
          },
          "data": {
            "type": "customers",
            "id": "bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-19T09:17:58+00:00",
        "updated_at": "2024-02-19T09:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-54@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bd6b7ab2-1714-45bb-acd3-4a17cc2a18b5&filter[owner_type]=customers"
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
      "id": "f811fba2-8162-44dd-9f95-d838523132a8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-19T09:17:58+00:00",
        "updated_at": "2024-02-19T09:17:58+00:00",
        "number": "http://bqbl.it/f811fba2-8162-44dd-9f95-d838523132a8",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-147.lvh.me:/barcodes/f811fba2-8162-44dd-9f95-d838523132a8/image",
        "owner_id": "2eff22d6-8bbf-4b9d-9191-9a9690f6a7e2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2eff22d6-8bbf-4b9d-9191-9a9690f6a7e2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTBmOGY0OTMtYWYzNy00NjBlLTlmY2ItYzcxZjU5ZTc1MDli&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a0f8f493-af37-460e-9fcb-c71f59e7509b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-19T09:17:59+00:00",
        "updated_at": "2024-02-19T09:17:59+00:00",
        "number": "http://bqbl.it/a0f8f493-af37-460e-9fcb-c71f59e7509b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-148.lvh.me:/barcodes/a0f8f493-af37-460e-9fcb-c71f59e7509b/image",
        "owner_id": "8231de81-93e6-44b5-a4b4-60cdbc4bf052",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8231de81-93e6-44b5-a4b4-60cdbc4bf052"
          },
          "data": {
            "type": "customers",
            "id": "8231de81-93e6-44b5-a4b4-60cdbc4bf052"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8231de81-93e6-44b5-a4b4-60cdbc4bf052",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-19T09:17:59+00:00",
        "updated_at": "2024-02-19T09:17:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-57@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=8231de81-93e6-44b5-a4b4-60cdbc4bf052&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8231de81-93e6-44b5-a4b4-60cdbc4bf052&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8231de81-93e6-44b5-a4b4-60cdbc4bf052&filter[owner_type]=customers"
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/ca1af2cf-4dc1-4f5a-946e-88b3a0bcfeea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ca1af2cf-4dc1-4f5a-946e-88b3a0bcfeea",
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
    "id": "ca1af2cf-4dc1-4f5a-946e-88b3a0bcfeea",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-19T09:18:00+00:00",
      "updated_at": "2024-02-19T09:18:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-149.lvh.me:/barcodes/ca1af2cf-4dc1-4f5a-946e-88b3a0bcfeea/image",
      "owner_id": "7cf06871-cd4a-4c88-97db-0b9b215eb9a1",
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/1a885d44-1f34-4b7f-b2da-7de5c4f1d33e' \
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