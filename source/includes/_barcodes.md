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
      "id": "820353ef-4f5b-4027-94d4-585b24827921",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T09:08:15+00:00",
        "updated_at": "2022-04-13T09:08:15+00:00",
        "number": "http://bqbl.it/820353ef-4f5b-4027-94d4-585b24827921",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2d9d4982314a7b78607311d5de56312e/barcode/image/820353ef-4f5b-4027-94d4-585b24827921/c193ac30-b024-4113-80e6-6d0d3595f0c9.svg",
        "owner_id": "217abb55-1793-40e5-a833-bd94a7b69d79",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/217abb55-1793-40e5-a833-bd94a7b69d79"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Feb3f6ca4-47ba-4952-bced-449f5fd0b230&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eb3f6ca4-47ba-4952-bced-449f5fd0b230",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T09:08:15+00:00",
        "updated_at": "2022-04-13T09:08:15+00:00",
        "number": "http://bqbl.it/eb3f6ca4-47ba-4952-bced-449f5fd0b230",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9d97f603158fb0c485bb2661a555ebef/barcode/image/eb3f6ca4-47ba-4952-bced-449f5fd0b230/c43cbe64-0af1-4415-bed0-37acef19ae6c.svg",
        "owner_id": "dee52c44-93ca-47f1-a892-094564c28f3e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dee52c44-93ca-47f1-a892-094564c28f3e"
          },
          "data": {
            "type": "customers",
            "id": "dee52c44-93ca-47f1-a892-094564c28f3e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dee52c44-93ca-47f1-a892-094564c28f3e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T09:08:15+00:00",
        "updated_at": "2022-04-13T09:08:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Moore and Sons",
        "email": "sons.moore.and@ratke-welch.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=dee52c44-93ca-47f1-a892-094564c28f3e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dee52c44-93ca-47f1-a892-094564c28f3e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dee52c44-93ca-47f1-a892-094564c28f3e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzUxZTQ4YTUtMzgyNy00YTIwLWI2ODAtMjA2NTcxOGNmMTI3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "751e48a5-3827-4a20-b680-2065718cf127",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T09:08:16+00:00",
        "updated_at": "2022-04-13T09:08:16+00:00",
        "number": "http://bqbl.it/751e48a5-3827-4a20-b680-2065718cf127",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1a27664727be95d810c14a24cefd3f54/barcode/image/751e48a5-3827-4a20-b680-2065718cf127/3fdcf653-36dc-4639-9b3c-c05af5861cf7.svg",
        "owner_id": "af504d80-96f4-44da-ace2-043f7e82b2e2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/af504d80-96f4-44da-ace2-043f7e82b2e2"
          },
          "data": {
            "type": "customers",
            "id": "af504d80-96f4-44da-ace2-043f7e82b2e2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "af504d80-96f4-44da-ace2-043f7e82b2e2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T09:08:16+00:00",
        "updated_at": "2022-04-13T09:08:16+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "D'Amore, Upton and Klocko",
        "email": "amore.klocko.upton.and.d@kris-abernathy.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=af504d80-96f4-44da-ace2-043f7e82b2e2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=af504d80-96f4-44da-ace2-043f7e82b2e2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=af504d80-96f4-44da-ace2-043f7e82b2e2&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T09:08:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ab266cde-c8e2-48b0-908c-a70cb02bc446?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ab266cde-c8e2-48b0-908c-a70cb02bc446",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T09:08:16+00:00",
      "updated_at": "2022-04-13T09:08:16+00:00",
      "number": "http://bqbl.it/ab266cde-c8e2-48b0-908c-a70cb02bc446",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fa1dc6a7fcc5b8e45eebe0c57f0b7f5f/barcode/image/ab266cde-c8e2-48b0-908c-a70cb02bc446/db83e7ae-5f19-491f-8a90-259db7323099.svg",
      "owner_id": "4559e3fa-129b-4c41-b2e0-4b0e3c51ebef",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4559e3fa-129b-4c41-b2e0-4b0e3c51ebef"
        },
        "data": {
          "type": "customers",
          "id": "4559e3fa-129b-4c41-b2e0-4b0e3c51ebef"
        }
      }
    }
  },
  "included": [
    {
      "id": "4559e3fa-129b-4c41-b2e0-4b0e3c51ebef",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T09:08:16+00:00",
        "updated_at": "2022-04-13T09:08:16+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Boehm Group",
        "email": "boehm_group@marvin.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=4559e3fa-129b-4c41-b2e0-4b0e3c51ebef&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4559e3fa-129b-4c41-b2e0-4b0e3c51ebef&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4559e3fa-129b-4c41-b2e0-4b0e3c51ebef&filter[owner_type]=customers"
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
          "owner_id": "58ab28b6-99ea-49b5-bad4-1cb197c969cd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "841a8934-b7d4-4cc0-8984-9c85bb5d4e59",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T09:08:17+00:00",
      "updated_at": "2022-04-13T09:08:17+00:00",
      "number": "http://bqbl.it/841a8934-b7d4-4cc0-8984-9c85bb5d4e59",
      "barcode_type": "qr_code",
      "image_url": "/uploads/56f694d748ce2fd99a9740666a25499d/barcode/image/841a8934-b7d4-4cc0-8984-9c85bb5d4e59/42adca89-3a14-49f6-ae9f-8bbebaf4334d.svg",
      "owner_id": "58ab28b6-99ea-49b5-bad4-1cb197c969cd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c85dded3-fb76-4f8f-847b-e9f2374b369d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c85dded3-fb76-4f8f-847b-e9f2374b369d",
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
    "id": "c85dded3-fb76-4f8f-847b-e9f2374b369d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T09:08:17+00:00",
      "updated_at": "2022-04-13T09:08:17+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bc803cfc1acb26cc1807d7b74f9da299/barcode/image/c85dded3-fb76-4f8f-847b-e9f2374b369d/ff8a4b3f-13e1-4567-aab1-8893682005b6.svg",
      "owner_id": "c1331211-1ec8-4527-a209-29812fdf4fb3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f23c94b2-62ee-496e-a342-6877ff502c56' \
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