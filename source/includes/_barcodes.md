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
      "id": "6ad0fd02-cb2d-4188-8937-5a43bf09a7ad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-14T18:52:57+00:00",
        "updated_at": "2022-01-14T18:52:57+00:00",
        "number": "http://bqbl.it/6ad0fd02-cb2d-4188-8937-5a43bf09a7ad",
        "barcode_type": "qr_code",
        "image_url": "/uploads/10c59d00d44d7c48d9ec332519acef11/barcode/image/6ad0fd02-cb2d-4188-8937-5a43bf09a7ad/a7968e78-e36f-4425-aae4-1da8603b4bd8.svg",
        "owner_id": "80a0d418-996d-4034-a81c-3b921f2bea12",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/80a0d418-996d-4034-a81c-3b921f2bea12"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc0cfb1ea-b5f1-43ef-a61e-61ea916c9576&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c0cfb1ea-b5f1-43ef-a61e-61ea916c9576",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-14T18:52:58+00:00",
        "updated_at": "2022-01-14T18:52:58+00:00",
        "number": "http://bqbl.it/c0cfb1ea-b5f1-43ef-a61e-61ea916c9576",
        "barcode_type": "qr_code",
        "image_url": "/uploads/984be21db0cb5fc9279e5eeca7f92e60/barcode/image/c0cfb1ea-b5f1-43ef-a61e-61ea916c9576/f8a639f4-a61d-4b21-9f2b-05927e678701.svg",
        "owner_id": "87c09cdd-f4dc-4253-9675-b92a5260e6e7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87c09cdd-f4dc-4253-9675-b92a5260e6e7"
          },
          "data": {
            "type": "customers",
            "id": "87c09cdd-f4dc-4253-9675-b92a5260e6e7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "87c09cdd-f4dc-4253-9675-b92a5260e6e7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-14T18:52:58+00:00",
        "updated_at": "2022-01-14T18:52:58+00:00",
        "number": 1,
        "name": "Little-Maggio",
        "email": "maggio_little@wiegand-murray.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=87c09cdd-f4dc-4253-9675-b92a5260e6e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87c09cdd-f4dc-4253-9675-b92a5260e6e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87c09cdd-f4dc-4253-9675-b92a5260e6e7&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-14T18:52:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e21b7a34-9cf6-447c-b340-529b9e98c53f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e21b7a34-9cf6-447c-b340-529b9e98c53f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-14T18:52:59+00:00",
      "updated_at": "2022-01-14T18:52:59+00:00",
      "number": "http://bqbl.it/e21b7a34-9cf6-447c-b340-529b9e98c53f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4b48d9f8615bac07e7dc859b6d00df38/barcode/image/e21b7a34-9cf6-447c-b340-529b9e98c53f/ab5e4e74-62b3-4496-b1ad-0a4fdd6d5a7e.svg",
      "owner_id": "0c78f043-940a-4a20-ba4b-41e9090726ff",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0c78f043-940a-4a20-ba4b-41e9090726ff"
        },
        "data": {
          "type": "customers",
          "id": "0c78f043-940a-4a20-ba4b-41e9090726ff"
        }
      }
    }
  },
  "included": [
    {
      "id": "0c78f043-940a-4a20-ba4b-41e9090726ff",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-14T18:52:59+00:00",
        "updated_at": "2022-01-14T18:52:59+00:00",
        "number": 1,
        "name": "Schowalter, Beer and McDermott",
        "email": "schowalter.mcdermott.and.beer@goldner.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=0c78f043-940a-4a20-ba4b-41e9090726ff&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0c78f043-940a-4a20-ba4b-41e9090726ff&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0c78f043-940a-4a20-ba4b-41e9090726ff&filter[owner_type]=customers"
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
          "owner_id": "78868cd3-1f93-4f6c-8900-fcba8aded181",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b4de7b9a-9c54-462b-85d8-3a618e50ad12",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-14T18:53:00+00:00",
      "updated_at": "2022-01-14T18:53:00+00:00",
      "number": "http://bqbl.it/b4de7b9a-9c54-462b-85d8-3a618e50ad12",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a47b21c1643bfd8d9387bd682a368f92/barcode/image/b4de7b9a-9c54-462b-85d8-3a618e50ad12/a9418667-9611-4ffb-94dc-4f3d78d85468.svg",
      "owner_id": "78868cd3-1f93-4f6c-8900-fcba8aded181",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bed4d158-72fd-4171-91c3-c24ae1b9947a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bed4d158-72fd-4171-91c3-c24ae1b9947a",
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
    "id": "bed4d158-72fd-4171-91c3-c24ae1b9947a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-14T18:53:00+00:00",
      "updated_at": "2022-01-14T18:53:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ab6abb40abc75641a5cba07a63b3aa7/barcode/image/bed4d158-72fd-4171-91c3-c24ae1b9947a/8b7fc8e5-64b2-4392-912a-2877900302ab.svg",
      "owner_id": "f04c4311-662a-4633-b42d-53e3473829f2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7381b054-272e-464a-ac95-451d7626c0a4' \
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