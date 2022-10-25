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
      "id": "a4643c2c-7003-4dd8-8faf-f9a087c01c55",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T16:29:49+00:00",
        "updated_at": "2022-10-25T16:29:49+00:00",
        "number": "http://bqbl.it/a4643c2c-7003-4dd8-8faf-f9a087c01c55",
        "barcode_type": "qr_code",
        "image_url": "/uploads/02156aef29deb31fd3ef50aebb8ecbd2/barcode/image/a4643c2c-7003-4dd8-8faf-f9a087c01c55/8ca18be1-482c-426e-bd24-e8e64b7d03d1.svg",
        "owner_id": "dd088f25-8d9c-4800-9bf0-728d3250c7dd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dd088f25-8d9c-4800-9bf0-728d3250c7dd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa14ad107-3a7e-4653-b400-d447aaeb63e7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a14ad107-3a7e-4653-b400-d447aaeb63e7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T16:29:50+00:00",
        "updated_at": "2022-10-25T16:29:50+00:00",
        "number": "http://bqbl.it/a14ad107-3a7e-4653-b400-d447aaeb63e7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ff040f8eee3251517cd6bc43f9ac756e/barcode/image/a14ad107-3a7e-4653-b400-d447aaeb63e7/aa3b786d-8400-4818-8f23-e4961cbef49e.svg",
        "owner_id": "06da5418-32c8-4676-94e1-79f3a0b73fd6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/06da5418-32c8-4676-94e1-79f3a0b73fd6"
          },
          "data": {
            "type": "customers",
            "id": "06da5418-32c8-4676-94e1-79f3a0b73fd6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "06da5418-32c8-4676-94e1-79f3a0b73fd6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T16:29:50+00:00",
        "updated_at": "2022-10-25T16:29:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=06da5418-32c8-4676-94e1-79f3a0b73fd6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=06da5418-32c8-4676-94e1-79f3a0b73fd6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=06da5418-32c8-4676-94e1-79f3a0b73fd6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjQ1ODVkZmUtYjMwYy00NmQzLWE5NTgtNmY3NjE2ODgyNjc3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "64585dfe-b30c-46d3-a958-6f7616882677",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T16:29:50+00:00",
        "updated_at": "2022-10-25T16:29:50+00:00",
        "number": "http://bqbl.it/64585dfe-b30c-46d3-a958-6f7616882677",
        "barcode_type": "qr_code",
        "image_url": "/uploads/47b158c2604e29f3902fe325095984e5/barcode/image/64585dfe-b30c-46d3-a958-6f7616882677/6b3e9570-4b12-4ff2-96c9-6cf4135196c5.svg",
        "owner_id": "a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7"
          },
          "data": {
            "type": "customers",
            "id": "a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T16:29:50+00:00",
        "updated_at": "2022-10-25T16:29:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a5631d4b-8f8b-4a0b-a970-8a2b921cfdb7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T16:29:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/15c1aa08-0005-4b7c-b885-6af64a74dbfa?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15c1aa08-0005-4b7c-b885-6af64a74dbfa",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T16:29:51+00:00",
      "updated_at": "2022-10-25T16:29:51+00:00",
      "number": "http://bqbl.it/15c1aa08-0005-4b7c-b885-6af64a74dbfa",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2c0a59ccf23f9c958110b0e81321dddb/barcode/image/15c1aa08-0005-4b7c-b885-6af64a74dbfa/83a39293-13e2-426e-b659-bcb22f932734.svg",
      "owner_id": "253d7a91-f3a9-401a-88cc-b387d26790fb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/253d7a91-f3a9-401a-88cc-b387d26790fb"
        },
        "data": {
          "type": "customers",
          "id": "253d7a91-f3a9-401a-88cc-b387d26790fb"
        }
      }
    }
  },
  "included": [
    {
      "id": "253d7a91-f3a9-401a-88cc-b387d26790fb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T16:29:51+00:00",
        "updated_at": "2022-10-25T16:29:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=253d7a91-f3a9-401a-88cc-b387d26790fb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=253d7a91-f3a9-401a-88cc-b387d26790fb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=253d7a91-f3a9-401a-88cc-b387d26790fb&filter[owner_type]=customers"
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
          "owner_id": "1a76a4fd-30ff-46c9-893f-ae944578d0ff",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8fdd6ab8-4408-4241-8b85-b12bff2ba6b6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T16:29:51+00:00",
      "updated_at": "2022-10-25T16:29:51+00:00",
      "number": "http://bqbl.it/8fdd6ab8-4408-4241-8b85-b12bff2ba6b6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9cb78b7a57c6f2f6f1626491517e4190/barcode/image/8fdd6ab8-4408-4241-8b85-b12bff2ba6b6/d1ecc7d4-5d64-4e1c-8a52-58ad9271190c.svg",
      "owner_id": "1a76a4fd-30ff-46c9-893f-ae944578d0ff",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/da01c303-db4d-49b9-b9fd-6e110c5655c8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "da01c303-db4d-49b9-b9fd-6e110c5655c8",
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
    "id": "da01c303-db4d-49b9-b9fd-6e110c5655c8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T16:29:52+00:00",
      "updated_at": "2022-10-25T16:29:52+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/766f2d7cfe58159035d0b178d39cc5fd/barcode/image/da01c303-db4d-49b9-b9fd-6e110c5655c8/b554cee6-3d2a-42f8-aefd-4bd77d86f914.svg",
      "owner_id": "cd0d74a7-a5e0-4a3a-aacf-93bebdb2e0d2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8a0cfcd9-d739-467f-ab95-a70059775ee7' \
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