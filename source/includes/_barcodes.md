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
      "id": "dacf82c8-9875-4c2a-bcba-85185b5c72aa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-03T09:17:51+00:00",
        "updated_at": "2022-02-03T09:17:51+00:00",
        "number": "http://bqbl.it/dacf82c8-9875-4c2a-bcba-85185b5c72aa",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b5196b5b7f578c17578e0c14a6510af/barcode/image/dacf82c8-9875-4c2a-bcba-85185b5c72aa/b414b00e-b235-4bbc-8f66-269fe5de3fe9.svg",
        "owner_id": "9d4b56d9-86c7-4af7-a0f2-7200f3417a4e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9d4b56d9-86c7-4af7-a0f2-7200f3417a4e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdc49d0f0-b7c1-4eb8-a0e6-ac65317e8d2a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dc49d0f0-b7c1-4eb8-a0e6-ac65317e8d2a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-03T09:17:52+00:00",
        "updated_at": "2022-02-03T09:17:52+00:00",
        "number": "http://bqbl.it/dc49d0f0-b7c1-4eb8-a0e6-ac65317e8d2a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/515768fc65da953f18a673f66b00bcdd/barcode/image/dc49d0f0-b7c1-4eb8-a0e6-ac65317e8d2a/3cd14afa-ba60-4aa3-8f32-84c04bbcd92e.svg",
        "owner_id": "3503d6ab-4998-4a69-892f-58c664576037",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3503d6ab-4998-4a69-892f-58c664576037"
          },
          "data": {
            "type": "customers",
            "id": "3503d6ab-4998-4a69-892f-58c664576037"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3503d6ab-4998-4a69-892f-58c664576037",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-03T09:17:52+00:00",
        "updated_at": "2022-02-03T09:17:52+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Heathcote and Sons",
        "email": "and_sons_heathcote@rutherford-daugherty.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=3503d6ab-4998-4a69-892f-58c664576037&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3503d6ab-4998-4a69-892f-58c664576037&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3503d6ab-4998-4a69-892f-58c664576037&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvY2ZhMjkxMmMtMzEzMy00ZjdiLTg3MjAtZTk3ZjA3Y2ZlMWM5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cfa2912c-3133-4f7b-8720-e97f07cfe1c9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-03T09:17:53+00:00",
        "updated_at": "2022-02-03T09:17:53+00:00",
        "number": "http://bqbl.it/cfa2912c-3133-4f7b-8720-e97f07cfe1c9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0551bf0836ad34871c3199000294b5f2/barcode/image/cfa2912c-3133-4f7b-8720-e97f07cfe1c9/d384c17c-9f45-4a3e-b248-f92b0ea913dd.svg",
        "owner_id": "e41c59eb-0145-4ff1-8d46-e1cb14459ba1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e41c59eb-0145-4ff1-8d46-e1cb14459ba1"
          },
          "data": {
            "type": "customers",
            "id": "e41c59eb-0145-4ff1-8d46-e1cb14459ba1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e41c59eb-0145-4ff1-8d46-e1cb14459ba1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-03T09:17:53+00:00",
        "updated_at": "2022-02-03T09:17:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Ebert-Larkin",
        "email": "ebert_larkin@vandervort.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=e41c59eb-0145-4ff1-8d46-e1cb14459ba1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e41c59eb-0145-4ff1-8d46-e1cb14459ba1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e41c59eb-0145-4ff1-8d46-e1cb14459ba1&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-03T09:17:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/93f85ab8-dad8-4eeb-94c9-f28cbdf0d263?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "93f85ab8-dad8-4eeb-94c9-f28cbdf0d263",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-03T09:17:53+00:00",
      "updated_at": "2022-02-03T09:17:53+00:00",
      "number": "http://bqbl.it/93f85ab8-dad8-4eeb-94c9-f28cbdf0d263",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3a1f5b6ca615fb417938f2e4de40eade/barcode/image/93f85ab8-dad8-4eeb-94c9-f28cbdf0d263/10ce3249-8390-4589-8a10-3553bcc0fd4b.svg",
      "owner_id": "11883825-5061-48a3-9768-2a35291d43ef",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/11883825-5061-48a3-9768-2a35291d43ef"
        },
        "data": {
          "type": "customers",
          "id": "11883825-5061-48a3-9768-2a35291d43ef"
        }
      }
    }
  },
  "included": [
    {
      "id": "11883825-5061-48a3-9768-2a35291d43ef",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-03T09:17:53+00:00",
        "updated_at": "2022-02-03T09:17:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Pouros Group",
        "email": "group_pouros@thiel.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=11883825-5061-48a3-9768-2a35291d43ef&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=11883825-5061-48a3-9768-2a35291d43ef&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=11883825-5061-48a3-9768-2a35291d43ef&filter[owner_type]=customers"
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
          "owner_id": "c24491fb-5fbc-4b45-89b2-c8edef397edb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "340d8ad5-ebab-425d-8143-47c1e972126f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-03T09:17:54+00:00",
      "updated_at": "2022-02-03T09:17:54+00:00",
      "number": "http://bqbl.it/340d8ad5-ebab-425d-8143-47c1e972126f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3b8a309f8d0b5c64570affa5cdc174cc/barcode/image/340d8ad5-ebab-425d-8143-47c1e972126f/8a4a11bf-cb55-441d-9c57-42d7b36586ba.svg",
      "owner_id": "c24491fb-5fbc-4b45-89b2-c8edef397edb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/01427aab-0316-44d2-92f2-97565c71fc35' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "01427aab-0316-44d2-92f2-97565c71fc35",
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
    "id": "01427aab-0316-44d2-92f2-97565c71fc35",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-03T09:17:55+00:00",
      "updated_at": "2022-02-03T09:17:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c8b1dbfbb1022c1db6fe29cbdfdaa3ba/barcode/image/01427aab-0316-44d2-92f2-97565c71fc35/ea3141ff-a76e-4129-bbc7-1bd4416e834b.svg",
      "owner_id": "5c15538b-c14c-470a-b9a8-23b8074f8c8d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3f68fdd2-1f02-4414-bcc6-9b36250666f0' \
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