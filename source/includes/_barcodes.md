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
`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

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
          "owner_id": "a939c9b1-c31f-46db-83c3-4b4f62a6a162",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3f0522c9-1afa-4f50-8ae1-01a8cfdf7f6d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-06T09:24:06+00:00",
      "updated_at": "2024-05-06T09:24:06+00:00",
      "number": "http://bqbl.it/3f0522c9-1afa-4f50-8ae1-01a8cfdf7f6d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-139.lvh.me:/barcodes/3f0522c9-1afa-4f50-8ae1-01a8cfdf7f6d/image",
      "owner_id": "a939c9b1-c31f-46db-83c3-4b4f62a6a162",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc85b1d65-4400-427f-b8d4-e64da5252713&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c85b1d65-4400-427f-b8d4-e64da5252713",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-06T09:24:06+00:00",
        "updated_at": "2024-05-06T09:24:06+00:00",
        "number": "http://bqbl.it/c85b1d65-4400-427f-b8d4-e64da5252713",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-140.lvh.me:/barcodes/c85b1d65-4400-427f-b8d4-e64da5252713/image",
        "owner_id": "7ff93596-b4ff-47a6-82e5-f1975712d72f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7ff93596-b4ff-47a6-82e5-f1975712d72f"
          },
          "data": {
            "type": "customers",
            "id": "7ff93596-b4ff-47a6-82e5-f1975712d72f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7ff93596-b4ff-47a6-82e5-f1975712d72f",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-06T09:24:06+00:00",
        "updated_at": "2024-05-06T09:24:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-45@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ff93596-b4ff-47a6-82e5-f1975712d72f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ff93596-b4ff-47a6-82e5-f1975712d72f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7ff93596-b4ff-47a6-82e5-f1975712d72f&filter[owner_type]=customers"
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
      "id": "7709b894-164f-4306-bf4b-d50cff5fb330",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-06T09:24:07+00:00",
        "updated_at": "2024-05-06T09:24:07+00:00",
        "number": "http://bqbl.it/7709b894-164f-4306-bf4b-d50cff5fb330",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-141.lvh.me:/barcodes/7709b894-164f-4306-bf4b-d50cff5fb330/image",
        "owner_id": "662bc668-fde4-40ce-ad5a-796e5ca5bff4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/662bc668-fde4-40ce-ad5a-796e5ca5bff4"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjNmNDdlNDYtYTIwMC00YWJhLTg3MTktZDgzNGJjMmYwMzE2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f3f47e46-a200-4aba-8719-d834bc2f0316",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-06T09:24:08+00:00",
        "updated_at": "2024-05-06T09:24:08+00:00",
        "number": "http://bqbl.it/f3f47e46-a200-4aba-8719-d834bc2f0316",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-142.lvh.me:/barcodes/f3f47e46-a200-4aba-8719-d834bc2f0316/image",
        "owner_id": "1071997b-44d9-486c-833b-3ce63c1a2885",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1071997b-44d9-486c-833b-3ce63c1a2885"
          },
          "data": {
            "type": "customers",
            "id": "1071997b-44d9-486c-833b-3ce63c1a2885"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1071997b-44d9-486c-833b-3ce63c1a2885",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-06T09:24:08+00:00",
        "updated_at": "2024-05-06T09:24:08+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-48@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=1071997b-44d9-486c-833b-3ce63c1a2885&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1071997b-44d9-486c-833b-3ce63c1a2885&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1071997b-44d9-486c-833b-3ce63c1a2885&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ba87f4d5-354c-479c-a47f-e4a11e7e9cbf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ba87f4d5-354c-479c-a47f-e4a11e7e9cbf",
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
    "id": "ba87f4d5-354c-479c-a47f-e4a11e7e9cbf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-06T09:24:08+00:00",
      "updated_at": "2024-05-06T09:24:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-143.lvh.me:/barcodes/ba87f4d5-354c-479c-a47f-e4a11e7e9cbf/image",
      "owner_id": "ec21f533-e357-4ec3-af9d-f73013991b7d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cd525233-bb5e-4e1d-aae6-7abc25585364?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cd525233-bb5e-4e1d-aae6-7abc25585364",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-06T09:24:09+00:00",
      "updated_at": "2024-05-06T09:24:09+00:00",
      "number": "http://bqbl.it/cd525233-bb5e-4e1d-aae6-7abc25585364",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-144.lvh.me:/barcodes/cd525233-bb5e-4e1d-aae6-7abc25585364/image",
      "owner_id": "56c8bcaa-0d32-47e0-892e-964b761a2fa1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/56c8bcaa-0d32-47e0-892e-964b761a2fa1"
        },
        "data": {
          "type": "customers",
          "id": "56c8bcaa-0d32-47e0-892e-964b761a2fa1"
        }
      }
    }
  },
  "included": [
    {
      "id": "56c8bcaa-0d32-47e0-892e-964b761a2fa1",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-06T09:24:09+00:00",
        "updated_at": "2024-05-06T09:24:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-50@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=56c8bcaa-0d32-47e0-892e-964b761a2fa1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=56c8bcaa-0d32-47e0-892e-964b761a2fa1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=56c8bcaa-0d32-47e0-892e-964b761a2fa1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/91365892-c2bc-4707-9931-6b075245b1f5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "91365892-c2bc-4707-9931-6b075245b1f5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-06T09:24:09+00:00",
      "updated_at": "2024-05-06T09:24:09+00:00",
      "number": "http://bqbl.it/91365892-c2bc-4707-9931-6b075245b1f5",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-145.lvh.me:/barcodes/91365892-c2bc-4707-9931-6b075245b1f5/image",
      "owner_id": "54d3897b-2438-43e2-b7f9-8cabee3adb6c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/54d3897b-2438-43e2-b7f9-8cabee3adb6c"
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

`owner`





