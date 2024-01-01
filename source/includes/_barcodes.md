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

`GET /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

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


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/8b98ece6-e8d0-4e46-a005-a9784a8cb9dc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8b98ece6-e8d0-4e46-a005-a9784a8cb9dc",
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
    "id": "8b98ece6-e8d0-4e46-a005-a9784a8cb9dc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-01T09:15:16+00:00",
      "updated_at": "2024-01-01T09:15:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-94.shop.lvh.me:/barcodes/8b98ece6-e8d0-4e46-a005-a9784a8cb9dc/image",
      "owner_id": "3290a947-8bbb-4182-9bc2-18c4ec384d36",
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



> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGYwZGFiMTAtZjZkNy00MzYzLWI2NWMtZmYyMDFmMzM2ZjJl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4f0dab10-f6d7-4363-b65c-ff201f336f2e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-01T09:15:16+00:00",
        "updated_at": "2024-01-01T09:15:16+00:00",
        "number": "http://bqbl.it/4f0dab10-f6d7-4363-b65c-ff201f336f2e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-95.shop.lvh.me:/barcodes/4f0dab10-f6d7-4363-b65c-ff201f336f2e/image",
        "owner_id": "994f1656-dc5e-44f7-af40-1b7367503b80",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/994f1656-dc5e-44f7-af40-1b7367503b80"
          },
          "data": {
            "type": "customers",
            "id": "994f1656-dc5e-44f7-af40-1b7367503b80"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "994f1656-dc5e-44f7-af40-1b7367503b80",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-01T09:15:16+00:00",
        "updated_at": "2024-01-01T09:15:16+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
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
            "related": "api/boomerang/properties?filter[owner_id]=994f1656-dc5e-44f7-af40-1b7367503b80&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=994f1656-dc5e-44f7-af40-1b7367503b80&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=994f1656-dc5e-44f7-af40-1b7367503b80&filter[owner_type]=customers"
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
      "id": "e78ad1ce-de33-4e31-9eed-085eb9f6c7fa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-01T09:15:17+00:00",
        "updated_at": "2024-01-01T09:15:17+00:00",
        "number": "http://bqbl.it/e78ad1ce-de33-4e31-9eed-085eb9f6c7fa",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-96.shop.lvh.me:/barcodes/e78ad1ce-de33-4e31-9eed-085eb9f6c7fa/image",
        "owner_id": "3093b83a-b0c7-4aa7-b56a-f4d15137339f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3093b83a-b0c7-4aa7-b56a-f4d15137339f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9b4cefe-c650-4f55-a462-6e553a0d80f7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b9b4cefe-c650-4f55-a462-6e553a0d80f7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-01T09:15:18+00:00",
        "updated_at": "2024-01-01T09:15:18+00:00",
        "number": "http://bqbl.it/b9b4cefe-c650-4f55-a462-6e553a0d80f7",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-97.shop.lvh.me:/barcodes/b9b4cefe-c650-4f55-a462-6e553a0d80f7/image",
        "owner_id": "65248488-e8b7-4c0b-901e-8d19d75ef8fb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/65248488-e8b7-4c0b-901e-8d19d75ef8fb"
          },
          "data": {
            "type": "customers",
            "id": "65248488-e8b7-4c0b-901e-8d19d75ef8fb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "65248488-e8b7-4c0b-901e-8d19d75ef8fb",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-01T09:15:18+00:00",
        "updated_at": "2024-01-01T09:15:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-37@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=65248488-e8b7-4c0b-901e-8d19d75ef8fb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=65248488-e8b7-4c0b-901e-8d19d75ef8fb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=65248488-e8b7-4c0b-901e-8d19d75ef8fb&filter[owner_type]=customers"
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






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/2c9822c6-db9d-44e2-8dd8-c9f8d2e9c1d2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c9822c6-db9d-44e2-8dd8-c9f8d2e9c1d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-01T09:15:18+00:00",
      "updated_at": "2024-01-01T09:15:18+00:00",
      "number": "http://bqbl.it/2c9822c6-db9d-44e2-8dd8-c9f8d2e9c1d2",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-98.shop.lvh.me:/barcodes/2c9822c6-db9d-44e2-8dd8-c9f8d2e9c1d2/image",
      "owner_id": "ab249fe1-80db-4458-a8cb-21bc9c677742",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ab249fe1-80db-4458-a8cb-21bc9c677742"
        },
        "data": {
          "type": "customers",
          "id": "ab249fe1-80db-4458-a8cb-21bc9c677742"
        }
      }
    }
  },
  "included": [
    {
      "id": "ab249fe1-80db-4458-a8cb-21bc9c677742",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-01T09:15:18+00:00",
        "updated_at": "2024-01-01T09:15:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
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
            "related": "api/boomerang/properties?filter[owner_id]=ab249fe1-80db-4458-a8cb-21bc9c677742&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ab249fe1-80db-4458-a8cb-21bc9c677742&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ab249fe1-80db-4458-a8cb-21bc9c677742&filter[owner_type]=customers"
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a7352175-a514-4c99-9d85-ac6b805288fb' \
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
          "owner_id": "3e549770-7ed7-4965-9c74-d7af26438c56",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d83a175a-26d2-4116-bbee-3be6c8d97029",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-01T09:15:20+00:00",
      "updated_at": "2024-01-01T09:15:20+00:00",
      "number": "http://bqbl.it/d83a175a-26d2-4116-bbee-3be6c8d97029",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-100.shop.lvh.me:/barcodes/d83a175a-26d2-4116-bbee-3be6c8d97029/image",
      "owner_id": "3e549770-7ed7-4965-9c74-d7af26438c56",
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





