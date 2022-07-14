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
      "id": "76a46db9-c35e-4640-851f-f76cc2745523",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:16:01+00:00",
        "updated_at": "2022-07-14T10:16:01+00:00",
        "number": "http://bqbl.it/76a46db9-c35e-4640-851f-f76cc2745523",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c999115412f77485b8acb7d752df39af/barcode/image/76a46db9-c35e-4640-851f-f76cc2745523/b9613241-d0d4-4027-8433-61bf4df3460b.svg",
        "owner_id": "686a4f61-173d-48f7-be94-873f57965b32",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/686a4f61-173d-48f7-be94-873f57965b32"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Feec4f4fd-4347-4df9-ab13-73d70356efeb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eec4f4fd-4347-4df9-ab13-73d70356efeb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:16:01+00:00",
        "updated_at": "2022-07-14T10:16:01+00:00",
        "number": "http://bqbl.it/eec4f4fd-4347-4df9-ab13-73d70356efeb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9c1d1e5fcbc03e4003dbcfa0560be846/barcode/image/eec4f4fd-4347-4df9-ab13-73d70356efeb/bc30f24f-4a9b-47f1-baac-5a93ad5e47d0.svg",
        "owner_id": "1a93a345-bc1e-4b95-87ca-c3f1ca7d194b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1a93a345-bc1e-4b95-87ca-c3f1ca7d194b"
          },
          "data": {
            "type": "customers",
            "id": "1a93a345-bc1e-4b95-87ca-c3f1ca7d194b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1a93a345-bc1e-4b95-87ca-c3f1ca7d194b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:16:01+00:00",
        "updated_at": "2022-07-14T10:16:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Heathcote Group",
        "email": "heathcote.group@bashirian.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=1a93a345-bc1e-4b95-87ca-c3f1ca7d194b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1a93a345-bc1e-4b95-87ca-c3f1ca7d194b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1a93a345-bc1e-4b95-87ca-c3f1ca7d194b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTg5NjA0NGEtYmNkZC00NGE3LWE0NTUtM2M4OWM0YjEzMzc2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a896044a-bcdd-44a7-a455-3c89c4b13376",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:16:02+00:00",
        "updated_at": "2022-07-14T10:16:02+00:00",
        "number": "http://bqbl.it/a896044a-bcdd-44a7-a455-3c89c4b13376",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a6d576defd19955d86b29a6a05dad73b/barcode/image/a896044a-bcdd-44a7-a455-3c89c4b13376/484aadb8-3456-4138-b028-b1ee6a2b48be.svg",
        "owner_id": "12e450c3-db85-4f83-937c-d03cea2ffaf1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/12e450c3-db85-4f83-937c-d03cea2ffaf1"
          },
          "data": {
            "type": "customers",
            "id": "12e450c3-db85-4f83-937c-d03cea2ffaf1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "12e450c3-db85-4f83-937c-d03cea2ffaf1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:16:02+00:00",
        "updated_at": "2022-07-14T10:16:02+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mosciski Inc",
        "email": "mosciski.inc@carroll.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=12e450c3-db85-4f83-937c-d03cea2ffaf1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=12e450c3-db85-4f83-937c-d03cea2ffaf1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=12e450c3-db85-4f83-937c-d03cea2ffaf1&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:15:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ca814359-0bd4-4aab-8772-b8c59a11104b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ca814359-0bd4-4aab-8772-b8c59a11104b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:16:03+00:00",
      "updated_at": "2022-07-14T10:16:03+00:00",
      "number": "http://bqbl.it/ca814359-0bd4-4aab-8772-b8c59a11104b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7525ca90e910b75693d8bf214b2e48c4/barcode/image/ca814359-0bd4-4aab-8772-b8c59a11104b/f27ccb84-4a95-4536-a6eb-d607e3f47ca7.svg",
      "owner_id": "d5fc6843-657d-4f98-a14b-ebd61f46adc0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d5fc6843-657d-4f98-a14b-ebd61f46adc0"
        },
        "data": {
          "type": "customers",
          "id": "d5fc6843-657d-4f98-a14b-ebd61f46adc0"
        }
      }
    }
  },
  "included": [
    {
      "id": "d5fc6843-657d-4f98-a14b-ebd61f46adc0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:16:03+00:00",
        "updated_at": "2022-07-14T10:16:03+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Ward-Cassin",
        "email": "cassin_ward@hilll.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=d5fc6843-657d-4f98-a14b-ebd61f46adc0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d5fc6843-657d-4f98-a14b-ebd61f46adc0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d5fc6843-657d-4f98-a14b-ebd61f46adc0&filter[owner_type]=customers"
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
          "owner_id": "60643beb-cb1d-40ba-bf97-1041b35309c8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "af374a07-acbf-4701-bb64-46b48532a18f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:16:03+00:00",
      "updated_at": "2022-07-14T10:16:03+00:00",
      "number": "http://bqbl.it/af374a07-acbf-4701-bb64-46b48532a18f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6d7033cfc12dd163d4546e031c89fc2a/barcode/image/af374a07-acbf-4701-bb64-46b48532a18f/a786ea99-3d4c-4cc4-8868-6113465a3736.svg",
      "owner_id": "60643beb-cb1d-40ba-bf97-1041b35309c8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/65fef012-95ee-44b5-b30b-8d5e471b5168' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "65fef012-95ee-44b5-b30b-8d5e471b5168",
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
    "id": "65fef012-95ee-44b5-b30b-8d5e471b5168",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:16:04+00:00",
      "updated_at": "2022-07-14T10:16:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1454be4f87e43cb3d4456f0fb949be50/barcode/image/65fef012-95ee-44b5-b30b-8d5e471b5168/66da2b11-7587-4651-840c-5682bd6658d8.svg",
      "owner_id": "a912eb7e-f67f-49d7-97bc-71a736447865",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d859d327-35bb-4e72-b123-2111506495e6' \
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