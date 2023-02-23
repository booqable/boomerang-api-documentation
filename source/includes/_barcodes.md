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
      "id": "581d1d4e-170b-401a-b2c0-0bdcadb329da",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T13:35:57+00:00",
        "updated_at": "2023-02-23T13:35:57+00:00",
        "number": "http://bqbl.it/581d1d4e-170b-401a-b2c0-0bdcadb329da",
        "barcode_type": "qr_code",
        "image_url": "/uploads/de12be3a8991b34c8ddec8eba5cbcf99/barcode/image/581d1d4e-170b-401a-b2c0-0bdcadb329da/1dc085e8-28a9-4f9b-b2c6-a9307e53a54b.svg",
        "owner_id": "fc3bd582-8c3f-492b-bc00-b877bdec95c2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fc3bd582-8c3f-492b-bc00-b877bdec95c2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc73e806c-b243-46e1-a3fc-fba48231ba66&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c73e806c-b243-46e1-a3fc-fba48231ba66",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T13:35:58+00:00",
        "updated_at": "2023-02-23T13:35:58+00:00",
        "number": "http://bqbl.it/c73e806c-b243-46e1-a3fc-fba48231ba66",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9cf5f28b6526be0934e9442e489a22c6/barcode/image/c73e806c-b243-46e1-a3fc-fba48231ba66/336dd40d-bcf8-4b34-8154-5bd76e4f16e7.svg",
        "owner_id": "a8424c4c-9657-443d-bb1f-9f4a6128da30",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a8424c4c-9657-443d-bb1f-9f4a6128da30"
          },
          "data": {
            "type": "customers",
            "id": "a8424c4c-9657-443d-bb1f-9f4a6128da30"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a8424c4c-9657-443d-bb1f-9f4a6128da30",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T13:35:58+00:00",
        "updated_at": "2023-02-23T13:35:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a8424c4c-9657-443d-bb1f-9f4a6128da30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a8424c4c-9657-443d-bb1f-9f4a6128da30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a8424c4c-9657-443d-bb1f-9f4a6128da30&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDg2MWFiZjMtZWY2Zi00OGIwLWI1OTAtYjBiNWQ3NjQ3NWQ0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d861abf3-ef6f-48b0-b590-b0b5d76475d4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T13:35:58+00:00",
        "updated_at": "2023-02-23T13:35:58+00:00",
        "number": "http://bqbl.it/d861abf3-ef6f-48b0-b590-b0b5d76475d4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/19fb6c2e3fc45cad94c671f30f0b4940/barcode/image/d861abf3-ef6f-48b0-b590-b0b5d76475d4/9a036140-8361-4f66-a315-59f0670b39ce.svg",
        "owner_id": "9b669b88-ca69-4ec1-b383-6af98186b33c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9b669b88-ca69-4ec1-b383-6af98186b33c"
          },
          "data": {
            "type": "customers",
            "id": "9b669b88-ca69-4ec1-b383-6af98186b33c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9b669b88-ca69-4ec1-b383-6af98186b33c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T13:35:58+00:00",
        "updated_at": "2023-02-23T13:35:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9b669b88-ca69-4ec1-b383-6af98186b33c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9b669b88-ca69-4ec1-b383-6af98186b33c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9b669b88-ca69-4ec1-b383-6af98186b33c&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:35:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/65fe0013-5516-436e-b4db-abbeb81db87b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "65fe0013-5516-436e-b4db-abbeb81db87b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T13:35:59+00:00",
      "updated_at": "2023-02-23T13:35:59+00:00",
      "number": "http://bqbl.it/65fe0013-5516-436e-b4db-abbeb81db87b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a6a5924d29c134d3a736bde3bf28f7ee/barcode/image/65fe0013-5516-436e-b4db-abbeb81db87b/0ca8bc30-82e4-4a8e-a160-f733d8a8946f.svg",
      "owner_id": "39824816-326a-48ba-b533-704eae4e1f2d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/39824816-326a-48ba-b533-704eae4e1f2d"
        },
        "data": {
          "type": "customers",
          "id": "39824816-326a-48ba-b533-704eae4e1f2d"
        }
      }
    }
  },
  "included": [
    {
      "id": "39824816-326a-48ba-b533-704eae4e1f2d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T13:35:59+00:00",
        "updated_at": "2023-02-23T13:35:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=39824816-326a-48ba-b533-704eae4e1f2d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=39824816-326a-48ba-b533-704eae4e1f2d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=39824816-326a-48ba-b533-704eae4e1f2d&filter[owner_type]=customers"
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
          "owner_id": "ea6bcdf7-65f8-443b-b879-83e4474cc370",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "37e98a09-3017-4402-aece-45230620ec18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T13:36:00+00:00",
      "updated_at": "2023-02-23T13:36:00+00:00",
      "number": "http://bqbl.it/37e98a09-3017-4402-aece-45230620ec18",
      "barcode_type": "qr_code",
      "image_url": "/uploads/00da0b4daf4eb4b2517619d7a9e94386/barcode/image/37e98a09-3017-4402-aece-45230620ec18/52aae3d4-09ea-47cb-8f47-6f805a28e497.svg",
      "owner_id": "ea6bcdf7-65f8-443b-b879-83e4474cc370",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/83f0e3c0-6d07-4edc-8714-05d92d5de824' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "83f0e3c0-6d07-4edc-8714-05d92d5de824",
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
    "id": "83f0e3c0-6d07-4edc-8714-05d92d5de824",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T13:36:00+00:00",
      "updated_at": "2023-02-23T13:36:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5e95e13d7e9cd903d5c3f963285270d8/barcode/image/83f0e3c0-6d07-4edc-8714-05d92d5de824/7f5a0c07-0ec4-4b0b-a02a-37e89aa6b682.svg",
      "owner_id": "abdeb373-f308-48fe-a193-0a4a4da56e52",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9370f129-36ed-461f-80dd-c4f3c3c3fbd5' \
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