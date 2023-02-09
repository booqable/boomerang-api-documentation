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
- | -
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
- | -
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
      "id": "d6f180fb-6021-4a61-bfc3-5b1e3f23c347",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T13:18:55+00:00",
        "updated_at": "2023-02-09T13:18:55+00:00",
        "number": "http://bqbl.it/d6f180fb-6021-4a61-bfc3-5b1e3f23c347",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7de10db5b537dece5240acf050214d27/barcode/image/d6f180fb-6021-4a61-bfc3-5b1e3f23c347/6b496683-e15f-4865-a3fe-8090996d4c1f.svg",
        "owner_id": "1e64a93f-6be6-417c-ae23-08ef70356ac1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1e64a93f-6be6-417c-ae23-08ef70356ac1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd962dbf2-98c5-4ab6-8b00-865a93918cad&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d962dbf2-98c5-4ab6-8b00-865a93918cad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T13:18:56+00:00",
        "updated_at": "2023-02-09T13:18:56+00:00",
        "number": "http://bqbl.it/d962dbf2-98c5-4ab6-8b00-865a93918cad",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6d3297287d064eada1ea548e0673837a/barcode/image/d962dbf2-98c5-4ab6-8b00-865a93918cad/9361d3fe-0809-4ec5-949e-bf32b82136a6.svg",
        "owner_id": "61c7bfa8-0e5c-4856-8806-a5dbf5b78670",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/61c7bfa8-0e5c-4856-8806-a5dbf5b78670"
          },
          "data": {
            "type": "customers",
            "id": "61c7bfa8-0e5c-4856-8806-a5dbf5b78670"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "61c7bfa8-0e5c-4856-8806-a5dbf5b78670",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T13:18:56+00:00",
        "updated_at": "2023-02-09T13:18:56+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=61c7bfa8-0e5c-4856-8806-a5dbf5b78670&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=61c7bfa8-0e5c-4856-8806-a5dbf5b78670&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=61c7bfa8-0e5c-4856-8806-a5dbf5b78670&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZmM1MmY5NTgtZjQxNi00Y2I3LTk0NGUtNGE0ZjQ3N2Q4NzE4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fc52f958-f416-4cb7-944e-4a4f477d8718",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T13:18:56+00:00",
        "updated_at": "2023-02-09T13:18:56+00:00",
        "number": "http://bqbl.it/fc52f958-f416-4cb7-944e-4a4f477d8718",
        "barcode_type": "qr_code",
        "image_url": "/uploads/54a772b560203a720a7b6d08e19db619/barcode/image/fc52f958-f416-4cb7-944e-4a4f477d8718/633249b9-1107-4889-93b2-b7859d6eb1c6.svg",
        "owner_id": "f71d75e6-0209-40d5-80f4-07b3737e9e19",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f71d75e6-0209-40d5-80f4-07b3737e9e19"
          },
          "data": {
            "type": "customers",
            "id": "f71d75e6-0209-40d5-80f4-07b3737e9e19"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f71d75e6-0209-40d5-80f4-07b3737e9e19",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T13:18:56+00:00",
        "updated_at": "2023-02-09T13:18:56+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=f71d75e6-0209-40d5-80f4-07b3737e9e19&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f71d75e6-0209-40d5-80f4-07b3737e9e19&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f71d75e6-0209-40d5-80f4-07b3737e9e19&filter[owner_type]=customers"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T13:18:36Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/8d423d6d-50bb-4fbf-945a-f70943d4ddf7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8d423d6d-50bb-4fbf-945a-f70943d4ddf7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T13:18:57+00:00",
      "updated_at": "2023-02-09T13:18:57+00:00",
      "number": "http://bqbl.it/8d423d6d-50bb-4fbf-945a-f70943d4ddf7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/825571d9421a4d30c1583d5395a61282/barcode/image/8d423d6d-50bb-4fbf-945a-f70943d4ddf7/9c4f602f-722e-4e44-a516-94c935f501bc.svg",
      "owner_id": "911cacb5-9783-45df-9b24-540f1e7e2598",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/911cacb5-9783-45df-9b24-540f1e7e2598"
        },
        "data": {
          "type": "customers",
          "id": "911cacb5-9783-45df-9b24-540f1e7e2598"
        }
      }
    }
  },
  "included": [
    {
      "id": "911cacb5-9783-45df-9b24-540f1e7e2598",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T13:18:57+00:00",
        "updated_at": "2023-02-09T13:18:57+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
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
            "related": "api/boomerang/properties?filter[owner_id]=911cacb5-9783-45df-9b24-540f1e7e2598&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=911cacb5-9783-45df-9b24-540f1e7e2598&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=911cacb5-9783-45df-9b24-540f1e7e2598&filter[owner_type]=customers"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "3a17b424-f689-4566-9e5a-0e62594354a5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2f112418-8b36-4db6-b1eb-1765b70eacbf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T13:18:57+00:00",
      "updated_at": "2023-02-09T13:18:57+00:00",
      "number": "http://bqbl.it/2f112418-8b36-4db6-b1eb-1765b70eacbf",
      "barcode_type": "qr_code",
      "image_url": "/uploads/508cd69f9041f376829939d7eb418fef/barcode/image/2f112418-8b36-4db6-b1eb-1765b70eacbf/5421cd66-6d91-4892-879f-47ae915069ab.svg",
      "owner_id": "3a17b424-f689-4566-9e5a-0e62594354a5",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cdb3eb65-f482-490b-9687-371d3d1735e4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cdb3eb65-f482-490b-9687-371d3d1735e4",
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
    "id": "cdb3eb65-f482-490b-9687-371d3d1735e4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T13:18:58+00:00",
      "updated_at": "2023-02-09T13:18:58+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3178766d61a7c9ba1bc8bd3607a2e5e4/barcode/image/cdb3eb65-f482-490b-9687-371d3d1735e4/751d1f34-6f90-41c7-b9d2-628eeb0d8532.svg",
      "owner_id": "f2325cc8-eda0-437f-9212-562d03bb0d10",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9a2e82e2-2eca-4740-9454-e2c6e9a44fb8' \
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes