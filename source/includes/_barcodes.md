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

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

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
          "owner_id": "e090a708-7166-4a5b-b9fd-b1a8caf7082d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4be6b489-4465-47ab-a9ed-00e064272a19",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-22T09:23:16+00:00",
      "updated_at": "2024-04-22T09:23:16+00:00",
      "number": "http://bqbl.it/4be6b489-4465-47ab-a9ed-00e064272a19",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-43.lvh.me:/barcodes/4be6b489-4465-47ab-a9ed-00e064272a19/image",
      "owner_id": "e090a708-7166-4a5b-b9fd-b1a8caf7082d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b585bd7d-0d95-4a00-97d1-60b62d661eb7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b585bd7d-0d95-4a00-97d1-60b62d661eb7",
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
    "id": "b585bd7d-0d95-4a00-97d1-60b62d661eb7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-22T09:23:17+00:00",
      "updated_at": "2024-04-22T09:23:17+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-44.lvh.me:/barcodes/b585bd7d-0d95-4a00-97d1-60b62d661eb7/image",
      "owner_id": "f6e51b45-eb57-4253-8eea-7e4c5a873ef9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDlhMTM2MDAtMTBiYS00MDkxLThkZjctNjc3NDdhNjg3YzZl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "49a13600-10ba-4091-8df7-67747a687c6e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-22T09:23:18+00:00",
        "updated_at": "2024-04-22T09:23:18+00:00",
        "number": "http://bqbl.it/49a13600-10ba-4091-8df7-67747a687c6e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-45.lvh.me:/barcodes/49a13600-10ba-4091-8df7-67747a687c6e/image",
        "owner_id": "f6d7015c-6678-44d6-a2fd-f93e21014008",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f6d7015c-6678-44d6-a2fd-f93e21014008"
          },
          "data": {
            "type": "customers",
            "id": "f6d7015c-6678-44d6-a2fd-f93e21014008"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f6d7015c-6678-44d6-a2fd-f93e21014008",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-22T09:23:18+00:00",
        "updated_at": "2024-04-22T09:23:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-18@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=f6d7015c-6678-44d6-a2fd-f93e21014008&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f6d7015c-6678-44d6-a2fd-f93e21014008&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f6d7015c-6678-44d6-a2fd-f93e21014008&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fab2ea2f3-3c23-4370-a6d6-983ae0eec843&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ab2ea2f3-3c23-4370-a6d6-983ae0eec843",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-22T09:23:19+00:00",
        "updated_at": "2024-04-22T09:23:19+00:00",
        "number": "http://bqbl.it/ab2ea2f3-3c23-4370-a6d6-983ae0eec843",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-46.lvh.me:/barcodes/ab2ea2f3-3c23-4370-a6d6-983ae0eec843/image",
        "owner_id": "95d8da0a-1509-4796-b27e-1952331961ce",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/95d8da0a-1509-4796-b27e-1952331961ce"
          },
          "data": {
            "type": "customers",
            "id": "95d8da0a-1509-4796-b27e-1952331961ce"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "95d8da0a-1509-4796-b27e-1952331961ce",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-22T09:23:19+00:00",
        "updated_at": "2024-04-22T09:23:19+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-19@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=95d8da0a-1509-4796-b27e-1952331961ce&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=95d8da0a-1509-4796-b27e-1952331961ce&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=95d8da0a-1509-4796-b27e-1952331961ce&filter[owner_type]=customers"
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
      "id": "99bed6a3-5e28-413d-b309-f118fe50f2a6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-22T09:23:20+00:00",
        "updated_at": "2024-04-22T09:23:20+00:00",
        "number": "http://bqbl.it/99bed6a3-5e28-413d-b309-f118fe50f2a6",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-47.lvh.me:/barcodes/99bed6a3-5e28-413d-b309-f118fe50f2a6/image",
        "owner_id": "b0c022da-bd7e-47e0-af69-4d4ffd0256ea",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0c022da-bd7e-47e0-af69-4d4ffd0256ea"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f72a88b0-d056-4392-b0b0-7145247e2f2e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f72a88b0-d056-4392-b0b0-7145247e2f2e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-22T09:23:20+00:00",
      "updated_at": "2024-04-22T09:23:20+00:00",
      "number": "http://bqbl.it/f72a88b0-d056-4392-b0b0-7145247e2f2e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-48.lvh.me:/barcodes/f72a88b0-d056-4392-b0b0-7145247e2f2e/image",
      "owner_id": "1ecca560-2287-4911-b27d-7a5cc582ccf9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1ecca560-2287-4911-b27d-7a5cc582ccf9"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/9ad0134c-9c13-4b68-a999-1f2d085e8d8a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9ad0134c-9c13-4b68-a999-1f2d085e8d8a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-22T09:23:21+00:00",
      "updated_at": "2024-04-22T09:23:21+00:00",
      "number": "http://bqbl.it/9ad0134c-9c13-4b68-a999-1f2d085e8d8a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-49.lvh.me:/barcodes/9ad0134c-9c13-4b68-a999-1f2d085e8d8a/image",
      "owner_id": "400eecbe-5f06-4e79-9cfc-07bae6bb9c11",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/400eecbe-5f06-4e79-9cfc-07bae6bb9c11"
        },
        "data": {
          "type": "customers",
          "id": "400eecbe-5f06-4e79-9cfc-07bae6bb9c11"
        }
      }
    }
  },
  "included": [
    {
      "id": "400eecbe-5f06-4e79-9cfc-07bae6bb9c11",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-22T09:23:21+00:00",
        "updated_at": "2024-04-22T09:23:21+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-22@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=400eecbe-5f06-4e79-9cfc-07bae6bb9c11&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=400eecbe-5f06-4e79-9cfc-07bae6bb9c11&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=400eecbe-5f06-4e79-9cfc-07bae6bb9c11&filter[owner_type]=customers"
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





