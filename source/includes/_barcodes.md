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
      "id": "42e25c03-6cdb-4896-92a2-fe93b80088a3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T15:31:51+00:00",
        "updated_at": "2022-11-22T15:31:51+00:00",
        "number": "http://bqbl.it/42e25c03-6cdb-4896-92a2-fe93b80088a3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7990f387f5ca5fea8a79d957aa636531/barcode/image/42e25c03-6cdb-4896-92a2-fe93b80088a3/77d36f9d-b543-4e96-9171-7c3138a04902.svg",
        "owner_id": "7d247ea9-ff15-49a1-92f3-54c866ca3ea5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7d247ea9-ff15-49a1-92f3-54c866ca3ea5"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2f0e7795-6994-4ab6-9fe2-23fd59ffee53&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2f0e7795-6994-4ab6-9fe2-23fd59ffee53",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T15:31:52+00:00",
        "updated_at": "2022-11-22T15:31:52+00:00",
        "number": "http://bqbl.it/2f0e7795-6994-4ab6-9fe2-23fd59ffee53",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c10b2c9bca0ba87fc9cb31124c9cd8ff/barcode/image/2f0e7795-6994-4ab6-9fe2-23fd59ffee53/1a584a86-b96b-4509-b22a-ccbe773c45b1.svg",
        "owner_id": "a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e"
          },
          "data": {
            "type": "customers",
            "id": "a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T15:31:52+00:00",
        "updated_at": "2022-11-22T15:31:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a5cf80a1-e09a-4f67-8aa3-a5beaabfd77e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmNjYjg0OGItMmU5Ni00ZjU5LWI5ZTUtNTM1YmY2NmU5YmM4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6ccb848b-2e96-4f59-b9e5-535bf66e9bc8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T15:31:52+00:00",
        "updated_at": "2022-11-22T15:31:52+00:00",
        "number": "http://bqbl.it/6ccb848b-2e96-4f59-b9e5-535bf66e9bc8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b5cd83baa35478e71362b45b54c704ac/barcode/image/6ccb848b-2e96-4f59-b9e5-535bf66e9bc8/8d8b5b3b-7714-4bc7-ad97-8a88819a508b.svg",
        "owner_id": "8b9cdb9a-c0b7-4a0d-b114-950bccededa0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8b9cdb9a-c0b7-4a0d-b114-950bccededa0"
          },
          "data": {
            "type": "customers",
            "id": "8b9cdb9a-c0b7-4a0d-b114-950bccededa0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8b9cdb9a-c0b7-4a0d-b114-950bccededa0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T15:31:52+00:00",
        "updated_at": "2022-11-22T15:31:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8b9cdb9a-c0b7-4a0d-b114-950bccededa0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8b9cdb9a-c0b7-4a0d-b114-950bccededa0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8b9cdb9a-c0b7-4a0d-b114-950bccededa0&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:31:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ae42855e-67b2-476a-b3e0-7a7b28352b34?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ae42855e-67b2-476a-b3e0-7a7b28352b34",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T15:31:53+00:00",
      "updated_at": "2022-11-22T15:31:53+00:00",
      "number": "http://bqbl.it/ae42855e-67b2-476a-b3e0-7a7b28352b34",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9f3394c21db10ad0305f9699256e497d/barcode/image/ae42855e-67b2-476a-b3e0-7a7b28352b34/23a45c03-2315-4c24-add3-4f93c5eaf9dd.svg",
      "owner_id": "a8322d53-969b-4509-bd18-3f676252c83e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a8322d53-969b-4509-bd18-3f676252c83e"
        },
        "data": {
          "type": "customers",
          "id": "a8322d53-969b-4509-bd18-3f676252c83e"
        }
      }
    }
  },
  "included": [
    {
      "id": "a8322d53-969b-4509-bd18-3f676252c83e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T15:31:53+00:00",
        "updated_at": "2022-11-22T15:31:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a8322d53-969b-4509-bd18-3f676252c83e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a8322d53-969b-4509-bd18-3f676252c83e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a8322d53-969b-4509-bd18-3f676252c83e&filter[owner_type]=customers"
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
          "owner_id": "d7ff156c-1a46-4380-8701-272aeab3474e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c4f67eae-2fe9-4cdc-849e-47577a2aebe0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T15:31:54+00:00",
      "updated_at": "2022-11-22T15:31:54+00:00",
      "number": "http://bqbl.it/c4f67eae-2fe9-4cdc-849e-47577a2aebe0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0a1c391b2523da07b2359493e22a0c0a/barcode/image/c4f67eae-2fe9-4cdc-849e-47577a2aebe0/c109cfde-afa8-48af-aaf0-8f56001d423c.svg",
      "owner_id": "d7ff156c-1a46-4380-8701-272aeab3474e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f5aa04dd-8ff7-4682-92ca-d637e0855c6d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f5aa04dd-8ff7-4682-92ca-d637e0855c6d",
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
    "id": "f5aa04dd-8ff7-4682-92ca-d637e0855c6d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T15:31:54+00:00",
      "updated_at": "2022-11-22T15:31:54+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8a8ad4483fe44b5aea10f47fd5e25f5a/barcode/image/f5aa04dd-8ff7-4682-92ca-d637e0855c6d/c21f491b-94f9-48dc-8b86-486326349327.svg",
      "owner_id": "013c41f7-1104-4008-9451-54ff3cc52305",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f080774f-6e2e-4b46-be05-0df231e0d222' \
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