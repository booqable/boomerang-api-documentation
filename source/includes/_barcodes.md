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
      "id": "4931ee68-1055-428f-a770-951c7032931a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-16T14:22:06+00:00",
        "updated_at": "2022-11-16T14:22:06+00:00",
        "number": "http://bqbl.it/4931ee68-1055-428f-a770-951c7032931a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ee75d77d41c45ad688c7b1017eee2564/barcode/image/4931ee68-1055-428f-a770-951c7032931a/ebb3a72e-2090-4a75-9a68-20d6f5b00b5e.svg",
        "owner_id": "e9ee1992-6399-4bd7-9b32-7440389154be",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e9ee1992-6399-4bd7-9b32-7440389154be"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc30d21cf-e286-4993-ae11-f911ea555412&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c30d21cf-e286-4993-ae11-f911ea555412",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-16T14:22:07+00:00",
        "updated_at": "2022-11-16T14:22:07+00:00",
        "number": "http://bqbl.it/c30d21cf-e286-4993-ae11-f911ea555412",
        "barcode_type": "qr_code",
        "image_url": "/uploads/455582b15738c2d2c434efe5fb697994/barcode/image/c30d21cf-e286-4993-ae11-f911ea555412/5f8c964f-edad-4242-8044-56dc45acb75e.svg",
        "owner_id": "db1f8c32-2a39-45db-84c6-bdf141b35e2c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/db1f8c32-2a39-45db-84c6-bdf141b35e2c"
          },
          "data": {
            "type": "customers",
            "id": "db1f8c32-2a39-45db-84c6-bdf141b35e2c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "db1f8c32-2a39-45db-84c6-bdf141b35e2c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-16T14:22:07+00:00",
        "updated_at": "2022-11-16T14:22:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=db1f8c32-2a39-45db-84c6-bdf141b35e2c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=db1f8c32-2a39-45db-84c6-bdf141b35e2c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=db1f8c32-2a39-45db-84c6-bdf141b35e2c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjI2ZGE0ZTAtM2U0Mi00ZWUwLWEzZTctZDFlNWNkZjE5ZDlh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b26da4e0-3e42-4ee0-a3e7-d1e5cdf19d9a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-16T14:22:07+00:00",
        "updated_at": "2022-11-16T14:22:07+00:00",
        "number": "http://bqbl.it/b26da4e0-3e42-4ee0-a3e7-d1e5cdf19d9a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/83d6b3e6cb97e844d20115600edba739/barcode/image/b26da4e0-3e42-4ee0-a3e7-d1e5cdf19d9a/1fe47b23-3491-4696-9311-8423ae5e6807.svg",
        "owner_id": "a51c4dd8-0097-4f95-92a9-12b70d6288ad",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a51c4dd8-0097-4f95-92a9-12b70d6288ad"
          },
          "data": {
            "type": "customers",
            "id": "a51c4dd8-0097-4f95-92a9-12b70d6288ad"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a51c4dd8-0097-4f95-92a9-12b70d6288ad",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-16T14:22:07+00:00",
        "updated_at": "2022-11-16T14:22:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a51c4dd8-0097-4f95-92a9-12b70d6288ad&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a51c4dd8-0097-4f95-92a9-12b70d6288ad&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a51c4dd8-0097-4f95-92a9-12b70d6288ad&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:21:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/be9a50ad-a349-4255-ad37-d7aa2a262749?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be9a50ad-a349-4255-ad37-d7aa2a262749",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-16T14:22:08+00:00",
      "updated_at": "2022-11-16T14:22:08+00:00",
      "number": "http://bqbl.it/be9a50ad-a349-4255-ad37-d7aa2a262749",
      "barcode_type": "qr_code",
      "image_url": "/uploads/83ace92167f38e79291d8a76141deb63/barcode/image/be9a50ad-a349-4255-ad37-d7aa2a262749/1e66ff27-2430-4bb9-833b-35bdc2ae9545.svg",
      "owner_id": "ecdfcf26-db78-42d2-83a5-59e33659042d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ecdfcf26-db78-42d2-83a5-59e33659042d"
        },
        "data": {
          "type": "customers",
          "id": "ecdfcf26-db78-42d2-83a5-59e33659042d"
        }
      }
    }
  },
  "included": [
    {
      "id": "ecdfcf26-db78-42d2-83a5-59e33659042d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-16T14:22:08+00:00",
        "updated_at": "2022-11-16T14:22:08+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ecdfcf26-db78-42d2-83a5-59e33659042d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ecdfcf26-db78-42d2-83a5-59e33659042d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ecdfcf26-db78-42d2-83a5-59e33659042d&filter[owner_type]=customers"
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
          "owner_id": "3251133c-6c79-42fd-a200-d8a573b25f99",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "93dc339e-efa0-4d2f-b6f2-672cd4926994",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-16T14:22:09+00:00",
      "updated_at": "2022-11-16T14:22:09+00:00",
      "number": "http://bqbl.it/93dc339e-efa0-4d2f-b6f2-672cd4926994",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fbdc17a2db8c5b47a4c1cf9a862fe929/barcode/image/93dc339e-efa0-4d2f-b6f2-672cd4926994/3c64be9f-3aca-418f-9723-96ae952c1188.svg",
      "owner_id": "3251133c-6c79-42fd-a200-d8a573b25f99",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/efc5df6a-7849-4104-a145-e7981d776221' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "efc5df6a-7849-4104-a145-e7981d776221",
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
    "id": "efc5df6a-7849-4104-a145-e7981d776221",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-16T14:22:09+00:00",
      "updated_at": "2022-11-16T14:22:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a589d0c64293f38934cd51f17a2fefed/barcode/image/efc5df6a-7849-4104-a145-e7981d776221/c65cfae2-b11d-4f3a-8418-d2ac4c0be7dc.svg",
      "owner_id": "86758685-0293-4409-a00e-8e3b1be074d9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9e9d9633-04bd-4d31-b5d5-d9ffc4895a6d' \
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