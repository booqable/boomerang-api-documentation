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
      "id": "3a6d7ac7-c6d3-4c93-b9e2-5694450b08f9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
        "number": "http://bqbl.it/3a6d7ac7-c6d3-4c93-b9e2-5694450b08f9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7711d670f9c154994fa217b3d6694d0c/barcode/image/3a6d7ac7-c6d3-4c93-b9e2-5694450b08f9/08dd95b1-8592-474d-9ae7-c614cfb03136.svg",
        "owner_id": "94935056-df60-4762-9f44-c27177eee8e0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/94935056-df60-4762-9f44-c27177eee8e0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb4cc44de-e02b-44db-bbf6-4087d8447312&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4cc44de-e02b-44db-bbf6-4087d8447312",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
        "number": "http://bqbl.it/b4cc44de-e02b-44db-bbf6-4087d8447312",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dd5b1f929f57e8c0f8d5e3d32fff890c/barcode/image/b4cc44de-e02b-44db-bbf6-4087d8447312/d60f0c2e-f1dd-4db4-9b3c-850a6a602018.svg",
        "owner_id": "10fbbaa4-349a-4333-92f8-b8824c0993fb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/10fbbaa4-349a-4333-92f8-b8824c0993fb"
          },
          "data": {
            "type": "customers",
            "id": "10fbbaa4-349a-4333-92f8-b8824c0993fb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "10fbbaa4-349a-4333-92f8-b8824c0993fb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=10fbbaa4-349a-4333-92f8-b8824c0993fb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=10fbbaa4-349a-4333-92f8-b8824c0993fb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=10fbbaa4-349a-4333-92f8-b8824c0993fb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGJkZjEzOTItZWEyZC00M2VhLTlmN2YtNzU3NDlmMWQ2MTBi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4bdf1392-ea2d-43ea-9f7f-75749f1d610b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:05:42+00:00",
        "updated_at": "2023-02-14T11:05:42+00:00",
        "number": "http://bqbl.it/4bdf1392-ea2d-43ea-9f7f-75749f1d610b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8594e8c4635d4377448380c5dd0f9b00/barcode/image/4bdf1392-ea2d-43ea-9f7f-75749f1d610b/16d1b419-9b04-418c-9157-893d319fcfa2.svg",
        "owner_id": "71d41b08-ccce-4a33-a960-ad8e0d2e83d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/71d41b08-ccce-4a33-a960-ad8e0d2e83d7"
          },
          "data": {
            "type": "customers",
            "id": "71d41b08-ccce-4a33-a960-ad8e0d2e83d7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "71d41b08-ccce-4a33-a960-ad8e0d2e83d7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:05:42+00:00",
        "updated_at": "2023-02-14T11:05:42+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=71d41b08-ccce-4a33-a960-ad8e0d2e83d7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=71d41b08-ccce-4a33-a960-ad8e0d2e83d7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=71d41b08-ccce-4a33-a960-ad8e0d2e83d7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:05:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a66f0ed5-ae28-44c1-b5be-c201360fa6e0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a66f0ed5-ae28-44c1-b5be-c201360fa6e0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:05:43+00:00",
      "updated_at": "2023-02-14T11:05:43+00:00",
      "number": "http://bqbl.it/a66f0ed5-ae28-44c1-b5be-c201360fa6e0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6750673a70534ed24ee5962a2ac0a3c4/barcode/image/a66f0ed5-ae28-44c1-b5be-c201360fa6e0/fbe75b53-099d-4d79-825f-ad5514f8e4cc.svg",
      "owner_id": "b201987a-ae80-4bbd-b074-61cda147c62b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b201987a-ae80-4bbd-b074-61cda147c62b"
        },
        "data": {
          "type": "customers",
          "id": "b201987a-ae80-4bbd-b074-61cda147c62b"
        }
      }
    }
  },
  "included": [
    {
      "id": "b201987a-ae80-4bbd-b074-61cda147c62b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:05:43+00:00",
        "updated_at": "2023-02-14T11:05:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b201987a-ae80-4bbd-b074-61cda147c62b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b201987a-ae80-4bbd-b074-61cda147c62b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b201987a-ae80-4bbd-b074-61cda147c62b&filter[owner_type]=customers"
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
          "owner_id": "7f641a91-3c42-4088-a2db-b251a40de12f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0272b394-98d5-441f-b54b-9c3bc83368d6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:05:44+00:00",
      "updated_at": "2023-02-14T11:05:44+00:00",
      "number": "http://bqbl.it/0272b394-98d5-441f-b54b-9c3bc83368d6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5f93cf07076cef3cf2a240b72c31c861/barcode/image/0272b394-98d5-441f-b54b-9c3bc83368d6/113a3a39-029d-437c-bd49-b5a3b7de44ba.svg",
      "owner_id": "7f641a91-3c42-4088-a2db-b251a40de12f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cfcf5983-8940-41d1-9266-8be8ed2362d5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cfcf5983-8940-41d1-9266-8be8ed2362d5",
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
    "id": "cfcf5983-8940-41d1-9266-8be8ed2362d5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:05:45+00:00",
      "updated_at": "2023-02-14T11:05:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c1227531e0ecb8bdbba260b3e8c3167b/barcode/image/cfcf5983-8940-41d1-9266-8be8ed2362d5/61a95bf6-a74e-432b-b497-1ed10f2f1f2e.svg",
      "owner_id": "58762f1d-aa11-424f-8aae-8a4127684a3e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1075812a-0343-47ab-91e4-9a3aa5cf333b' \
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