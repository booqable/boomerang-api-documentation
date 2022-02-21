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
      "id": "38b9b455-8ed4-4c1a-9c81-176b9e0309f0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-21T07:52:06+00:00",
        "updated_at": "2022-02-21T07:52:06+00:00",
        "number": "http://bqbl.it/38b9b455-8ed4-4c1a-9c81-176b9e0309f0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/029c61849baf0128b3d108e9d3317522/barcode/image/38b9b455-8ed4-4c1a-9c81-176b9e0309f0/383945ca-c225-402c-94a8-d9abbb04c619.svg",
        "owner_id": "53a63469-9364-41fc-b884-0fd911a98989",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/53a63469-9364-41fc-b884-0fd911a98989"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4bf5dc53-4896-4183-9085-d7da408e4c5e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4bf5dc53-4896-4183-9085-d7da408e4c5e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-21T07:52:06+00:00",
        "updated_at": "2022-02-21T07:52:06+00:00",
        "number": "http://bqbl.it/4bf5dc53-4896-4183-9085-d7da408e4c5e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9449b00d7b117f012fa2aa36540b4210/barcode/image/4bf5dc53-4896-4183-9085-d7da408e4c5e/e1000c74-d845-44e6-98dc-da68768af431.svg",
        "owner_id": "c4451094-de1b-45a1-95c7-7f76b029be3d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c4451094-de1b-45a1-95c7-7f76b029be3d"
          },
          "data": {
            "type": "customers",
            "id": "c4451094-de1b-45a1-95c7-7f76b029be3d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c4451094-de1b-45a1-95c7-7f76b029be3d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-21T07:52:06+00:00",
        "updated_at": "2022-02-21T07:52:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Cummings Group",
        "email": "group.cummings@kilback.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=c4451094-de1b-45a1-95c7-7f76b029be3d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c4451094-de1b-45a1-95c7-7f76b029be3d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c4451094-de1b-45a1-95c7-7f76b029be3d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzAzMDc3MmYtNmZjNS00MDRiLWI5NWYtMzNjMjRjODc1MWNh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c030772f-6fc5-404b-b95f-33c24c8751ca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-21T07:52:07+00:00",
        "updated_at": "2022-02-21T07:52:07+00:00",
        "number": "http://bqbl.it/c030772f-6fc5-404b-b95f-33c24c8751ca",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4d0415e86021bcdb76d1620977aa71ab/barcode/image/c030772f-6fc5-404b-b95f-33c24c8751ca/1edefd7a-73e6-48b0-9f92-8b9777067d05.svg",
        "owner_id": "1f66212a-26b5-48f4-8a2d-47d513ea4a49",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1f66212a-26b5-48f4-8a2d-47d513ea4a49"
          },
          "data": {
            "type": "customers",
            "id": "1f66212a-26b5-48f4-8a2d-47d513ea4a49"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1f66212a-26b5-48f4-8a2d-47d513ea4a49",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-21T07:52:07+00:00",
        "updated_at": "2022-02-21T07:52:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Marks, Lubowitz and Hilpert",
        "email": "hilpert_and_lubowitz_marks@bechtelar.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=1f66212a-26b5-48f4-8a2d-47d513ea4a49&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1f66212a-26b5-48f4-8a2d-47d513ea4a49&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1f66212a-26b5-48f4-8a2d-47d513ea4a49&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-21T07:51:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f7673e9-80e2-45de-8252-b93afce53f63?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9f7673e9-80e2-45de-8252-b93afce53f63",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-21T07:52:07+00:00",
      "updated_at": "2022-02-21T07:52:07+00:00",
      "number": "http://bqbl.it/9f7673e9-80e2-45de-8252-b93afce53f63",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e580420eb832f40d4d7e205e4dbf75c3/barcode/image/9f7673e9-80e2-45de-8252-b93afce53f63/f3a39dd7-5c26-474d-90ab-61418ccc283d.svg",
      "owner_id": "d5d19bdf-8bc5-4618-b772-c3ea8a100d35",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d5d19bdf-8bc5-4618-b772-c3ea8a100d35"
        },
        "data": {
          "type": "customers",
          "id": "d5d19bdf-8bc5-4618-b772-c3ea8a100d35"
        }
      }
    }
  },
  "included": [
    {
      "id": "d5d19bdf-8bc5-4618-b772-c3ea8a100d35",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-21T07:52:07+00:00",
        "updated_at": "2022-02-21T07:52:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Herzog-Quitzon",
        "email": "quitzon.herzog@ferry.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=d5d19bdf-8bc5-4618-b772-c3ea8a100d35&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d5d19bdf-8bc5-4618-b772-c3ea8a100d35&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d5d19bdf-8bc5-4618-b772-c3ea8a100d35&filter[owner_type]=customers"
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
          "owner_id": "5f12f987-42bb-4203-9e04-e781c85501c3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "28c11189-cd7a-4e27-9d0d-802702a4b9e0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-21T07:52:08+00:00",
      "updated_at": "2022-02-21T07:52:08+00:00",
      "number": "http://bqbl.it/28c11189-cd7a-4e27-9d0d-802702a4b9e0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bcbaf137e141aa2975c2cc1ff85bdf42/barcode/image/28c11189-cd7a-4e27-9d0d-802702a4b9e0/bf460ca5-5800-48cf-9137-b22c3e2fc9a1.svg",
      "owner_id": "5f12f987-42bb-4203-9e04-e781c85501c3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9c36279c-c134-4f8c-85a3-5c6f0ad62ee1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9c36279c-c134-4f8c-85a3-5c6f0ad62ee1",
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
    "id": "9c36279c-c134-4f8c-85a3-5c6f0ad62ee1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-21T07:52:08+00:00",
      "updated_at": "2022-02-21T07:52:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/824e0cf9a33489383c8e54e189375ff5/barcode/image/9c36279c-c134-4f8c-85a3-5c6f0ad62ee1/a485324a-f6cf-4ed4-af8f-34bb26b35bd1.svg",
      "owner_id": "bcdc7f62-870d-4d65-af79-2e0726e06174",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9b58670a-8a7d-46f2-bd75-a9797cdf333e' \
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