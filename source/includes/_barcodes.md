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
      "id": "61f83f9c-16cf-4904-8d63-b51188e6150b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-31T14:14:43+00:00",
        "updated_at": "2022-03-31T14:14:43+00:00",
        "number": "http://bqbl.it/61f83f9c-16cf-4904-8d63-b51188e6150b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/da9ad03ab289421a639608b67a340284/barcode/image/61f83f9c-16cf-4904-8d63-b51188e6150b/ccd82f3a-fb0a-456d-9d7f-b05375c7a593.svg",
        "owner_id": "58733b3f-d7cc-4d03-a34c-1298e269547d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/58733b3f-d7cc-4d03-a34c-1298e269547d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F403b5076-5704-4c36-93f6-fc65296302fc&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "403b5076-5704-4c36-93f6-fc65296302fc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-31T14:14:43+00:00",
        "updated_at": "2022-03-31T14:14:43+00:00",
        "number": "http://bqbl.it/403b5076-5704-4c36-93f6-fc65296302fc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1f6c2fb9057cf268e50b20455d7dcd83/barcode/image/403b5076-5704-4c36-93f6-fc65296302fc/a57ed721-ff2a-408a-90e4-3b421cc28ffc.svg",
        "owner_id": "6e6ef62a-06ad-4931-bb93-a8818694d77b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6e6ef62a-06ad-4931-bb93-a8818694d77b"
          },
          "data": {
            "type": "customers",
            "id": "6e6ef62a-06ad-4931-bb93-a8818694d77b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6e6ef62a-06ad-4931-bb93-a8818694d77b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-31T14:14:43+00:00",
        "updated_at": "2022-03-31T14:14:43+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "O'Reilly and Sons",
        "email": "reilly_and_sons_o@lang-bernier.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=6e6ef62a-06ad-4931-bb93-a8818694d77b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6e6ef62a-06ad-4931-bb93-a8818694d77b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6e6ef62a-06ad-4931-bb93-a8818694d77b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzlmNmI2ODAtZWY3YS00MjJmLWJiZDQtNzY1NTM2MTQ2ZmEz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c9f6b680-ef7a-422f-bbd4-765536146fa3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-31T14:14:44+00:00",
        "updated_at": "2022-03-31T14:14:44+00:00",
        "number": "http://bqbl.it/c9f6b680-ef7a-422f-bbd4-765536146fa3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bf8ce80937158533a6956e8a3057c635/barcode/image/c9f6b680-ef7a-422f-bbd4-765536146fa3/f8e969b5-0fd5-4a39-bf5f-3783d0e28505.svg",
        "owner_id": "1fe2e17e-9047-4ba0-b044-bc205089ab19",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1fe2e17e-9047-4ba0-b044-bc205089ab19"
          },
          "data": {
            "type": "customers",
            "id": "1fe2e17e-9047-4ba0-b044-bc205089ab19"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1fe2e17e-9047-4ba0-b044-bc205089ab19",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-31T14:14:44+00:00",
        "updated_at": "2022-03-31T14:14:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Cartwright-Hauck",
        "email": "hauck.cartwright@kuhic.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=1fe2e17e-9047-4ba0-b044-bc205089ab19&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1fe2e17e-9047-4ba0-b044-bc205089ab19&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1fe2e17e-9047-4ba0-b044-bc205089ab19&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-31T14:14:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8ac06253-92bd-43e8-9395-26fcb2267d7e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8ac06253-92bd-43e8-9395-26fcb2267d7e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-31T14:14:44+00:00",
      "updated_at": "2022-03-31T14:14:44+00:00",
      "number": "http://bqbl.it/8ac06253-92bd-43e8-9395-26fcb2267d7e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/88ff7070e35590499aff26081ed39af3/barcode/image/8ac06253-92bd-43e8-9395-26fcb2267d7e/700ac47e-0db8-411f-bea9-925c6bad4e33.svg",
      "owner_id": "f1bee6c7-f861-4374-ba50-98e1f50063a7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f1bee6c7-f861-4374-ba50-98e1f50063a7"
        },
        "data": {
          "type": "customers",
          "id": "f1bee6c7-f861-4374-ba50-98e1f50063a7"
        }
      }
    }
  },
  "included": [
    {
      "id": "f1bee6c7-f861-4374-ba50-98e1f50063a7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-31T14:14:44+00:00",
        "updated_at": "2022-03-31T14:14:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hodkiewicz LLC",
        "email": "hodkiewicz.llc@tillman-ward.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=f1bee6c7-f861-4374-ba50-98e1f50063a7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1bee6c7-f861-4374-ba50-98e1f50063a7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1bee6c7-f861-4374-ba50-98e1f50063a7&filter[owner_type]=customers"
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
          "owner_id": "f589bb8d-22ba-43d6-875e-d60e99c69c75",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c824074f-96e0-4d8e-9c9f-ba5b3f655b7e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-31T14:14:45+00:00",
      "updated_at": "2022-03-31T14:14:45+00:00",
      "number": "http://bqbl.it/c824074f-96e0-4d8e-9c9f-ba5b3f655b7e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e176b682a185e1507b8f17640d9ee9c5/barcode/image/c824074f-96e0-4d8e-9c9f-ba5b3f655b7e/7dacd756-6190-4436-9c34-0d9d2920737d.svg",
      "owner_id": "f589bb8d-22ba-43d6-875e-d60e99c69c75",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6b5751df-b45c-4a6e-9d43-6f990a46cae4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6b5751df-b45c-4a6e-9d43-6f990a46cae4",
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
    "id": "6b5751df-b45c-4a6e-9d43-6f990a46cae4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-31T14:14:45+00:00",
      "updated_at": "2022-03-31T14:14:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b66a2c88bcd78d1db0ce31f72b964bb4/barcode/image/6b5751df-b45c-4a6e-9d43-6f990a46cae4/b6e24ae4-87fa-480b-afbe-1b850c1b912c.svg",
      "owner_id": "57072ab3-239e-4261-8865-22d1e20771fa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1a36bbf3-e1f4-462e-8ef8-e4b39617beb4' \
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