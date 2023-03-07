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
      "id": "cff0f3b9-619d-460a-9437-090b6a63b564",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T08:27:04+00:00",
        "updated_at": "2023-03-07T08:27:04+00:00",
        "number": "http://bqbl.it/cff0f3b9-619d-460a-9437-090b6a63b564",
        "barcode_type": "qr_code",
        "image_url": "/uploads/786b44b6293a323493a84a4ca27abcf1/barcode/image/cff0f3b9-619d-460a-9437-090b6a63b564/2a083961-5980-44c4-90b9-503a312b1c89.svg",
        "owner_id": "39cbb4c2-52b2-4d56-b6ff-fd93d388b856",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/39cbb4c2-52b2-4d56-b6ff-fd93d388b856"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdd2600ab-d8db-48e2-9459-ebf086864e8b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dd2600ab-d8db-48e2-9459-ebf086864e8b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T08:27:05+00:00",
        "updated_at": "2023-03-07T08:27:05+00:00",
        "number": "http://bqbl.it/dd2600ab-d8db-48e2-9459-ebf086864e8b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/90921e9d786a0979f7c0f26096adfdc6/barcode/image/dd2600ab-d8db-48e2-9459-ebf086864e8b/ceeee2fa-d740-459a-aeba-7bc1f8945395.svg",
        "owner_id": "8018d58e-6c83-4a13-bc2a-f10915593b63",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8018d58e-6c83-4a13-bc2a-f10915593b63"
          },
          "data": {
            "type": "customers",
            "id": "8018d58e-6c83-4a13-bc2a-f10915593b63"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8018d58e-6c83-4a13-bc2a-f10915593b63",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T08:27:04+00:00",
        "updated_at": "2023-03-07T08:27:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8018d58e-6c83-4a13-bc2a-f10915593b63&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8018d58e-6c83-4a13-bc2a-f10915593b63&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8018d58e-6c83-4a13-bc2a-f10915593b63&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjU4YzNmY2QtNzhlNS00OTEwLWI3MWEtNDNjMDNmYzNiYjg5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f58c3fcd-78e5-4910-b71a-43c03fc3bb89",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T08:27:05+00:00",
        "updated_at": "2023-03-07T08:27:05+00:00",
        "number": "http://bqbl.it/f58c3fcd-78e5-4910-b71a-43c03fc3bb89",
        "barcode_type": "qr_code",
        "image_url": "/uploads/af4113c9e86a96d98b37c2e0720ddbf9/barcode/image/f58c3fcd-78e5-4910-b71a-43c03fc3bb89/4b57cc35-2fe5-472b-b329-e2866df326e6.svg",
        "owner_id": "27679f8e-347d-4650-a0b9-258c508ab9fd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/27679f8e-347d-4650-a0b9-258c508ab9fd"
          },
          "data": {
            "type": "customers",
            "id": "27679f8e-347d-4650-a0b9-258c508ab9fd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "27679f8e-347d-4650-a0b9-258c508ab9fd",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T08:27:05+00:00",
        "updated_at": "2023-03-07T08:27:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=27679f8e-347d-4650-a0b9-258c508ab9fd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=27679f8e-347d-4650-a0b9-258c508ab9fd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=27679f8e-347d-4650-a0b9-258c508ab9fd&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:26:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/284dff46-421a-441f-ac39-1f8d43989a70?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "284dff46-421a-441f-ac39-1f8d43989a70",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T08:27:06+00:00",
      "updated_at": "2023-03-07T08:27:06+00:00",
      "number": "http://bqbl.it/284dff46-421a-441f-ac39-1f8d43989a70",
      "barcode_type": "qr_code",
      "image_url": "/uploads/31bfe5ba18b594cabc5af3a4778e8a0b/barcode/image/284dff46-421a-441f-ac39-1f8d43989a70/118f3ed2-53cb-4a0e-8e29-50d76131fa2a.svg",
      "owner_id": "63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec"
        },
        "data": {
          "type": "customers",
          "id": "63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec"
        }
      }
    }
  },
  "included": [
    {
      "id": "63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T08:27:05+00:00",
        "updated_at": "2023-03-07T08:27:06+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=63fa3bc9-f992-4ef6-aa8a-143d77f5d5ec&filter[owner_type]=customers"
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
          "owner_id": "c278e54d-f0cb-42dc-aaf7-554cedb5b8f1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cc6c87f3-74bb-4c59-b5af-d1473965b759",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T08:27:06+00:00",
      "updated_at": "2023-03-07T08:27:06+00:00",
      "number": "http://bqbl.it/cc6c87f3-74bb-4c59-b5af-d1473965b759",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5294b17f77268fa161d110c1dac8e363/barcode/image/cc6c87f3-74bb-4c59-b5af-d1473965b759/7aa3b249-37b1-4af7-bab0-7e28330ef971.svg",
      "owner_id": "c278e54d-f0cb-42dc-aaf7-554cedb5b8f1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/72ec955f-69e0-4a06-adf3-08ca8a11b1b3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "72ec955f-69e0-4a06-adf3-08ca8a11b1b3",
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
    "id": "72ec955f-69e0-4a06-adf3-08ca8a11b1b3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T08:27:07+00:00",
      "updated_at": "2023-03-07T08:27:07+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e7f3149f6158979ff3861b89f2eacc74/barcode/image/72ec955f-69e0-4a06-adf3-08ca8a11b1b3/2f5b9f8e-45b6-4603-9602-16d1fb7e7414.svg",
      "owner_id": "842151fa-3c6e-4db4-98f7-b0950d0b155d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ac1de287-1378-42dd-8f32-a617fd8a0224' \
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