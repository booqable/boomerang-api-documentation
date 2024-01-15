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

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

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
    --url 'https://example.booqable.com/api/boomerang/barcodes/60382287-9c42-43e4-9405-c6e381d4430e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "60382287-9c42-43e4-9405-c6e381d4430e",
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
    "id": "60382287-9c42-43e4-9405-c6e381d4430e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-15T09:13:17+00:00",
      "updated_at": "2024-01-15T09:13:17+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-17.shop.lvh.me:/barcodes/60382287-9c42-43e4-9405-c6e381d4430e/image",
      "owner_id": "5229c4d8-becd-42f8-9a76-f8bd6b3c102f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/66de5d0e-fc5f-4e75-ad83-3c85bd594e8f' \
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f048fdf5-58e0-41af-82a3-988a87787662?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f048fdf5-58e0-41af-82a3-988a87787662",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-15T09:13:18+00:00",
      "updated_at": "2024-01-15T09:13:18+00:00",
      "number": "http://bqbl.it/f048fdf5-58e0-41af-82a3-988a87787662",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-19.shop.lvh.me:/barcodes/f048fdf5-58e0-41af-82a3-988a87787662/image",
      "owner_id": "a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6"
        },
        "data": {
          "type": "customers",
          "id": "a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6"
        }
      }
    }
  },
  "included": [
    {
      "id": "a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-15T09:13:18+00:00",
        "updated_at": "2024-01-15T09:13:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a2f8d2ce-7374-4ca3-a3fc-1d57001e56a6&filter[owner_type]=customers"
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
      "id": "eb1c1ce9-b36e-495a-a2f0-9c0664781471",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-15T09:13:19+00:00",
        "updated_at": "2024-01-15T09:13:19+00:00",
        "number": "http://bqbl.it/eb1c1ce9-b36e-495a-a2f0-9c0664781471",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-20.shop.lvh.me:/barcodes/eb1c1ce9-b36e-495a-a2f0-9c0664781471/image",
        "owner_id": "d52526c2-5d56-40a5-b7fd-9c7cb53a93c2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d52526c2-5d56-40a5-b7fd-9c7cb53a93c2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTI1OGJkY2EtMWQ5Mi00YTVhLWFhZTItZTU5MmI1ZTk1ZDZm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5258bdca-1d92-4a5a-aae2-e592b5e95d6f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-15T09:13:20+00:00",
        "updated_at": "2024-01-15T09:13:20+00:00",
        "number": "http://bqbl.it/5258bdca-1d92-4a5a-aae2-e592b5e95d6f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-21.shop.lvh.me:/barcodes/5258bdca-1d92-4a5a-aae2-e592b5e95d6f/image",
        "owner_id": "df3d59c6-1cee-4d11-9587-849870697eae",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/df3d59c6-1cee-4d11-9587-849870697eae"
          },
          "data": {
            "type": "customers",
            "id": "df3d59c6-1cee-4d11-9587-849870697eae"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "df3d59c6-1cee-4d11-9587-849870697eae",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-15T09:13:20+00:00",
        "updated_at": "2024-01-15T09:13:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-6@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=df3d59c6-1cee-4d11-9587-849870697eae&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=df3d59c6-1cee-4d11-9587-849870697eae&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=df3d59c6-1cee-4d11-9587-849870697eae&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbc208374-cc41-42b3-a592-efd17e6cb092&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bc208374-cc41-42b3-a592-efd17e6cb092",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-15T09:13:21+00:00",
        "updated_at": "2024-01-15T09:13:21+00:00",
        "number": "http://bqbl.it/bc208374-cc41-42b3-a592-efd17e6cb092",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-22.shop.lvh.me:/barcodes/bc208374-cc41-42b3-a592-efd17e6cb092/image",
        "owner_id": "ab6f3035-39c4-4537-8eb7-58955db1a457",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ab6f3035-39c4-4537-8eb7-58955db1a457"
          },
          "data": {
            "type": "customers",
            "id": "ab6f3035-39c4-4537-8eb7-58955db1a457"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ab6f3035-39c4-4537-8eb7-58955db1a457",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-15T09:13:21+00:00",
        "updated_at": "2024-01-15T09:13:21+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-7@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=ab6f3035-39c4-4537-8eb7-58955db1a457&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ab6f3035-39c4-4537-8eb7-58955db1a457&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ab6f3035-39c4-4537-8eb7-58955db1a457&filter[owner_type]=customers"
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
          "owner_id": "1eaa243c-705d-4154-ba88-326a9f1aed0c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "79657179-61b5-46b7-a15d-a306da7ed6b3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-15T09:13:22+00:00",
      "updated_at": "2024-01-15T09:13:22+00:00",
      "number": "http://bqbl.it/79657179-61b5-46b7-a15d-a306da7ed6b3",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-23.shop.lvh.me:/barcodes/79657179-61b5-46b7-a15d-a306da7ed6b3/image",
      "owner_id": "1eaa243c-705d-4154-ba88-326a9f1aed0c",
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





