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
      "id": "2850332d-49d4-476a-bfae-aabfb04ea36a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T08:54:22+00:00",
        "updated_at": "2023-02-23T08:54:22+00:00",
        "number": "http://bqbl.it/2850332d-49d4-476a-bfae-aabfb04ea36a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/06859f02e859f2c59fdce8a3641c9353/barcode/image/2850332d-49d4-476a-bfae-aabfb04ea36a/57e9f59d-87b2-42fd-bbeb-1f4373e88c9c.svg",
        "owner_id": "7eae2c13-67f9-4fcf-bb20-ce8f45d076a2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7eae2c13-67f9-4fcf-bb20-ce8f45d076a2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0e3828f5-7689-4534-9583-68f7fc0c92fa&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0e3828f5-7689-4534-9583-68f7fc0c92fa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T08:54:23+00:00",
        "updated_at": "2023-02-23T08:54:23+00:00",
        "number": "http://bqbl.it/0e3828f5-7689-4534-9583-68f7fc0c92fa",
        "barcode_type": "qr_code",
        "image_url": "/uploads/be0407382503f695628194cab3a58496/barcode/image/0e3828f5-7689-4534-9583-68f7fc0c92fa/19d3d268-4318-4680-a9da-f83bceb3e605.svg",
        "owner_id": "bb2989a1-eafd-4249-a558-251f0bf932d2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bb2989a1-eafd-4249-a558-251f0bf932d2"
          },
          "data": {
            "type": "customers",
            "id": "bb2989a1-eafd-4249-a558-251f0bf932d2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bb2989a1-eafd-4249-a558-251f0bf932d2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T08:54:23+00:00",
        "updated_at": "2023-02-23T08:54:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=bb2989a1-eafd-4249-a558-251f0bf932d2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bb2989a1-eafd-4249-a558-251f0bf932d2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bb2989a1-eafd-4249-a558-251f0bf932d2&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODYyNDNhMWYtNTk5MC00ZWNlLThiMzMtYTY1Yzg5OTk1Nzk5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "86243a1f-5990-4ece-8b33-a65c89995799",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-23T08:54:23+00:00",
        "updated_at": "2023-02-23T08:54:23+00:00",
        "number": "http://bqbl.it/86243a1f-5990-4ece-8b33-a65c89995799",
        "barcode_type": "qr_code",
        "image_url": "/uploads/46ba15f0817630e0e680d19e6e9f66ea/barcode/image/86243a1f-5990-4ece-8b33-a65c89995799/7a6d631d-e3c1-4562-a239-eaeba571930e.svg",
        "owner_id": "a361873c-0cbf-4f05-b732-89fa7f1e2195",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a361873c-0cbf-4f05-b732-89fa7f1e2195"
          },
          "data": {
            "type": "customers",
            "id": "a361873c-0cbf-4f05-b732-89fa7f1e2195"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a361873c-0cbf-4f05-b732-89fa7f1e2195",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T08:54:23+00:00",
        "updated_at": "2023-02-23T08:54:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a361873c-0cbf-4f05-b732-89fa7f1e2195&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a361873c-0cbf-4f05-b732-89fa7f1e2195&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a361873c-0cbf-4f05-b732-89fa7f1e2195&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T08:53:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/84035edd-be24-4310-8a24-538cfca5c160?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "84035edd-be24-4310-8a24-538cfca5c160",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T08:54:24+00:00",
      "updated_at": "2023-02-23T08:54:24+00:00",
      "number": "http://bqbl.it/84035edd-be24-4310-8a24-538cfca5c160",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aa98cb8655db4c145004483740615aa7/barcode/image/84035edd-be24-4310-8a24-538cfca5c160/24689e40-c316-42c9-a401-0ba9c3efbbc8.svg",
      "owner_id": "5a36a71e-4114-4440-a70a-150552b178fd",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5a36a71e-4114-4440-a70a-150552b178fd"
        },
        "data": {
          "type": "customers",
          "id": "5a36a71e-4114-4440-a70a-150552b178fd"
        }
      }
    }
  },
  "included": [
    {
      "id": "5a36a71e-4114-4440-a70a-150552b178fd",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-23T08:54:24+00:00",
        "updated_at": "2023-02-23T08:54:24+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5a36a71e-4114-4440-a70a-150552b178fd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5a36a71e-4114-4440-a70a-150552b178fd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5a36a71e-4114-4440-a70a-150552b178fd&filter[owner_type]=customers"
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
          "owner_id": "1467a4d7-3e8f-4a26-8445-e9fcca416402",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ca18a6d9-a28b-4cab-9081-ee079adacf2e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T08:54:24+00:00",
      "updated_at": "2023-02-23T08:54:24+00:00",
      "number": "http://bqbl.it/ca18a6d9-a28b-4cab-9081-ee079adacf2e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cc25261543b268f97676854b5fcb92bd/barcode/image/ca18a6d9-a28b-4cab-9081-ee079adacf2e/36de55db-1200-4e99-a3b7-8b721aa86c16.svg",
      "owner_id": "1467a4d7-3e8f-4a26-8445-e9fcca416402",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b924c7ef-9bc5-497f-ad60-16f992bdf555' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b924c7ef-9bc5-497f-ad60-16f992bdf555",
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
    "id": "b924c7ef-9bc5-497f-ad60-16f992bdf555",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-23T08:54:25+00:00",
      "updated_at": "2023-02-23T08:54:25+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e8935e870d547de877e82908543a9c93/barcode/image/b924c7ef-9bc5-497f-ad60-16f992bdf555/e65f597e-db1e-4126-a1fd-2c29fd57b861.svg",
      "owner_id": "c2502b61-59e6-4b78-a5aa-d2e96122abb3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8455d84f-2ba3-4e90-9be2-53c636c6facb' \
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