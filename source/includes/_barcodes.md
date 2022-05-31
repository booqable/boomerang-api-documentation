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
      "id": "c08ac463-71c5-4713-ad22-6b05d1fa1b9d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-31T06:54:30+00:00",
        "updated_at": "2022-05-31T06:54:30+00:00",
        "number": "http://bqbl.it/c08ac463-71c5-4713-ad22-6b05d1fa1b9d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/eec2e0cf5c0c4ac6149d3433b28954c1/barcode/image/c08ac463-71c5-4713-ad22-6b05d1fa1b9d/6684816c-4530-4d9f-84bb-5e5f9c41b9c3.svg",
        "owner_id": "ac99d53e-5492-4e5e-8e39-47ccea6b2492",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ac99d53e-5492-4e5e-8e39-47ccea6b2492"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb86bf5cc-c8bd-48c1-9cac-009861ac09ba&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b86bf5cc-c8bd-48c1-9cac-009861ac09ba",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-31T06:54:30+00:00",
        "updated_at": "2022-05-31T06:54:30+00:00",
        "number": "http://bqbl.it/b86bf5cc-c8bd-48c1-9cac-009861ac09ba",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2cba470e6632dc8f7979f04f3c766e6f/barcode/image/b86bf5cc-c8bd-48c1-9cac-009861ac09ba/1ebb5e09-c4c1-48dc-99b8-4c0dbdaed778.svg",
        "owner_id": "f7b44d0d-1248-49a8-a5b3-869fdf2c5718",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f7b44d0d-1248-49a8-a5b3-869fdf2c5718"
          },
          "data": {
            "type": "customers",
            "id": "f7b44d0d-1248-49a8-a5b3-869fdf2c5718"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f7b44d0d-1248-49a8-a5b3-869fdf2c5718",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T06:54:30+00:00",
        "updated_at": "2022-05-31T06:54:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hauck-Lang",
        "email": "hauck.lang@willms.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=f7b44d0d-1248-49a8-a5b3-869fdf2c5718&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7b44d0d-1248-49a8-a5b3-869fdf2c5718&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f7b44d0d-1248-49a8-a5b3-869fdf2c5718&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjFhNjZlNDEtMzA4OC00MGVlLWFmNWQtYmY0MzRiZmJjZmI1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f1a66e41-3088-40ee-af5d-bf434bfbcfb5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-31T06:54:31+00:00",
        "updated_at": "2022-05-31T06:54:31+00:00",
        "number": "http://bqbl.it/f1a66e41-3088-40ee-af5d-bf434bfbcfb5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63060d1c785e73beddae058d247b6549/barcode/image/f1a66e41-3088-40ee-af5d-bf434bfbcfb5/0a7d9c62-6a51-444e-a304-19dba8ebbc90.svg",
        "owner_id": "2451b933-3dcc-4ffa-a0d8-5406ff0ff467",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2451b933-3dcc-4ffa-a0d8-5406ff0ff467"
          },
          "data": {
            "type": "customers",
            "id": "2451b933-3dcc-4ffa-a0d8-5406ff0ff467"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2451b933-3dcc-4ffa-a0d8-5406ff0ff467",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T06:54:31+00:00",
        "updated_at": "2022-05-31T06:54:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mills-Skiles",
        "email": "mills.skiles@jenkins-klocko.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=2451b933-3dcc-4ffa-a0d8-5406ff0ff467&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2451b933-3dcc-4ffa-a0d8-5406ff0ff467&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2451b933-3dcc-4ffa-a0d8-5406ff0ff467&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T06:54:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99ec8a3e-cfbe-443d-83e9-8bc1ff26d25f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99ec8a3e-cfbe-443d-83e9-8bc1ff26d25f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-31T06:54:31+00:00",
      "updated_at": "2022-05-31T06:54:31+00:00",
      "number": "http://bqbl.it/99ec8a3e-cfbe-443d-83e9-8bc1ff26d25f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/61824098fb616deba4a27f04d4833d49/barcode/image/99ec8a3e-cfbe-443d-83e9-8bc1ff26d25f/f08c3c74-8a21-455c-b5e4-976e0686f2e2.svg",
      "owner_id": "3dce140a-2c22-464b-89f8-983e7bc929ed",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3dce140a-2c22-464b-89f8-983e7bc929ed"
        },
        "data": {
          "type": "customers",
          "id": "3dce140a-2c22-464b-89f8-983e7bc929ed"
        }
      }
    }
  },
  "included": [
    {
      "id": "3dce140a-2c22-464b-89f8-983e7bc929ed",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T06:54:31+00:00",
        "updated_at": "2022-05-31T06:54:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Corwin-Hilll",
        "email": "hilll.corwin@dickinson-huels.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=3dce140a-2c22-464b-89f8-983e7bc929ed&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3dce140a-2c22-464b-89f8-983e7bc929ed&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3dce140a-2c22-464b-89f8-983e7bc929ed&filter[owner_type]=customers"
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
          "owner_id": "c9a4c73c-b602-4870-a563-64fe86351257",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "73ab6a36-e24b-46c7-afe5-80164855b911",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-31T06:54:32+00:00",
      "updated_at": "2022-05-31T06:54:32+00:00",
      "number": "http://bqbl.it/73ab6a36-e24b-46c7-afe5-80164855b911",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54b33c792814a8c41a3343a04603e8d9/barcode/image/73ab6a36-e24b-46c7-afe5-80164855b911/85e85362-4b34-405e-b693-5b9ea167a06d.svg",
      "owner_id": "c9a4c73c-b602-4870-a563-64fe86351257",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bbdd7560-d1d2-427c-811c-0e4a6a89f44c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bbdd7560-d1d2-427c-811c-0e4a6a89f44c",
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
    "id": "bbdd7560-d1d2-427c-811c-0e4a6a89f44c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-31T06:54:32+00:00",
      "updated_at": "2022-05-31T06:54:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/27a1980936358e04eadcaeeaa65cdbaf/barcode/image/bbdd7560-d1d2-427c-811c-0e4a6a89f44c/98de67af-f2e0-44a0-99c6-d5d5bc420867.svg",
      "owner_id": "4c3880b8-cf4e-4195-97e5-63baddaa9057",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/56704d58-9d9a-4933-80fe-67d1eb6053bd' \
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