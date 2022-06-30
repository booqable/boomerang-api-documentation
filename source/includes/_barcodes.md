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
      "id": "a45c38cf-9a54-4a60-859a-e3a43998100c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T08:45:33+00:00",
        "updated_at": "2022-06-30T08:45:33+00:00",
        "number": "http://bqbl.it/a45c38cf-9a54-4a60-859a-e3a43998100c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/892edea5cddc87104ae5805e09669a22/barcode/image/a45c38cf-9a54-4a60-859a-e3a43998100c/8b9b9141-4b80-41af-b2d5-59c2249c3f98.svg",
        "owner_id": "313c2d31-73dc-45e1-af4e-e271670010b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/313c2d31-73dc-45e1-af4e-e271670010b2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdf0152fa-cbb3-412e-9e39-04b0fac86d74&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "df0152fa-cbb3-412e-9e39-04b0fac86d74",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T08:45:34+00:00",
        "updated_at": "2022-06-30T08:45:34+00:00",
        "number": "http://bqbl.it/df0152fa-cbb3-412e-9e39-04b0fac86d74",
        "barcode_type": "qr_code",
        "image_url": "/uploads/28a2cce818c48283f50f0ab7cc78d46c/barcode/image/df0152fa-cbb3-412e-9e39-04b0fac86d74/32c56b20-e7f8-443b-9faf-b653b05207a7.svg",
        "owner_id": "92d34a43-070d-4cd5-8887-154659bb815f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/92d34a43-070d-4cd5-8887-154659bb815f"
          },
          "data": {
            "type": "customers",
            "id": "92d34a43-070d-4cd5-8887-154659bb815f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "92d34a43-070d-4cd5-8887-154659bb815f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T08:45:34+00:00",
        "updated_at": "2022-06-30T08:45:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Daniel-McLaughlin",
        "email": "daniel.mclaughlin@mertz.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=92d34a43-070d-4cd5-8887-154659bb815f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92d34a43-070d-4cd5-8887-154659bb815f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92d34a43-070d-4cd5-8887-154659bb815f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDIyMWY3ZmYtMDVmNy00ZmE1LWJjYzgtNGQ4YmY0YzkwMjY1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4221f7ff-05f7-4fa5-bcc8-4d8bf4c90265",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T08:45:34+00:00",
        "updated_at": "2022-06-30T08:45:34+00:00",
        "number": "http://bqbl.it/4221f7ff-05f7-4fa5-bcc8-4d8bf4c90265",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a5fac6c73b3dfda2894b9bd58bfa29d6/barcode/image/4221f7ff-05f7-4fa5-bcc8-4d8bf4c90265/30603c0b-9efe-4655-bb8c-de478f02e061.svg",
        "owner_id": "d30a4db3-8be9-46aa-baf0-25290fb50c1b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d30a4db3-8be9-46aa-baf0-25290fb50c1b"
          },
          "data": {
            "type": "customers",
            "id": "d30a4db3-8be9-46aa-baf0-25290fb50c1b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d30a4db3-8be9-46aa-baf0-25290fb50c1b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T08:45:34+00:00",
        "updated_at": "2022-06-30T08:45:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Beahan-Hagenes",
        "email": "beahan.hagenes@blanda.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=d30a4db3-8be9-46aa-baf0-25290fb50c1b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d30a4db3-8be9-46aa-baf0-25290fb50c1b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d30a4db3-8be9-46aa-baf0-25290fb50c1b&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T08:45:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a64f2542-7559-45f1-9428-2edb8316c148?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a64f2542-7559-45f1-9428-2edb8316c148",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T08:45:35+00:00",
      "updated_at": "2022-06-30T08:45:35+00:00",
      "number": "http://bqbl.it/a64f2542-7559-45f1-9428-2edb8316c148",
      "barcode_type": "qr_code",
      "image_url": "/uploads/673926c4c8f624b432f7a644e247b7d3/barcode/image/a64f2542-7559-45f1-9428-2edb8316c148/de53b039-7f43-4ad9-b6ff-e5318d74371c.svg",
      "owner_id": "763adf57-fd70-4807-8d40-24a7fc83d6a3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/763adf57-fd70-4807-8d40-24a7fc83d6a3"
        },
        "data": {
          "type": "customers",
          "id": "763adf57-fd70-4807-8d40-24a7fc83d6a3"
        }
      }
    }
  },
  "included": [
    {
      "id": "763adf57-fd70-4807-8d40-24a7fc83d6a3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T08:45:34+00:00",
        "updated_at": "2022-06-30T08:45:35+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "MacGyver Group",
        "email": "group_macgyver@morissette.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=763adf57-fd70-4807-8d40-24a7fc83d6a3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=763adf57-fd70-4807-8d40-24a7fc83d6a3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=763adf57-fd70-4807-8d40-24a7fc83d6a3&filter[owner_type]=customers"
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
          "owner_id": "647fd5d6-0999-41fb-9ab1-52423ae132cc",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b680c949-3fbc-49d3-8a75-75681d7bf13f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T08:45:35+00:00",
      "updated_at": "2022-06-30T08:45:35+00:00",
      "number": "http://bqbl.it/b680c949-3fbc-49d3-8a75-75681d7bf13f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/77ed8e2e9f79f3cad1ac81211648619c/barcode/image/b680c949-3fbc-49d3-8a75-75681d7bf13f/74a73f76-e6c4-4dc5-864f-7f515863bed8.svg",
      "owner_id": "647fd5d6-0999-41fb-9ab1-52423ae132cc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/949abea9-e9cc-4ce6-a2be-1ed6e629897a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "949abea9-e9cc-4ce6-a2be-1ed6e629897a",
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
    "id": "949abea9-e9cc-4ce6-a2be-1ed6e629897a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T08:45:35+00:00",
      "updated_at": "2022-06-30T08:45:36+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db9ca9f8501cf5486e5d75120cd06a5e/barcode/image/949abea9-e9cc-4ce6-a2be-1ed6e629897a/17a4aec4-f4c6-43e5-866d-774ddcabbeec.svg",
      "owner_id": "c85f72f7-ceeb-4c50-a609-e0e587f9f633",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/01714be0-1cdc-4b54-8e7e-ac94543fd368' \
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