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
      "id": "ef5d16da-7434-46d3-88c3-8831daba5a8d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T16:21:11+00:00",
        "updated_at": "2023-02-21T16:21:11+00:00",
        "number": "http://bqbl.it/ef5d16da-7434-46d3-88c3-8831daba5a8d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d9975f86d520e4d3fd475eb70c4519fc/barcode/image/ef5d16da-7434-46d3-88c3-8831daba5a8d/2233dce6-5800-46fb-b6ab-776e9d536427.svg",
        "owner_id": "1daaec34-4b45-40fe-b0b3-694d0715c077",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1daaec34-4b45-40fe-b0b3-694d0715c077"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5d731ff8-6a9f-48bb-bda9-887c2f0187f2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5d731ff8-6a9f-48bb-bda9-887c2f0187f2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T16:21:11+00:00",
        "updated_at": "2023-02-21T16:21:11+00:00",
        "number": "http://bqbl.it/5d731ff8-6a9f-48bb-bda9-887c2f0187f2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/611a6d7020bac467c9e0add5b0bf02e7/barcode/image/5d731ff8-6a9f-48bb-bda9-887c2f0187f2/32f018e3-f145-4d8d-95f4-602ad7292351.svg",
        "owner_id": "ee6e4c9b-1af6-431a-bbf5-07f402fa5e46",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ee6e4c9b-1af6-431a-bbf5-07f402fa5e46"
          },
          "data": {
            "type": "customers",
            "id": "ee6e4c9b-1af6-431a-bbf5-07f402fa5e46"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ee6e4c9b-1af6-431a-bbf5-07f402fa5e46",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T16:21:11+00:00",
        "updated_at": "2023-02-21T16:21:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee6e4c9b-1af6-431a-bbf5-07f402fa5e46&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee6e4c9b-1af6-431a-bbf5-07f402fa5e46&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee6e4c9b-1af6-431a-bbf5-07f402fa5e46&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzkyYmRlMjgtNTI5YS00MGRlLWJiNmQtMTNkMzJlMDFjNGI1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "392bde28-529a-40de-bb6d-13d32e01c4b5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T16:21:12+00:00",
        "updated_at": "2023-02-21T16:21:12+00:00",
        "number": "http://bqbl.it/392bde28-529a-40de-bb6d-13d32e01c4b5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5f1aba28607e6ec86a3eebb5d9ff6126/barcode/image/392bde28-529a-40de-bb6d-13d32e01c4b5/0e439880-ac4a-4842-8cab-0f0e5f38985b.svg",
        "owner_id": "b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31"
          },
          "data": {
            "type": "customers",
            "id": "b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T16:21:11+00:00",
        "updated_at": "2023-02-21T16:21:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b6fcff59-bd1e-4fd2-81f6-493eb5d4dc31&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T16:20:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/13dae6c3-d08e-4edc-9b1d-aad8f15a75eb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13dae6c3-d08e-4edc-9b1d-aad8f15a75eb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T16:21:12+00:00",
      "updated_at": "2023-02-21T16:21:12+00:00",
      "number": "http://bqbl.it/13dae6c3-d08e-4edc-9b1d-aad8f15a75eb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d62ec290e1505c1b02daa355b4b423f9/barcode/image/13dae6c3-d08e-4edc-9b1d-aad8f15a75eb/9cde912a-973f-4087-b9c6-761e82a91772.svg",
      "owner_id": "d72a2b76-54b3-43b0-a362-d940f33807ab",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d72a2b76-54b3-43b0-a362-d940f33807ab"
        },
        "data": {
          "type": "customers",
          "id": "d72a2b76-54b3-43b0-a362-d940f33807ab"
        }
      }
    }
  },
  "included": [
    {
      "id": "d72a2b76-54b3-43b0-a362-d940f33807ab",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T16:21:12+00:00",
        "updated_at": "2023-02-21T16:21:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d72a2b76-54b3-43b0-a362-d940f33807ab&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d72a2b76-54b3-43b0-a362-d940f33807ab&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d72a2b76-54b3-43b0-a362-d940f33807ab&filter[owner_type]=customers"
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
          "owner_id": "cceafb73-053b-4b7b-9992-d1ae23714245",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fb55b7fc-33f8-4da6-b231-6ad1b1504a16",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T16:21:13+00:00",
      "updated_at": "2023-02-21T16:21:13+00:00",
      "number": "http://bqbl.it/fb55b7fc-33f8-4da6-b231-6ad1b1504a16",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fa97500f12e6c32cefe1ab325e2dd01b/barcode/image/fb55b7fc-33f8-4da6-b231-6ad1b1504a16/2504e6a2-39da-4e11-8f9a-9329614fd629.svg",
      "owner_id": "cceafb73-053b-4b7b-9992-d1ae23714245",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/09d05ce0-601e-499f-a644-4a42737e72c6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "09d05ce0-601e-499f-a644-4a42737e72c6",
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
    "id": "09d05ce0-601e-499f-a644-4a42737e72c6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T16:21:13+00:00",
      "updated_at": "2023-02-21T16:21:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/215a1e197ea9f0aa0ad36d3dc1063690/barcode/image/09d05ce0-601e-499f-a644-4a42737e72c6/f126fabd-ac9a-4f7b-a370-bdbc8e59a560.svg",
      "owner_id": "1339cb07-a133-424c-9eb0-22a9c2d05795",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d541784-ced7-4c04-9e44-2d69dc81d2d4' \
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