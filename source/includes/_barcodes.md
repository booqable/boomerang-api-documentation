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
      "id": "9b3ecb01-36a3-40a1-b0f4-0d852ccb819a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T11:14:47+00:00",
        "updated_at": "2023-02-02T11:14:47+00:00",
        "number": "http://bqbl.it/9b3ecb01-36a3-40a1-b0f4-0d852ccb819a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/91d71768b4d43ecdd9b49889d9ffc6b8/barcode/image/9b3ecb01-36a3-40a1-b0f4-0d852ccb819a/d82cd431-70cd-4ede-b303-208a78c8775c.svg",
        "owner_id": "1cd47740-8b10-43e8-a471-08ee7fcf48be",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1cd47740-8b10-43e8-a471-08ee7fcf48be"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0af75650-3346-45ec-8cf4-9996dbea9b48&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0af75650-3346-45ec-8cf4-9996dbea9b48",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T11:14:49+00:00",
        "updated_at": "2023-02-02T11:14:49+00:00",
        "number": "http://bqbl.it/0af75650-3346-45ec-8cf4-9996dbea9b48",
        "barcode_type": "qr_code",
        "image_url": "/uploads/275742c8cbafd44fc3c7843fda52ce10/barcode/image/0af75650-3346-45ec-8cf4-9996dbea9b48/17bc4d53-7166-4b53-b643-48b2102b53ad.svg",
        "owner_id": "de27c3cc-8e10-4100-9c01-a4ca5e85655f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/de27c3cc-8e10-4100-9c01-a4ca5e85655f"
          },
          "data": {
            "type": "customers",
            "id": "de27c3cc-8e10-4100-9c01-a4ca5e85655f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "de27c3cc-8e10-4100-9c01-a4ca5e85655f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T11:14:49+00:00",
        "updated_at": "2023-02-02T11:14:49+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=de27c3cc-8e10-4100-9c01-a4ca5e85655f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=de27c3cc-8e10-4100-9c01-a4ca5e85655f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=de27c3cc-8e10-4100-9c01-a4ca5e85655f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzkwOTRjNzYtZjVkYy00NjZmLWI4OTItMjUxODAwYzM2YzUw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "39094c76-f5dc-466f-b892-251800c36c50",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T11:14:52+00:00",
        "updated_at": "2023-02-02T11:14:52+00:00",
        "number": "http://bqbl.it/39094c76-f5dc-466f-b892-251800c36c50",
        "barcode_type": "qr_code",
        "image_url": "/uploads/89ed4599a63317cdf06d8209396b56b5/barcode/image/39094c76-f5dc-466f-b892-251800c36c50/3e2deb9e-d2d1-4b72-b91d-1d0d92038a18.svg",
        "owner_id": "f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a"
          },
          "data": {
            "type": "customers",
            "id": "f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T11:14:52+00:00",
        "updated_at": "2023-02-02T11:14:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f54033f7-cd1e-4e8b-bd7f-6dd19ad13e9a&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T11:14:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/75481448-f576-4306-9d6c-cd651ee96204?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "75481448-f576-4306-9d6c-cd651ee96204",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T11:14:53+00:00",
      "updated_at": "2023-02-02T11:14:53+00:00",
      "number": "http://bqbl.it/75481448-f576-4306-9d6c-cd651ee96204",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4822200249126384bfebfc1371cee6b2/barcode/image/75481448-f576-4306-9d6c-cd651ee96204/c25c174e-b79c-4a9d-ae90-c84a814a008a.svg",
      "owner_id": "58972f15-f5d8-4624-930f-3444d5e08ac0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/58972f15-f5d8-4624-930f-3444d5e08ac0"
        },
        "data": {
          "type": "customers",
          "id": "58972f15-f5d8-4624-930f-3444d5e08ac0"
        }
      }
    }
  },
  "included": [
    {
      "id": "58972f15-f5d8-4624-930f-3444d5e08ac0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T11:14:53+00:00",
        "updated_at": "2023-02-02T11:14:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=58972f15-f5d8-4624-930f-3444d5e08ac0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=58972f15-f5d8-4624-930f-3444d5e08ac0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=58972f15-f5d8-4624-930f-3444d5e08ac0&filter[owner_type]=customers"
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
          "owner_id": "45cd382e-7f04-4500-9f21-9e557d1f3fbd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5b18bf4e-b34b-4820-8bf3-e4174fb73939",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T11:14:55+00:00",
      "updated_at": "2023-02-02T11:14:55+00:00",
      "number": "http://bqbl.it/5b18bf4e-b34b-4820-8bf3-e4174fb73939",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4d775eeb7045ed2e192c10348a8c900c/barcode/image/5b18bf4e-b34b-4820-8bf3-e4174fb73939/02f7ef33-09ce-4a1d-aaa7-d2ab771dfd2b.svg",
      "owner_id": "45cd382e-7f04-4500-9f21-9e557d1f3fbd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/098fb14b-e0e3-40e8-bcd1-07c20e52b61d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "098fb14b-e0e3-40e8-bcd1-07c20e52b61d",
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
    "id": "098fb14b-e0e3-40e8-bcd1-07c20e52b61d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T11:14:56+00:00",
      "updated_at": "2023-02-02T11:14:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e7da3c6b7cff561739c482cfe4e4b6d0/barcode/image/098fb14b-e0e3-40e8-bcd1-07c20e52b61d/fc9f39c4-7c59-4235-b76e-3a065022bc2f.svg",
      "owner_id": "300e96dd-0e39-405e-a801-af42a3a85298",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3545b621-4f60-4ecd-ae36-0716d6a102f8' \
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