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
      "id": "e9151b62-5ddf-4a89-9d08-a479ce516d85",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-05T12:25:52+00:00",
        "updated_at": "2022-05-05T12:25:52+00:00",
        "number": "http://bqbl.it/e9151b62-5ddf-4a89-9d08-a479ce516d85",
        "barcode_type": "qr_code",
        "image_url": "/uploads/05392e8499cb293c190dd7a2af765a14/barcode/image/e9151b62-5ddf-4a89-9d08-a479ce516d85/13793bdd-b1b7-4df0-ac1a-3012b6f8d9e6.svg",
        "owner_id": "31c90cec-f652-42d1-b5ad-07f4196a034e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/31c90cec-f652-42d1-b5ad-07f4196a034e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F45a7eae3-2e6d-4f08-a6ed-791e3096da51&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "45a7eae3-2e6d-4f08-a6ed-791e3096da51",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-05T12:25:53+00:00",
        "updated_at": "2022-05-05T12:25:53+00:00",
        "number": "http://bqbl.it/45a7eae3-2e6d-4f08-a6ed-791e3096da51",
        "barcode_type": "qr_code",
        "image_url": "/uploads/eb3b5ed0f359def92aa987c9bafc860b/barcode/image/45a7eae3-2e6d-4f08-a6ed-791e3096da51/7da0382a-fc38-4831-b4db-7bb906631b45.svg",
        "owner_id": "8faea4b6-cc21-40cc-b865-f086bd299d40",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8faea4b6-cc21-40cc-b865-f086bd299d40"
          },
          "data": {
            "type": "customers",
            "id": "8faea4b6-cc21-40cc-b865-f086bd299d40"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8faea4b6-cc21-40cc-b865-f086bd299d40",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-05T12:25:53+00:00",
        "updated_at": "2022-05-05T12:25:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "West LLC",
        "email": "llc_west@stokes.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=8faea4b6-cc21-40cc-b865-f086bd299d40&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8faea4b6-cc21-40cc-b865-f086bd299d40&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8faea4b6-cc21-40cc-b865-f086bd299d40&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMWQ5NDQ1ZWMtNTJjMi00NGJmLWFjZmItYWM3MTI4NmIwNDRh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1d9445ec-52c2-44bf-acfb-ac71286b044a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-05T12:25:53+00:00",
        "updated_at": "2022-05-05T12:25:53+00:00",
        "number": "http://bqbl.it/1d9445ec-52c2-44bf-acfb-ac71286b044a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/60387a9a955cd51b8eca99ccd47ef19e/barcode/image/1d9445ec-52c2-44bf-acfb-ac71286b044a/b1d93b04-ce97-46e2-a290-8dbcce541296.svg",
        "owner_id": "6ae85c6e-b222-4e6a-8a63-e3dd54d3407a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6ae85c6e-b222-4e6a-8a63-e3dd54d3407a"
          },
          "data": {
            "type": "customers",
            "id": "6ae85c6e-b222-4e6a-8a63-e3dd54d3407a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6ae85c6e-b222-4e6a-8a63-e3dd54d3407a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-05T12:25:53+00:00",
        "updated_at": "2022-05-05T12:25:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Rohan, Little and Kuvalis",
        "email": "little.kuvalis.and.rohan@ziemann.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=6ae85c6e-b222-4e6a-8a63-e3dd54d3407a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6ae85c6e-b222-4e6a-8a63-e3dd54d3407a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6ae85c6e-b222-4e6a-8a63-e3dd54d3407a&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T12:25:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c16e276-da90-4f6d-96d7-3749cccbd941?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1c16e276-da90-4f6d-96d7-3749cccbd941",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-05T12:25:54+00:00",
      "updated_at": "2022-05-05T12:25:54+00:00",
      "number": "http://bqbl.it/1c16e276-da90-4f6d-96d7-3749cccbd941",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ed182a0638064ce2c8d49d6e9d985ae/barcode/image/1c16e276-da90-4f6d-96d7-3749cccbd941/5a4b82d1-fccb-4e52-ba0b-d23ecc3d1780.svg",
      "owner_id": "3219be90-15d1-4e48-9b44-7b77ccbd65d6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3219be90-15d1-4e48-9b44-7b77ccbd65d6"
        },
        "data": {
          "type": "customers",
          "id": "3219be90-15d1-4e48-9b44-7b77ccbd65d6"
        }
      }
    }
  },
  "included": [
    {
      "id": "3219be90-15d1-4e48-9b44-7b77ccbd65d6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-05T12:25:54+00:00",
        "updated_at": "2022-05-05T12:25:54+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Bechtelar, Stanton and Hansen",
        "email": "and_bechtelar_hansen_stanton@schoen.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=3219be90-15d1-4e48-9b44-7b77ccbd65d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3219be90-15d1-4e48-9b44-7b77ccbd65d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3219be90-15d1-4e48-9b44-7b77ccbd65d6&filter[owner_type]=customers"
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
          "owner_id": "ce190c07-9efd-41f6-bd56-51798953b109",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "40619307-22c1-488e-be84-5b7972fe6c4f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-05T12:25:55+00:00",
      "updated_at": "2022-05-05T12:25:55+00:00",
      "number": "http://bqbl.it/40619307-22c1-488e-be84-5b7972fe6c4f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2b071b3e81edaea419c726b6e3ce5928/barcode/image/40619307-22c1-488e-be84-5b7972fe6c4f/90a9ae48-2416-4016-ac63-0046bab1ddf7.svg",
      "owner_id": "ce190c07-9efd-41f6-bd56-51798953b109",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8d84d81d-c690-4b5f-bf55-5f11e9c0dd0f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8d84d81d-c690-4b5f-bf55-5f11e9c0dd0f",
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
    "id": "8d84d81d-c690-4b5f-bf55-5f11e9c0dd0f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-05T12:25:55+00:00",
      "updated_at": "2022-05-05T12:25:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ca6b389df5f0fc96ab123d4d6370a0d7/barcode/image/8d84d81d-c690-4b5f-bf55-5f11e9c0dd0f/38500cca-e497-424c-ba04-10b098e526d8.svg",
      "owner_id": "0f3cc55c-981d-40aa-ba6d-b029a04136fe",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a398839c-b94d-4167-93fc-670bbe40df57' \
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