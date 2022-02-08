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
      "id": "73ef8b8b-8d51-4769-a74b-3db9de652b9f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-08T09:12:37+00:00",
        "updated_at": "2022-02-08T09:12:37+00:00",
        "number": "http://bqbl.it/73ef8b8b-8d51-4769-a74b-3db9de652b9f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/440debad58b46fb8842b920b64bc5077/barcode/image/73ef8b8b-8d51-4769-a74b-3db9de652b9f/ce309df7-0887-43de-ae04-d9432533580a.svg",
        "owner_id": "78b33a46-81a8-4a94-bf7b-dd96444a3234",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/78b33a46-81a8-4a94-bf7b-dd96444a3234"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9e0adf45-038f-44e8-a8e5-6cd8d54462ba&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9e0adf45-038f-44e8-a8e5-6cd8d54462ba",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-08T09:12:37+00:00",
        "updated_at": "2022-02-08T09:12:37+00:00",
        "number": "http://bqbl.it/9e0adf45-038f-44e8-a8e5-6cd8d54462ba",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4fc235c6391237235a77e87d6d33a2a9/barcode/image/9e0adf45-038f-44e8-a8e5-6cd8d54462ba/431009ad-e52e-4e34-992a-4ce65fa0d03f.svg",
        "owner_id": "732accf0-1fc5-4693-a700-4f4904f56f4f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/732accf0-1fc5-4693-a700-4f4904f56f4f"
          },
          "data": {
            "type": "customers",
            "id": "732accf0-1fc5-4693-a700-4f4904f56f4f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "732accf0-1fc5-4693-a700-4f4904f56f4f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-08T09:12:37+00:00",
        "updated_at": "2022-02-08T09:12:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Crist and Sons",
        "email": "and.sons.crist@paucek.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=732accf0-1fc5-4693-a700-4f4904f56f4f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=732accf0-1fc5-4693-a700-4f4904f56f4f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=732accf0-1fc5-4693-a700-4f4904f56f4f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmU2M2U1ZTAtYTZhNS00MjVlLWFlOGMtNTMyODNjZjZkNjA0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2e63e5e0-a6a5-425e-ae8c-53283cf6d604",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-08T09:12:38+00:00",
        "updated_at": "2022-02-08T09:12:38+00:00",
        "number": "http://bqbl.it/2e63e5e0-a6a5-425e-ae8c-53283cf6d604",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0130f60156a1b775ace99d584b69e324/barcode/image/2e63e5e0-a6a5-425e-ae8c-53283cf6d604/67461f81-81e0-4f39-b3e2-fa5494ffc52f.svg",
        "owner_id": "65ee7928-5925-4612-b81a-e0b7f2006cd5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/65ee7928-5925-4612-b81a-e0b7f2006cd5"
          },
          "data": {
            "type": "customers",
            "id": "65ee7928-5925-4612-b81a-e0b7f2006cd5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "65ee7928-5925-4612-b81a-e0b7f2006cd5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-08T09:12:38+00:00",
        "updated_at": "2022-02-08T09:12:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Johns, Stanton and Parker",
        "email": "stanton_parker_johns_and@bernier-hettinger.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=65ee7928-5925-4612-b81a-e0b7f2006cd5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=65ee7928-5925-4612-b81a-e0b7f2006cd5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=65ee7928-5925-4612-b81a-e0b7f2006cd5&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c295e204-65f7-4fc9-bda0-edd56d48a626?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c295e204-65f7-4fc9-bda0-edd56d48a626",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-08T09:12:39+00:00",
      "updated_at": "2022-02-08T09:12:39+00:00",
      "number": "http://bqbl.it/c295e204-65f7-4fc9-bda0-edd56d48a626",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aab0028c69683f7ce782d13772cbb75e/barcode/image/c295e204-65f7-4fc9-bda0-edd56d48a626/ad2b0e63-e548-4c5a-98b1-749a7e7e7caf.svg",
      "owner_id": "c84ff881-7ce0-4eba-a568-5660072a7545",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c84ff881-7ce0-4eba-a568-5660072a7545"
        },
        "data": {
          "type": "customers",
          "id": "c84ff881-7ce0-4eba-a568-5660072a7545"
        }
      }
    }
  },
  "included": [
    {
      "id": "c84ff881-7ce0-4eba-a568-5660072a7545",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-08T09:12:39+00:00",
        "updated_at": "2022-02-08T09:12:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Pfeffer-Dach",
        "email": "pfeffer.dach@skiles.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=c84ff881-7ce0-4eba-a568-5660072a7545&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c84ff881-7ce0-4eba-a568-5660072a7545&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c84ff881-7ce0-4eba-a568-5660072a7545&filter[owner_type]=customers"
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
          "owner_id": "69ccf8d4-d938-4e7e-be84-e54bfce75ebb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "114ae521-5005-401b-8f16-4c0f009861af",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-08T09:12:39+00:00",
      "updated_at": "2022-02-08T09:12:39+00:00",
      "number": "http://bqbl.it/114ae521-5005-401b-8f16-4c0f009861af",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e66adab73205f937723976b2b4e4e19e/barcode/image/114ae521-5005-401b-8f16-4c0f009861af/35d278a3-832f-41da-a36f-aeda4bfd9204.svg",
      "owner_id": "69ccf8d4-d938-4e7e-be84-e54bfce75ebb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/29375fa0-0a4e-48e6-8887-ca3746504a17' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "29375fa0-0a4e-48e6-8887-ca3746504a17",
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
    "id": "29375fa0-0a4e-48e6-8887-ca3746504a17",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-08T09:12:40+00:00",
      "updated_at": "2022-02-08T09:12:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/268d8ee93ca0481a2c1daac068fa0c94/barcode/image/29375fa0-0a4e-48e6-8887-ca3746504a17/53fda884-de1f-48a8-a11b-707948825f4b.svg",
      "owner_id": "09656f1a-93b6-45ae-9bc1-8c20821507e7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f063c44a-97cd-470a-bbeb-bedd920b69fa' \
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