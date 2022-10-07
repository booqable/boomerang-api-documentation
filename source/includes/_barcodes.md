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
      "id": "1f60cc3e-a084-4b88-8f84-88db9565d191",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T15:05:14+00:00",
        "updated_at": "2022-10-07T15:05:14+00:00",
        "number": "http://bqbl.it/1f60cc3e-a084-4b88-8f84-88db9565d191",
        "barcode_type": "qr_code",
        "image_url": "/uploads/280e663b089c24454b2442f4013ed44c/barcode/image/1f60cc3e-a084-4b88-8f84-88db9565d191/77394b83-fbf1-40d6-bf8b-a58910cf7d9d.svg",
        "owner_id": "5f71edb3-f225-44e0-9d06-b9c52c138889",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5f71edb3-f225-44e0-9d06-b9c52c138889"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff8415182-d1e8-4fe3-ad93-c33e5a150b00&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f8415182-d1e8-4fe3-ad93-c33e5a150b00",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T15:05:15+00:00",
        "updated_at": "2022-10-07T15:05:15+00:00",
        "number": "http://bqbl.it/f8415182-d1e8-4fe3-ad93-c33e5a150b00",
        "barcode_type": "qr_code",
        "image_url": "/uploads/712cc885accacfcf3c5f553e30e35386/barcode/image/f8415182-d1e8-4fe3-ad93-c33e5a150b00/d27b7889-fa8d-4519-9030-7686a26e1fd7.svg",
        "owner_id": "aed34532-539e-4ae8-97bb-0e3cbec046e3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aed34532-539e-4ae8-97bb-0e3cbec046e3"
          },
          "data": {
            "type": "customers",
            "id": "aed34532-539e-4ae8-97bb-0e3cbec046e3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aed34532-539e-4ae8-97bb-0e3cbec046e3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T15:05:15+00:00",
        "updated_at": "2022-10-07T15:05:15+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=aed34532-539e-4ae8-97bb-0e3cbec046e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aed34532-539e-4ae8-97bb-0e3cbec046e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aed34532-539e-4ae8-97bb-0e3cbec046e3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjcxYTljYWItZDVlYy00MWVhLWJhNDItZjYwMzI3NTkzNjg5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f71a9cab-d5ec-41ea-ba42-f60327593689",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-07T15:05:16+00:00",
        "updated_at": "2022-10-07T15:05:16+00:00",
        "number": "http://bqbl.it/f71a9cab-d5ec-41ea-ba42-f60327593689",
        "barcode_type": "qr_code",
        "image_url": "/uploads/396aa0d5ee8899601426e5217f1ce6c1/barcode/image/f71a9cab-d5ec-41ea-ba42-f60327593689/7a63feaf-0517-4284-8c96-3a6426b10190.svg",
        "owner_id": "ef9f1a5a-6f4a-4914-88a8-36d35c5242ab",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ef9f1a5a-6f4a-4914-88a8-36d35c5242ab"
          },
          "data": {
            "type": "customers",
            "id": "ef9f1a5a-6f4a-4914-88a8-36d35c5242ab"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ef9f1a5a-6f4a-4914-88a8-36d35c5242ab",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T15:05:16+00:00",
        "updated_at": "2022-10-07T15:05:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ef9f1a5a-6f4a-4914-88a8-36d35c5242ab&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ef9f1a5a-6f4a-4914-88a8-36d35c5242ab&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ef9f1a5a-6f4a-4914-88a8-36d35c5242ab&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T15:04:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/08d11d9e-61ae-4d68-88a6-ba518ad654c9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "08d11d9e-61ae-4d68-88a6-ba518ad654c9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T15:05:16+00:00",
      "updated_at": "2022-10-07T15:05:16+00:00",
      "number": "http://bqbl.it/08d11d9e-61ae-4d68-88a6-ba518ad654c9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ebb02ed1a7a62d935a43bc81e679e45/barcode/image/08d11d9e-61ae-4d68-88a6-ba518ad654c9/4cf05912-c1a0-482f-996a-ed4ee4047f09.svg",
      "owner_id": "576ec291-7bf9-4557-9a8c-e23e6a8b285d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/576ec291-7bf9-4557-9a8c-e23e6a8b285d"
        },
        "data": {
          "type": "customers",
          "id": "576ec291-7bf9-4557-9a8c-e23e6a8b285d"
        }
      }
    }
  },
  "included": [
    {
      "id": "576ec291-7bf9-4557-9a8c-e23e6a8b285d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-07T15:05:16+00:00",
        "updated_at": "2022-10-07T15:05:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=576ec291-7bf9-4557-9a8c-e23e6a8b285d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=576ec291-7bf9-4557-9a8c-e23e6a8b285d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=576ec291-7bf9-4557-9a8c-e23e6a8b285d&filter[owner_type]=customers"
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
          "owner_id": "16a40712-0194-43a9-bd20-b3ae5c06592a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c8c83897-155e-4f9e-a002-1f676b04c12a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T15:05:17+00:00",
      "updated_at": "2022-10-07T15:05:17+00:00",
      "number": "http://bqbl.it/c8c83897-155e-4f9e-a002-1f676b04c12a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/670d5c8f49abd6b9f62aecb12b903d66/barcode/image/c8c83897-155e-4f9e-a002-1f676b04c12a/647e2ab0-9782-45e2-b1be-dcd26db8d9ce.svg",
      "owner_id": "16a40712-0194-43a9-bd20-b3ae5c06592a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4e8a39be-dc15-497d-a153-969f66f3e581' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4e8a39be-dc15-497d-a153-969f66f3e581",
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
    "id": "4e8a39be-dc15-497d-a153-969f66f3e581",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-07T15:05:21+00:00",
      "updated_at": "2022-10-07T15:05:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a8bd7b36b16a62b597d62d085b03b266/barcode/image/4e8a39be-dc15-497d-a153-969f66f3e581/29403d9b-3995-4767-af80-8b781eb2689a.svg",
      "owner_id": "fc43ac81-9051-45e2-ac01-56319a7948ee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9ca5469-a3cc-4f99-83f3-7784749e3ecf' \
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