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
      "id": "f02578e5-8fb3-4c5b-b7c7-71b2e73a35d6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T15:22:09+00:00",
        "updated_at": "2023-03-08T15:22:09+00:00",
        "number": "http://bqbl.it/f02578e5-8fb3-4c5b-b7c7-71b2e73a35d6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/03acc41116ed666b045d640dde82f005/barcode/image/f02578e5-8fb3-4c5b-b7c7-71b2e73a35d6/917256dd-edcf-47d2-b8d2-8f4b7df72ad5.svg",
        "owner_id": "fd684ddf-c266-4c8b-85c0-b2ee506004d6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fd684ddf-c266-4c8b-85c0-b2ee506004d6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6277ba41-0527-4734-bb10-81d1f79a6d4a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6277ba41-0527-4734-bb10-81d1f79a6d4a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T15:22:10+00:00",
        "updated_at": "2023-03-08T15:22:10+00:00",
        "number": "http://bqbl.it/6277ba41-0527-4734-bb10-81d1f79a6d4a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c1370a58e575253ee2e03ae51af76c16/barcode/image/6277ba41-0527-4734-bb10-81d1f79a6d4a/630a3f90-0a4d-4ec6-9c67-644c2733e5ce.svg",
        "owner_id": "fb97deba-b7a0-49a5-afbf-7f72e50484fd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fb97deba-b7a0-49a5-afbf-7f72e50484fd"
          },
          "data": {
            "type": "customers",
            "id": "fb97deba-b7a0-49a5-afbf-7f72e50484fd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fb97deba-b7a0-49a5-afbf-7f72e50484fd",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T15:22:10+00:00",
        "updated_at": "2023-03-08T15:22:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fb97deba-b7a0-49a5-afbf-7f72e50484fd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fb97deba-b7a0-49a5-afbf-7f72e50484fd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fb97deba-b7a0-49a5-afbf-7f72e50484fd&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTZjYmYyZDQtNzhhYy00YTZlLWFlOGYtYmY1N2U2MGMxODkx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "96cbf2d4-78ac-4a6e-ae8f-bf57e60c1891",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T15:22:11+00:00",
        "updated_at": "2023-03-08T15:22:11+00:00",
        "number": "http://bqbl.it/96cbf2d4-78ac-4a6e-ae8f-bf57e60c1891",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c1ffce699a96ea6da1012ee0639d70ad/barcode/image/96cbf2d4-78ac-4a6e-ae8f-bf57e60c1891/5b98b6dd-f54c-4c6d-8f86-0424e3092cea.svg",
        "owner_id": "5cda3370-f900-4bb6-95d3-daa69c15b1bc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5cda3370-f900-4bb6-95d3-daa69c15b1bc"
          },
          "data": {
            "type": "customers",
            "id": "5cda3370-f900-4bb6-95d3-daa69c15b1bc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5cda3370-f900-4bb6-95d3-daa69c15b1bc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T15:22:11+00:00",
        "updated_at": "2023-03-08T15:22:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5cda3370-f900-4bb6-95d3-daa69c15b1bc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5cda3370-f900-4bb6-95d3-daa69c15b1bc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5cda3370-f900-4bb6-95d3-daa69c15b1bc&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T15:21:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d4ca0352-d1bd-41eb-9ed8-e7bb7987167c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d4ca0352-d1bd-41eb-9ed8-e7bb7987167c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T15:22:11+00:00",
      "updated_at": "2023-03-08T15:22:11+00:00",
      "number": "http://bqbl.it/d4ca0352-d1bd-41eb-9ed8-e7bb7987167c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5dce892492de796247e41a4d0d86bd15/barcode/image/d4ca0352-d1bd-41eb-9ed8-e7bb7987167c/f05440be-d89a-43a4-8ca8-2373a5f85170.svg",
      "owner_id": "7551caaa-4ff8-4688-acde-e9cb68239a98",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7551caaa-4ff8-4688-acde-e9cb68239a98"
        },
        "data": {
          "type": "customers",
          "id": "7551caaa-4ff8-4688-acde-e9cb68239a98"
        }
      }
    }
  },
  "included": [
    {
      "id": "7551caaa-4ff8-4688-acde-e9cb68239a98",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T15:22:11+00:00",
        "updated_at": "2023-03-08T15:22:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7551caaa-4ff8-4688-acde-e9cb68239a98&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7551caaa-4ff8-4688-acde-e9cb68239a98&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7551caaa-4ff8-4688-acde-e9cb68239a98&filter[owner_type]=customers"
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
          "owner_id": "4c320290-deda-43c6-a5f5-def8be68bd8f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cb5124ca-aadd-4d22-a4b2-aa2166c977d4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T15:22:12+00:00",
      "updated_at": "2023-03-08T15:22:12+00:00",
      "number": "http://bqbl.it/cb5124ca-aadd-4d22-a4b2-aa2166c977d4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0385faf73fa8f8fdf2db69974a0db2e1/barcode/image/cb5124ca-aadd-4d22-a4b2-aa2166c977d4/baaaa67d-f41f-42eb-b507-74633c13f577.svg",
      "owner_id": "4c320290-deda-43c6-a5f5-def8be68bd8f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/da489c00-74c2-4778-bf76-cf27d9a3b743' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "da489c00-74c2-4778-bf76-cf27d9a3b743",
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
    "id": "da489c00-74c2-4778-bf76-cf27d9a3b743",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T15:22:13+00:00",
      "updated_at": "2023-03-08T15:22:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db94214f1c6a271b399e3c30d76b2bd9/barcode/image/da489c00-74c2-4778-bf76-cf27d9a3b743/8e4e9c87-cd4f-454d-8e0d-409116d33e32.svg",
      "owner_id": "2cc6eabb-e988-4aa0-80c6-be987bc69ca7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/26a0d7fa-f7ad-49c5-9e26-6d44d43aecf2' \
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