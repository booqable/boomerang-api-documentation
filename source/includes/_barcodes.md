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
      "id": "cc0d5612-d54e-450b-b2a3-9c906bcc9606",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:34:37+00:00",
        "updated_at": "2022-11-22T16:34:37+00:00",
        "number": "http://bqbl.it/cc0d5612-d54e-450b-b2a3-9c906bcc9606",
        "barcode_type": "qr_code",
        "image_url": "/uploads/45a494be7984b87743d11bdfa7b38327/barcode/image/cc0d5612-d54e-450b-b2a3-9c906bcc9606/3cc7940e-758c-497d-866b-3289c4981873.svg",
        "owner_id": "5d9cd55d-d290-47ea-aaad-8c0334d72770",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5d9cd55d-d290-47ea-aaad-8c0334d72770"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F337c5a6d-b94c-42a3-bda7-85369d24c161&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "337c5a6d-b94c-42a3-bda7-85369d24c161",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:34:38+00:00",
        "updated_at": "2022-11-22T16:34:38+00:00",
        "number": "http://bqbl.it/337c5a6d-b94c-42a3-bda7-85369d24c161",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ac466a807b1df75499ddf878f5be261a/barcode/image/337c5a6d-b94c-42a3-bda7-85369d24c161/6a554b65-5e40-4936-8a55-70998db7f44a.svg",
        "owner_id": "2708631b-5644-4add-8f58-a95f2d3bc8c0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2708631b-5644-4add-8f58-a95f2d3bc8c0"
          },
          "data": {
            "type": "customers",
            "id": "2708631b-5644-4add-8f58-a95f2d3bc8c0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2708631b-5644-4add-8f58-a95f2d3bc8c0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:34:38+00:00",
        "updated_at": "2022-11-22T16:34:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2708631b-5644-4add-8f58-a95f2d3bc8c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2708631b-5644-4add-8f58-a95f2d3bc8c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2708631b-5644-4add-8f58-a95f2d3bc8c0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzUyN2Q1M2QtMmI3OS00ZjJkLThlMzUtOTk5ZjY5N2FhNjk0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3527d53d-2b79-4f2d-8e35-999f697aa694",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:34:38+00:00",
        "updated_at": "2022-11-22T16:34:38+00:00",
        "number": "http://bqbl.it/3527d53d-2b79-4f2d-8e35-999f697aa694",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8e1470443ef1accba51c0ed8a8044ec1/barcode/image/3527d53d-2b79-4f2d-8e35-999f697aa694/f1dd064c-9d54-4bf2-837e-2f6ecc00e349.svg",
        "owner_id": "b680984e-8ffe-445f-9bf1-8c6c72a4e5c2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b680984e-8ffe-445f-9bf1-8c6c72a4e5c2"
          },
          "data": {
            "type": "customers",
            "id": "b680984e-8ffe-445f-9bf1-8c6c72a4e5c2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b680984e-8ffe-445f-9bf1-8c6c72a4e5c2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:34:38+00:00",
        "updated_at": "2022-11-22T16:34:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b680984e-8ffe-445f-9bf1-8c6c72a4e5c2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b680984e-8ffe-445f-9bf1-8c6c72a4e5c2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b680984e-8ffe-445f-9bf1-8c6c72a4e5c2&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:34:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/005114af-af5b-4726-b329-c4c2110c3d4a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "005114af-af5b-4726-b329-c4c2110c3d4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:34:38+00:00",
      "updated_at": "2022-11-22T16:34:38+00:00",
      "number": "http://bqbl.it/005114af-af5b-4726-b329-c4c2110c3d4a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/003410952fb4a2296b2315d07dbeed27/barcode/image/005114af-af5b-4726-b329-c4c2110c3d4a/2062d9e8-bc34-41d4-8ebd-ce3866010a3c.svg",
      "owner_id": "f3d73473-ff69-4e64-8004-2b76a7c6f70f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f3d73473-ff69-4e64-8004-2b76a7c6f70f"
        },
        "data": {
          "type": "customers",
          "id": "f3d73473-ff69-4e64-8004-2b76a7c6f70f"
        }
      }
    }
  },
  "included": [
    {
      "id": "f3d73473-ff69-4e64-8004-2b76a7c6f70f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:34:38+00:00",
        "updated_at": "2022-11-22T16:34:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f3d73473-ff69-4e64-8004-2b76a7c6f70f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f3d73473-ff69-4e64-8004-2b76a7c6f70f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f3d73473-ff69-4e64-8004-2b76a7c6f70f&filter[owner_type]=customers"
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
          "owner_id": "0b64cccc-1e17-4f69-ac82-272245d2d42b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "39a4d18b-9da4-4c5a-9dd6-174b51425757",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:34:39+00:00",
      "updated_at": "2022-11-22T16:34:39+00:00",
      "number": "http://bqbl.it/39a4d18b-9da4-4c5a-9dd6-174b51425757",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2ca2930c0afabda1b255633ea846df42/barcode/image/39a4d18b-9da4-4c5a-9dd6-174b51425757/a4077679-3973-4eb4-a5f2-dbdf53fe75f0.svg",
      "owner_id": "0b64cccc-1e17-4f69-ac82-272245d2d42b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7b821c5a-da5a-451c-8be2-1ea17c437113' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7b821c5a-da5a-451c-8be2-1ea17c437113",
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
    "id": "7b821c5a-da5a-451c-8be2-1ea17c437113",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:34:39+00:00",
      "updated_at": "2022-11-22T16:34:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c9ba52f3ceb39911e2f7d3472eee03a/barcode/image/7b821c5a-da5a-451c-8be2-1ea17c437113/1f95f146-4fb2-4ebd-9ef2-c336766a1591.svg",
      "owner_id": "fbe3acb0-4919-4819-b0ab-6d7c47cba7af",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/55aa79d3-70ce-4455-9154-db8f89212f40' \
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