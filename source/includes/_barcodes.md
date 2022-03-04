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
      "id": "83967cef-0df8-474f-a598-30ccde939e83",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-04T10:45:43+00:00",
        "updated_at": "2022-03-04T10:45:43+00:00",
        "number": "http://bqbl.it/83967cef-0df8-474f-a598-30ccde939e83",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d3616a3d203d3fd8f95f93dfb8a4e99c/barcode/image/83967cef-0df8-474f-a598-30ccde939e83/95943884-88c9-49d8-b175-c23eaf4f4dce.svg",
        "owner_id": "d9a8b7c6-b7ad-4c6f-b2d1-4219a1824b73",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d9a8b7c6-b7ad-4c6f-b2d1-4219a1824b73"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5c8e9fc2-acd8-444f-9c25-b4ac1fa45bea&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5c8e9fc2-acd8-444f-9c25-b4ac1fa45bea",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-04T10:45:43+00:00",
        "updated_at": "2022-03-04T10:45:43+00:00",
        "number": "http://bqbl.it/5c8e9fc2-acd8-444f-9c25-b4ac1fa45bea",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1e635a80d3159f21a38ddb4e44d67ea5/barcode/image/5c8e9fc2-acd8-444f-9c25-b4ac1fa45bea/5b485371-42de-43fa-b757-8310d33179b6.svg",
        "owner_id": "1f63d13b-4783-456f-a684-a5c40af2599c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1f63d13b-4783-456f-a684-a5c40af2599c"
          },
          "data": {
            "type": "customers",
            "id": "1f63d13b-4783-456f-a684-a5c40af2599c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1f63d13b-4783-456f-a684-a5c40af2599c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-04T10:45:43+00:00",
        "updated_at": "2022-03-04T10:45:43+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Nicolas, Casper and Pfannerstill",
        "email": "nicolas.pfannerstill.and.casper@towne.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=1f63d13b-4783-456f-a684-a5c40af2599c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1f63d13b-4783-456f-a684-a5c40af2599c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1f63d13b-4783-456f-a684-a5c40af2599c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZmMwNGNlNjUtNGQ0Zi00NWRiLWI0ZmYtYWEwZmE4NjAwYjJl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fc04ce65-4d4f-45db-b4ff-aa0fa8600b2e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-04T10:45:44+00:00",
        "updated_at": "2022-03-04T10:45:44+00:00",
        "number": "http://bqbl.it/fc04ce65-4d4f-45db-b4ff-aa0fa8600b2e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b204aeba55d08798cb84244ec328a4d2/barcode/image/fc04ce65-4d4f-45db-b4ff-aa0fa8600b2e/b2b88518-531f-4ed4-a5f1-c887492ee39f.svg",
        "owner_id": "d1195c1e-90ee-4a61-96d9-838400b557ee",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d1195c1e-90ee-4a61-96d9-838400b557ee"
          },
          "data": {
            "type": "customers",
            "id": "d1195c1e-90ee-4a61-96d9-838400b557ee"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d1195c1e-90ee-4a61-96d9-838400b557ee",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-04T10:45:44+00:00",
        "updated_at": "2022-03-04T10:45:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Leuschke, Ankunding and Stanton",
        "email": "ankunding.and.stanton.leuschke@white-orn.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=d1195c1e-90ee-4a61-96d9-838400b557ee&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d1195c1e-90ee-4a61-96d9-838400b557ee&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d1195c1e-90ee-4a61-96d9-838400b557ee&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-04T10:45:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c09b7d38-bb28-47f9-9210-ab78a89abc4a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c09b7d38-bb28-47f9-9210-ab78a89abc4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-04T10:45:44+00:00",
      "updated_at": "2022-03-04T10:45:44+00:00",
      "number": "http://bqbl.it/c09b7d38-bb28-47f9-9210-ab78a89abc4a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/34c85bd7c47f21505cac3fea0b261016/barcode/image/c09b7d38-bb28-47f9-9210-ab78a89abc4a/94fbf688-cd62-46ab-ae84-2e26a91d89c7.svg",
      "owner_id": "f7f6dbc4-4161-4c70-9b1a-de4e01f83df6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f7f6dbc4-4161-4c70-9b1a-de4e01f83df6"
        },
        "data": {
          "type": "customers",
          "id": "f7f6dbc4-4161-4c70-9b1a-de4e01f83df6"
        }
      }
    }
  },
  "included": [
    {
      "id": "f7f6dbc4-4161-4c70-9b1a-de4e01f83df6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-04T10:45:44+00:00",
        "updated_at": "2022-03-04T10:45:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Farrell LLC",
        "email": "llc.farrell@johnston.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=f7f6dbc4-4161-4c70-9b1a-de4e01f83df6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7f6dbc4-4161-4c70-9b1a-de4e01f83df6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f7f6dbc4-4161-4c70-9b1a-de4e01f83df6&filter[owner_type]=customers"
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
          "owner_id": "442f9390-5c60-494d-9f07-c3ad790f105a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8df5cf1e-9aba-4c6d-8e2a-ee3ea1fcc628",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-04T10:45:45+00:00",
      "updated_at": "2022-03-04T10:45:45+00:00",
      "number": "http://bqbl.it/8df5cf1e-9aba-4c6d-8e2a-ee3ea1fcc628",
      "barcode_type": "qr_code",
      "image_url": "/uploads/61d9a1ee6c3d97e6dd9808a682a953e1/barcode/image/8df5cf1e-9aba-4c6d-8e2a-ee3ea1fcc628/838801f8-ac32-46fb-9f6e-4421f7120293.svg",
      "owner_id": "442f9390-5c60-494d-9f07-c3ad790f105a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1da88674-a83b-45e0-b769-3647dd916b4a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1da88674-a83b-45e0-b769-3647dd916b4a",
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
    "id": "1da88674-a83b-45e0-b769-3647dd916b4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-04T10:45:45+00:00",
      "updated_at": "2022-03-04T10:45:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a3a661dee163907101e33a86599f1c06/barcode/image/1da88674-a83b-45e0-b769-3647dd916b4a/9e4d3c1d-99e1-406b-97ac-693bbc6f66c4.svg",
      "owner_id": "007f3604-9604-4d4e-b1d6-f61fb9c98206",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/285a9a05-7208-425e-a60d-b28c2e05b38d' \
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