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
      "id": "9e9424e4-4641-410f-b333-caa1ff88f683",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:14:19+00:00",
        "updated_at": "2023-02-16T09:14:19+00:00",
        "number": "http://bqbl.it/9e9424e4-4641-410f-b333-caa1ff88f683",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a7b5669d96d8b2122b14113727f96a22/barcode/image/9e9424e4-4641-410f-b333-caa1ff88f683/3b5b9d26-d829-49f2-85f3-153a9d1d2220.svg",
        "owner_id": "70bc22bf-b238-420d-a240-a265de09b9d2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/70bc22bf-b238-420d-a240-a265de09b9d2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd9553928-56a1-4a6f-a001-be380aa080ba&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d9553928-56a1-4a6f-a001-be380aa080ba",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:14:19+00:00",
        "updated_at": "2023-02-16T09:14:19+00:00",
        "number": "http://bqbl.it/d9553928-56a1-4a6f-a001-be380aa080ba",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6d2148068a69c0879e98861e5003434c/barcode/image/d9553928-56a1-4a6f-a001-be380aa080ba/6e22a5fa-b110-4220-ba74-6b767d3663cd.svg",
        "owner_id": "05bf65a7-adc7-4885-8746-29b76bf11c51",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/05bf65a7-adc7-4885-8746-29b76bf11c51"
          },
          "data": {
            "type": "customers",
            "id": "05bf65a7-adc7-4885-8746-29b76bf11c51"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "05bf65a7-adc7-4885-8746-29b76bf11c51",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:14:19+00:00",
        "updated_at": "2023-02-16T09:14:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=05bf65a7-adc7-4885-8746-29b76bf11c51&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=05bf65a7-adc7-4885-8746-29b76bf11c51&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=05bf65a7-adc7-4885-8746-29b76bf11c51&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWE5OGM3MGMtZTE5YS00OTEyLTg5MzktMTM3NWJlYWUxMGZi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ea98c70c-e19a-4912-8939-1375beae10fb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:14:19+00:00",
        "updated_at": "2023-02-16T09:14:19+00:00",
        "number": "http://bqbl.it/ea98c70c-e19a-4912-8939-1375beae10fb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/746e546555127a4885a27b2183e856da/barcode/image/ea98c70c-e19a-4912-8939-1375beae10fb/bb9ca4ec-ebce-43ec-a1ac-3b9838947d82.svg",
        "owner_id": "d7bc7f6a-4b42-422c-89c2-05b5370e9fdf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d7bc7f6a-4b42-422c-89c2-05b5370e9fdf"
          },
          "data": {
            "type": "customers",
            "id": "d7bc7f6a-4b42-422c-89c2-05b5370e9fdf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d7bc7f6a-4b42-422c-89c2-05b5370e9fdf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:14:19+00:00",
        "updated_at": "2023-02-16T09:14:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d7bc7f6a-4b42-422c-89c2-05b5370e9fdf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d7bc7f6a-4b42-422c-89c2-05b5370e9fdf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d7bc7f6a-4b42-422c-89c2-05b5370e9fdf&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:13:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8f514979-1836-4d81-b877-4c7a6250e7cc?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8f514979-1836-4d81-b877-4c7a6250e7cc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:14:20+00:00",
      "updated_at": "2023-02-16T09:14:20+00:00",
      "number": "http://bqbl.it/8f514979-1836-4d81-b877-4c7a6250e7cc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3d725408c9aed8720e8cef689126e636/barcode/image/8f514979-1836-4d81-b877-4c7a6250e7cc/59023f76-b4fd-4d9e-ba10-58fb5baf3059.svg",
      "owner_id": "e47683d4-c66a-4e5b-aa6b-a74edba71521",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e47683d4-c66a-4e5b-aa6b-a74edba71521"
        },
        "data": {
          "type": "customers",
          "id": "e47683d4-c66a-4e5b-aa6b-a74edba71521"
        }
      }
    }
  },
  "included": [
    {
      "id": "e47683d4-c66a-4e5b-aa6b-a74edba71521",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:14:20+00:00",
        "updated_at": "2023-02-16T09:14:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e47683d4-c66a-4e5b-aa6b-a74edba71521&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e47683d4-c66a-4e5b-aa6b-a74edba71521&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e47683d4-c66a-4e5b-aa6b-a74edba71521&filter[owner_type]=customers"
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
          "owner_id": "76bc11fa-0938-469b-a970-01f402127059",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d017dfe1-ef8e-4ac8-a1df-37b0fb9b968e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:14:20+00:00",
      "updated_at": "2023-02-16T09:14:20+00:00",
      "number": "http://bqbl.it/d017dfe1-ef8e-4ac8-a1df-37b0fb9b968e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/49ce7ef2505a4e83146626dfadfede8a/barcode/image/d017dfe1-ef8e-4ac8-a1df-37b0fb9b968e/e9e99cf4-c620-462d-9af0-231c3c9fea94.svg",
      "owner_id": "76bc11fa-0938-469b-a970-01f402127059",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/14973e33-165b-4216-9ef8-7beefc82bbed' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "14973e33-165b-4216-9ef8-7beefc82bbed",
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
    "id": "14973e33-165b-4216-9ef8-7beefc82bbed",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:14:21+00:00",
      "updated_at": "2023-02-16T09:14:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c1373f40e144f10eebadad5e03a083a/barcode/image/14973e33-165b-4216-9ef8-7beefc82bbed/e21d6707-b0a6-4c72-a8ef-45df6ab380be.svg",
      "owner_id": "b7d20f6e-494a-4d0f-93c2-d97dbe8674a5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2decfdff-e8d4-4afa-91bd-2569d09ff1a2' \
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