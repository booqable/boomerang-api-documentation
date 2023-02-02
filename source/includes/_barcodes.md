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
      "id": "876159c6-3e81-4ab4-bcd3-12bf76fd5720",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:28:12+00:00",
        "updated_at": "2023-02-02T16:28:12+00:00",
        "number": "http://bqbl.it/876159c6-3e81-4ab4-bcd3-12bf76fd5720",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a92f67527cf8e2ad992856bb3b0fe8be/barcode/image/876159c6-3e81-4ab4-bcd3-12bf76fd5720/94d4e155-aad3-4fb9-b912-6253c906ca7f.svg",
        "owner_id": "f8f4c565-384e-4fb3-9f7c-6460e22a5189",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f8f4c565-384e-4fb3-9f7c-6460e22a5189"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdf6e923f-60e4-4ecb-bb60-137eb69a3c24&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "df6e923f-60e4-4ecb-bb60-137eb69a3c24",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:28:12+00:00",
        "updated_at": "2023-02-02T16:28:12+00:00",
        "number": "http://bqbl.it/df6e923f-60e4-4ecb-bb60-137eb69a3c24",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2a4de546b41abf090babebea881466bc/barcode/image/df6e923f-60e4-4ecb-bb60-137eb69a3c24/73824503-1456-4406-80c0-b27c35722dbf.svg",
        "owner_id": "af08b2b8-f3b4-4597-9e18-f25b6e52729e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/af08b2b8-f3b4-4597-9e18-f25b6e52729e"
          },
          "data": {
            "type": "customers",
            "id": "af08b2b8-f3b4-4597-9e18-f25b6e52729e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "af08b2b8-f3b4-4597-9e18-f25b6e52729e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:28:12+00:00",
        "updated_at": "2023-02-02T16:28:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=af08b2b8-f3b4-4597-9e18-f25b6e52729e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=af08b2b8-f3b4-4597-9e18-f25b6e52729e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=af08b2b8-f3b4-4597-9e18-f25b6e52729e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODA3NjI4ODAtNDc0OS00ZDlhLWFhMTAtMGNmMzJkMzZmOGVl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "80762880-4749-4d9a-aa10-0cf32d36f8ee",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:28:13+00:00",
        "updated_at": "2023-02-02T16:28:13+00:00",
        "number": "http://bqbl.it/80762880-4749-4d9a-aa10-0cf32d36f8ee",
        "barcode_type": "qr_code",
        "image_url": "/uploads/060590f2b983351d57cd079772202cc6/barcode/image/80762880-4749-4d9a-aa10-0cf32d36f8ee/5388afe6-ba0f-42d7-8b99-738bd041d1d6.svg",
        "owner_id": "b0f10a30-89fc-4bd8-8621-2f06a6ca00e9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0f10a30-89fc-4bd8-8621-2f06a6ca00e9"
          },
          "data": {
            "type": "customers",
            "id": "b0f10a30-89fc-4bd8-8621-2f06a6ca00e9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b0f10a30-89fc-4bd8-8621-2f06a6ca00e9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:28:13+00:00",
        "updated_at": "2023-02-02T16:28:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b0f10a30-89fc-4bd8-8621-2f06a6ca00e9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b0f10a30-89fc-4bd8-8621-2f06a6ca00e9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b0f10a30-89fc-4bd8-8621-2f06a6ca00e9&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9b79024a-8fee-49ab-8679-fb5bd4cb5e7a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9b79024a-8fee-49ab-8679-fb5bd4cb5e7a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:28:14+00:00",
      "updated_at": "2023-02-02T16:28:14+00:00",
      "number": "http://bqbl.it/9b79024a-8fee-49ab-8679-fb5bd4cb5e7a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5ab670ade75c9b47424de52cefa41af0/barcode/image/9b79024a-8fee-49ab-8679-fb5bd4cb5e7a/c8998bd9-b127-487e-92c6-7af0800ae1b9.svg",
      "owner_id": "896bca53-c3dd-48e6-a3ff-b26c22a03ec8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/896bca53-c3dd-48e6-a3ff-b26c22a03ec8"
        },
        "data": {
          "type": "customers",
          "id": "896bca53-c3dd-48e6-a3ff-b26c22a03ec8"
        }
      }
    }
  },
  "included": [
    {
      "id": "896bca53-c3dd-48e6-a3ff-b26c22a03ec8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:28:14+00:00",
        "updated_at": "2023-02-02T16:28:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=896bca53-c3dd-48e6-a3ff-b26c22a03ec8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=896bca53-c3dd-48e6-a3ff-b26c22a03ec8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=896bca53-c3dd-48e6-a3ff-b26c22a03ec8&filter[owner_type]=customers"
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
          "owner_id": "e4d5b545-b146-4ada-b557-4a3ce388cb45",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d2bb6c03-809b-4677-916f-44d6ea4e77cb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:28:15+00:00",
      "updated_at": "2023-02-02T16:28:15+00:00",
      "number": "http://bqbl.it/d2bb6c03-809b-4677-916f-44d6ea4e77cb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5ac46486cdeb1e726bbe57986ff8bf58/barcode/image/d2bb6c03-809b-4677-916f-44d6ea4e77cb/6e95b991-c74a-446d-8da9-96c8dfcae36a.svg",
      "owner_id": "e4d5b545-b146-4ada-b557-4a3ce388cb45",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/031aed11-b9cb-45bb-afc5-adbeacfe2184' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "031aed11-b9cb-45bb-afc5-adbeacfe2184",
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
    "id": "031aed11-b9cb-45bb-afc5-adbeacfe2184",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:28:16+00:00",
      "updated_at": "2023-02-02T16:28:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/73ba73314f172a2c0ea14d9753808db0/barcode/image/031aed11-b9cb-45bb-afc5-adbeacfe2184/63b25e60-852a-438a-b341-a5f5c4481d9e.svg",
      "owner_id": "165ffcd4-bac8-4904-8405-518de5675b63",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3d7ac023-4a01-439c-b025-bb8e6131c984' \
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