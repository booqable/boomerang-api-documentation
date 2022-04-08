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
      "id": "6c09011e-01f9-4ec2-ad21-97f5cf93c4b6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T10:16:11+00:00",
        "updated_at": "2022-04-07T10:16:11+00:00",
        "number": "http://bqbl.it/6c09011e-01f9-4ec2-ad21-97f5cf93c4b6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/eec3b28ea0653955d60f34506cd2cc2b/barcode/image/6c09011e-01f9-4ec2-ad21-97f5cf93c4b6/a1722b9e-12e6-413d-b818-6db1eb35128b.svg",
        "owner_id": "29e3c491-4579-4b71-a2dd-57253bc629e2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/29e3c491-4579-4b71-a2dd-57253bc629e2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F04159c61-523a-4b9c-bfab-f98c4cae4943&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "04159c61-523a-4b9c-bfab-f98c4cae4943",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T10:16:12+00:00",
        "updated_at": "2022-04-07T10:16:12+00:00",
        "number": "http://bqbl.it/04159c61-523a-4b9c-bfab-f98c4cae4943",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c87a9dbf7e2e69c5f34669a2d842c330/barcode/image/04159c61-523a-4b9c-bfab-f98c4cae4943/b865f23a-1397-417a-8fda-c51f7d11a841.svg",
        "owner_id": "b218c025-70c0-4ba3-bdb0-263832c8c32a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b218c025-70c0-4ba3-bdb0-263832c8c32a"
          },
          "data": {
            "type": "customers",
            "id": "b218c025-70c0-4ba3-bdb0-263832c8c32a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b218c025-70c0-4ba3-bdb0-263832c8c32a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T10:16:12+00:00",
        "updated_at": "2022-04-07T10:16:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kohler Inc",
        "email": "kohler_inc@roberts-donnelly.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=b218c025-70c0-4ba3-bdb0-263832c8c32a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b218c025-70c0-4ba3-bdb0-263832c8c32a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b218c025-70c0-4ba3-bdb0-263832c8c32a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmY3MjAwYjktMjU4NC00YjE5LThmOTgtM2ZiMjAxMGJmYjIw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2f7200b9-2584-4b19-8f98-3fb2010bfb20",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T10:16:12+00:00",
        "updated_at": "2022-04-07T10:16:12+00:00",
        "number": "http://bqbl.it/2f7200b9-2584-4b19-8f98-3fb2010bfb20",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e48bad585217ab4924b9645acf0d098c/barcode/image/2f7200b9-2584-4b19-8f98-3fb2010bfb20/808b42ad-cd50-4f94-859f-e7acce875b2f.svg",
        "owner_id": "31528d9b-6a3b-4ebc-81b8-631395ecbcf8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/31528d9b-6a3b-4ebc-81b8-631395ecbcf8"
          },
          "data": {
            "type": "customers",
            "id": "31528d9b-6a3b-4ebc-81b8-631395ecbcf8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "31528d9b-6a3b-4ebc-81b8-631395ecbcf8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T10:16:12+00:00",
        "updated_at": "2022-04-07T10:16:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Dickens and Sons",
        "email": "dickens_sons_and@bergnaum-gerlach.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=31528d9b-6a3b-4ebc-81b8-631395ecbcf8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=31528d9b-6a3b-4ebc-81b8-631395ecbcf8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=31528d9b-6a3b-4ebc-81b8-631395ecbcf8&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T10:16:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/339bffac-ea45-4f5d-bcb9-af5494c72626?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "339bffac-ea45-4f5d-bcb9-af5494c72626",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T10:16:13+00:00",
      "updated_at": "2022-04-07T10:16:13+00:00",
      "number": "http://bqbl.it/339bffac-ea45-4f5d-bcb9-af5494c72626",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ac13c55b52f9152e44c53e87287a1bae/barcode/image/339bffac-ea45-4f5d-bcb9-af5494c72626/3af97ffb-7763-4977-b33a-2e5fb9fc6084.svg",
      "owner_id": "fbb72272-6322-43dc-bade-734bb8a9131a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fbb72272-6322-43dc-bade-734bb8a9131a"
        },
        "data": {
          "type": "customers",
          "id": "fbb72272-6322-43dc-bade-734bb8a9131a"
        }
      }
    }
  },
  "included": [
    {
      "id": "fbb72272-6322-43dc-bade-734bb8a9131a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T10:16:13+00:00",
        "updated_at": "2022-04-07T10:16:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Boyer Group",
        "email": "group_boyer@kovacek.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=fbb72272-6322-43dc-bade-734bb8a9131a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fbb72272-6322-43dc-bade-734bb8a9131a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fbb72272-6322-43dc-bade-734bb8a9131a&filter[owner_type]=customers"
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
          "owner_id": "7a6e8141-cd0e-4272-ba00-d8860fc2df1b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f6b814a1-4900-4006-af41-6f8e6483d2d1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T10:16:14+00:00",
      "updated_at": "2022-04-07T10:16:14+00:00",
      "number": "http://bqbl.it/f6b814a1-4900-4006-af41-6f8e6483d2d1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/092bfbca0f451155606bf6f9924fb1b8/barcode/image/f6b814a1-4900-4006-af41-6f8e6483d2d1/a2ce5a7a-ce98-4707-b728-48b9882162d2.svg",
      "owner_id": "7a6e8141-cd0e-4272-ba00-d8860fc2df1b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0893c31c-1ace-4262-8811-8e9cc6cd10f1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0893c31c-1ace-4262-8811-8e9cc6cd10f1",
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
    "id": "0893c31c-1ace-4262-8811-8e9cc6cd10f1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T10:16:14+00:00",
      "updated_at": "2022-04-07T10:16:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9230d6678e85ffed10dbe9eeace513c1/barcode/image/0893c31c-1ace-4262-8811-8e9cc6cd10f1/42eb230e-5b7d-453b-a4ff-89a1f41a5e09.svg",
      "owner_id": "30bb1247-4aa2-4c26-8402-3be7a0e43c62",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/da6412a0-00c5-4963-9d8a-1a49137d43ae' \
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