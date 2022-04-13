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
      "id": "ec86eb62-0e25-4167-9b61-f517b3dc6733",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T06:33:46+00:00",
        "updated_at": "2022-04-13T06:33:46+00:00",
        "number": "http://bqbl.it/ec86eb62-0e25-4167-9b61-f517b3dc6733",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a5a4b0bd2a820bc4e2e4a3f071a6a027/barcode/image/ec86eb62-0e25-4167-9b61-f517b3dc6733/d0552406-691b-46f8-a2ce-666cd8898d51.svg",
        "owner_id": "2b4d8d74-ac1f-4476-ba51-24b9015fffec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2b4d8d74-ac1f-4476-ba51-24b9015fffec"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9eabb24d-30b3-4d3b-a0fb-9c47ea4ca73c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9eabb24d-30b3-4d3b-a0fb-9c47ea4ca73c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T06:33:47+00:00",
        "updated_at": "2022-04-13T06:33:47+00:00",
        "number": "http://bqbl.it/9eabb24d-30b3-4d3b-a0fb-9c47ea4ca73c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f0f1939288d2494cc01050c6fa64464a/barcode/image/9eabb24d-30b3-4d3b-a0fb-9c47ea4ca73c/1c01b705-1717-4768-a74f-58bbd72471f7.svg",
        "owner_id": "1d451b8a-44a0-4a42-9671-f8602ece9b74",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1d451b8a-44a0-4a42-9671-f8602ece9b74"
          },
          "data": {
            "type": "customers",
            "id": "1d451b8a-44a0-4a42-9671-f8602ece9b74"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1d451b8a-44a0-4a42-9671-f8602ece9b74",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T06:33:47+00:00",
        "updated_at": "2022-04-13T06:33:47+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Simonis, Bartell and Parisian",
        "email": "parisian_bartell_and_simonis@okuneva.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=1d451b8a-44a0-4a42-9671-f8602ece9b74&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1d451b8a-44a0-4a42-9671-f8602ece9b74&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1d451b8a-44a0-4a42-9671-f8602ece9b74&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTM3ZGY5NjYtOTkzOS00NjU0LWExYWQtNDU4YTJlNTRhZmU1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e37df966-9939-4654-a1ad-458a2e54afe5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T06:33:47+00:00",
        "updated_at": "2022-04-13T06:33:47+00:00",
        "number": "http://bqbl.it/e37df966-9939-4654-a1ad-458a2e54afe5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b1d57ccfb7832c6775d29e234034b4c/barcode/image/e37df966-9939-4654-a1ad-458a2e54afe5/d93719ca-b281-4dfc-9879-ef83a83f0914.svg",
        "owner_id": "3a26ad3a-3733-475b-b4c6-320f3d20ec0f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3a26ad3a-3733-475b-b4c6-320f3d20ec0f"
          },
          "data": {
            "type": "customers",
            "id": "3a26ad3a-3733-475b-b4c6-320f3d20ec0f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3a26ad3a-3733-475b-b4c6-320f3d20ec0f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T06:33:47+00:00",
        "updated_at": "2022-04-13T06:33:47+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Bergstrom Inc",
        "email": "bergstrom.inc@donnelly-keeling.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=3a26ad3a-3733-475b-b4c6-320f3d20ec0f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3a26ad3a-3733-475b-b4c6-320f3d20ec0f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3a26ad3a-3733-475b-b4c6-320f3d20ec0f&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T06:33:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f3afc5ef-0ba5-4039-813c-2e122802dddf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f3afc5ef-0ba5-4039-813c-2e122802dddf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T06:33:48+00:00",
      "updated_at": "2022-04-13T06:33:48+00:00",
      "number": "http://bqbl.it/f3afc5ef-0ba5-4039-813c-2e122802dddf",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ac62cf2ade5b93f79dc77f8612450d38/barcode/image/f3afc5ef-0ba5-4039-813c-2e122802dddf/b26594c8-7585-49e6-b708-295bb5fa0e75.svg",
      "owner_id": "b3692503-81f1-40c3-8a04-8a15d2e5695c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b3692503-81f1-40c3-8a04-8a15d2e5695c"
        },
        "data": {
          "type": "customers",
          "id": "b3692503-81f1-40c3-8a04-8a15d2e5695c"
        }
      }
    }
  },
  "included": [
    {
      "id": "b3692503-81f1-40c3-8a04-8a15d2e5695c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T06:33:48+00:00",
        "updated_at": "2022-04-13T06:33:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Gleichner Inc",
        "email": "inc_gleichner@wunsch.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=b3692503-81f1-40c3-8a04-8a15d2e5695c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b3692503-81f1-40c3-8a04-8a15d2e5695c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b3692503-81f1-40c3-8a04-8a15d2e5695c&filter[owner_type]=customers"
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
          "owner_id": "9407b8b6-4098-4fde-892b-0f47805db689",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "43ee5aa9-8f7a-4be1-8fd4-80a1323d3562",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T06:33:48+00:00",
      "updated_at": "2022-04-13T06:33:48+00:00",
      "number": "http://bqbl.it/43ee5aa9-8f7a-4be1-8fd4-80a1323d3562",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4cb90c12b31addad9172e41d317e89c0/barcode/image/43ee5aa9-8f7a-4be1-8fd4-80a1323d3562/72c78c9c-1121-42bd-9ab4-0fda876cf077.svg",
      "owner_id": "9407b8b6-4098-4fde-892b-0f47805db689",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9b30335-a0cd-4e7a-8e9f-d00b96e10dce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a9b30335-a0cd-4e7a-8e9f-d00b96e10dce",
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
    "id": "a9b30335-a0cd-4e7a-8e9f-d00b96e10dce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T06:33:49+00:00",
      "updated_at": "2022-04-13T06:33:49+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dd0206a227f2d7e7dee7f524c5f77fe6/barcode/image/a9b30335-a0cd-4e7a-8e9f-d00b96e10dce/803a85ff-f391-4362-bf2a-1a0f4d29c857.svg",
      "owner_id": "e9622518-d14e-494f-8935-812894fc5849",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bf22b6b7-1ee6-4065-85aa-950f678478cd' \
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