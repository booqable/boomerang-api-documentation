# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "58ab334f-dcfe-4c63-8b3d-03c5849b8833",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-26T14:23:36+00:00",
        "updated_at": "2022-01-26T14:23:36+00:00",
        "number": "http://bqbl.it/58ab334f-dcfe-4c63-8b3d-03c5849b8833",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6954c1eacfe0a179c0bdeef163ef4978/barcode/image/58ab334f-dcfe-4c63-8b3d-03c5849b8833/50977873-3c0d-425b-af2e-8b401146b4f1.svg",
        "owner_id": "c3d7deec-eee4-4ae5-97a3-25dac1a1a4e2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c3d7deec-eee4-4ae5-97a3-25dac1a1a4e2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Feda2c5ba-58af-4f98-b216-d2d3c7b57730&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eda2c5ba-58af-4f98-b216-d2d3c7b57730",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-26T14:23:37+00:00",
        "updated_at": "2022-01-26T14:23:37+00:00",
        "number": "http://bqbl.it/eda2c5ba-58af-4f98-b216-d2d3c7b57730",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ef57f161a93654bdac6436d1b4d1c1fd/barcode/image/eda2c5ba-58af-4f98-b216-d2d3c7b57730/b49c4014-60d1-444d-ad7a-a0fcbfe8a6ec.svg",
        "owner_id": "dcdda012-56c0-4639-95d6-2585908a4438",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dcdda012-56c0-4639-95d6-2585908a4438"
          },
          "data": {
            "type": "customers",
            "id": "dcdda012-56c0-4639-95d6-2585908a4438"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dcdda012-56c0-4639-95d6-2585908a4438",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-26T14:23:37+00:00",
        "updated_at": "2022-01-26T14:23:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Murray Group",
        "email": "murray_group@nikolaus.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=dcdda012-56c0-4639-95d6-2585908a4438&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dcdda012-56c0-4639-95d6-2585908a4438&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dcdda012-56c0-4639-95d6-2585908a4438&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-26T14:23:27Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/92e88aee-f195-412e-9ad1-98d227874aca?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "92e88aee-f195-412e-9ad1-98d227874aca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-26T14:23:37+00:00",
      "updated_at": "2022-01-26T14:23:37+00:00",
      "number": "http://bqbl.it/92e88aee-f195-412e-9ad1-98d227874aca",
      "barcode_type": "qr_code",
      "image_url": "/uploads/969ba01f252a57146a802de200f42123/barcode/image/92e88aee-f195-412e-9ad1-98d227874aca/6b3f2acd-7169-4439-a3af-1b8360267b27.svg",
      "owner_id": "57c307bd-d0e7-47db-8230-251c4dd77fa1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/57c307bd-d0e7-47db-8230-251c4dd77fa1"
        },
        "data": {
          "type": "customers",
          "id": "57c307bd-d0e7-47db-8230-251c4dd77fa1"
        }
      }
    }
  },
  "included": [
    {
      "id": "57c307bd-d0e7-47db-8230-251c4dd77fa1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-26T14:23:37+00:00",
        "updated_at": "2022-01-26T14:23:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Russel and Sons",
        "email": "russel_and_sons@jacobi-donnelly.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=57c307bd-d0e7-47db-8230-251c4dd77fa1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57c307bd-d0e7-47db-8230-251c4dd77fa1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57c307bd-d0e7-47db-8230-251c4dd77fa1&filter[owner_type]=customers"
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
          "owner_id": "063a24ec-1660-4db4-a0c3-f17ce40b72db",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "97048550-b29f-458d-84c1-659b7851bfd8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-26T14:23:38+00:00",
      "updated_at": "2022-01-26T14:23:38+00:00",
      "number": "http://bqbl.it/97048550-b29f-458d-84c1-659b7851bfd8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b0b841038dec68910460b990db947c87/barcode/image/97048550-b29f-458d-84c1-659b7851bfd8/98261036-da39-401b-8261-261c36bcd023.svg",
      "owner_id": "063a24ec-1660-4db4-a0c3-f17ce40b72db",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/48778791-7d2e-4c80-b929-b3052cbd1d0a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "48778791-7d2e-4c80-b929-b3052cbd1d0a",
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
    "id": "48778791-7d2e-4c80-b929-b3052cbd1d0a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-26T14:23:38+00:00",
      "updated_at": "2022-01-26T14:23:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2ecc1806dea03871c33e21931aeb501e/barcode/image/48778791-7d2e-4c80-b929-b3052cbd1d0a/5cb04498-c98e-4745-9aa7-875f4a017601.svg",
      "owner_id": "40043bc1-dbc1-4f5d-9593-69b26f1aed15",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dbb2c86c-7efa-47da-9c06-6270b205f1bf' \
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