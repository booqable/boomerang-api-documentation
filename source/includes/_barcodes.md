# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "a116c65f-87a8-4795-b861-4b736d0f35c3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-08T12:33:55+00:00",
        "updated_at": "2021-12-08T12:33:55+00:00",
        "number": "http://bqbl.it/a116c65f-87a8-4795-b861-4b736d0f35c3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5eddc2e60ce77eb4e472cc4ff723f7bc/barcode/image/a116c65f-87a8-4795-b861-4b736d0f35c3/2a8542f4-7003-4439-805f-1b45caa28d02.svg",
        "owner_id": "173a727e-15a8-4151-b949-5083ade2fa40",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/173a727e-15a8-4151-b949-5083ade2fa40"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4ca4a45d-f7af-48d0-96ac-271ee280f7e4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4ca4a45d-f7af-48d0-96ac-271ee280f7e4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-08T12:33:57+00:00",
        "updated_at": "2021-12-08T12:33:57+00:00",
        "number": "http://bqbl.it/4ca4a45d-f7af-48d0-96ac-271ee280f7e4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63677ede38b361ad6cc4326042bb0065/barcode/image/4ca4a45d-f7af-48d0-96ac-271ee280f7e4/beb53c93-a853-46e7-b93f-6476b560f7a9.svg",
        "owner_id": "1f26b6bc-efd6-4c23-8231-1f351ea49493",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1f26b6bc-efd6-4c23-8231-1f351ea49493"
          },
          "data": {
            "type": "customers",
            "id": "1f26b6bc-efd6-4c23-8231-1f351ea49493"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1f26b6bc-efd6-4c23-8231-1f351ea49493",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-08T12:33:57+00:00",
        "updated_at": "2021-12-08T12:33:57+00:00",
        "number": 1,
        "name": "O'Conner-Schuster",
        "email": "o_conner_schuster@morar-quigley.io",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=1f26b6bc-efd6-4c23-8231-1f351ea49493&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1f26b6bc-efd6-4c23-8231-1f351ea49493&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1f26b6bc-efd6-4c23-8231-1f351ea49493&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4ca4a45d-f7af-48d0-96ac-271ee280f7e4&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4ca4a45d-f7af-48d0-96ac-271ee280f7e4&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4ca4a45d-f7af-48d0-96ac-271ee280f7e4&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3e541884-632f-427a-9e04-e035e3859ded?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3e541884-632f-427a-9e04-e035e3859ded",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-08T12:33:57+00:00",
      "updated_at": "2021-12-08T12:33:57+00:00",
      "number": "http://bqbl.it/3e541884-632f-427a-9e04-e035e3859ded",
      "barcode_type": "qr_code",
      "image_url": "/uploads/431c9dd29b3c29693f81a3a609799133/barcode/image/3e541884-632f-427a-9e04-e035e3859ded/78ceb782-59a0-4b15-a8f5-1ff3f2015a3f.svg",
      "owner_id": "7e984f5b-7a6d-44b0-9fbb-3d7256739381",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7e984f5b-7a6d-44b0-9fbb-3d7256739381"
        },
        "data": {
          "type": "customers",
          "id": "7e984f5b-7a6d-44b0-9fbb-3d7256739381"
        }
      }
    }
  },
  "included": [
    {
      "id": "7e984f5b-7a6d-44b0-9fbb-3d7256739381",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-08T12:33:57+00:00",
        "updated_at": "2021-12-08T12:33:57+00:00",
        "number": 1,
        "name": "Langosh and Sons",
        "email": "sons_langosh_and@okuneva-lynch.org",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=7e984f5b-7a6d-44b0-9fbb-3d7256739381&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7e984f5b-7a6d-44b0-9fbb-3d7256739381&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7e984f5b-7a6d-44b0-9fbb-3d7256739381&filter[owner_type]=customers"
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
          "owner_id": "ef160423-2219-4c8c-82b2-9b6723603be3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7d8c38d1-5cd1-44c2-a482-2a2f232ebabb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-08T12:33:58+00:00",
      "updated_at": "2021-12-08T12:33:58+00:00",
      "number": "http://bqbl.it/7d8c38d1-5cd1-44c2-a482-2a2f232ebabb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2dd47491924acc81eafd15e8f6f9d4dd/barcode/image/7d8c38d1-5cd1-44c2-a482-2a2f232ebabb/ef72f845-8f09-4fab-bcdb-2687607db4eb.svg",
      "owner_id": "ef160423-2219-4c8c-82b2-9b6723603be3",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ef160423-2219-4c8c-82b2-9b6723603be3&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ef160423-2219-4c8c-82b2-9b6723603be3&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ef160423-2219-4c8c-82b2-9b6723603be3&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/56ba8ed0-a3eb-48cc-848c-c3d9f3c51947' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "56ba8ed0-a3eb-48cc-848c-c3d9f3c51947",
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
    "id": "56ba8ed0-a3eb-48cc-848c-c3d9f3c51947",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-08T12:33:58+00:00",
      "updated_at": "2021-12-08T12:33:58+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e62d7be7c608d7eae937bab6fbe4ce4f/barcode/image/56ba8ed0-a3eb-48cc-848c-c3d9f3c51947/12d35a36-6d46-4ac8-9579-43ebf9fdf633.svg",
      "owner_id": "18e97347-a903-46ac-8868-2158725c69a6",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/efa70fd9-0d13-4343-8bd5-7d1ebc8d2343' \
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