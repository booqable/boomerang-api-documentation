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
      "id": "2e2bb46d-9ea7-42c6-a4a0-082287f05609",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T09:07:52+00:00",
        "updated_at": "2023-02-13T09:07:52+00:00",
        "number": "http://bqbl.it/2e2bb46d-9ea7-42c6-a4a0-082287f05609",
        "barcode_type": "qr_code",
        "image_url": "/uploads/25829bb8429f0f243fca4f6928323060/barcode/image/2e2bb46d-9ea7-42c6-a4a0-082287f05609/f323e40c-08f1-4ca0-9c14-2f42dc8aab3b.svg",
        "owner_id": "0a50e9df-dd18-415e-a4ce-87ff62c5956d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0a50e9df-dd18-415e-a4ce-87ff62c5956d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc051ff77-05db-4c2b-8fc1-f208593cbf9e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c051ff77-05db-4c2b-8fc1-f208593cbf9e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T09:07:53+00:00",
        "updated_at": "2023-02-13T09:07:53+00:00",
        "number": "http://bqbl.it/c051ff77-05db-4c2b-8fc1-f208593cbf9e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a66f26b3605030f0523f7d8f46ac7b80/barcode/image/c051ff77-05db-4c2b-8fc1-f208593cbf9e/aff697e4-5e42-4bbc-a52c-3e2b2ee4ead5.svg",
        "owner_id": "1becce0c-1f7f-494f-b0ac-f8cd74b12767",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1becce0c-1f7f-494f-b0ac-f8cd74b12767"
          },
          "data": {
            "type": "customers",
            "id": "1becce0c-1f7f-494f-b0ac-f8cd74b12767"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1becce0c-1f7f-494f-b0ac-f8cd74b12767",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T09:07:53+00:00",
        "updated_at": "2023-02-13T09:07:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1becce0c-1f7f-494f-b0ac-f8cd74b12767&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1becce0c-1f7f-494f-b0ac-f8cd74b12767&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1becce0c-1f7f-494f-b0ac-f8cd74b12767&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODg0YTkyNjItMDg0YS00MjVjLTk1MzQtYmIxZDBhZWMyNzhk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "884a9262-084a-425c-9534-bb1d0aec278d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T09:07:54+00:00",
        "updated_at": "2023-02-13T09:07:54+00:00",
        "number": "http://bqbl.it/884a9262-084a-425c-9534-bb1d0aec278d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/833b1cc628b5e3dcda93c97cff48aa37/barcode/image/884a9262-084a-425c-9534-bb1d0aec278d/3a1527fe-710f-4b6f-81f3-44a50d3c2258.svg",
        "owner_id": "6b291f21-028e-4882-b002-353e41bae43a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6b291f21-028e-4882-b002-353e41bae43a"
          },
          "data": {
            "type": "customers",
            "id": "6b291f21-028e-4882-b002-353e41bae43a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6b291f21-028e-4882-b002-353e41bae43a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T09:07:54+00:00",
        "updated_at": "2023-02-13T09:07:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6b291f21-028e-4882-b002-353e41bae43a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6b291f21-028e-4882-b002-353e41bae43a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6b291f21-028e-4882-b002-353e41bae43a&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T09:07:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/67f4d2e3-b412-41a1-8d66-6139a3d1a31b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "67f4d2e3-b412-41a1-8d66-6139a3d1a31b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T09:07:54+00:00",
      "updated_at": "2023-02-13T09:07:54+00:00",
      "number": "http://bqbl.it/67f4d2e3-b412-41a1-8d66-6139a3d1a31b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/067d27652d1c7f2c0ec9d2acfb1bc779/barcode/image/67f4d2e3-b412-41a1-8d66-6139a3d1a31b/0972d5b7-dd8f-41a3-88fd-9ff09f4104ac.svg",
      "owner_id": "f2a2ea8c-6804-41d3-a4f8-a215f62c5537",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f2a2ea8c-6804-41d3-a4f8-a215f62c5537"
        },
        "data": {
          "type": "customers",
          "id": "f2a2ea8c-6804-41d3-a4f8-a215f62c5537"
        }
      }
    }
  },
  "included": [
    {
      "id": "f2a2ea8c-6804-41d3-a4f8-a215f62c5537",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T09:07:54+00:00",
        "updated_at": "2023-02-13T09:07:54+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f2a2ea8c-6804-41d3-a4f8-a215f62c5537&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f2a2ea8c-6804-41d3-a4f8-a215f62c5537&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f2a2ea8c-6804-41d3-a4f8-a215f62c5537&filter[owner_type]=customers"
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
          "owner_id": "25be3118-f264-4c64-9eed-bb111f15d8f0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "aaecb872-dccc-429d-8aa1-809ad9a67790",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T09:07:55+00:00",
      "updated_at": "2023-02-13T09:07:55+00:00",
      "number": "http://bqbl.it/aaecb872-dccc-429d-8aa1-809ad9a67790",
      "barcode_type": "qr_code",
      "image_url": "/uploads/883cce4d254628f955dc58c816a5f11b/barcode/image/aaecb872-dccc-429d-8aa1-809ad9a67790/7388a61c-05f7-45ee-be2b-8409b3196994.svg",
      "owner_id": "25be3118-f264-4c64-9eed-bb111f15d8f0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d225f0a9-3d8c-45e6-8e6a-b339df49eaca' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d225f0a9-3d8c-45e6-8e6a-b339df49eaca",
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
    "id": "d225f0a9-3d8c-45e6-8e6a-b339df49eaca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T09:07:55+00:00",
      "updated_at": "2023-02-13T09:07:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/679fa1530ba3ce3b7292751c457a754d/barcode/image/d225f0a9-3d8c-45e6-8e6a-b339df49eaca/0a5ccc21-55dc-45a8-ab6b-be69693ab03e.svg",
      "owner_id": "af8b4bf6-ffd2-496e-9b0d-b83fcc1b4aaa",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8abcb174-1dc5-40c4-8e01-4c6081cd3c22' \
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