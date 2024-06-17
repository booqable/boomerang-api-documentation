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
      "id": "6fb800a3-8310-49e0-86da-f8870601bd6f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-17T09:27:39.383851+00:00",
        "updated_at": "2024-06-17T09:27:39.383851+00:00",
        "number": "http://bqbl.it/6fb800a3-8310-49e0-86da-f8870601bd6f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-179.lvh.me:/barcodes/6fb800a3-8310-49e0-86da-f8870601bd6f/image",
        "owner_id": "e2c7a42e-484f-49f6-a96c-528f8961df74",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e2c7a42e-484f-49f6-a96c-528f8961df74"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffa3b4118-f886-4d16-b20d-9745824d9492&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fa3b4118-f886-4d16-b20d-9745824d9492",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-17T09:27:39.917066+00:00",
        "updated_at": "2024-06-17T09:27:39.917066+00:00",
        "number": "http://bqbl.it/fa3b4118-f886-4d16-b20d-9745824d9492",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-180.lvh.me:/barcodes/fa3b4118-f886-4d16-b20d-9745824d9492/image",
        "owner_id": "a9d36e2c-9f65-4073-846c-280af26d9860",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a9d36e2c-9f65-4073-846c-280af26d9860"
          },
          "data": {
            "type": "customers",
            "id": "a9d36e2c-9f65-4073-846c-280af26d9860"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a9d36e2c-9f65-4073-846c-280af26d9860",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-17T09:27:39.898219+00:00",
        "updated_at": "2024-06-17T09:27:39.919670+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-62@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=a9d36e2c-9f65-4073-846c-280af26d9860&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a9d36e2c-9f65-4073-846c-280af26d9860&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a9d36e2c-9f65-4073-846c-280af26d9860&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWM2ZjlhZGEtNjE3ZS00YTgyLThkZTctMWQ5MmUzYjNhMjA3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ac6f9ada-617e-4a82-8de7-1d92e3b3a207",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-17T09:27:38.817750+00:00",
        "updated_at": "2024-06-17T09:27:38.817750+00:00",
        "number": "http://bqbl.it/ac6f9ada-617e-4a82-8de7-1d92e3b3a207",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-178.lvh.me:/barcodes/ac6f9ada-617e-4a82-8de7-1d92e3b3a207/image",
        "owner_id": "0b019766-dc4a-4c74-958b-d2453fd57803",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0b019766-dc4a-4c74-958b-d2453fd57803"
          },
          "data": {
            "type": "customers",
            "id": "0b019766-dc4a-4c74-958b-d2453fd57803"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0b019766-dc4a-4c74-958b-d2453fd57803",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-17T09:27:38.797417+00:00",
        "updated_at": "2024-06-17T09:27:38.821005+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-60@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=0b019766-dc4a-4c74-958b-d2453fd57803&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0b019766-dc4a-4c74-958b-d2453fd57803&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0b019766-dc4a-4c74-958b-d2453fd57803&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/1533c2f6-488c-444e-ab06-27fef347b82e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1533c2f6-488c-444e-ab06-27fef347b82e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-17T09:27:41.704770+00:00",
      "updated_at": "2024-06-17T09:27:41.704770+00:00",
      "number": "http://bqbl.it/1533c2f6-488c-444e-ab06-27fef347b82e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-183.lvh.me:/barcodes/1533c2f6-488c-444e-ab06-27fef347b82e/image",
      "owner_id": "0fcdcce1-8aa2-4757-bff9-deef95d5f3c1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0fcdcce1-8aa2-4757-bff9-deef95d5f3c1"
        },
        "data": {
          "type": "customers",
          "id": "0fcdcce1-8aa2-4757-bff9-deef95d5f3c1"
        }
      }
    }
  },
  "included": [
    {
      "id": "0fcdcce1-8aa2-4757-bff9-deef95d5f3c1",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-17T09:27:41.687443+00:00",
        "updated_at": "2024-06-17T09:27:41.708711+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-66@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=0fcdcce1-8aa2-4757-bff9-deef95d5f3c1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0fcdcce1-8aa2-4757-bff9-deef95d5f3c1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0fcdcce1-8aa2-4757-bff9-deef95d5f3c1&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










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
          "owner_id": "e1bd6e90-ac84-426c-8c74-b51e4685b12f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c4e432d8-b9df-4464-9bd1-a2f88d8153f6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-17T09:27:40.515519+00:00",
      "updated_at": "2024-06-17T09:27:40.515519+00:00",
      "number": "http://bqbl.it/c4e432d8-b9df-4464-9bd1-a2f88d8153f6",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-181.lvh.me:/barcodes/c4e432d8-b9df-4464-9bd1-a2f88d8153f6/image",
      "owner_id": "e1bd6e90-ac84-426c-8c74-b51e4685b12f",
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

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/24ca71f4-3c4b-4530-80d2-9bc187f03123' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "24ca71f4-3c4b-4530-80d2-9bc187f03123",
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
    "id": "24ca71f4-3c4b-4530-80d2-9bc187f03123",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-17T09:27:42.288273+00:00",
      "updated_at": "2024-06-17T09:27:42.338543+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-184.lvh.me:/barcodes/24ca71f4-3c4b-4530-80d2-9bc187f03123/image",
      "owner_id": "6e55d286-a25d-4591-a32e-433d0d5669dc",
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

`owner` => 
`photo`


`product` => 
`photo`










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/ef8ecb81-088e-42dc-bcdd-5894ece9020c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ef8ecb81-088e-42dc-bcdd-5894ece9020c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-17T09:27:41.073750+00:00",
      "updated_at": "2024-06-17T09:27:41.073750+00:00",
      "number": "http://bqbl.it/ef8ecb81-088e-42dc-bcdd-5894ece9020c",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-182.lvh.me:/barcodes/ef8ecb81-088e-42dc-bcdd-5894ece9020c/image",
      "owner_id": "a1661a45-e234-4edb-9137-63a2610f6219",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a1661a45-e234-4edb-9137-63a2610f6219"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`









