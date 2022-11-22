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
      "id": "525e96aa-30d1-4b1d-999c-e66035e640bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:33:31+00:00",
        "updated_at": "2022-11-22T16:33:31+00:00",
        "number": "http://bqbl.it/525e96aa-30d1-4b1d-999c-e66035e640bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/78e2a0d31512cadc979e72ed6e3a9fd1/barcode/image/525e96aa-30d1-4b1d-999c-e66035e640bd/dc77029a-ca2d-473d-9c17-d283cfc95336.svg",
        "owner_id": "b4cd2a4e-66f9-406a-b812-d4cd374adc3a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b4cd2a4e-66f9-406a-b812-d4cd374adc3a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc2a0f443-a2f6-435b-879b-5ef103693de2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c2a0f443-a2f6-435b-879b-5ef103693de2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:33:31+00:00",
        "updated_at": "2022-11-22T16:33:31+00:00",
        "number": "http://bqbl.it/c2a0f443-a2f6-435b-879b-5ef103693de2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/68ba551833cacaa12bfe943814fddc27/barcode/image/c2a0f443-a2f6-435b-879b-5ef103693de2/d8cf0dd4-33d3-488d-99f6-4d213411f9b1.svg",
        "owner_id": "ca3a487c-0203-4ada-9f28-708a0391f8eb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ca3a487c-0203-4ada-9f28-708a0391f8eb"
          },
          "data": {
            "type": "customers",
            "id": "ca3a487c-0203-4ada-9f28-708a0391f8eb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ca3a487c-0203-4ada-9f28-708a0391f8eb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:33:31+00:00",
        "updated_at": "2022-11-22T16:33:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ca3a487c-0203-4ada-9f28-708a0391f8eb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ca3a487c-0203-4ada-9f28-708a0391f8eb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ca3a487c-0203-4ada-9f28-708a0391f8eb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjc1NTY1YjMtMTQ5Ni00ZjdlLTk4MjMtZjJhNzNhYjVmNGEx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "275565b3-1496-4f7e-9823-f2a73ab5f4a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T16:33:32+00:00",
        "updated_at": "2022-11-22T16:33:32+00:00",
        "number": "http://bqbl.it/275565b3-1496-4f7e-9823-f2a73ab5f4a1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ec99da52bd63fbd1cb45e3578dfe6b50/barcode/image/275565b3-1496-4f7e-9823-f2a73ab5f4a1/266ea3b9-1302-415b-ad28-507741766833.svg",
        "owner_id": "00d235ff-9ab4-49e5-a593-3d6bc14ce7fe",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/00d235ff-9ab4-49e5-a593-3d6bc14ce7fe"
          },
          "data": {
            "type": "customers",
            "id": "00d235ff-9ab4-49e5-a593-3d6bc14ce7fe"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "00d235ff-9ab4-49e5-a593-3d6bc14ce7fe",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:33:32+00:00",
        "updated_at": "2022-11-22T16:33:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=00d235ff-9ab4-49e5-a593-3d6bc14ce7fe&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=00d235ff-9ab4-49e5-a593-3d6bc14ce7fe&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=00d235ff-9ab4-49e5-a593-3d6bc14ce7fe&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:33:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/28910be4-c575-44f1-8f54-ff0ec57d6861?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "28910be4-c575-44f1-8f54-ff0ec57d6861",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:33:32+00:00",
      "updated_at": "2022-11-22T16:33:32+00:00",
      "number": "http://bqbl.it/28910be4-c575-44f1-8f54-ff0ec57d6861",
      "barcode_type": "qr_code",
      "image_url": "/uploads/baa9b975a8ef0972c6c2b67bb3091629/barcode/image/28910be4-c575-44f1-8f54-ff0ec57d6861/1d873da9-9a5e-4ac4-a348-e5b205dbe342.svg",
      "owner_id": "63c44447-da03-4c57-9f87-0c48003359e0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/63c44447-da03-4c57-9f87-0c48003359e0"
        },
        "data": {
          "type": "customers",
          "id": "63c44447-da03-4c57-9f87-0c48003359e0"
        }
      }
    }
  },
  "included": [
    {
      "id": "63c44447-da03-4c57-9f87-0c48003359e0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T16:33:32+00:00",
        "updated_at": "2022-11-22T16:33:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=63c44447-da03-4c57-9f87-0c48003359e0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=63c44447-da03-4c57-9f87-0c48003359e0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=63c44447-da03-4c57-9f87-0c48003359e0&filter[owner_type]=customers"
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
          "owner_id": "1c34f7de-dab1-4c22-922d-4dd733108d7b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8befded9-1cd2-48b2-89a1-d62b7f20bf6d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:33:33+00:00",
      "updated_at": "2022-11-22T16:33:33+00:00",
      "number": "http://bqbl.it/8befded9-1cd2-48b2-89a1-d62b7f20bf6d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f919ed0721ca3d26070177ea1b047816/barcode/image/8befded9-1cd2-48b2-89a1-d62b7f20bf6d/46c221e8-720a-471c-b94f-5331907fe648.svg",
      "owner_id": "1c34f7de-dab1-4c22-922d-4dd733108d7b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3da41359-6d32-4a95-a915-b9a948c7727a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3da41359-6d32-4a95-a915-b9a948c7727a",
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
    "id": "3da41359-6d32-4a95-a915-b9a948c7727a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T16:33:33+00:00",
      "updated_at": "2022-11-22T16:33:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/765adfff422c215d57d800082d0d2ea0/barcode/image/3da41359-6d32-4a95-a915-b9a948c7727a/888afd31-ea08-4d33-9ac1-c99ece1cc76d.svg",
      "owner_id": "b81e9434-dd11-4165-9e91-a93035919479",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/01348b45-f3db-4649-b6ba-96cc77273aff' \
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