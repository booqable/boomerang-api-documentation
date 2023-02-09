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
      "id": "397c7744-b302-40f2-a94d-ba3434903bad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:18:02+00:00",
        "updated_at": "2023-02-09T10:18:02+00:00",
        "number": "http://bqbl.it/397c7744-b302-40f2-a94d-ba3434903bad",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f3e03d864a64f9b8f7b6aea34ade46d4/barcode/image/397c7744-b302-40f2-a94d-ba3434903bad/9e34beeb-865b-4066-831b-40596276746c.svg",
        "owner_id": "cfcc6785-a9ba-4680-86b4-a509a27352f7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cfcc6785-a9ba-4680-86b4-a509a27352f7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1040b012-660e-4b28-8e8c-7fa57fd238af&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1040b012-660e-4b28-8e8c-7fa57fd238af",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:18:03+00:00",
        "updated_at": "2023-02-09T10:18:03+00:00",
        "number": "http://bqbl.it/1040b012-660e-4b28-8e8c-7fa57fd238af",
        "barcode_type": "qr_code",
        "image_url": "/uploads/698eeb64f15b10904d3eb20739e7f23e/barcode/image/1040b012-660e-4b28-8e8c-7fa57fd238af/68dee079-d66b-4971-b001-0935d4d8fbf2.svg",
        "owner_id": "69000e86-6821-4b35-a1ea-c12ce74a7ef8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/69000e86-6821-4b35-a1ea-c12ce74a7ef8"
          },
          "data": {
            "type": "customers",
            "id": "69000e86-6821-4b35-a1ea-c12ce74a7ef8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "69000e86-6821-4b35-a1ea-c12ce74a7ef8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:18:02+00:00",
        "updated_at": "2023-02-09T10:18:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=69000e86-6821-4b35-a1ea-c12ce74a7ef8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=69000e86-6821-4b35-a1ea-c12ce74a7ef8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=69000e86-6821-4b35-a1ea-c12ce74a7ef8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvN2Y5NTg1M2MtMzk5OC00YTcxLTlmYTktZDJkMzY2NDk1Y2Ew&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7f95853c-3998-4a71-9fa9-d2d366495ca0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:18:03+00:00",
        "updated_at": "2023-02-09T10:18:03+00:00",
        "number": "http://bqbl.it/7f95853c-3998-4a71-9fa9-d2d366495ca0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/39db177f57a070751de8cd17a6a024e0/barcode/image/7f95853c-3998-4a71-9fa9-d2d366495ca0/e8127f36-304a-4a5e-92ad-c3b8cb993823.svg",
        "owner_id": "6b0b05bc-427e-44ba-804c-b457665a95b4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6b0b05bc-427e-44ba-804c-b457665a95b4"
          },
          "data": {
            "type": "customers",
            "id": "6b0b05bc-427e-44ba-804c-b457665a95b4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6b0b05bc-427e-44ba-804c-b457665a95b4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:18:03+00:00",
        "updated_at": "2023-02-09T10:18:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6b0b05bc-427e-44ba-804c-b457665a95b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6b0b05bc-427e-44ba-804c-b457665a95b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6b0b05bc-427e-44ba-804c-b457665a95b4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0a955560-dfd5-41a4-a657-6e7f2af22b61?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0a955560-dfd5-41a4-a657-6e7f2af22b61",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:18:04+00:00",
      "updated_at": "2023-02-09T10:18:04+00:00",
      "number": "http://bqbl.it/0a955560-dfd5-41a4-a657-6e7f2af22b61",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3a7883dba7d5632e9e473d1bb05b9ba0/barcode/image/0a955560-dfd5-41a4-a657-6e7f2af22b61/8eb9ab94-4031-466d-80ce-c4ed3683c818.svg",
      "owner_id": "cd929c4d-2979-4c70-bb0c-c084fbb16d3a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/cd929c4d-2979-4c70-bb0c-c084fbb16d3a"
        },
        "data": {
          "type": "customers",
          "id": "cd929c4d-2979-4c70-bb0c-c084fbb16d3a"
        }
      }
    }
  },
  "included": [
    {
      "id": "cd929c4d-2979-4c70-bb0c-c084fbb16d3a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:18:04+00:00",
        "updated_at": "2023-02-09T10:18:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cd929c4d-2979-4c70-bb0c-c084fbb16d3a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cd929c4d-2979-4c70-bb0c-c084fbb16d3a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cd929c4d-2979-4c70-bb0c-c084fbb16d3a&filter[owner_type]=customers"
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
          "owner_id": "453d0838-b8a5-4268-ac66-5f6585e277d3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "054070d6-9cb8-4ba8-ac1d-d3f23aaf06ac",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:18:05+00:00",
      "updated_at": "2023-02-09T10:18:05+00:00",
      "number": "http://bqbl.it/054070d6-9cb8-4ba8-ac1d-d3f23aaf06ac",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3beb32635eef085fc0bcd9aec42992fd/barcode/image/054070d6-9cb8-4ba8-ac1d-d3f23aaf06ac/72b5e061-819a-4d18-aff2-61aaa628801f.svg",
      "owner_id": "453d0838-b8a5-4268-ac66-5f6585e277d3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fea22ab3-ba9e-442c-a0e9-1e2bd979bc16' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fea22ab3-ba9e-442c-a0e9-1e2bd979bc16",
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
    "id": "fea22ab3-ba9e-442c-a0e9-1e2bd979bc16",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:18:05+00:00",
      "updated_at": "2023-02-09T10:18:05+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1af19d1701d70702b028f3127c2ae283/barcode/image/fea22ab3-ba9e-442c-a0e9-1e2bd979bc16/bf6a537e-48b1-44a9-b18b-fcae73d8a2a8.svg",
      "owner_id": "06e14fdf-5250-4c54-8884-d2d6595d9904",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/042e7a15-e8b0-4a7f-9b68-afcf0462a2b0' \
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