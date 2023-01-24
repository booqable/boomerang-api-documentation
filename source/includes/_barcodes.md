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
      "id": "39cd05d2-d1b8-481a-9304-f74d3d9d9df5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T14:00:18+00:00",
        "updated_at": "2023-01-24T14:00:18+00:00",
        "number": "http://bqbl.it/39cd05d2-d1b8-481a-9304-f74d3d9d9df5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dc9c7792abf023dc6345a5ac0ae8a150/barcode/image/39cd05d2-d1b8-481a-9304-f74d3d9d9df5/714aa844-535e-433e-84ac-0f320703ec25.svg",
        "owner_id": "de15aa59-c222-4b8d-a761-ceae3f13293b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/de15aa59-c222-4b8d-a761-ceae3f13293b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdde45054-7054-49d5-a283-e2bb635ab748&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dde45054-7054-49d5-a283-e2bb635ab748",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T14:00:18+00:00",
        "updated_at": "2023-01-24T14:00:18+00:00",
        "number": "http://bqbl.it/dde45054-7054-49d5-a283-e2bb635ab748",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b784c35f7a908973b66b1ff7fc2e4ce3/barcode/image/dde45054-7054-49d5-a283-e2bb635ab748/3537067b-2740-4b06-9cf4-f0b32af88036.svg",
        "owner_id": "b6cd72da-7f67-436b-a642-19dbe97a8b30",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b6cd72da-7f67-436b-a642-19dbe97a8b30"
          },
          "data": {
            "type": "customers",
            "id": "b6cd72da-7f67-436b-a642-19dbe97a8b30"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b6cd72da-7f67-436b-a642-19dbe97a8b30",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T14:00:18+00:00",
        "updated_at": "2023-01-24T14:00:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b6cd72da-7f67-436b-a642-19dbe97a8b30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b6cd72da-7f67-436b-a642-19dbe97a8b30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b6cd72da-7f67-436b-a642-19dbe97a8b30&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvY2U2NDVjYWYtZGZlZC00ZjhkLTk0NTEtMWI5ODc2M2Y5Nzgx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ce645caf-dfed-4f8d-9451-1b98763f9781",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T14:00:19+00:00",
        "updated_at": "2023-01-24T14:00:19+00:00",
        "number": "http://bqbl.it/ce645caf-dfed-4f8d-9451-1b98763f9781",
        "barcode_type": "qr_code",
        "image_url": "/uploads/09638e55952d9edc4e544b95a0c1bb19/barcode/image/ce645caf-dfed-4f8d-9451-1b98763f9781/b383c85d-10e1-4390-af5f-82a08e90e8d1.svg",
        "owner_id": "516b88bb-9135-4fac-bcad-037220ad6bbb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/516b88bb-9135-4fac-bcad-037220ad6bbb"
          },
          "data": {
            "type": "customers",
            "id": "516b88bb-9135-4fac-bcad-037220ad6bbb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "516b88bb-9135-4fac-bcad-037220ad6bbb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T14:00:19+00:00",
        "updated_at": "2023-01-24T14:00:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=516b88bb-9135-4fac-bcad-037220ad6bbb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=516b88bb-9135-4fac-bcad-037220ad6bbb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=516b88bb-9135-4fac-bcad-037220ad6bbb&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T14:00:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1135f7c7-a4cf-4086-85a1-1b39b65e4dc2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1135f7c7-a4cf-4086-85a1-1b39b65e4dc2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T14:00:19+00:00",
      "updated_at": "2023-01-24T14:00:19+00:00",
      "number": "http://bqbl.it/1135f7c7-a4cf-4086-85a1-1b39b65e4dc2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/35b344478e0d7cd47e8c0c55d72e7d6b/barcode/image/1135f7c7-a4cf-4086-85a1-1b39b65e4dc2/93b2ee71-e261-4100-a5d3-b1ffd6e3f2e0.svg",
      "owner_id": "c00fffa0-502a-428d-8ea6-05f9c42540ee",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c00fffa0-502a-428d-8ea6-05f9c42540ee"
        },
        "data": {
          "type": "customers",
          "id": "c00fffa0-502a-428d-8ea6-05f9c42540ee"
        }
      }
    }
  },
  "included": [
    {
      "id": "c00fffa0-502a-428d-8ea6-05f9c42540ee",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T14:00:19+00:00",
        "updated_at": "2023-01-24T14:00:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c00fffa0-502a-428d-8ea6-05f9c42540ee&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c00fffa0-502a-428d-8ea6-05f9c42540ee&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c00fffa0-502a-428d-8ea6-05f9c42540ee&filter[owner_type]=customers"
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
          "owner_id": "67b7a575-0c39-4ac5-bf0a-b478ae5c2e2e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d2fe04d7-1da1-430b-a1c0-01db96d002db",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T14:00:20+00:00",
      "updated_at": "2023-01-24T14:00:20+00:00",
      "number": "http://bqbl.it/d2fe04d7-1da1-430b-a1c0-01db96d002db",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c3c41fe61c97af24770348b211a294e3/barcode/image/d2fe04d7-1da1-430b-a1c0-01db96d002db/58871ba5-559f-440c-9bca-356e75df8e69.svg",
      "owner_id": "67b7a575-0c39-4ac5-bf0a-b478ae5c2e2e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d8276eb-3f09-48f3-9c6e-b1d7299f9ab3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d8276eb-3f09-48f3-9c6e-b1d7299f9ab3",
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
    "id": "2d8276eb-3f09-48f3-9c6e-b1d7299f9ab3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T14:00:20+00:00",
      "updated_at": "2023-01-24T14:00:20+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/655e54176c89225b451dbcff23230e7e/barcode/image/2d8276eb-3f09-48f3-9c6e-b1d7299f9ab3/424208e1-75c8-4cb3-9d02-7b379468a8d7.svg",
      "owner_id": "3e44d665-0c76-4fce-b23d-6c4388f8019a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/db4af8ee-d858-4dfd-9733-395f16c114f7' \
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