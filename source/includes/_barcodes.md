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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "4d1b5f36-0143-412c-a33a-375ccec79195",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T08:53:29+00:00",
        "updated_at": "2022-07-08T08:53:29+00:00",
        "number": "http://bqbl.it/4d1b5f36-0143-412c-a33a-375ccec79195",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fa8851a4c95492d1bbe95929926b371f/barcode/image/4d1b5f36-0143-412c-a33a-375ccec79195/c56e8aa9-55c0-4d9f-a3f6-86ac73c17144.svg",
        "owner_id": "4ed398f6-fa69-4284-b6ce-f570082c982a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4ed398f6-fa69-4284-b6ce-f570082c982a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fccd74211-d719-411b-9405-dafb7b9dc387&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ccd74211-d719-411b-9405-dafb7b9dc387",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T08:53:29+00:00",
        "updated_at": "2022-07-08T08:53:29+00:00",
        "number": "http://bqbl.it/ccd74211-d719-411b-9405-dafb7b9dc387",
        "barcode_type": "qr_code",
        "image_url": "/uploads/25e42e4f0bdca50f75e8acc2ed80bcf3/barcode/image/ccd74211-d719-411b-9405-dafb7b9dc387/86e0417e-f328-4f74-85e6-26d1d431e9b9.svg",
        "owner_id": "b6b268ee-749f-4722-9901-3ed12c0aced2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b6b268ee-749f-4722-9901-3ed12c0aced2"
          },
          "data": {
            "type": "customers",
            "id": "b6b268ee-749f-4722-9901-3ed12c0aced2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b6b268ee-749f-4722-9901-3ed12c0aced2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T08:53:29+00:00",
        "updated_at": "2022-07-08T08:53:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kreiger, Reinger and Rutherford",
        "email": "reinger_kreiger_and_rutherford@witting.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=b6b268ee-749f-4722-9901-3ed12c0aced2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b6b268ee-749f-4722-9901-3ed12c0aced2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b6b268ee-749f-4722-9901-3ed12c0aced2&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmYxY2QzMzktYzQwZC00NTM3LWIzZWUtYjJhNTgwNTRiMDBk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bf1cd339-c40d-4537-b3ee-b2a58054b00d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T08:53:29+00:00",
        "updated_at": "2022-07-08T08:53:29+00:00",
        "number": "http://bqbl.it/bf1cd339-c40d-4537-b3ee-b2a58054b00d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7190fdeac2a7bad04ee865865943a7ca/barcode/image/bf1cd339-c40d-4537-b3ee-b2a58054b00d/41f68589-154f-4e9c-ac73-83f8ffdb5de6.svg",
        "owner_id": "5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7"
          },
          "data": {
            "type": "customers",
            "id": "5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T08:53:29+00:00",
        "updated_at": "2022-07-08T08:53:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Ledner Inc",
        "email": "ledner.inc@kertzmann.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5d27ad6a-8ed4-46bb-968c-c122e9a1e6d7&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T08:53:16Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/56b79f94-3a91-4785-b064-4058109496ec?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "56b79f94-3a91-4785-b064-4058109496ec",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T08:53:30+00:00",
      "updated_at": "2022-07-08T08:53:30+00:00",
      "number": "http://bqbl.it/56b79f94-3a91-4785-b064-4058109496ec",
      "barcode_type": "qr_code",
      "image_url": "/uploads/88d2fe75c3b8f9cb289ffb391b47b32e/barcode/image/56b79f94-3a91-4785-b064-4058109496ec/037bc552-065f-4005-9bed-93b5e1714047.svg",
      "owner_id": "5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1"
        },
        "data": {
          "type": "customers",
          "id": "5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1"
        }
      }
    }
  },
  "included": [
    {
      "id": "5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T08:53:30+00:00",
        "updated_at": "2022-07-08T08:53:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Corkery, Gleason and Murphy",
        "email": "and_murphy_corkery_gleason@bailey-hahn.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5e039b5d-9a37-4fdf-a13d-1bfc45b7c0c1&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "fdab1ce2-40a6-4cb7-819e-d8429b9d986d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6ef4bef0-03a4-4ff7-8b34-9363be102d70",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T08:53:30+00:00",
      "updated_at": "2022-07-08T08:53:30+00:00",
      "number": "http://bqbl.it/6ef4bef0-03a4-4ff7-8b34-9363be102d70",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a740f1f7d0ebb63e5e2025cb8262264a/barcode/image/6ef4bef0-03a4-4ff7-8b34-9363be102d70/2133b225-83c5-43c5-ac60-6d87e4098a6d.svg",
      "owner_id": "fdab1ce2-40a6-4cb7-819e-d8429b9d986d",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a4dd5b52-dbcc-459d-967c-f90dcda9d560' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a4dd5b52-dbcc-459d-967c-f90dcda9d560",
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
    "id": "a4dd5b52-dbcc-459d-967c-f90dcda9d560",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T08:53:31+00:00",
      "updated_at": "2022-07-08T08:53:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f24065f1f6770369ba03eef68ae372ee/barcode/image/a4dd5b52-dbcc-459d-967c-f90dcda9d560/8783ffec-cca0-4121-85b8-6d617938fa20.svg",
      "owner_id": "ab5c84bc-3740-450c-b7c4-33979ea266b1",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a1fd2146-e4d9-46c0-a4df-9243910f0e12' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes