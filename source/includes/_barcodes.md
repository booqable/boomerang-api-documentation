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
      "id": "09ee9a67-b6a2-4a74-a5d8-52350b8a7016",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T08:26:19+00:00",
        "updated_at": "2023-02-03T08:26:19+00:00",
        "number": "http://bqbl.it/09ee9a67-b6a2-4a74-a5d8-52350b8a7016",
        "barcode_type": "qr_code",
        "image_url": "/uploads/250d6db53d867881f85e4b0a95d1128d/barcode/image/09ee9a67-b6a2-4a74-a5d8-52350b8a7016/edc9f06f-a92f-410b-9448-59867f6191f3.svg",
        "owner_id": "e6ced387-342d-45d8-98fc-d50ff554c4ee",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e6ced387-342d-45d8-98fc-d50ff554c4ee"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F680d85fe-e5d6-4d35-a46d-138709981669&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "680d85fe-e5d6-4d35-a46d-138709981669",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T08:26:19+00:00",
        "updated_at": "2023-02-03T08:26:19+00:00",
        "number": "http://bqbl.it/680d85fe-e5d6-4d35-a46d-138709981669",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3275ae6fdd2d1961fec848f9c5848b9c/barcode/image/680d85fe-e5d6-4d35-a46d-138709981669/daf8c7a0-ac93-43a9-8823-b8435c972545.svg",
        "owner_id": "450d7090-7882-4b66-acb7-51db7526172d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/450d7090-7882-4b66-acb7-51db7526172d"
          },
          "data": {
            "type": "customers",
            "id": "450d7090-7882-4b66-acb7-51db7526172d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "450d7090-7882-4b66-acb7-51db7526172d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T08:26:19+00:00",
        "updated_at": "2023-02-03T08:26:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=450d7090-7882-4b66-acb7-51db7526172d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=450d7090-7882-4b66-acb7-51db7526172d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=450d7090-7882-4b66-acb7-51db7526172d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjkwM2E3OWYtYTlhZS00YTQ4LWE2ZmQtMGY5MGJhOThkMDI2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f903a79f-a9ae-4a48-a6fd-0f90ba98d026",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T08:26:20+00:00",
        "updated_at": "2023-02-03T08:26:20+00:00",
        "number": "http://bqbl.it/f903a79f-a9ae-4a48-a6fd-0f90ba98d026",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f2312bd9dd5737d5eaba3ab83644c138/barcode/image/f903a79f-a9ae-4a48-a6fd-0f90ba98d026/9c3e2a80-09c4-4e2f-9e33-60078b47d130.svg",
        "owner_id": "295a4d6b-a4b1-4370-a1b5-612107d9a39d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/295a4d6b-a4b1-4370-a1b5-612107d9a39d"
          },
          "data": {
            "type": "customers",
            "id": "295a4d6b-a4b1-4370-a1b5-612107d9a39d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "295a4d6b-a4b1-4370-a1b5-612107d9a39d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T08:26:20+00:00",
        "updated_at": "2023-02-03T08:26:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=295a4d6b-a4b1-4370-a1b5-612107d9a39d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=295a4d6b-a4b1-4370-a1b5-612107d9a39d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=295a4d6b-a4b1-4370-a1b5-612107d9a39d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T08:25:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3940307b-8e7d-4753-a8ce-b8dea0efaf46?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3940307b-8e7d-4753-a8ce-b8dea0efaf46",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T08:26:21+00:00",
      "updated_at": "2023-02-03T08:26:21+00:00",
      "number": "http://bqbl.it/3940307b-8e7d-4753-a8ce-b8dea0efaf46",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1f16d2ed02efc6355c74a5bc6cdb8fa7/barcode/image/3940307b-8e7d-4753-a8ce-b8dea0efaf46/31f70e19-2de4-4139-a464-53d481feb3de.svg",
      "owner_id": "57b5d784-f376-4f46-a45a-6fa16ee3ef5d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/57b5d784-f376-4f46-a45a-6fa16ee3ef5d"
        },
        "data": {
          "type": "customers",
          "id": "57b5d784-f376-4f46-a45a-6fa16ee3ef5d"
        }
      }
    }
  },
  "included": [
    {
      "id": "57b5d784-f376-4f46-a45a-6fa16ee3ef5d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T08:26:21+00:00",
        "updated_at": "2023-02-03T08:26:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=57b5d784-f376-4f46-a45a-6fa16ee3ef5d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57b5d784-f376-4f46-a45a-6fa16ee3ef5d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57b5d784-f376-4f46-a45a-6fa16ee3ef5d&filter[owner_type]=customers"
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
          "owner_id": "cf997a0e-37c9-47f8-ad89-6a4490195b8e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e5d0253a-804f-47e3-a7b2-6c2682a7932a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T08:26:22+00:00",
      "updated_at": "2023-02-03T08:26:22+00:00",
      "number": "http://bqbl.it/e5d0253a-804f-47e3-a7b2-6c2682a7932a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2b4a95f144d7a9e00eff5ee021899aa6/barcode/image/e5d0253a-804f-47e3-a7b2-6c2682a7932a/1a5b67a6-cbfa-4ca7-8799-6d26c8ffbf25.svg",
      "owner_id": "cf997a0e-37c9-47f8-ad89-6a4490195b8e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d55f28b6-84d6-4803-b38e-c036243747d2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d55f28b6-84d6-4803-b38e-c036243747d2",
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
    "id": "d55f28b6-84d6-4803-b38e-c036243747d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T08:26:22+00:00",
      "updated_at": "2023-02-03T08:26:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ccdaf74fe3cea387fab81a534d29144/barcode/image/d55f28b6-84d6-4803-b38e-c036243747d2/68af3546-4328-4a6a-914f-b70b27fce618.svg",
      "owner_id": "2dd66fd4-1763-47cc-898c-adeee758eede",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5aac05af-a75d-4b49-ab18-e7a1ee10133c' \
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