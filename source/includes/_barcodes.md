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
      "id": "7287e62e-a9af-459a-9b55-8cec12ddb53a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-10T08:36:51+00:00",
        "updated_at": "2023-03-10T08:36:51+00:00",
        "number": "http://bqbl.it/7287e62e-a9af-459a-9b55-8cec12ddb53a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5774dc93bd172e06d74f49bee7f817af/barcode/image/7287e62e-a9af-459a-9b55-8cec12ddb53a/2c470848-6079-4400-a8d3-a3754aeac86d.svg",
        "owner_id": "cb90eb1b-1a10-451e-a830-668c9192c656",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cb90eb1b-1a10-451e-a830-668c9192c656"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2e1effcc-d788-4ba3-8f20-c8f242f7bd7b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2e1effcc-d788-4ba3-8f20-c8f242f7bd7b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-10T08:36:51+00:00",
        "updated_at": "2023-03-10T08:36:51+00:00",
        "number": "http://bqbl.it/2e1effcc-d788-4ba3-8f20-c8f242f7bd7b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7ea5e9fb9371f394f5ddb3ad8e0df0f3/barcode/image/2e1effcc-d788-4ba3-8f20-c8f242f7bd7b/65909306-63c1-49e7-a4ab-30343da26885.svg",
        "owner_id": "1f40cb94-659b-44c0-9f66-92e634b1a455",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1f40cb94-659b-44c0-9f66-92e634b1a455"
          },
          "data": {
            "type": "customers",
            "id": "1f40cb94-659b-44c0-9f66-92e634b1a455"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1f40cb94-659b-44c0-9f66-92e634b1a455",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-10T08:36:51+00:00",
        "updated_at": "2023-03-10T08:36:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1f40cb94-659b-44c0-9f66-92e634b1a455&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1f40cb94-659b-44c0-9f66-92e634b1a455&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1f40cb94-659b-44c0-9f66-92e634b1a455&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDc5YjM4YmUtOTFkNi00Y2E1LWI1ZDctMWMzZmRlZjgxN2Vj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "479b38be-91d6-4ca5-b5d7-1c3fdef817ec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-10T08:36:53+00:00",
        "updated_at": "2023-03-10T08:36:53+00:00",
        "number": "http://bqbl.it/479b38be-91d6-4ca5-b5d7-1c3fdef817ec",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b3ea362efe62b936f24c79d4fa67b370/barcode/image/479b38be-91d6-4ca5-b5d7-1c3fdef817ec/77f2b82f-a1c2-4189-8693-e65d15f8e316.svg",
        "owner_id": "57e87712-e89d-434d-876a-ee2c885156ee",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/57e87712-e89d-434d-876a-ee2c885156ee"
          },
          "data": {
            "type": "customers",
            "id": "57e87712-e89d-434d-876a-ee2c885156ee"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "57e87712-e89d-434d-876a-ee2c885156ee",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-10T08:36:53+00:00",
        "updated_at": "2023-03-10T08:36:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=57e87712-e89d-434d-876a-ee2c885156ee&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57e87712-e89d-434d-876a-ee2c885156ee&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57e87712-e89d-434d-876a-ee2c885156ee&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-10T08:36:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8a476919-d957-43eb-ab7f-e071ec8b184c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8a476919-d957-43eb-ab7f-e071ec8b184c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-10T08:36:54+00:00",
      "updated_at": "2023-03-10T08:36:54+00:00",
      "number": "http://bqbl.it/8a476919-d957-43eb-ab7f-e071ec8b184c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d356215cd73a9f06c32e1780e0eaeb85/barcode/image/8a476919-d957-43eb-ab7f-e071ec8b184c/c35df9b2-ee63-49d9-a169-6e7e9dc9df18.svg",
      "owner_id": "87766076-8b49-4b29-9516-1376454be83e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/87766076-8b49-4b29-9516-1376454be83e"
        },
        "data": {
          "type": "customers",
          "id": "87766076-8b49-4b29-9516-1376454be83e"
        }
      }
    }
  },
  "included": [
    {
      "id": "87766076-8b49-4b29-9516-1376454be83e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-10T08:36:53+00:00",
        "updated_at": "2023-03-10T08:36:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=87766076-8b49-4b29-9516-1376454be83e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87766076-8b49-4b29-9516-1376454be83e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87766076-8b49-4b29-9516-1376454be83e&filter[owner_type]=customers"
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
          "owner_id": "eee36cee-b7f7-4b11-bf04-41a42bd8483d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "00b1a9bc-27df-449e-8ea2-706089704193",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-10T08:36:54+00:00",
      "updated_at": "2023-03-10T08:36:54+00:00",
      "number": "http://bqbl.it/00b1a9bc-27df-449e-8ea2-706089704193",
      "barcode_type": "qr_code",
      "image_url": "/uploads/508316883c33786f604091953a47f651/barcode/image/00b1a9bc-27df-449e-8ea2-706089704193/65700a99-9ca0-4c3f-ad4c-5c2ef35ddeb4.svg",
      "owner_id": "eee36cee-b7f7-4b11-bf04-41a42bd8483d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e9977ed6-2512-400d-bfd3-e21c5fd75194' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e9977ed6-2512-400d-bfd3-e21c5fd75194",
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
    "id": "e9977ed6-2512-400d-bfd3-e21c5fd75194",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-10T08:36:55+00:00",
      "updated_at": "2023-03-10T08:36:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0585909d1d8f20497b1047f2193fbc3c/barcode/image/e9977ed6-2512-400d-bfd3-e21c5fd75194/95ddd44b-4657-4717-933d-692ae9de26da.svg",
      "owner_id": "13f6b12c-8a06-464c-ac60-0c7d50af41a2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7a174fc1-58f8-4d4b-ab4f-0908c7bd4829' \
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes