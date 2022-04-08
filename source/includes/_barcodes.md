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
      "id": "9d089f4e-0fc1-42a1-b357-bfc8aa77ade3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-08T17:51:26+00:00",
        "updated_at": "2022-04-08T17:51:26+00:00",
        "number": "http://bqbl.it/9d089f4e-0fc1-42a1-b357-bfc8aa77ade3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/aafe3838714dda475780f49c5c46700f/barcode/image/9d089f4e-0fc1-42a1-b357-bfc8aa77ade3/fc3399b9-dace-4160-9be0-1693629d28e4.svg",
        "owner_id": "5c0bb6f9-d7a8-452e-ab2e-ba5ba8911064",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5c0bb6f9-d7a8-452e-ab2e-ba5ba8911064"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F395ffc8c-7a29-4e95-8fe8-87cc791213dd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "395ffc8c-7a29-4e95-8fe8-87cc791213dd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-08T17:51:27+00:00",
        "updated_at": "2022-04-08T17:51:27+00:00",
        "number": "http://bqbl.it/395ffc8c-7a29-4e95-8fe8-87cc791213dd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/031c89bfddc61917e8ac5e4fe5908be2/barcode/image/395ffc8c-7a29-4e95-8fe8-87cc791213dd/adccb17e-8316-457a-a9c3-fa15e4e48d7a.svg",
        "owner_id": "18466e14-3fe7-435f-88fa-3c05481e3964",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/18466e14-3fe7-435f-88fa-3c05481e3964"
          },
          "data": {
            "type": "customers",
            "id": "18466e14-3fe7-435f-88fa-3c05481e3964"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "18466e14-3fe7-435f-88fa-3c05481e3964",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T17:51:27+00:00",
        "updated_at": "2022-04-08T17:51:27+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Braun-Trantow",
        "email": "braun_trantow@bechtelar.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=18466e14-3fe7-435f-88fa-3c05481e3964&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=18466e14-3fe7-435f-88fa-3c05481e3964&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=18466e14-3fe7-435f-88fa-3c05481e3964&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmFhMGU3NDYtNGE2MS00ZDhhLTllNmItYzUwZWRmZGVjMDIx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2aa0e746-4a61-4d8a-9e6b-c50edfdec021",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-08T17:51:27+00:00",
        "updated_at": "2022-04-08T17:51:27+00:00",
        "number": "http://bqbl.it/2aa0e746-4a61-4d8a-9e6b-c50edfdec021",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1d6c05cb933c6d7cad0dfe3cdd55a98a/barcode/image/2aa0e746-4a61-4d8a-9e6b-c50edfdec021/ff5c53b5-6a2a-43f1-9e30-12bb3182d6f0.svg",
        "owner_id": "832b64d7-88da-490c-99d3-9ab3ee0142ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/832b64d7-88da-490c-99d3-9ab3ee0142ec"
          },
          "data": {
            "type": "customers",
            "id": "832b64d7-88da-490c-99d3-9ab3ee0142ec"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "832b64d7-88da-490c-99d3-9ab3ee0142ec",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T17:51:27+00:00",
        "updated_at": "2022-04-08T17:51:27+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Wuckert and Sons",
        "email": "wuckert.sons.and@windler-morissette.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=832b64d7-88da-490c-99d3-9ab3ee0142ec&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=832b64d7-88da-490c-99d3-9ab3ee0142ec&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=832b64d7-88da-490c-99d3-9ab3ee0142ec&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1eccfd5d-5329-4832-b7a6-bb6e6b044459?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1eccfd5d-5329-4832-b7a6-bb6e6b044459",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-08T17:51:28+00:00",
      "updated_at": "2022-04-08T17:51:28+00:00",
      "number": "http://bqbl.it/1eccfd5d-5329-4832-b7a6-bb6e6b044459",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a54ae42d8e2c570df878de0f3ea8bd70/barcode/image/1eccfd5d-5329-4832-b7a6-bb6e6b044459/fff9d59f-edbe-4faf-aa29-197fd272d9d6.svg",
      "owner_id": "61123180-0e00-4d3a-886b-c88d20cc6e5f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/61123180-0e00-4d3a-886b-c88d20cc6e5f"
        },
        "data": {
          "type": "customers",
          "id": "61123180-0e00-4d3a-886b-c88d20cc6e5f"
        }
      }
    }
  },
  "included": [
    {
      "id": "61123180-0e00-4d3a-886b-c88d20cc6e5f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T17:51:27+00:00",
        "updated_at": "2022-04-08T17:51:28+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Cremin-Walter",
        "email": "cremin_walter@doyle-koelpin.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=61123180-0e00-4d3a-886b-c88d20cc6e5f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=61123180-0e00-4d3a-886b-c88d20cc6e5f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=61123180-0e00-4d3a-886b-c88d20cc6e5f&filter[owner_type]=customers"
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
          "owner_id": "e3ec5bf9-2929-446b-8a32-071b7a1fa691",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "92a3a054-dbf1-4e68-9f09-2cb3e973c8e8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-08T17:51:28+00:00",
      "updated_at": "2022-04-08T17:51:28+00:00",
      "number": "http://bqbl.it/92a3a054-dbf1-4e68-9f09-2cb3e973c8e8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c5a01ccada48134f21352d264f3131a9/barcode/image/92a3a054-dbf1-4e68-9f09-2cb3e973c8e8/5c2020fd-946f-4b0b-ab8d-880dc6fa50bd.svg",
      "owner_id": "e3ec5bf9-2929-446b-8a32-071b7a1fa691",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/25bff9db-ef16-4ef7-a035-ab7c2581c8e9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "25bff9db-ef16-4ef7-a035-ab7c2581c8e9",
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
    "id": "25bff9db-ef16-4ef7-a035-ab7c2581c8e9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-08T17:51:28+00:00",
      "updated_at": "2022-04-08T17:51:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3db0afdd7e3f15291f11f0da09bccfa1/barcode/image/25bff9db-ef16-4ef7-a035-ab7c2581c8e9/17494c19-e1bf-4138-88df-49f889afd19e.svg",
      "owner_id": "b7683a10-2a36-4c16-942b-b968d43751d7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/44aeae87-800b-4508-9723-41ec598c9b6b' \
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