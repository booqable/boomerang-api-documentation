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
      "id": "acdbc7b3-1470-4efb-97e8-3cbbd40543c4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-12T12:56:26+00:00",
        "updated_at": "2022-10-12T12:56:26+00:00",
        "number": "http://bqbl.it/acdbc7b3-1470-4efb-97e8-3cbbd40543c4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4899a3ec52dc1927eb2d2e69000c60c9/barcode/image/acdbc7b3-1470-4efb-97e8-3cbbd40543c4/9fda7245-1a4e-4195-8578-3cd3725f5173.svg",
        "owner_id": "97492c79-b1b2-4726-86a8-6878d831b7db",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/97492c79-b1b2-4726-86a8-6878d831b7db"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff16ad43b-c4fc-4466-bcc4-7a4147c42bb7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f16ad43b-c4fc-4466-bcc4-7a4147c42bb7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-12T12:56:27+00:00",
        "updated_at": "2022-10-12T12:56:27+00:00",
        "number": "http://bqbl.it/f16ad43b-c4fc-4466-bcc4-7a4147c42bb7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b9e0d84dbe352521882cf894592d872/barcode/image/f16ad43b-c4fc-4466-bcc4-7a4147c42bb7/1df54d8e-508b-48d6-97fc-cc1f0da38dd0.svg",
        "owner_id": "c71ea730-f625-469f-8aec-b77f7f215925",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c71ea730-f625-469f-8aec-b77f7f215925"
          },
          "data": {
            "type": "customers",
            "id": "c71ea730-f625-469f-8aec-b77f7f215925"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c71ea730-f625-469f-8aec-b77f7f215925",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-12T12:56:27+00:00",
        "updated_at": "2022-10-12T12:56:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c71ea730-f625-469f-8aec-b77f7f215925&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c71ea730-f625-469f-8aec-b77f7f215925&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c71ea730-f625-469f-8aec-b77f7f215925&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzBhMWQ2NDYtOGEyNy00MzY3LWFhNzItY2RhNDY5MjIyN2Nk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c0a1d646-8a27-4367-aa72-cda4692227cd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-12T12:56:27+00:00",
        "updated_at": "2022-10-12T12:56:27+00:00",
        "number": "http://bqbl.it/c0a1d646-8a27-4367-aa72-cda4692227cd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7bcee34d8a656da00f43e456f521506a/barcode/image/c0a1d646-8a27-4367-aa72-cda4692227cd/c4cfbfc4-0969-4067-adeb-8fd13091d2c0.svg",
        "owner_id": "45b5e036-f73d-45bd-bbdd-27a7e6427e0f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/45b5e036-f73d-45bd-bbdd-27a7e6427e0f"
          },
          "data": {
            "type": "customers",
            "id": "45b5e036-f73d-45bd-bbdd-27a7e6427e0f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "45b5e036-f73d-45bd-bbdd-27a7e6427e0f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-12T12:56:27+00:00",
        "updated_at": "2022-10-12T12:56:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=45b5e036-f73d-45bd-bbdd-27a7e6427e0f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=45b5e036-f73d-45bd-bbdd-27a7e6427e0f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=45b5e036-f73d-45bd-bbdd-27a7e6427e0f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-12T12:56:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/98e5d6bf-44de-412d-88a7-ad1f8b8d7421?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "98e5d6bf-44de-412d-88a7-ad1f8b8d7421",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-12T12:56:28+00:00",
      "updated_at": "2022-10-12T12:56:28+00:00",
      "number": "http://bqbl.it/98e5d6bf-44de-412d-88a7-ad1f8b8d7421",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a436b446a9e3c34693ac98e5361385ec/barcode/image/98e5d6bf-44de-412d-88a7-ad1f8b8d7421/398689f2-b7ee-4dde-b8c7-92fa67a48bc5.svg",
      "owner_id": "3ac85d00-1bbb-4534-8f43-43a3a9480356",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3ac85d00-1bbb-4534-8f43-43a3a9480356"
        },
        "data": {
          "type": "customers",
          "id": "3ac85d00-1bbb-4534-8f43-43a3a9480356"
        }
      }
    }
  },
  "included": [
    {
      "id": "3ac85d00-1bbb-4534-8f43-43a3a9480356",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-12T12:56:28+00:00",
        "updated_at": "2022-10-12T12:56:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3ac85d00-1bbb-4534-8f43-43a3a9480356&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3ac85d00-1bbb-4534-8f43-43a3a9480356&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3ac85d00-1bbb-4534-8f43-43a3a9480356&filter[owner_type]=customers"
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
          "owner_id": "dbdbcf5f-513a-4f40-aee6-da3cc53adb33",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2d7ef691-a328-4ba9-bfc7-1c6c11a61e62",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-12T12:56:29+00:00",
      "updated_at": "2022-10-12T12:56:29+00:00",
      "number": "http://bqbl.it/2d7ef691-a328-4ba9-bfc7-1c6c11a61e62",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5195d1993cc512ec09362e99e1b8f836/barcode/image/2d7ef691-a328-4ba9-bfc7-1c6c11a61e62/93c2132f-8c3b-4d03-9f12-cd6d527bdde6.svg",
      "owner_id": "dbdbcf5f-513a-4f40-aee6-da3cc53adb33",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d553b80-602d-41df-b530-a137e64bfab5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1d553b80-602d-41df-b530-a137e64bfab5",
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
    "id": "1d553b80-602d-41df-b530-a137e64bfab5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-12T12:56:29+00:00",
      "updated_at": "2022-10-12T12:56:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b4a79d7f1e53c12115e4c40bc0e05f23/barcode/image/1d553b80-602d-41df-b530-a137e64bfab5/60da51ff-9b55-49f2-9bc1-8cf976a4b71f.svg",
      "owner_id": "9fbe84ee-f2b7-482c-9efd-f848bc50b184",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c33c31e5-2a56-4ca8-b4dc-90fb624c522b' \
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