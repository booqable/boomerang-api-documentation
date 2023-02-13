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
      "id": "f153a51d-078d-4c20-ad2f-68e66ea109f7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T08:14:03+00:00",
        "updated_at": "2023-02-13T08:14:03+00:00",
        "number": "http://bqbl.it/f153a51d-078d-4c20-ad2f-68e66ea109f7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5de9f47359f3629c8b5f0e76f5728111/barcode/image/f153a51d-078d-4c20-ad2f-68e66ea109f7/5736385b-39c7-4e4c-a87a-8f48ab1fb242.svg",
        "owner_id": "565fa910-0445-4991-a57a-da12941e7c0c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/565fa910-0445-4991-a57a-da12941e7c0c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff2613712-a480-4b0c-90d7-296241021048&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f2613712-a480-4b0c-90d7-296241021048",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T08:14:04+00:00",
        "updated_at": "2023-02-13T08:14:04+00:00",
        "number": "http://bqbl.it/f2613712-a480-4b0c-90d7-296241021048",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6745f1d02b6f0509bd920805b5660b57/barcode/image/f2613712-a480-4b0c-90d7-296241021048/8451c374-818b-4981-9ec4-ea45eebb48fa.svg",
        "owner_id": "c384f2b9-aeca-4bd7-9087-574dcec204e3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c384f2b9-aeca-4bd7-9087-574dcec204e3"
          },
          "data": {
            "type": "customers",
            "id": "c384f2b9-aeca-4bd7-9087-574dcec204e3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c384f2b9-aeca-4bd7-9087-574dcec204e3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T08:14:04+00:00",
        "updated_at": "2023-02-13T08:14:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c384f2b9-aeca-4bd7-9087-574dcec204e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c384f2b9-aeca-4bd7-9087-574dcec204e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c384f2b9-aeca-4bd7-9087-574dcec204e3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDEyNDZkOGItMDc2OC00NGU1LTlkM2YtYWRiN2MwYWI1YmY3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d1246d8b-0768-44e5-9d3f-adb7c0ab5bf7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T08:14:05+00:00",
        "updated_at": "2023-02-13T08:14:05+00:00",
        "number": "http://bqbl.it/d1246d8b-0768-44e5-9d3f-adb7c0ab5bf7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cb191a536b743dd04154379e8d9eb990/barcode/image/d1246d8b-0768-44e5-9d3f-adb7c0ab5bf7/a143f016-fe2c-4e18-9160-cdc617deecf8.svg",
        "owner_id": "0209a8af-fcb7-4332-a964-4ddc671daa87",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0209a8af-fcb7-4332-a964-4ddc671daa87"
          },
          "data": {
            "type": "customers",
            "id": "0209a8af-fcb7-4332-a964-4ddc671daa87"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0209a8af-fcb7-4332-a964-4ddc671daa87",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T08:14:05+00:00",
        "updated_at": "2023-02-13T08:14:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0209a8af-fcb7-4332-a964-4ddc671daa87&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0209a8af-fcb7-4332-a964-4ddc671daa87&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0209a8af-fcb7-4332-a964-4ddc671daa87&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T08:13:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9e34a80d-c24f-4b36-8786-13d520c8e98e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9e34a80d-c24f-4b36-8786-13d520c8e98e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T08:14:05+00:00",
      "updated_at": "2023-02-13T08:14:05+00:00",
      "number": "http://bqbl.it/9e34a80d-c24f-4b36-8786-13d520c8e98e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7a037fcb8a05d33d7e3bfc9ec94773fb/barcode/image/9e34a80d-c24f-4b36-8786-13d520c8e98e/cdc51dca-369c-4f5a-81a8-7655d6b5075a.svg",
      "owner_id": "9a1368e0-7a06-4bfa-8131-6c6331c4fa62",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9a1368e0-7a06-4bfa-8131-6c6331c4fa62"
        },
        "data": {
          "type": "customers",
          "id": "9a1368e0-7a06-4bfa-8131-6c6331c4fa62"
        }
      }
    }
  },
  "included": [
    {
      "id": "9a1368e0-7a06-4bfa-8131-6c6331c4fa62",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T08:14:05+00:00",
        "updated_at": "2023-02-13T08:14:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9a1368e0-7a06-4bfa-8131-6c6331c4fa62&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9a1368e0-7a06-4bfa-8131-6c6331c4fa62&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9a1368e0-7a06-4bfa-8131-6c6331c4fa62&filter[owner_type]=customers"
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
          "owner_id": "de5bd3a6-378d-4c12-a77e-82d9315485cb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3cf93015-3d4a-44dd-a0e8-c8cd38891117",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T08:14:06+00:00",
      "updated_at": "2023-02-13T08:14:06+00:00",
      "number": "http://bqbl.it/3cf93015-3d4a-44dd-a0e8-c8cd38891117",
      "barcode_type": "qr_code",
      "image_url": "/uploads/408449fb95d4b5e06c8f1d89eac80a56/barcode/image/3cf93015-3d4a-44dd-a0e8-c8cd38891117/42179afe-4d50-4a26-8e65-4f10eec82b7c.svg",
      "owner_id": "de5bd3a6-378d-4c12-a77e-82d9315485cb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/68a9409f-52d5-440b-adfc-1b0c6a27db15' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "68a9409f-52d5-440b-adfc-1b0c6a27db15",
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
    "id": "68a9409f-52d5-440b-adfc-1b0c6a27db15",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T08:14:06+00:00",
      "updated_at": "2023-02-13T08:14:06+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1434cceff8e4763a36dcadad667e816a/barcode/image/68a9409f-52d5-440b-adfc-1b0c6a27db15/4d238ce4-1613-481d-a55e-055ef5d490a3.svg",
      "owner_id": "f3537806-3bf3-4e85-9a35-76b120296526",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c03d4881-1dd3-40d2-9f06-c22cc29e9686' \
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