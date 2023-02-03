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
      "id": "9ac01753-d648-4a23-bf0f-6e199c8556da",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T08:13:49+00:00",
        "updated_at": "2023-02-03T08:13:49+00:00",
        "number": "http://bqbl.it/9ac01753-d648-4a23-bf0f-6e199c8556da",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c5fcaf682070ad3e97ef44e3a4304c52/barcode/image/9ac01753-d648-4a23-bf0f-6e199c8556da/c2710506-5a4b-459e-85ab-de95b2d08dfc.svg",
        "owner_id": "8355b5ef-4780-4e99-a1b6-eb22286ea772",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8355b5ef-4780-4e99-a1b6-eb22286ea772"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2c1b3ae5-0a8c-4096-9ecc-d9261ec21260&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2c1b3ae5-0a8c-4096-9ecc-d9261ec21260",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T08:13:50+00:00",
        "updated_at": "2023-02-03T08:13:50+00:00",
        "number": "http://bqbl.it/2c1b3ae5-0a8c-4096-9ecc-d9261ec21260",
        "barcode_type": "qr_code",
        "image_url": "/uploads/235100e30a9145058e71eb7ab641f9e6/barcode/image/2c1b3ae5-0a8c-4096-9ecc-d9261ec21260/3a4f37f9-938b-4de2-a10a-5b7d4b2aa236.svg",
        "owner_id": "c254d511-57e9-4b0e-a541-47d1e8d09726",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c254d511-57e9-4b0e-a541-47d1e8d09726"
          },
          "data": {
            "type": "customers",
            "id": "c254d511-57e9-4b0e-a541-47d1e8d09726"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c254d511-57e9-4b0e-a541-47d1e8d09726",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T08:13:50+00:00",
        "updated_at": "2023-02-03T08:13:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c254d511-57e9-4b0e-a541-47d1e8d09726&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c254d511-57e9-4b0e-a541-47d1e8d09726&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c254d511-57e9-4b0e-a541-47d1e8d09726&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDZlMjFjMGUtOWI4YS00ODRhLWFlZmYtNGI2NDA5NzIzMGVk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "46e21c0e-9b8a-484a-aeff-4b64097230ed",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T08:13:50+00:00",
        "updated_at": "2023-02-03T08:13:50+00:00",
        "number": "http://bqbl.it/46e21c0e-9b8a-484a-aeff-4b64097230ed",
        "barcode_type": "qr_code",
        "image_url": "/uploads/455dc186066875e87b5d930ae53c9d4a/barcode/image/46e21c0e-9b8a-484a-aeff-4b64097230ed/b2b0f324-7b04-4686-8dd0-295d8cf9f66c.svg",
        "owner_id": "c1ecf841-a78d-4de1-89e0-06f208948515",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c1ecf841-a78d-4de1-89e0-06f208948515"
          },
          "data": {
            "type": "customers",
            "id": "c1ecf841-a78d-4de1-89e0-06f208948515"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c1ecf841-a78d-4de1-89e0-06f208948515",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T08:13:50+00:00",
        "updated_at": "2023-02-03T08:13:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c1ecf841-a78d-4de1-89e0-06f208948515&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c1ecf841-a78d-4de1-89e0-06f208948515&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c1ecf841-a78d-4de1-89e0-06f208948515&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T08:13:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2af86d99-fb51-4a81-8bd7-94fa99e9618b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2af86d99-fb51-4a81-8bd7-94fa99e9618b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T08:13:51+00:00",
      "updated_at": "2023-02-03T08:13:51+00:00",
      "number": "http://bqbl.it/2af86d99-fb51-4a81-8bd7-94fa99e9618b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/299732de0ed630b5f4e07a2f7f06b781/barcode/image/2af86d99-fb51-4a81-8bd7-94fa99e9618b/189153e0-1f25-4c51-bd4c-94c9c437fa90.svg",
      "owner_id": "ce90a41f-5fe7-4b8c-9bb2-29984baae928",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ce90a41f-5fe7-4b8c-9bb2-29984baae928"
        },
        "data": {
          "type": "customers",
          "id": "ce90a41f-5fe7-4b8c-9bb2-29984baae928"
        }
      }
    }
  },
  "included": [
    {
      "id": "ce90a41f-5fe7-4b8c-9bb2-29984baae928",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T08:13:51+00:00",
        "updated_at": "2023-02-03T08:13:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ce90a41f-5fe7-4b8c-9bb2-29984baae928&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ce90a41f-5fe7-4b8c-9bb2-29984baae928&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ce90a41f-5fe7-4b8c-9bb2-29984baae928&filter[owner_type]=customers"
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
          "owner_id": "13326df3-be70-4b54-b46a-1ac125c5299c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "02794cff-0380-439d-a0fd-ae5880d36782",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T08:13:52+00:00",
      "updated_at": "2023-02-03T08:13:52+00:00",
      "number": "http://bqbl.it/02794cff-0380-439d-a0fd-ae5880d36782",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f6a6d3c51289d1e7fe86b260db2b222a/barcode/image/02794cff-0380-439d-a0fd-ae5880d36782/e062c96c-8b21-4a99-8a7c-33a2aaddb415.svg",
      "owner_id": "13326df3-be70-4b54-b46a-1ac125c5299c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8ebfb9b6-e8e7-44e6-a8d8-8acf45a8a9a6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8ebfb9b6-e8e7-44e6-a8d8-8acf45a8a9a6",
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
    "id": "8ebfb9b6-e8e7-44e6-a8d8-8acf45a8a9a6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T08:13:52+00:00",
      "updated_at": "2023-02-03T08:13:52+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b11b8f94f7d70de464b274c74078d77b/barcode/image/8ebfb9b6-e8e7-44e6-a8d8-8acf45a8a9a6/c43473d1-af93-4c47-9bbd-391528cf9730.svg",
      "owner_id": "e6bcf8e4-b4ca-4054-a2c6-4a3f8f1116ee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9bcb6158-bbcb-4ac8-a57f-db29ed3f3352' \
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