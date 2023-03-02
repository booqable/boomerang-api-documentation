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
      "id": "cc026a42-7f15-4f4e-a660-adebcc2d34cd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T09:23:12+00:00",
        "updated_at": "2023-03-02T09:23:12+00:00",
        "number": "http://bqbl.it/cc026a42-7f15-4f4e-a660-adebcc2d34cd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4719408be6c798dbaf5814a92484185f/barcode/image/cc026a42-7f15-4f4e-a660-adebcc2d34cd/fd421a15-c20d-4044-91ac-e76d0bdbf489.svg",
        "owner_id": "fe192fc6-fa80-48e7-a570-9e231372d610",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fe192fc6-fa80-48e7-a570-9e231372d610"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F466ffa8b-7b16-4bff-bfee-35f772096d66&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "466ffa8b-7b16-4bff-bfee-35f772096d66",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T09:23:13+00:00",
        "updated_at": "2023-03-02T09:23:13+00:00",
        "number": "http://bqbl.it/466ffa8b-7b16-4bff-bfee-35f772096d66",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dd47c9009ac931ed7f53fadd513a39ac/barcode/image/466ffa8b-7b16-4bff-bfee-35f772096d66/f09ae1af-08da-4e6b-ae7a-78415981f27e.svg",
        "owner_id": "480e0d3c-40aa-46b1-ba57-6813b4c3a934",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/480e0d3c-40aa-46b1-ba57-6813b4c3a934"
          },
          "data": {
            "type": "customers",
            "id": "480e0d3c-40aa-46b1-ba57-6813b4c3a934"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "480e0d3c-40aa-46b1-ba57-6813b4c3a934",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T09:23:13+00:00",
        "updated_at": "2023-03-02T09:23:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=480e0d3c-40aa-46b1-ba57-6813b4c3a934&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=480e0d3c-40aa-46b1-ba57-6813b4c3a934&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=480e0d3c-40aa-46b1-ba57-6813b4c3a934&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjlhZmY2ODQtMmEyZi00YjAzLWEyZDctNWNkZTM1ODlmM2Y5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f9aff684-2a2f-4b03-a2d7-5cde3589f3f9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T09:23:13+00:00",
        "updated_at": "2023-03-02T09:23:13+00:00",
        "number": "http://bqbl.it/f9aff684-2a2f-4b03-a2d7-5cde3589f3f9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d2a3f75574963a94a9905d2338dd00fb/barcode/image/f9aff684-2a2f-4b03-a2d7-5cde3589f3f9/f9188896-f547-4cc9-a4cc-d39be13c2b42.svg",
        "owner_id": "fe240105-e52d-4ce5-a4d8-d899d0b4b7db",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fe240105-e52d-4ce5-a4d8-d899d0b4b7db"
          },
          "data": {
            "type": "customers",
            "id": "fe240105-e52d-4ce5-a4d8-d899d0b4b7db"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fe240105-e52d-4ce5-a4d8-d899d0b4b7db",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T09:23:13+00:00",
        "updated_at": "2023-03-02T09:23:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fe240105-e52d-4ce5-a4d8-d899d0b4b7db&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fe240105-e52d-4ce5-a4d8-d899d0b4b7db&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fe240105-e52d-4ce5-a4d8-d899d0b4b7db&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T09:22:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/60fff2ae-88fb-4795-af21-d831bbb12e8d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "60fff2ae-88fb-4795-af21-d831bbb12e8d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T09:23:14+00:00",
      "updated_at": "2023-03-02T09:23:14+00:00",
      "number": "http://bqbl.it/60fff2ae-88fb-4795-af21-d831bbb12e8d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/18eff7317c3db6306f8d03a440de3f06/barcode/image/60fff2ae-88fb-4795-af21-d831bbb12e8d/bd029ab6-9d62-46b9-b359-20ab89527342.svg",
      "owner_id": "f1b0d436-5e5a-4781-aee3-c096db9c730d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f1b0d436-5e5a-4781-aee3-c096db9c730d"
        },
        "data": {
          "type": "customers",
          "id": "f1b0d436-5e5a-4781-aee3-c096db9c730d"
        }
      }
    }
  },
  "included": [
    {
      "id": "f1b0d436-5e5a-4781-aee3-c096db9c730d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T09:23:14+00:00",
        "updated_at": "2023-03-02T09:23:14+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f1b0d436-5e5a-4781-aee3-c096db9c730d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1b0d436-5e5a-4781-aee3-c096db9c730d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1b0d436-5e5a-4781-aee3-c096db9c730d&filter[owner_type]=customers"
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
          "owner_id": "089a531c-3a41-4532-a750-af5467098b69",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "328cdf4a-dff6-4da5-a490-2ebf5d265402",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T09:23:15+00:00",
      "updated_at": "2023-03-02T09:23:15+00:00",
      "number": "http://bqbl.it/328cdf4a-dff6-4da5-a490-2ebf5d265402",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cab157648ef0032da3e318d6d49dc90f/barcode/image/328cdf4a-dff6-4da5-a490-2ebf5d265402/9570a793-87c1-4dff-8a9e-8194919b1307.svg",
      "owner_id": "089a531c-3a41-4532-a750-af5467098b69",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d3f3ab50-7c86-41d3-9bcb-9dae0ef86cdd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d3f3ab50-7c86-41d3-9bcb-9dae0ef86cdd",
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
    "id": "d3f3ab50-7c86-41d3-9bcb-9dae0ef86cdd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T09:23:16+00:00",
      "updated_at": "2023-03-02T09:23:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3792c5256a23e50c6b2375ffd3cce09f/barcode/image/d3f3ab50-7c86-41d3-9bcb-9dae0ef86cdd/024a460f-26ef-4bef-95d8-b1586d7922b9.svg",
      "owner_id": "387fc9b0-1a52-4140-8ce1-24d096ca08f3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f519d934-78f4-4b5b-975f-fca5c11f5519' \
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