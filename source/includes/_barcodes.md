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
      "id": "f093e566-5d77-4d8b-925e-acd4483f5597",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T22:55:10+00:00",
        "updated_at": "2023-02-16T22:55:10+00:00",
        "number": "http://bqbl.it/f093e566-5d77-4d8b-925e-acd4483f5597",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6c7c6feaa205d3f518378a448e94f9b4/barcode/image/f093e566-5d77-4d8b-925e-acd4483f5597/465902fb-996f-45d9-ab41-c9219c540862.svg",
        "owner_id": "aff8663a-3d37-4939-837e-5d07e167d1a1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aff8663a-3d37-4939-837e-5d07e167d1a1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc42032a5-b726-46c1-b22f-a20adbfbeb3d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c42032a5-b726-46c1-b22f-a20adbfbeb3d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T22:55:11+00:00",
        "updated_at": "2023-02-16T22:55:11+00:00",
        "number": "http://bqbl.it/c42032a5-b726-46c1-b22f-a20adbfbeb3d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/08784588a4b930f55ddae6828137e08c/barcode/image/c42032a5-b726-46c1-b22f-a20adbfbeb3d/4613387b-6a36-4beb-a7d6-176f6b4fe955.svg",
        "owner_id": "da441835-64b4-49a4-894f-f32322b312ee",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/da441835-64b4-49a4-894f-f32322b312ee"
          },
          "data": {
            "type": "customers",
            "id": "da441835-64b4-49a4-894f-f32322b312ee"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "da441835-64b4-49a4-894f-f32322b312ee",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T22:55:11+00:00",
        "updated_at": "2023-02-16T22:55:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=da441835-64b4-49a4-894f-f32322b312ee&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=da441835-64b4-49a4-894f-f32322b312ee&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=da441835-64b4-49a4-894f-f32322b312ee&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTNjMjk3YWQtZTAyMy00Yzk4LWJjNzktYmQ2MTM5YTIzNTBm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a3c297ad-e023-4c98-bc79-bd6139a2350f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T22:55:11+00:00",
        "updated_at": "2023-02-16T22:55:11+00:00",
        "number": "http://bqbl.it/a3c297ad-e023-4c98-bc79-bd6139a2350f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0fa19bdb6f60cccbede74cf8c83e8b57/barcode/image/a3c297ad-e023-4c98-bc79-bd6139a2350f/23a83fa7-d8d2-4bc5-97a8-0abe16da2b61.svg",
        "owner_id": "34548e46-2649-4494-b9ab-f91b299728da",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/34548e46-2649-4494-b9ab-f91b299728da"
          },
          "data": {
            "type": "customers",
            "id": "34548e46-2649-4494-b9ab-f91b299728da"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "34548e46-2649-4494-b9ab-f91b299728da",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T22:55:11+00:00",
        "updated_at": "2023-02-16T22:55:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=34548e46-2649-4494-b9ab-f91b299728da&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=34548e46-2649-4494-b9ab-f91b299728da&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=34548e46-2649-4494-b9ab-f91b299728da&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T22:54:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ace2b52d-7235-449e-911b-a5cfea872e92?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ace2b52d-7235-449e-911b-a5cfea872e92",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T22:55:12+00:00",
      "updated_at": "2023-02-16T22:55:12+00:00",
      "number": "http://bqbl.it/ace2b52d-7235-449e-911b-a5cfea872e92",
      "barcode_type": "qr_code",
      "image_url": "/uploads/16114e65dbfc94f5580c39f79cd7e2f8/barcode/image/ace2b52d-7235-449e-911b-a5cfea872e92/3823147e-f9e0-46fe-975a-0cd99c2f60a0.svg",
      "owner_id": "8328a36d-553e-4888-ba02-618af4f1dc71",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8328a36d-553e-4888-ba02-618af4f1dc71"
        },
        "data": {
          "type": "customers",
          "id": "8328a36d-553e-4888-ba02-618af4f1dc71"
        }
      }
    }
  },
  "included": [
    {
      "id": "8328a36d-553e-4888-ba02-618af4f1dc71",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T22:55:12+00:00",
        "updated_at": "2023-02-16T22:55:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8328a36d-553e-4888-ba02-618af4f1dc71&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8328a36d-553e-4888-ba02-618af4f1dc71&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8328a36d-553e-4888-ba02-618af4f1dc71&filter[owner_type]=customers"
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
          "owner_id": "3b9c147b-a499-4a5b-9f8a-8e0a59089091",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "01dce9e1-37b6-4e1e-8a4b-f46a5da4e317",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T22:55:12+00:00",
      "updated_at": "2023-02-16T22:55:12+00:00",
      "number": "http://bqbl.it/01dce9e1-37b6-4e1e-8a4b-f46a5da4e317",
      "barcode_type": "qr_code",
      "image_url": "/uploads/83f8132452b1b47cf2b417239ded20f9/barcode/image/01dce9e1-37b6-4e1e-8a4b-f46a5da4e317/497d8cbf-05f9-40fa-b9b4-ce1754a92652.svg",
      "owner_id": "3b9c147b-a499-4a5b-9f8a-8e0a59089091",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b716725d-f134-49c0-8cf5-beb2c1af8acf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b716725d-f134-49c0-8cf5-beb2c1af8acf",
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
    "id": "b716725d-f134-49c0-8cf5-beb2c1af8acf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T22:55:13+00:00",
      "updated_at": "2023-02-16T22:55:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/28f878c1c98ab55432a8d0b08becf337/barcode/image/b716725d-f134-49c0-8cf5-beb2c1af8acf/cb7bc0cd-1790-4503-aaac-d33479b3f138.svg",
      "owner_id": "db75d54a-3ed0-4dea-9c95-b4dd410af213",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5a41e8cf-92c6-4a8a-a9d9-86f0bf200502' \
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