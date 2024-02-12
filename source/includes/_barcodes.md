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

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

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
          "owner_id": "c16e6137-4169-42d8-8ba2-92042f0d0ae0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "124e1b68-61a9-4744-9cf1-923a5ded3e27",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-12T09:15:10+00:00",
      "updated_at": "2024-02-12T09:15:10+00:00",
      "number": "http://bqbl.it/124e1b68-61a9-4744-9cf1-923a5ded3e27",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-112.shop.lvh.me:/barcodes/124e1b68-61a9-4744-9cf1-923a5ded3e27/image",
      "owner_id": "c16e6137-4169-42d8-8ba2-92042f0d0ae0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f9dbc9a-c97d-44b5-885b-59bbef77be4b' \
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b5dacce9-3d28-435d-80ea-19f91cf44fa5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b5dacce9-3d28-435d-80ea-19f91cf44fa5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-12T09:15:11+00:00",
      "updated_at": "2024-02-12T09:15:11+00:00",
      "number": "http://bqbl.it/b5dacce9-3d28-435d-80ea-19f91cf44fa5",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-114.shop.lvh.me:/barcodes/b5dacce9-3d28-435d-80ea-19f91cf44fa5/image",
      "owner_id": "961ca5e8-d3ea-4cb4-99ef-7616c99d35ed",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/961ca5e8-d3ea-4cb4-99ef-7616c99d35ed"
        },
        "data": {
          "type": "customers",
          "id": "961ca5e8-d3ea-4cb4-99ef-7616c99d35ed"
        }
      }
    }
  },
  "included": [
    {
      "id": "961ca5e8-d3ea-4cb4-99ef-7616c99d35ed",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-12T09:15:11+00:00",
        "updated_at": "2024-02-12T09:15:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-15@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=961ca5e8-d3ea-4cb4-99ef-7616c99d35ed&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=961ca5e8-d3ea-4cb4-99ef-7616c99d35ed&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=961ca5e8-d3ea-4cb4-99ef-7616c99d35ed&filter[owner_type]=customers"
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/d85dcf05-9fcd-4c0d-bd5d-accee6bbefce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d85dcf05-9fcd-4c0d-bd5d-accee6bbefce",
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
    "id": "d85dcf05-9fcd-4c0d-bd5d-accee6bbefce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-02-12T09:15:12+00:00",
      "updated_at": "2024-02-12T09:15:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-115.shop.lvh.me:/barcodes/d85dcf05-9fcd-4c0d-bd5d-accee6bbefce/image",
      "owner_id": "6536f7af-8123-4444-9d96-95ccabe32d29",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmViMThhYWUtNDhiNC00ZmM5LWJjYTItNzU1YzE4OWU4Njcy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2eb18aae-48b4-4fc9-bca2-755c189e8672",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-12T09:15:13+00:00",
        "updated_at": "2024-02-12T09:15:13+00:00",
        "number": "http://bqbl.it/2eb18aae-48b4-4fc9-bca2-755c189e8672",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-116.shop.lvh.me:/barcodes/2eb18aae-48b4-4fc9-bca2-755c189e8672/image",
        "owner_id": "f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6"
          },
          "data": {
            "type": "customers",
            "id": "f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-12T09:15:13+00:00",
        "updated_at": "2024-02-12T09:15:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f5af1e8f-aad5-4d4c-84cd-89fcbfbe95a6&filter[owner_type]=customers"
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
      "id": "732764c4-b262-47da-af8a-a8d04390feae",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-12T09:15:13+00:00",
        "updated_at": "2024-02-12T09:15:13+00:00",
        "number": "http://bqbl.it/732764c4-b262-47da-af8a-a8d04390feae",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-117.shop.lvh.me:/barcodes/732764c4-b262-47da-af8a-a8d04390feae/image",
        "owner_id": "78e97982-ce6f-4aae-9ab4-2c1a6eb00ddf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/78e97982-ce6f-4aae-9ab4-2c1a6eb00ddf"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8ef9c33a-a4a6-491b-929c-d96dc73faaf7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8ef9c33a-a4a6-491b-929c-d96dc73faaf7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-02-12T09:15:14+00:00",
        "updated_at": "2024-02-12T09:15:14+00:00",
        "number": "http://bqbl.it/8ef9c33a-a4a6-491b-929c-d96dc73faaf7",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-118.shop.lvh.me:/barcodes/8ef9c33a-a4a6-491b-929c-d96dc73faaf7/image",
        "owner_id": "dacd40e2-34b6-4a45-be6a-17ccc6cd62d3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dacd40e2-34b6-4a45-be6a-17ccc6cd62d3"
          },
          "data": {
            "type": "customers",
            "id": "dacd40e2-34b6-4a45-be6a-17ccc6cd62d3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dacd40e2-34b6-4a45-be6a-17ccc6cd62d3",
      "type": "customers",
      "attributes": {
        "created_at": "2024-02-12T09:15:14+00:00",
        "updated_at": "2024-02-12T09:15:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-20@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=dacd40e2-34b6-4a45-be6a-17ccc6cd62d3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dacd40e2-34b6-4a45-be6a-17ccc6cd62d3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dacd40e2-34b6-4a45-be6a-17ccc6cd62d3&filter[owner_type]=customers"
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





