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
      "id": "d0652f6c-1c12-4d58-88e0-3e7bbf324ff3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-09T10:01:40+00:00",
        "updated_at": "2022-03-09T10:01:40+00:00",
        "number": "http://bqbl.it/d0652f6c-1c12-4d58-88e0-3e7bbf324ff3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9a90c9886002bb1b8d4cacd4bcc03d22/barcode/image/d0652f6c-1c12-4d58-88e0-3e7bbf324ff3/675fdf44-23dc-4635-ac60-b850c59decd1.svg",
        "owner_id": "a70c7caa-741e-4915-9ea1-ed28e12c8bfd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a70c7caa-741e-4915-9ea1-ed28e12c8bfd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3a8ba2ce-9e9c-4a7f-bbc7-623b4bc0127d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3a8ba2ce-9e9c-4a7f-bbc7-623b4bc0127d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-09T10:01:41+00:00",
        "updated_at": "2022-03-09T10:01:41+00:00",
        "number": "http://bqbl.it/3a8ba2ce-9e9c-4a7f-bbc7-623b4bc0127d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/95a0b22a869669620531961dbaa8c79a/barcode/image/3a8ba2ce-9e9c-4a7f-bbc7-623b4bc0127d/b51ba11e-eae0-4d28-a03a-afa016b82cf1.svg",
        "owner_id": "bbf7632e-1153-402e-bacb-ebdd4e74baea",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bbf7632e-1153-402e-bacb-ebdd4e74baea"
          },
          "data": {
            "type": "customers",
            "id": "bbf7632e-1153-402e-bacb-ebdd4e74baea"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bbf7632e-1153-402e-bacb-ebdd4e74baea",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-09T10:01:41+00:00",
        "updated_at": "2022-03-09T10:01:41+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Windler, Koepp and Buckridge",
        "email": "koepp_buckridge_and_windler@daugherty.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=bbf7632e-1153-402e-bacb-ebdd4e74baea&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bbf7632e-1153-402e-bacb-ebdd4e74baea&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bbf7632e-1153-402e-bacb-ebdd4e74baea&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDU1YjMzMGEtNGRhMi00NjU4LThjZjQtNWI5MzIwMzc2ZTVk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "455b330a-4da2-4658-8cf4-5b9320376e5d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-09T10:01:41+00:00",
        "updated_at": "2022-03-09T10:01:41+00:00",
        "number": "http://bqbl.it/455b330a-4da2-4658-8cf4-5b9320376e5d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3aaa691d9e096ca2f9856e5ee12e183f/barcode/image/455b330a-4da2-4658-8cf4-5b9320376e5d/2d82513e-dec2-461b-82c6-c838ccba09be.svg",
        "owner_id": "c09ed0e3-cf57-4d87-b81a-de08977de3c8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c09ed0e3-cf57-4d87-b81a-de08977de3c8"
          },
          "data": {
            "type": "customers",
            "id": "c09ed0e3-cf57-4d87-b81a-de08977de3c8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c09ed0e3-cf57-4d87-b81a-de08977de3c8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-09T10:01:41+00:00",
        "updated_at": "2022-03-09T10:01:41+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Parker and Sons",
        "email": "sons_and_parker@abernathy-lebsack.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=c09ed0e3-cf57-4d87-b81a-de08977de3c8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c09ed0e3-cf57-4d87-b81a-de08977de3c8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c09ed0e3-cf57-4d87-b81a-de08977de3c8&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-09T10:01:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a144dfd6-1d1b-44ee-b2ae-573b5a664806?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a144dfd6-1d1b-44ee-b2ae-573b5a664806",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-09T10:01:42+00:00",
      "updated_at": "2022-03-09T10:01:42+00:00",
      "number": "http://bqbl.it/a144dfd6-1d1b-44ee-b2ae-573b5a664806",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3addd1da30e397696eff53ff82cde3c8/barcode/image/a144dfd6-1d1b-44ee-b2ae-573b5a664806/29e89aac-6b41-492b-9895-8b7c98bb0175.svg",
      "owner_id": "5d0aed98-662e-45f3-b6f7-0645dd2f8a14",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5d0aed98-662e-45f3-b6f7-0645dd2f8a14"
        },
        "data": {
          "type": "customers",
          "id": "5d0aed98-662e-45f3-b6f7-0645dd2f8a14"
        }
      }
    }
  },
  "included": [
    {
      "id": "5d0aed98-662e-45f3-b6f7-0645dd2f8a14",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-09T10:01:42+00:00",
        "updated_at": "2022-03-09T10:01:42+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Paucek, Kshlerin and Ferry",
        "email": "ferry_and_paucek_kshlerin@kassulke.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=5d0aed98-662e-45f3-b6f7-0645dd2f8a14&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5d0aed98-662e-45f3-b6f7-0645dd2f8a14&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5d0aed98-662e-45f3-b6f7-0645dd2f8a14&filter[owner_type]=customers"
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
          "owner_id": "b812e254-c9d9-4df7-8ff8-0e23b1dd70b8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f0e2c92d-9874-4ba9-b94a-7e820342bcd1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-09T10:01:42+00:00",
      "updated_at": "2022-03-09T10:01:42+00:00",
      "number": "http://bqbl.it/f0e2c92d-9874-4ba9-b94a-7e820342bcd1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cc41329903aeb187950ab6425ed46cb6/barcode/image/f0e2c92d-9874-4ba9-b94a-7e820342bcd1/c87ab80b-b67f-4765-b8e7-b384fccd048a.svg",
      "owner_id": "b812e254-c9d9-4df7-8ff8-0e23b1dd70b8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6cd8e727-1fbc-4cab-bbf4-df7214b41481' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6cd8e727-1fbc-4cab-bbf4-df7214b41481",
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
    "id": "6cd8e727-1fbc-4cab-bbf4-df7214b41481",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-09T10:01:43+00:00",
      "updated_at": "2022-03-09T10:01:43+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4777a0000ddd9020848eed90d346e382/barcode/image/6cd8e727-1fbc-4cab-bbf4-df7214b41481/1272520d-bf4b-44b4-8f59-da35073d90cd.svg",
      "owner_id": "3bb42f23-8f3c-453e-bfe1-7056c9a59056",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3db679ad-9295-4c7d-ac50-3cee8c059703' \
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