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
      "id": "a057b514-f0ec-4fd0-848b-63f2a9422899",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T09:39:54+00:00",
        "updated_at": "2023-03-08T09:39:54+00:00",
        "number": "http://bqbl.it/a057b514-f0ec-4fd0-848b-63f2a9422899",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d540cc2fec757438424354b297cf25c0/barcode/image/a057b514-f0ec-4fd0-848b-63f2a9422899/07fa63a4-5df2-4120-be30-4c22a55cfcdd.svg",
        "owner_id": "cdc570a0-3676-48e7-9b1a-2314ab181cd7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cdc570a0-3676-48e7-9b1a-2314ab181cd7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6d529a6c-d4e3-4dd2-a413-cc8772d963b0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6d529a6c-d4e3-4dd2-a413-cc8772d963b0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T09:39:55+00:00",
        "updated_at": "2023-03-08T09:39:55+00:00",
        "number": "http://bqbl.it/6d529a6c-d4e3-4dd2-a413-cc8772d963b0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0baf815d9906a75c19b9bd2a0a25494c/barcode/image/6d529a6c-d4e3-4dd2-a413-cc8772d963b0/b78e823c-09b8-47af-8c84-3f76dbb53011.svg",
        "owner_id": "529a5fae-6fb1-4c90-b795-62b056a6dc21",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/529a5fae-6fb1-4c90-b795-62b056a6dc21"
          },
          "data": {
            "type": "customers",
            "id": "529a5fae-6fb1-4c90-b795-62b056a6dc21"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "529a5fae-6fb1-4c90-b795-62b056a6dc21",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T09:39:55+00:00",
        "updated_at": "2023-03-08T09:39:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=529a5fae-6fb1-4c90-b795-62b056a6dc21&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=529a5fae-6fb1-4c90-b795-62b056a6dc21&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=529a5fae-6fb1-4c90-b795-62b056a6dc21&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWVmNDI0MDMtMzgzYy00NThlLWE2MzYtNWI5YjhhMTQwNWM2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eef42403-383c-458e-a636-5b9b8a1405c6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T09:39:55+00:00",
        "updated_at": "2023-03-08T09:39:55+00:00",
        "number": "http://bqbl.it/eef42403-383c-458e-a636-5b9b8a1405c6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ecd6c323b2d7b3b7ee4745c7fe244a81/barcode/image/eef42403-383c-458e-a636-5b9b8a1405c6/35ac592b-681b-4268-bf1e-5fc7f434c4aa.svg",
        "owner_id": "87082173-84db-4b38-9ce9-05169f1d8b69",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87082173-84db-4b38-9ce9-05169f1d8b69"
          },
          "data": {
            "type": "customers",
            "id": "87082173-84db-4b38-9ce9-05169f1d8b69"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "87082173-84db-4b38-9ce9-05169f1d8b69",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T09:39:55+00:00",
        "updated_at": "2023-03-08T09:39:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=87082173-84db-4b38-9ce9-05169f1d8b69&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87082173-84db-4b38-9ce9-05169f1d8b69&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87082173-84db-4b38-9ce9-05169f1d8b69&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:39:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e32642ce-d03b-4eac-8b59-a188ea2deb59?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e32642ce-d03b-4eac-8b59-a188ea2deb59",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T09:39:56+00:00",
      "updated_at": "2023-03-08T09:39:56+00:00",
      "number": "http://bqbl.it/e32642ce-d03b-4eac-8b59-a188ea2deb59",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1bd2c9225350812b5710d71461dc896b/barcode/image/e32642ce-d03b-4eac-8b59-a188ea2deb59/e215b794-b46a-44da-bffd-40125ff00185.svg",
      "owner_id": "ee9a6230-d333-46a8-b755-db372bdf4b66",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ee9a6230-d333-46a8-b755-db372bdf4b66"
        },
        "data": {
          "type": "customers",
          "id": "ee9a6230-d333-46a8-b755-db372bdf4b66"
        }
      }
    }
  },
  "included": [
    {
      "id": "ee9a6230-d333-46a8-b755-db372bdf4b66",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T09:39:56+00:00",
        "updated_at": "2023-03-08T09:39:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee9a6230-d333-46a8-b755-db372bdf4b66&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee9a6230-d333-46a8-b755-db372bdf4b66&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee9a6230-d333-46a8-b755-db372bdf4b66&filter[owner_type]=customers"
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
          "owner_id": "2e3d769f-4e31-44db-9ab9-000961d40802",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "11a98d5d-f1ad-46a0-a8ae-a81eaf420c77",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T09:39:57+00:00",
      "updated_at": "2023-03-08T09:39:57+00:00",
      "number": "http://bqbl.it/11a98d5d-f1ad-46a0-a8ae-a81eaf420c77",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f07b0b02f40f277904d43f760ec42fc4/barcode/image/11a98d5d-f1ad-46a0-a8ae-a81eaf420c77/4156e545-4ed7-4b21-b48b-4677530b8405.svg",
      "owner_id": "2e3d769f-4e31-44db-9ab9-000961d40802",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d12d3b4-30b1-4be3-888d-0140376fd02d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d12d3b4-30b1-4be3-888d-0140376fd02d",
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
    "id": "2d12d3b4-30b1-4be3-888d-0140376fd02d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T09:39:57+00:00",
      "updated_at": "2023-03-08T09:39:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/646e9d23c5167968f786ceccb46a0e76/barcode/image/2d12d3b4-30b1-4be3-888d-0140376fd02d/bad693b8-cdf6-4fa5-8d2b-2c8c233972ad.svg",
      "owner_id": "1d319fe8-ad53-4b08-8325-59ed6217cc2c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4646be3c-9760-4ba1-b914-b12dc9ea79a9' \
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