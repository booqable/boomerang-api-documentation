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
      "id": "968700be-0c40-4f60-bf93-3a586c67531f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-21T10:55:56+00:00",
        "updated_at": "2022-07-21T10:55:56+00:00",
        "number": "http://bqbl.it/968700be-0c40-4f60-bf93-3a586c67531f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7ec02453b84e3045b245c4119b45b38d/barcode/image/968700be-0c40-4f60-bf93-3a586c67531f/5ee8f321-96da-45bd-adf6-5317e9a8f000.svg",
        "owner_id": "d3a3c42a-7031-4d18-b177-7346e630a153",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d3a3c42a-7031-4d18-b177-7346e630a153"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1910951e-3faf-49fc-a2b4-2a41f871f43f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1910951e-3faf-49fc-a2b4-2a41f871f43f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-21T10:55:57+00:00",
        "updated_at": "2022-07-21T10:55:57+00:00",
        "number": "http://bqbl.it/1910951e-3faf-49fc-a2b4-2a41f871f43f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8c3afebb6c6868ba0447201e4d635825/barcode/image/1910951e-3faf-49fc-a2b4-2a41f871f43f/0a7fcbd2-23f1-459c-a777-75dac1b92a6a.svg",
        "owner_id": "a32d60a7-98bc-42f9-bd06-e6abba48431f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a32d60a7-98bc-42f9-bd06-e6abba48431f"
          },
          "data": {
            "type": "customers",
            "id": "a32d60a7-98bc-42f9-bd06-e6abba48431f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a32d60a7-98bc-42f9-bd06-e6abba48431f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-21T10:55:57+00:00",
        "updated_at": "2022-07-21T10:55:57+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Simonis-Smitham",
        "email": "simonis_smitham@kling.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=a32d60a7-98bc-42f9-bd06-e6abba48431f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a32d60a7-98bc-42f9-bd06-e6abba48431f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a32d60a7-98bc-42f9-bd06-e6abba48431f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2RhOGYwMzAtOTc2My00ZjQzLTlkMzYtNTIzYmRkMTEyMDk2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3da8f030-9763-4f43-9d36-523bdd112096",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-21T10:55:57+00:00",
        "updated_at": "2022-07-21T10:55:57+00:00",
        "number": "http://bqbl.it/3da8f030-9763-4f43-9d36-523bdd112096",
        "barcode_type": "qr_code",
        "image_url": "/uploads/70c09bfedf751c4af0695e18274d5c8f/barcode/image/3da8f030-9763-4f43-9d36-523bdd112096/4183095c-d7d3-45fa-98b6-4b7cc36f8b5f.svg",
        "owner_id": "f7f5b227-00c3-4331-bff9-164cbecd93d9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f7f5b227-00c3-4331-bff9-164cbecd93d9"
          },
          "data": {
            "type": "customers",
            "id": "f7f5b227-00c3-4331-bff9-164cbecd93d9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f7f5b227-00c3-4331-bff9-164cbecd93d9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-21T10:55:57+00:00",
        "updated_at": "2022-07-21T10:55:57+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Koch-Osinski",
        "email": "koch.osinski@herzog.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=f7f5b227-00c3-4331-bff9-164cbecd93d9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7f5b227-00c3-4331-bff9-164cbecd93d9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f7f5b227-00c3-4331-bff9-164cbecd93d9&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-21T10:55:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e5f67b32-07a9-4bf9-9187-3f7645c1935a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e5f67b32-07a9-4bf9-9187-3f7645c1935a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-21T10:55:58+00:00",
      "updated_at": "2022-07-21T10:55:58+00:00",
      "number": "http://bqbl.it/e5f67b32-07a9-4bf9-9187-3f7645c1935a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d13da3f2f9047df903054de85c08e0b9/barcode/image/e5f67b32-07a9-4bf9-9187-3f7645c1935a/da215ad2-d410-409c-9306-6c970c357e93.svg",
      "owner_id": "6aacf0fc-9550-44b2-80e8-31732371d74c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6aacf0fc-9550-44b2-80e8-31732371d74c"
        },
        "data": {
          "type": "customers",
          "id": "6aacf0fc-9550-44b2-80e8-31732371d74c"
        }
      }
    }
  },
  "included": [
    {
      "id": "6aacf0fc-9550-44b2-80e8-31732371d74c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-21T10:55:58+00:00",
        "updated_at": "2022-07-21T10:55:58+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Volkman-Schultz",
        "email": "volkman_schultz@sipes.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=6aacf0fc-9550-44b2-80e8-31732371d74c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6aacf0fc-9550-44b2-80e8-31732371d74c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6aacf0fc-9550-44b2-80e8-31732371d74c&filter[owner_type]=customers"
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
          "owner_id": "557340ac-2128-4c09-aae8-e1288041653f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "92faaccc-bf7f-4692-8672-c602ea2a8d46",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-21T10:55:58+00:00",
      "updated_at": "2022-07-21T10:55:58+00:00",
      "number": "http://bqbl.it/92faaccc-bf7f-4692-8672-c602ea2a8d46",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c4e02f1092048c74e182153ba59c4df0/barcode/image/92faaccc-bf7f-4692-8672-c602ea2a8d46/9d8fbdff-c028-4bf4-93f3-d51f3043fece.svg",
      "owner_id": "557340ac-2128-4c09-aae8-e1288041653f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8d11f976-6515-4fca-9da2-f96060a6bb9b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8d11f976-6515-4fca-9da2-f96060a6bb9b",
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
    "id": "8d11f976-6515-4fca-9da2-f96060a6bb9b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-21T10:55:59+00:00",
      "updated_at": "2022-07-21T10:55:59+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ecddf3d5d2e34e3ac7b176b7efdb6386/barcode/image/8d11f976-6515-4fca-9da2-f96060a6bb9b/cae0b66b-9cf2-405a-81e2-f752ea89941c.svg",
      "owner_id": "26177b3d-a245-414b-ba06-af4aa5d27035",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/afccb5f8-19af-43ad-821b-bb945bb75d59' \
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