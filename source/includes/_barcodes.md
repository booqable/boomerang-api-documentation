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
      "id": "96b80922-448c-4185-8c41-65d8db11287d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-30T08:57:04+00:00",
        "updated_at": "2022-11-30T08:57:04+00:00",
        "number": "http://bqbl.it/96b80922-448c-4185-8c41-65d8db11287d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/509e12a718660ffcac0bbfabd8217189/barcode/image/96b80922-448c-4185-8c41-65d8db11287d/7415269c-75bd-4b6c-8229-8f82b7e0e271.svg",
        "owner_id": "8813ba6d-bb27-40dc-ab64-c081331283ed",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8813ba6d-bb27-40dc-ab64-c081331283ed"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe5ad1613-fe11-4926-a676-f454be278e71&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e5ad1613-fe11-4926-a676-f454be278e71",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-30T08:57:04+00:00",
        "updated_at": "2022-11-30T08:57:04+00:00",
        "number": "http://bqbl.it/e5ad1613-fe11-4926-a676-f454be278e71",
        "barcode_type": "qr_code",
        "image_url": "/uploads/95e97221b4a46354977276e6dcbca91b/barcode/image/e5ad1613-fe11-4926-a676-f454be278e71/18b155f8-7b40-403b-a58b-d6ab2d7acbcf.svg",
        "owner_id": "263c6f80-425c-4eec-a968-9b48ce23913a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/263c6f80-425c-4eec-a968-9b48ce23913a"
          },
          "data": {
            "type": "customers",
            "id": "263c6f80-425c-4eec-a968-9b48ce23913a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "263c6f80-425c-4eec-a968-9b48ce23913a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-30T08:57:04+00:00",
        "updated_at": "2022-11-30T08:57:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=263c6f80-425c-4eec-a968-9b48ce23913a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=263c6f80-425c-4eec-a968-9b48ce23913a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=263c6f80-425c-4eec-a968-9b48ce23913a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOWVmZmZmOTktNjQ5Yy00Yjg1LWFiYjItMmRlMGQ0NjVlY2Q5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9effff99-649c-4b85-abb2-2de0d465ecd9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-30T08:57:05+00:00",
        "updated_at": "2022-11-30T08:57:05+00:00",
        "number": "http://bqbl.it/9effff99-649c-4b85-abb2-2de0d465ecd9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/21e0bb88b6052160fb58f072dabd40f8/barcode/image/9effff99-649c-4b85-abb2-2de0d465ecd9/fe221028-f679-4533-baf6-a41138f78f29.svg",
        "owner_id": "38b5afdc-58c7-4800-9268-cba1face97d1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/38b5afdc-58c7-4800-9268-cba1face97d1"
          },
          "data": {
            "type": "customers",
            "id": "38b5afdc-58c7-4800-9268-cba1face97d1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "38b5afdc-58c7-4800-9268-cba1face97d1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-30T08:57:05+00:00",
        "updated_at": "2022-11-30T08:57:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=38b5afdc-58c7-4800-9268-cba1face97d1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=38b5afdc-58c7-4800-9268-cba1face97d1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=38b5afdc-58c7-4800-9268-cba1face97d1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-30T08:56:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/85c88283-30f9-4d7e-a14d-ad255c3d6734?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "85c88283-30f9-4d7e-a14d-ad255c3d6734",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-30T08:57:05+00:00",
      "updated_at": "2022-11-30T08:57:05+00:00",
      "number": "http://bqbl.it/85c88283-30f9-4d7e-a14d-ad255c3d6734",
      "barcode_type": "qr_code",
      "image_url": "/uploads/34e97dc77bad2d856d9c3555c80a10e1/barcode/image/85c88283-30f9-4d7e-a14d-ad255c3d6734/fd06e0a0-c9fc-473f-a8a6-a66b0c75f63c.svg",
      "owner_id": "997ca37d-16f5-442b-8c41-88f7e8f14a4b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/997ca37d-16f5-442b-8c41-88f7e8f14a4b"
        },
        "data": {
          "type": "customers",
          "id": "997ca37d-16f5-442b-8c41-88f7e8f14a4b"
        }
      }
    }
  },
  "included": [
    {
      "id": "997ca37d-16f5-442b-8c41-88f7e8f14a4b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-30T08:57:05+00:00",
        "updated_at": "2022-11-30T08:57:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=997ca37d-16f5-442b-8c41-88f7e8f14a4b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=997ca37d-16f5-442b-8c41-88f7e8f14a4b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=997ca37d-16f5-442b-8c41-88f7e8f14a4b&filter[owner_type]=customers"
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
          "owner_id": "e450c1db-3a84-4d09-8322-26730b595aff",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7e89aa68-db87-4a8a-825d-8d79f8b29999",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-30T08:57:06+00:00",
      "updated_at": "2022-11-30T08:57:06+00:00",
      "number": "http://bqbl.it/7e89aa68-db87-4a8a-825d-8d79f8b29999",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1810812ee028ec25863a019db2872ede/barcode/image/7e89aa68-db87-4a8a-825d-8d79f8b29999/d3cbbc2a-1b08-47c0-a87f-870700ad3ec1.svg",
      "owner_id": "e450c1db-3a84-4d09-8322-26730b595aff",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3f7e858b-35d5-492b-bd35-b5fafc73d57b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3f7e858b-35d5-492b-bd35-b5fafc73d57b",
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
    "id": "3f7e858b-35d5-492b-bd35-b5fafc73d57b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-30T08:57:06+00:00",
      "updated_at": "2022-11-30T08:57:06+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/303109e37c9535afd9fcd07e8de8f8d3/barcode/image/3f7e858b-35d5-492b-bd35-b5fafc73d57b/bda651ee-462f-4226-9de3-1a6e2f03d4bb.svg",
      "owner_id": "1344e338-e77d-48ba-9564-1704a6a5b6b3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6c41d55c-7635-4251-949c-6e5425aeb711' \
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