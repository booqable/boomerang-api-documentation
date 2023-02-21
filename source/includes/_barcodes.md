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
      "id": "9706efc6-0228-40d8-a209-376baa4cdad5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T08:18:57+00:00",
        "updated_at": "2023-02-21T08:18:57+00:00",
        "number": "http://bqbl.it/9706efc6-0228-40d8-a209-376baa4cdad5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/35dd4d6e3f1367d188c77709d5c8cc05/barcode/image/9706efc6-0228-40d8-a209-376baa4cdad5/c15ff15f-05cf-4b09-8193-90c07b216796.svg",
        "owner_id": "d290ae74-2115-439d-90eb-d8e1a03e4fe6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d290ae74-2115-439d-90eb-d8e1a03e4fe6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1e9b7816-fac4-4a78-9808-a038ce21386a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1e9b7816-fac4-4a78-9808-a038ce21386a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T08:18:58+00:00",
        "updated_at": "2023-02-21T08:18:58+00:00",
        "number": "http://bqbl.it/1e9b7816-fac4-4a78-9808-a038ce21386a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/939704836c99f1de5c5b670cd0cda315/barcode/image/1e9b7816-fac4-4a78-9808-a038ce21386a/222466cd-f178-46e4-9575-f15f3ff84e65.svg",
        "owner_id": "f5572985-dd02-4e0b-b721-a517c3b98c27",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f5572985-dd02-4e0b-b721-a517c3b98c27"
          },
          "data": {
            "type": "customers",
            "id": "f5572985-dd02-4e0b-b721-a517c3b98c27"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f5572985-dd02-4e0b-b721-a517c3b98c27",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T08:18:58+00:00",
        "updated_at": "2023-02-21T08:18:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f5572985-dd02-4e0b-b721-a517c3b98c27&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f5572985-dd02-4e0b-b721-a517c3b98c27&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f5572985-dd02-4e0b-b721-a517c3b98c27&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWFlYWVhMDctNTA4MC00MDdlLWIyYmQtZmIyNTgzNmY3MmNi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "aaeaea07-5080-407e-b2bd-fb25836f72cb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-21T08:18:58+00:00",
        "updated_at": "2023-02-21T08:18:58+00:00",
        "number": "http://bqbl.it/aaeaea07-5080-407e-b2bd-fb25836f72cb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9bbdcd1d8c1391a998d7c9326fcf14b5/barcode/image/aaeaea07-5080-407e-b2bd-fb25836f72cb/2cea7d51-2a3a-493e-9c1e-59d191c20a1c.svg",
        "owner_id": "e0e25e4e-85fd-4103-9232-1aa4c59fe26b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e0e25e4e-85fd-4103-9232-1aa4c59fe26b"
          },
          "data": {
            "type": "customers",
            "id": "e0e25e4e-85fd-4103-9232-1aa4c59fe26b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e0e25e4e-85fd-4103-9232-1aa4c59fe26b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T08:18:58+00:00",
        "updated_at": "2023-02-21T08:18:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e0e25e4e-85fd-4103-9232-1aa4c59fe26b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e0e25e4e-85fd-4103-9232-1aa4c59fe26b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e0e25e4e-85fd-4103-9232-1aa4c59fe26b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T08:18:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ce929528-19a1-488b-aeb5-5d1aa2536c4c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ce929528-19a1-488b-aeb5-5d1aa2536c4c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T08:18:59+00:00",
      "updated_at": "2023-02-21T08:18:59+00:00",
      "number": "http://bqbl.it/ce929528-19a1-488b-aeb5-5d1aa2536c4c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4566468340bf9d36424e6d562ca8ab2b/barcode/image/ce929528-19a1-488b-aeb5-5d1aa2536c4c/9d76b527-ca23-463f-a542-d8e911333f50.svg",
      "owner_id": "e5572d81-851f-4218-8aa9-dd395e25f632",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e5572d81-851f-4218-8aa9-dd395e25f632"
        },
        "data": {
          "type": "customers",
          "id": "e5572d81-851f-4218-8aa9-dd395e25f632"
        }
      }
    }
  },
  "included": [
    {
      "id": "e5572d81-851f-4218-8aa9-dd395e25f632",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-21T08:18:58+00:00",
        "updated_at": "2023-02-21T08:18:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e5572d81-851f-4218-8aa9-dd395e25f632&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e5572d81-851f-4218-8aa9-dd395e25f632&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e5572d81-851f-4218-8aa9-dd395e25f632&filter[owner_type]=customers"
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
          "owner_id": "65641ae8-679f-4161-8d68-b9d8f641e058",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e3800422-11ee-4db6-8072-29cbddb71fa9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T08:18:59+00:00",
      "updated_at": "2023-02-21T08:18:59+00:00",
      "number": "http://bqbl.it/e3800422-11ee-4db6-8072-29cbddb71fa9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4044e09c058d6b1e2f06f4f4bd6bc9ab/barcode/image/e3800422-11ee-4db6-8072-29cbddb71fa9/89d0d12a-e027-4d9b-a99b-58255a4b2d07.svg",
      "owner_id": "65641ae8-679f-4161-8d68-b9d8f641e058",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cb9939f5-b557-45bc-a55c-ec717936f9ea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cb9939f5-b557-45bc-a55c-ec717936f9ea",
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
    "id": "cb9939f5-b557-45bc-a55c-ec717936f9ea",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-21T08:18:59+00:00",
      "updated_at": "2023-02-21T08:19:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/741c509438da6cffc264cb78f97fd200/barcode/image/cb9939f5-b557-45bc-a55c-ec717936f9ea/4d4efbcf-3f74-4b05-972f-4fccc2cee985.svg",
      "owner_id": "981b09b1-e77c-4d04-a9c2-330a5d245838",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d42bb87e-1452-40e1-9598-85f4168f4241' \
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