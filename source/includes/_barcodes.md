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
      "id": "190d9da8-eebd-47e4-b010-e9c5ce872fea",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T11:09:26+00:00",
        "updated_at": "2023-02-03T11:09:26+00:00",
        "number": "http://bqbl.it/190d9da8-eebd-47e4-b010-e9c5ce872fea",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5301c2424b1952be5a2c4f023d433aa4/barcode/image/190d9da8-eebd-47e4-b010-e9c5ce872fea/f79b418e-e45b-4404-b09a-50631509de0b.svg",
        "owner_id": "9d0d71e3-b1ca-4c1f-b7ed-083e5e41a84d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9d0d71e3-b1ca-4c1f-b7ed-083e5e41a84d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffb17db7e-12e7-460c-b1ba-d66b33867ddc&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fb17db7e-12e7-460c-b1ba-d66b33867ddc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T11:09:26+00:00",
        "updated_at": "2023-02-03T11:09:26+00:00",
        "number": "http://bqbl.it/fb17db7e-12e7-460c-b1ba-d66b33867ddc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/92d30518349ae1a2e74dc1489b7fbd7a/barcode/image/fb17db7e-12e7-460c-b1ba-d66b33867ddc/6fe6b31a-d940-426a-bf8c-a1559cb9fb36.svg",
        "owner_id": "d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1"
          },
          "data": {
            "type": "customers",
            "id": "d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T11:09:26+00:00",
        "updated_at": "2023-02-03T11:09:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d7da3898-2c2e-4ecc-9e0d-52ef1e26cdb1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzhhZjk1MGMtZTY4Ni00NTVjLTg0MjktOTU3NzZhODQwNDI4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c8af950c-e686-455c-8429-95776a840428",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T11:09:26+00:00",
        "updated_at": "2023-02-03T11:09:26+00:00",
        "number": "http://bqbl.it/c8af950c-e686-455c-8429-95776a840428",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fd1e9f0de8d4c30e214aa66eedf736d2/barcode/image/c8af950c-e686-455c-8429-95776a840428/30e387c9-bfd9-495b-bfbf-fbb5fc2476c6.svg",
        "owner_id": "9d44d27d-3aee-4737-b659-3af90eb17165",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9d44d27d-3aee-4737-b659-3af90eb17165"
          },
          "data": {
            "type": "customers",
            "id": "9d44d27d-3aee-4737-b659-3af90eb17165"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9d44d27d-3aee-4737-b659-3af90eb17165",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T11:09:26+00:00",
        "updated_at": "2023-02-03T11:09:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9d44d27d-3aee-4737-b659-3af90eb17165&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9d44d27d-3aee-4737-b659-3af90eb17165&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9d44d27d-3aee-4737-b659-3af90eb17165&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:09:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c57b2f60-6f9e-418b-8ef3-ffa943e69e83?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c57b2f60-6f9e-418b-8ef3-ffa943e69e83",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T11:09:27+00:00",
      "updated_at": "2023-02-03T11:09:27+00:00",
      "number": "http://bqbl.it/c57b2f60-6f9e-418b-8ef3-ffa943e69e83",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c42973e89964d0cd2b722f97f12dcd5/barcode/image/c57b2f60-6f9e-418b-8ef3-ffa943e69e83/7b2eb507-7a4e-402b-a193-8d8449cf5e7d.svg",
      "owner_id": "4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe"
        },
        "data": {
          "type": "customers",
          "id": "4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe"
        }
      }
    }
  },
  "included": [
    {
      "id": "4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T11:09:27+00:00",
        "updated_at": "2023-02-03T11:09:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4f7dd3ed-ffde-4459-a5fa-cc24d2f314fe&filter[owner_type]=customers"
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
          "owner_id": "0d75f74e-10b1-478b-9cad-b3df6f525d09",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "80f2c06e-1547-4d18-bbb5-5ea7466d023a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T11:09:27+00:00",
      "updated_at": "2023-02-03T11:09:27+00:00",
      "number": "http://bqbl.it/80f2c06e-1547-4d18-bbb5-5ea7466d023a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8abb696784adb5fdf18c694d66e947cc/barcode/image/80f2c06e-1547-4d18-bbb5-5ea7466d023a/5a65fcb3-4f51-4f1c-be38-530c329733cf.svg",
      "owner_id": "0d75f74e-10b1-478b-9cad-b3df6f525d09",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b554eac5-453f-4896-bdc8-cc2ad99e7c06' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b554eac5-453f-4896-bdc8-cc2ad99e7c06",
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
    "id": "b554eac5-453f-4896-bdc8-cc2ad99e7c06",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T11:09:28+00:00",
      "updated_at": "2023-02-03T11:09:28+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8dcc51951e0c6c7bb312fe4f01d958ea/barcode/image/b554eac5-453f-4896-bdc8-cc2ad99e7c06/2f353b76-c048-42d2-8018-17bbfd9b8d83.svg",
      "owner_id": "b5df347f-a5fe-4b03-afce-70d461cd09fc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f6111f82-3a9d-48b2-b361-09c92b164aca' \
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