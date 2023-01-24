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
      "id": "b0cfa3b4-2fbc-4b2b-aa45-74f361f50604",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T14:00:05+00:00",
        "updated_at": "2023-01-24T14:00:05+00:00",
        "number": "http://bqbl.it/b0cfa3b4-2fbc-4b2b-aa45-74f361f50604",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d794fd15fdbd40b126876da629b0914c/barcode/image/b0cfa3b4-2fbc-4b2b-aa45-74f361f50604/63d2656f-78cd-4a86-877d-9342a85579d0.svg",
        "owner_id": "6fab8e90-911a-48ac-9875-c58f4f66bd7b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6fab8e90-911a-48ac-9875-c58f4f66bd7b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fcbeb9069-05ab-42b9-9d33-64f00b571085&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cbeb9069-05ab-42b9-9d33-64f00b571085",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T14:00:05+00:00",
        "updated_at": "2023-01-24T14:00:05+00:00",
        "number": "http://bqbl.it/cbeb9069-05ab-42b9-9d33-64f00b571085",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b08f7a495f29cc32f8d6cae1ba8f9b2f/barcode/image/cbeb9069-05ab-42b9-9d33-64f00b571085/f6b2e669-6ca3-4936-ba99-68ab5b6d885f.svg",
        "owner_id": "048e472e-c1aa-4f59-8679-b83a0cb24b9d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/048e472e-c1aa-4f59-8679-b83a0cb24b9d"
          },
          "data": {
            "type": "customers",
            "id": "048e472e-c1aa-4f59-8679-b83a0cb24b9d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "048e472e-c1aa-4f59-8679-b83a0cb24b9d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T14:00:05+00:00",
        "updated_at": "2023-01-24T14:00:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=048e472e-c1aa-4f59-8679-b83a0cb24b9d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=048e472e-c1aa-4f59-8679-b83a0cb24b9d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=048e472e-c1aa-4f59-8679-b83a0cb24b9d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWFiZmI5MzctNGYwZS00YmFmLWI2NjMtNzY2NzRjNDIyYTNj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eabfb937-4f0e-4baf-b663-76674c422a3c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T14:00:06+00:00",
        "updated_at": "2023-01-24T14:00:06+00:00",
        "number": "http://bqbl.it/eabfb937-4f0e-4baf-b663-76674c422a3c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/34ce2795c610ce3c04bf08d9b28537a0/barcode/image/eabfb937-4f0e-4baf-b663-76674c422a3c/c0642f67-f5c6-45c7-971e-59c68f89ae28.svg",
        "owner_id": "d821cdfc-a458-4f47-b9f1-ae5d21f1e03c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d821cdfc-a458-4f47-b9f1-ae5d21f1e03c"
          },
          "data": {
            "type": "customers",
            "id": "d821cdfc-a458-4f47-b9f1-ae5d21f1e03c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d821cdfc-a458-4f47-b9f1-ae5d21f1e03c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T14:00:06+00:00",
        "updated_at": "2023-01-24T14:00:06+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d821cdfc-a458-4f47-b9f1-ae5d21f1e03c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d821cdfc-a458-4f47-b9f1-ae5d21f1e03c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d821cdfc-a458-4f47-b9f1-ae5d21f1e03c&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:59:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cbbea125-93da-4316-a63c-9c254daf29e5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cbbea125-93da-4316-a63c-9c254daf29e5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T14:00:06+00:00",
      "updated_at": "2023-01-24T14:00:06+00:00",
      "number": "http://bqbl.it/cbbea125-93da-4316-a63c-9c254daf29e5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5de1e8064f3d57f50e4929add4280864/barcode/image/cbbea125-93da-4316-a63c-9c254daf29e5/641fce41-88c1-4af1-b0ee-ea37dae22c6b.svg",
      "owner_id": "bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6"
        },
        "data": {
          "type": "customers",
          "id": "bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6"
        }
      }
    }
  },
  "included": [
    {
      "id": "bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T14:00:06+00:00",
        "updated_at": "2023-01-24T14:00:06+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bab3a8f8-2ef4-4a3f-b395-bdb1dbafa4a6&filter[owner_type]=customers"
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
          "owner_id": "922131a9-2e0b-4c1e-8db3-3c5074c42113",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ba8a453b-2fba-478a-a2de-4d144d1939af",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T14:00:07+00:00",
      "updated_at": "2023-01-24T14:00:07+00:00",
      "number": "http://bqbl.it/ba8a453b-2fba-478a-a2de-4d144d1939af",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6947bb6bcb13a0402b8e935e20681860/barcode/image/ba8a453b-2fba-478a-a2de-4d144d1939af/58f4cfab-65e3-4950-ab04-329d28d757a6.svg",
      "owner_id": "922131a9-2e0b-4c1e-8db3-3c5074c42113",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/12e2d27f-bc37-48a9-a385-faca375d2ebc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "12e2d27f-bc37-48a9-a385-faca375d2ebc",
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
    "id": "12e2d27f-bc37-48a9-a385-faca375d2ebc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T14:00:07+00:00",
      "updated_at": "2023-01-24T14:00:07+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db93541ad09b6c054deca4475a255b0c/barcode/image/12e2d27f-bc37-48a9-a385-faca375d2ebc/1de8001e-2e77-4adf-8f6f-bdc6d46c31de.svg",
      "owner_id": "810caf6e-7d1c-42b8-a3e0-b2cafc779eae",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5975056a-1b41-4806-bb06-e3805cc1755c' \
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