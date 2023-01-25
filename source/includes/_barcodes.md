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
      "id": "12051ea7-c067-46b4-88a1-4a7f41b99281",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-25T12:34:01+00:00",
        "updated_at": "2023-01-25T12:34:01+00:00",
        "number": "http://bqbl.it/12051ea7-c067-46b4-88a1-4a7f41b99281",
        "barcode_type": "qr_code",
        "image_url": "/uploads/96d6b7d9bcb72ad30ddd911ea0164cb1/barcode/image/12051ea7-c067-46b4-88a1-4a7f41b99281/eb9e14ef-5df4-4537-b55a-495ff6b05c1f.svg",
        "owner_id": "8d45c204-8257-4dde-8999-47af3117986e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8d45c204-8257-4dde-8999-47af3117986e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F457e944c-0090-4a72-9643-92659b628e41&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "457e944c-0090-4a72-9643-92659b628e41",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-25T12:34:02+00:00",
        "updated_at": "2023-01-25T12:34:02+00:00",
        "number": "http://bqbl.it/457e944c-0090-4a72-9643-92659b628e41",
        "barcode_type": "qr_code",
        "image_url": "/uploads/520a910a48040192173f142abfce608f/barcode/image/457e944c-0090-4a72-9643-92659b628e41/6d10ad12-7b17-4321-b5f0-4df33b2b8fa4.svg",
        "owner_id": "e060d445-1eff-4ff9-bfb9-712f237718d3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e060d445-1eff-4ff9-bfb9-712f237718d3"
          },
          "data": {
            "type": "customers",
            "id": "e060d445-1eff-4ff9-bfb9-712f237718d3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e060d445-1eff-4ff9-bfb9-712f237718d3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-25T12:34:02+00:00",
        "updated_at": "2023-01-25T12:34:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e060d445-1eff-4ff9-bfb9-712f237718d3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e060d445-1eff-4ff9-bfb9-712f237718d3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e060d445-1eff-4ff9-bfb9-712f237718d3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTc3Y2U4NzktNDg2Yy00YTliLTg3YTYtYWM0NzQyZWRkOTA4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "177ce879-486c-4a9b-87a6-ac4742edd908",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-25T12:34:02+00:00",
        "updated_at": "2023-01-25T12:34:02+00:00",
        "number": "http://bqbl.it/177ce879-486c-4a9b-87a6-ac4742edd908",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d5f692e1f0908c3f953d2c837ab524ee/barcode/image/177ce879-486c-4a9b-87a6-ac4742edd908/1bfe79d8-1dfb-454d-9d09-b71b8ce09e11.svg",
        "owner_id": "0694d84e-cef8-4bcd-9c4b-eecd13cb110e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0694d84e-cef8-4bcd-9c4b-eecd13cb110e"
          },
          "data": {
            "type": "customers",
            "id": "0694d84e-cef8-4bcd-9c4b-eecd13cb110e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0694d84e-cef8-4bcd-9c4b-eecd13cb110e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-25T12:34:02+00:00",
        "updated_at": "2023-01-25T12:34:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0694d84e-cef8-4bcd-9c4b-eecd13cb110e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0694d84e-cef8-4bcd-9c4b-eecd13cb110e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0694d84e-cef8-4bcd-9c4b-eecd13cb110e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-25T12:33:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/451f1826-8ab3-4076-ad88-2b27aaca88d2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "451f1826-8ab3-4076-ad88-2b27aaca88d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-25T12:34:03+00:00",
      "updated_at": "2023-01-25T12:34:03+00:00",
      "number": "http://bqbl.it/451f1826-8ab3-4076-ad88-2b27aaca88d2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a39dbf49669bf944a57ad32fac52d550/barcode/image/451f1826-8ab3-4076-ad88-2b27aaca88d2/a7e9a338-1f25-4be7-a358-bd9ffa827589.svg",
      "owner_id": "e337d94e-4069-47ee-a98c-81fc98743b21",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e337d94e-4069-47ee-a98c-81fc98743b21"
        },
        "data": {
          "type": "customers",
          "id": "e337d94e-4069-47ee-a98c-81fc98743b21"
        }
      }
    }
  },
  "included": [
    {
      "id": "e337d94e-4069-47ee-a98c-81fc98743b21",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-25T12:34:03+00:00",
        "updated_at": "2023-01-25T12:34:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e337d94e-4069-47ee-a98c-81fc98743b21&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e337d94e-4069-47ee-a98c-81fc98743b21&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e337d94e-4069-47ee-a98c-81fc98743b21&filter[owner_type]=customers"
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
          "owner_id": "cd3ddb6c-4a1c-43e5-a278-44304ad4220c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b38823ed-9088-4868-acaf-dd9dd5bb2986",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-25T12:34:04+00:00",
      "updated_at": "2023-01-25T12:34:04+00:00",
      "number": "http://bqbl.it/b38823ed-9088-4868-acaf-dd9dd5bb2986",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5843cc9bb4aa2291a242b6031b4db2cb/barcode/image/b38823ed-9088-4868-acaf-dd9dd5bb2986/7d307613-aa30-446a-be77-15e4fe4d4d10.svg",
      "owner_id": "cd3ddb6c-4a1c-43e5-a278-44304ad4220c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7277a4a5-bb5d-4d13-b8ae-c676fe1bff54' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7277a4a5-bb5d-4d13-b8ae-c676fe1bff54",
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
    "id": "7277a4a5-bb5d-4d13-b8ae-c676fe1bff54",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-25T12:34:04+00:00",
      "updated_at": "2023-01-25T12:34:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/61903d77aef509a35042cac497db181a/barcode/image/7277a4a5-bb5d-4d13-b8ae-c676fe1bff54/b1042beb-32a1-4993-a3ee-77812576a286.svg",
      "owner_id": "14cdaccb-ebe4-432e-a990-67fdd92907e4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e1591310-8938-4778-889a-1a33b680f4a2' \
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