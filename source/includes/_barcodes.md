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
      "id": "ff029685-96fc-42a4-a9d8-0cb30752c81e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T16:31:04+00:00",
        "updated_at": "2023-01-24T16:31:04+00:00",
        "number": "http://bqbl.it/ff029685-96fc-42a4-a9d8-0cb30752c81e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1b484a11d791bed99d4d9300a5d0a117/barcode/image/ff029685-96fc-42a4-a9d8-0cb30752c81e/3a61b583-8b48-4155-b083-f2decdbc3528.svg",
        "owner_id": "2b64be7c-623f-47b5-840f-bbe3f59a4b7b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2b64be7c-623f-47b5-840f-bbe3f59a4b7b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe212c31c-5395-4977-b5ce-9dd67d8f9b74&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e212c31c-5395-4977-b5ce-9dd67d8f9b74",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T16:31:04+00:00",
        "updated_at": "2023-01-24T16:31:04+00:00",
        "number": "http://bqbl.it/e212c31c-5395-4977-b5ce-9dd67d8f9b74",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d1960009f96fde3ddeb5b064b159dca6/barcode/image/e212c31c-5395-4977-b5ce-9dd67d8f9b74/eb3a5816-bb76-4b99-85b1-a0d9f967e295.svg",
        "owner_id": "ace4d890-3029-41e0-adb6-d544e546d4ac",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ace4d890-3029-41e0-adb6-d544e546d4ac"
          },
          "data": {
            "type": "customers",
            "id": "ace4d890-3029-41e0-adb6-d544e546d4ac"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ace4d890-3029-41e0-adb6-d544e546d4ac",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T16:31:04+00:00",
        "updated_at": "2023-01-24T16:31:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ace4d890-3029-41e0-adb6-d544e546d4ac&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ace4d890-3029-41e0-adb6-d544e546d4ac&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ace4d890-3029-41e0-adb6-d544e546d4ac&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGYyMTkxYWUtZmMzNi00YTA1LThkNjEtNWZjYzRlMTQ0MWIx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8f2191ae-fc36-4a05-8d61-5fcc4e1441b1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-24T16:31:05+00:00",
        "updated_at": "2023-01-24T16:31:05+00:00",
        "number": "http://bqbl.it/8f2191ae-fc36-4a05-8d61-5fcc4e1441b1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8d284acc78d7a322caac8acefbfefcec/barcode/image/8f2191ae-fc36-4a05-8d61-5fcc4e1441b1/6f866fc8-9098-4514-a29c-c8c244257b83.svg",
        "owner_id": "a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b"
          },
          "data": {
            "type": "customers",
            "id": "a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T16:31:05+00:00",
        "updated_at": "2023-01-24T16:31:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a91f3b8b-5dbf-4a96-9ab3-fa2f7067b28b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T16:30:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/90b263d6-5c5a-4129-8656-02eec8647d28?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "90b263d6-5c5a-4129-8656-02eec8647d28",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T16:31:05+00:00",
      "updated_at": "2023-01-24T16:31:05+00:00",
      "number": "http://bqbl.it/90b263d6-5c5a-4129-8656-02eec8647d28",
      "barcode_type": "qr_code",
      "image_url": "/uploads/68cafdd43068e4c816292237cebc8051/barcode/image/90b263d6-5c5a-4129-8656-02eec8647d28/51013ca2-102d-4150-9098-a847689e3434.svg",
      "owner_id": "191c372d-1b70-4ead-8fa9-be82ede95ab3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/191c372d-1b70-4ead-8fa9-be82ede95ab3"
        },
        "data": {
          "type": "customers",
          "id": "191c372d-1b70-4ead-8fa9-be82ede95ab3"
        }
      }
    }
  },
  "included": [
    {
      "id": "191c372d-1b70-4ead-8fa9-be82ede95ab3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-24T16:31:05+00:00",
        "updated_at": "2023-01-24T16:31:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=191c372d-1b70-4ead-8fa9-be82ede95ab3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=191c372d-1b70-4ead-8fa9-be82ede95ab3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=191c372d-1b70-4ead-8fa9-be82ede95ab3&filter[owner_type]=customers"
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
          "owner_id": "e1c425f7-993d-4f4e-b2a9-35d8684f5ed5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7aefc03c-2b2d-4408-8100-cb6f3f94cd8e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T16:31:06+00:00",
      "updated_at": "2023-01-24T16:31:06+00:00",
      "number": "http://bqbl.it/7aefc03c-2b2d-4408-8100-cb6f3f94cd8e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1d3e25e538e84f9e383a96266ef18244/barcode/image/7aefc03c-2b2d-4408-8100-cb6f3f94cd8e/c1ee1caf-73ac-4f32-bb78-5f662aaa3ebd.svg",
      "owner_id": "e1c425f7-993d-4f4e-b2a9-35d8684f5ed5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f72cfdf7-0875-4051-9b18-7cf7a3796893' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f72cfdf7-0875-4051-9b18-7cf7a3796893",
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
    "id": "f72cfdf7-0875-4051-9b18-7cf7a3796893",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-24T16:31:06+00:00",
      "updated_at": "2023-01-24T16:31:06+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9f86a422e805f2ac6e9df911ea7cf172/barcode/image/f72cfdf7-0875-4051-9b18-7cf7a3796893/5bbf3b93-e80b-4abc-8546-054159e6cfe8.svg",
      "owner_id": "4bdadc47-2634-4a8b-a309-23ff8ca791b2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/316d30c6-3f2e-4205-8293-11c71f4a1b22' \
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