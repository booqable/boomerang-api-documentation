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
      "id": "5a891e14-9d86-46bd-95b2-a0c19482a117",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T13:54:18+00:00",
        "updated_at": "2023-03-02T13:54:18+00:00",
        "number": "http://bqbl.it/5a891e14-9d86-46bd-95b2-a0c19482a117",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ab9252fe2de43603a455cfbdf6daa0b2/barcode/image/5a891e14-9d86-46bd-95b2-a0c19482a117/d29361b8-2007-4e94-854d-6ea363a04b36.svg",
        "owner_id": "96ada370-f240-4eba-8de6-809514da09c1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96ada370-f240-4eba-8de6-809514da09c1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa5e11e8b-52a2-423a-82ed-cda951820c3c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a5e11e8b-52a2-423a-82ed-cda951820c3c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T13:54:18+00:00",
        "updated_at": "2023-03-02T13:54:18+00:00",
        "number": "http://bqbl.it/a5e11e8b-52a2-423a-82ed-cda951820c3c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b9118218394147d38e959f06d48c2639/barcode/image/a5e11e8b-52a2-423a-82ed-cda951820c3c/dd3df613-cf91-4e86-9b05-543bc0598f39.svg",
        "owner_id": "6861d479-ef86-4dc7-a00f-05e4a3fd807a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6861d479-ef86-4dc7-a00f-05e4a3fd807a"
          },
          "data": {
            "type": "customers",
            "id": "6861d479-ef86-4dc7-a00f-05e4a3fd807a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6861d479-ef86-4dc7-a00f-05e4a3fd807a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T13:54:18+00:00",
        "updated_at": "2023-03-02T13:54:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6861d479-ef86-4dc7-a00f-05e4a3fd807a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6861d479-ef86-4dc7-a00f-05e4a3fd807a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6861d479-ef86-4dc7-a00f-05e4a3fd807a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDY2YWZhZWMtOGViNy00ODc4LWI3ZTktMzVlZDJjZTMwMjgw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d66afaec-8eb7-4878-b7e9-35ed2ce30280",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T13:54:19+00:00",
        "updated_at": "2023-03-02T13:54:19+00:00",
        "number": "http://bqbl.it/d66afaec-8eb7-4878-b7e9-35ed2ce30280",
        "barcode_type": "qr_code",
        "image_url": "/uploads/122627298888fd96af71ec9e84ac9108/barcode/image/d66afaec-8eb7-4878-b7e9-35ed2ce30280/e7bb0a44-ba25-4ff8-a7bc-dadf2a3babcd.svg",
        "owner_id": "0be04215-56fc-47a3-9ac2-ef9636dee018",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0be04215-56fc-47a3-9ac2-ef9636dee018"
          },
          "data": {
            "type": "customers",
            "id": "0be04215-56fc-47a3-9ac2-ef9636dee018"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0be04215-56fc-47a3-9ac2-ef9636dee018",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T13:54:19+00:00",
        "updated_at": "2023-03-02T13:54:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0be04215-56fc-47a3-9ac2-ef9636dee018&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0be04215-56fc-47a3-9ac2-ef9636dee018&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0be04215-56fc-47a3-9ac2-ef9636dee018&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T13:53:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/75ca87f6-2520-439a-8103-6a9756e81158?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "75ca87f6-2520-439a-8103-6a9756e81158",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T13:54:19+00:00",
      "updated_at": "2023-03-02T13:54:19+00:00",
      "number": "http://bqbl.it/75ca87f6-2520-439a-8103-6a9756e81158",
      "barcode_type": "qr_code",
      "image_url": "/uploads/692e6e8820b7ab789bc9fde92377569e/barcode/image/75ca87f6-2520-439a-8103-6a9756e81158/15f23631-59ab-4589-bec2-615072c5cc1e.svg",
      "owner_id": "d42f8a49-6090-4eff-801c-1ad143dfb30d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d42f8a49-6090-4eff-801c-1ad143dfb30d"
        },
        "data": {
          "type": "customers",
          "id": "d42f8a49-6090-4eff-801c-1ad143dfb30d"
        }
      }
    }
  },
  "included": [
    {
      "id": "d42f8a49-6090-4eff-801c-1ad143dfb30d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T13:54:19+00:00",
        "updated_at": "2023-03-02T13:54:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d42f8a49-6090-4eff-801c-1ad143dfb30d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d42f8a49-6090-4eff-801c-1ad143dfb30d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d42f8a49-6090-4eff-801c-1ad143dfb30d&filter[owner_type]=customers"
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
          "owner_id": "a1cb406a-f3c7-4876-a86f-7f84e17554ba",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "666beb35-e122-4386-8f8f-c5c8b445719a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T13:54:20+00:00",
      "updated_at": "2023-03-02T13:54:20+00:00",
      "number": "http://bqbl.it/666beb35-e122-4386-8f8f-c5c8b445719a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1ed41cfc73fb537e47454575e1ac91ac/barcode/image/666beb35-e122-4386-8f8f-c5c8b445719a/7c331cdf-07db-438f-a6a3-71043697ef26.svg",
      "owner_id": "a1cb406a-f3c7-4876-a86f-7f84e17554ba",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/56de37c9-70fa-4fb9-94da-d96bde3b8856' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "56de37c9-70fa-4fb9-94da-d96bde3b8856",
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
    "id": "56de37c9-70fa-4fb9-94da-d96bde3b8856",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T13:54:20+00:00",
      "updated_at": "2023-03-02T13:54:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d28a017765c16b95af85992c770f5063/barcode/image/56de37c9-70fa-4fb9-94da-d96bde3b8856/2137ec54-8e95-4cb3-bbe6-445fbfb573b2.svg",
      "owner_id": "4559ef44-b177-43f8-a9e9-add6425b210e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b5c7415f-2093-43f6-922c-c52c167e6b02' \
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