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
      "id": "2138bb62-4b28-4d10-a339-39880aae8ec8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T08:55:54+00:00",
        "updated_at": "2022-10-13T08:55:54+00:00",
        "number": "http://bqbl.it/2138bb62-4b28-4d10-a339-39880aae8ec8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/957ae97927a1d2d3275c0201e84f7e21/barcode/image/2138bb62-4b28-4d10-a339-39880aae8ec8/23949556-e85a-4d87-b587-6043bd9640e3.svg",
        "owner_id": "988e00c8-3aa7-4b4e-afb9-97882e7ccaa9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/988e00c8-3aa7-4b4e-afb9-97882e7ccaa9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0a2ce6ec-f288-4712-8513-44011cc2cb16&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0a2ce6ec-f288-4712-8513-44011cc2cb16",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T08:55:55+00:00",
        "updated_at": "2022-10-13T08:55:55+00:00",
        "number": "http://bqbl.it/0a2ce6ec-f288-4712-8513-44011cc2cb16",
        "barcode_type": "qr_code",
        "image_url": "/uploads/22dbc7fe45166ae25726c56cf9b1e59b/barcode/image/0a2ce6ec-f288-4712-8513-44011cc2cb16/3473911d-00cc-447e-8751-b662e6696d11.svg",
        "owner_id": "8a983a45-e158-4c7c-8a7a-235f84bc4100",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8a983a45-e158-4c7c-8a7a-235f84bc4100"
          },
          "data": {
            "type": "customers",
            "id": "8a983a45-e158-4c7c-8a7a-235f84bc4100"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8a983a45-e158-4c7c-8a7a-235f84bc4100",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T08:55:55+00:00",
        "updated_at": "2022-10-13T08:55:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8a983a45-e158-4c7c-8a7a-235f84bc4100&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a983a45-e158-4c7c-8a7a-235f84bc4100&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a983a45-e158-4c7c-8a7a-235f84bc4100&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTBlMGRhYjctNDFhMy00ODQ4LWEyNDItNDU0NDBhZDJkZTM1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "50e0dab7-41a3-4848-a242-45440ad2de35",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T08:55:56+00:00",
        "updated_at": "2022-10-13T08:55:56+00:00",
        "number": "http://bqbl.it/50e0dab7-41a3-4848-a242-45440ad2de35",
        "barcode_type": "qr_code",
        "image_url": "/uploads/06e9b2648b35af47fc909bc8cead2650/barcode/image/50e0dab7-41a3-4848-a242-45440ad2de35/dcd4afd8-62f5-46c7-ad48-3efc71f75f21.svg",
        "owner_id": "d120f6a4-716e-4f37-aa47-b69a3c74ad62",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d120f6a4-716e-4f37-aa47-b69a3c74ad62"
          },
          "data": {
            "type": "customers",
            "id": "d120f6a4-716e-4f37-aa47-b69a3c74ad62"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d120f6a4-716e-4f37-aa47-b69a3c74ad62",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T08:55:55+00:00",
        "updated_at": "2022-10-13T08:55:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d120f6a4-716e-4f37-aa47-b69a3c74ad62&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d120f6a4-716e-4f37-aa47-b69a3c74ad62&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d120f6a4-716e-4f37-aa47-b69a3c74ad62&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T08:55:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a406e868-d351-4c0f-a7e2-e71a7c1b6663?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a406e868-d351-4c0f-a7e2-e71a7c1b6663",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T08:55:56+00:00",
      "updated_at": "2022-10-13T08:55:56+00:00",
      "number": "http://bqbl.it/a406e868-d351-4c0f-a7e2-e71a7c1b6663",
      "barcode_type": "qr_code",
      "image_url": "/uploads/97c7b132d18ec8b4c94b93277da1b83a/barcode/image/a406e868-d351-4c0f-a7e2-e71a7c1b6663/42e727a8-8497-4212-b911-da866dea671a.svg",
      "owner_id": "96233119-685d-42c6-bce8-32a045cf7952",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/96233119-685d-42c6-bce8-32a045cf7952"
        },
        "data": {
          "type": "customers",
          "id": "96233119-685d-42c6-bce8-32a045cf7952"
        }
      }
    }
  },
  "included": [
    {
      "id": "96233119-685d-42c6-bce8-32a045cf7952",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T08:55:56+00:00",
        "updated_at": "2022-10-13T08:55:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=96233119-685d-42c6-bce8-32a045cf7952&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=96233119-685d-42c6-bce8-32a045cf7952&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=96233119-685d-42c6-bce8-32a045cf7952&filter[owner_type]=customers"
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
          "owner_id": "6e496f18-a00e-46f6-ad6e-24adff12b627",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3328d2c1-c885-4ba4-8957-6af9fc8a6002",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T08:55:57+00:00",
      "updated_at": "2022-10-13T08:55:57+00:00",
      "number": "http://bqbl.it/3328d2c1-c885-4ba4-8957-6af9fc8a6002",
      "barcode_type": "qr_code",
      "image_url": "/uploads/881beb0de5d35b0e6095fbcbd1f14f03/barcode/image/3328d2c1-c885-4ba4-8957-6af9fc8a6002/0113b406-2b60-42cd-8a20-e2b07053d69b.svg",
      "owner_id": "6e496f18-a00e-46f6-ad6e-24adff12b627",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b3dddee1-4c78-42c3-8422-80a8efa3975a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b3dddee1-4c78-42c3-8422-80a8efa3975a",
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
    "id": "b3dddee1-4c78-42c3-8422-80a8efa3975a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T08:55:58+00:00",
      "updated_at": "2022-10-13T08:55:58+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0f854284898da89504db1072007c852a/barcode/image/b3dddee1-4c78-42c3-8422-80a8efa3975a/10723e9f-26fe-4af4-8f75-dedf964c8cb3.svg",
      "owner_id": "67fc785d-c79b-416d-850b-915dab8e5b86",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c12320fc-4cf6-4d5f-b712-745aec5c1bf2' \
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