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
      "id": "63d2e1fa-c78a-41fe-bc12-93e52922d912",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T14:55:20+00:00",
        "updated_at": "2023-02-24T14:55:20+00:00",
        "number": "http://bqbl.it/63d2e1fa-c78a-41fe-bc12-93e52922d912",
        "barcode_type": "qr_code",
        "image_url": "/uploads/84c6807abad9fc51841e5992f37627c0/barcode/image/63d2e1fa-c78a-41fe-bc12-93e52922d912/164b731c-bdf6-4d6d-b2c2-3e1a733b94b2.svg",
        "owner_id": "b65a42e3-6b7b-46db-a1e5-d174efbacbec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b65a42e3-6b7b-46db-a1e5-d174efbacbec"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8887ed5d-41c1-4fcd-b14f-fa7411922805&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8887ed5d-41c1-4fcd-b14f-fa7411922805",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T14:55:21+00:00",
        "updated_at": "2023-02-24T14:55:21+00:00",
        "number": "http://bqbl.it/8887ed5d-41c1-4fcd-b14f-fa7411922805",
        "barcode_type": "qr_code",
        "image_url": "/uploads/952e33f8408cb87099cc39b28de1101f/barcode/image/8887ed5d-41c1-4fcd-b14f-fa7411922805/2972a33d-6545-4582-8bf6-04bda97ddb27.svg",
        "owner_id": "9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b"
          },
          "data": {
            "type": "customers",
            "id": "9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T14:55:21+00:00",
        "updated_at": "2023-02-24T14:55:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9fdab77b-a7a8-47d3-8688-1ccfea9d3f2b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjQ4YWIyOGMtNjljNC00NmI3LWE0ODEtY2RiOWJhM2RlOTcy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "648ab28c-69c4-46b7-a481-cdb9ba3de972",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T14:55:21+00:00",
        "updated_at": "2023-02-24T14:55:21+00:00",
        "number": "http://bqbl.it/648ab28c-69c4-46b7-a481-cdb9ba3de972",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ecd3108f6b628a2ff987eeabcaad8424/barcode/image/648ab28c-69c4-46b7-a481-cdb9ba3de972/d3d24735-a5e7-488b-a1fe-9d7e798f3e4b.svg",
        "owner_id": "455a3182-9af6-47cc-96f6-8c7e2dba4f6b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/455a3182-9af6-47cc-96f6-8c7e2dba4f6b"
          },
          "data": {
            "type": "customers",
            "id": "455a3182-9af6-47cc-96f6-8c7e2dba4f6b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "455a3182-9af6-47cc-96f6-8c7e2dba4f6b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T14:55:21+00:00",
        "updated_at": "2023-02-24T14:55:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=455a3182-9af6-47cc-96f6-8c7e2dba4f6b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=455a3182-9af6-47cc-96f6-8c7e2dba4f6b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=455a3182-9af6-47cc-96f6-8c7e2dba4f6b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:54:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ee6256c2-8b19-4b9e-9829-65906045a747?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ee6256c2-8b19-4b9e-9829-65906045a747",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T14:55:22+00:00",
      "updated_at": "2023-02-24T14:55:22+00:00",
      "number": "http://bqbl.it/ee6256c2-8b19-4b9e-9829-65906045a747",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3dc0f45b1d5bb6d2c89c401bbbf83ae2/barcode/image/ee6256c2-8b19-4b9e-9829-65906045a747/24e612fd-a6ca-4c59-a85f-d57151a83e13.svg",
      "owner_id": "7c4ff52a-f80d-463f-b04a-367be096ef5a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7c4ff52a-f80d-463f-b04a-367be096ef5a"
        },
        "data": {
          "type": "customers",
          "id": "7c4ff52a-f80d-463f-b04a-367be096ef5a"
        }
      }
    }
  },
  "included": [
    {
      "id": "7c4ff52a-f80d-463f-b04a-367be096ef5a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T14:55:22+00:00",
        "updated_at": "2023-02-24T14:55:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7c4ff52a-f80d-463f-b04a-367be096ef5a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7c4ff52a-f80d-463f-b04a-367be096ef5a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7c4ff52a-f80d-463f-b04a-367be096ef5a&filter[owner_type]=customers"
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
          "owner_id": "2d168f66-8414-4bd2-afbc-50522577858e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "714708e3-5fa4-4723-94fc-018c095d3ce6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T14:55:22+00:00",
      "updated_at": "2023-02-24T14:55:22+00:00",
      "number": "http://bqbl.it/714708e3-5fa4-4723-94fc-018c095d3ce6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/420fe1b6dcc4149a535f339ec998560f/barcode/image/714708e3-5fa4-4723-94fc-018c095d3ce6/f1818888-ffed-4a41-afda-28552e0c1a20.svg",
      "owner_id": "2d168f66-8414-4bd2-afbc-50522577858e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5782023a-8594-4805-870a-25aca40f14b7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5782023a-8594-4805-870a-25aca40f14b7",
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
    "id": "5782023a-8594-4805-870a-25aca40f14b7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T14:55:23+00:00",
      "updated_at": "2023-02-24T14:55:23+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/083ab8998d2c40e06a9f84374ac5aa35/barcode/image/5782023a-8594-4805-870a-25aca40f14b7/00074ba7-42c9-4221-b699-b011fec02aff.svg",
      "owner_id": "29e39091-13ee-47b2-9f74-40d89b134041",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/47e0b74f-5cd2-47a8-90ef-ddb6bf4130c1' \
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