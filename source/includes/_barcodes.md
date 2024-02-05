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
`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

`POST /api/boomerang/barcodes`

`DELETE /api/boomerang/barcodes/{id}`

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


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/83a516f3-5e6d-41d6-a345-3886b698e4bd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "83a516f3-5e6d-41d6-a345-3886b698e4bd",
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
    "id": "83a516f3-5e6d-41d6-a345-3886b698e4bd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-05T09:17:35+00:00",
      "updated_at": "2024-02-05T09:17:35+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-140.shop.lvh.me:/barcodes/83a516f3-5e6d-41d6-a345-3886b698e4bd/image",
      "owner_id": "1d381c64-6178-4970-a9bd-b3023b821ba1",
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






## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F481d128d-e0bc-488c-b5e4-f2f7b5b32f6d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "481d128d-e0bc-488c-b5e4-f2f7b5b32f6d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-05T09:17:36+00:00",
        "updated_at": "2024-02-05T09:17:36+00:00",
        "number": "http://bqbl.it/481d128d-e0bc-488c-b5e4-f2f7b5b32f6d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-141.shop.lvh.me:/barcodes/481d128d-e0bc-488c-b5e4-f2f7b5b32f6d/image",
        "owner_id": "c31f88d4-bc3f-4a61-9736-210a6a093b57",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c31f88d4-bc3f-4a61-9736-210a6a093b57"
          },
          "data": {
            "type": "customers",
            "id": "c31f88d4-bc3f-4a61-9736-210a6a093b57"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c31f88d4-bc3f-4a61-9736-210a6a093b57",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-05T09:17:36+00:00",
        "updated_at": "2024-02-05T09:17:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-35@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=c31f88d4-bc3f-4a61-9736-210a6a093b57&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c31f88d4-bc3f-4a61-9736-210a6a093b57&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c31f88d4-bc3f-4a61-9736-210a6a093b57&filter[owner_type]=customers"
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
      "id": "1b1bd9ea-641d-47b4-a4f9-05bc67007b8e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-05T09:17:37+00:00",
        "updated_at": "2024-02-05T09:17:37+00:00",
        "number": "http://bqbl.it/1b1bd9ea-641d-47b4-a4f9-05bc67007b8e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-142.shop.lvh.me:/barcodes/1b1bd9ea-641d-47b4-a4f9-05bc67007b8e/image",
        "owner_id": "2ae45662-2971-46b5-839d-c80c378897bf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2ae45662-2971-46b5-839d-c80c378897bf"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGI3ZGI5NGMtY2RjZC00OTE3LThjYjgtZGU1MGIzNmQzOWMw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "db7db94c-cdcd-4917-8cb8-de50b36d39c0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-05T09:17:38+00:00",
        "updated_at": "2024-02-05T09:17:38+00:00",
        "number": "http://bqbl.it/db7db94c-cdcd-4917-8cb8-de50b36d39c0",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-143.shop.lvh.me:/barcodes/db7db94c-cdcd-4917-8cb8-de50b36d39c0/image",
        "owner_id": "4551232c-4192-4868-955f-2d612bc616aa",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4551232c-4192-4868-955f-2d612bc616aa"
          },
          "data": {
            "type": "customers",
            "id": "4551232c-4192-4868-955f-2d612bc616aa"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4551232c-4192-4868-955f-2d612bc616aa",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-05T09:17:38+00:00",
        "updated_at": "2024-02-05T09:17:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-38@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=4551232c-4192-4868-955f-2d612bc616aa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4551232c-4192-4868-955f-2d612bc616aa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4551232c-4192-4868-955f-2d612bc616aa&filter[owner_type]=customers"
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
          "owner_id": "1db507f8-3fbe-4f95-b0eb-f1ef49dc2c33",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d606e74f-3596-4b6e-9a1e-edb5dc0aec03",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-05T09:17:40+00:00",
      "updated_at": "2024-02-05T09:17:40+00:00",
      "number": "http://bqbl.it/d606e74f-3596-4b6e-9a1e-edb5dc0aec03",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-144.shop.lvh.me:/barcodes/d606e74f-3596-4b6e-9a1e-edb5dc0aec03/image",
      "owner_id": "1db507f8-3fbe-4f95-b0eb-f1ef49dc2c33",
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/699bca77-c706-4c17-b9da-f5683289587c' \
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
## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9c5873d-0677-4a28-a7d3-56b6d489f6c1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a9c5873d-0677-4a28-a7d3-56b6d489f6c1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-05T09:17:43+00:00",
      "updated_at": "2024-02-05T09:17:43+00:00",
      "number": "http://bqbl.it/a9c5873d-0677-4a28-a7d3-56b6d489f6c1",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-146.shop.lvh.me:/barcodes/a9c5873d-0677-4a28-a7d3-56b6d489f6c1/image",
      "owner_id": "15c1523c-3beb-461e-b27a-b15c2eaef0db",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/15c1523c-3beb-461e-b27a-b15c2eaef0db"
        },
        "data": {
          "type": "customers",
          "id": "15c1523c-3beb-461e-b27a-b15c2eaef0db"
        }
      }
    }
  },
  "included": [
    {
      "id": "15c1523c-3beb-461e-b27a-b15c2eaef0db",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-05T09:17:43+00:00",
        "updated_at": "2024-02-05T09:17:43+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-42@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=15c1523c-3beb-461e-b27a-b15c2eaef0db&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=15c1523c-3beb-461e-b27a-b15c2eaef0db&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=15c1523c-3beb-461e-b27a-b15c2eaef0db&filter[owner_type]=customers"
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





