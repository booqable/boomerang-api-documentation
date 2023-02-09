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
      "id": "322fe2a6-db02-43b5-8f45-5082257963e7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T09:39:00+00:00",
        "updated_at": "2023-02-09T09:39:00+00:00",
        "number": "http://bqbl.it/322fe2a6-db02-43b5-8f45-5082257963e7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d6358054b2f1024751a6aae707868b6f/barcode/image/322fe2a6-db02-43b5-8f45-5082257963e7/66de83ae-c284-4e5a-98d4-911297b527bb.svg",
        "owner_id": "f5d888f4-f28b-42c8-a860-b689c323c3d5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f5d888f4-f28b-42c8-a860-b689c323c3d5"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb6405239-d361-4cc0-897c-22b8f9d05f32&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b6405239-d361-4cc0-897c-22b8f9d05f32",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T09:39:00+00:00",
        "updated_at": "2023-02-09T09:39:00+00:00",
        "number": "http://bqbl.it/b6405239-d361-4cc0-897c-22b8f9d05f32",
        "barcode_type": "qr_code",
        "image_url": "/uploads/714547d0052ff1b60cbc8a14350180da/barcode/image/b6405239-d361-4cc0-897c-22b8f9d05f32/43eba027-9194-414a-86d8-f6ce7ae7c68d.svg",
        "owner_id": "4dfb6cd2-b827-49b2-a370-561d61663d43",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4dfb6cd2-b827-49b2-a370-561d61663d43"
          },
          "data": {
            "type": "customers",
            "id": "4dfb6cd2-b827-49b2-a370-561d61663d43"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4dfb6cd2-b827-49b2-a370-561d61663d43",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T09:39:00+00:00",
        "updated_at": "2023-02-09T09:39:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4dfb6cd2-b827-49b2-a370-561d61663d43&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4dfb6cd2-b827-49b2-a370-561d61663d43&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4dfb6cd2-b827-49b2-a370-561d61663d43&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzI1ZDgzNWQtYzBjZS00Y2E1LTlmY2EtYWE0OTVkNzhhNTA1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c25d835d-c0ce-4ca5-9fca-aa495d78a505",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T09:39:01+00:00",
        "updated_at": "2023-02-09T09:39:01+00:00",
        "number": "http://bqbl.it/c25d835d-c0ce-4ca5-9fca-aa495d78a505",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8c6e980c19e81c76383946ea7aa32a92/barcode/image/c25d835d-c0ce-4ca5-9fca-aa495d78a505/560c97a3-7d92-4fe5-9e3b-8ed35875d351.svg",
        "owner_id": "004efc79-9773-4ed5-a35d-884a813902ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/004efc79-9773-4ed5-a35d-884a813902ec"
          },
          "data": {
            "type": "customers",
            "id": "004efc79-9773-4ed5-a35d-884a813902ec"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "004efc79-9773-4ed5-a35d-884a813902ec",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T09:39:01+00:00",
        "updated_at": "2023-02-09T09:39:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=004efc79-9773-4ed5-a35d-884a813902ec&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=004efc79-9773-4ed5-a35d-884a813902ec&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=004efc79-9773-4ed5-a35d-884a813902ec&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T09:38:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1f6a98b9-c123-4e66-9701-dcc58a686783?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1f6a98b9-c123-4e66-9701-dcc58a686783",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T09:39:02+00:00",
      "updated_at": "2023-02-09T09:39:02+00:00",
      "number": "http://bqbl.it/1f6a98b9-c123-4e66-9701-dcc58a686783",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ddf12b2e42768f084fe4f99592ba530b/barcode/image/1f6a98b9-c123-4e66-9701-dcc58a686783/4c590f93-9b07-44e6-84d2-40f4746bb4b6.svg",
      "owner_id": "57d69bb1-0ced-4a10-801e-b311f622674e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/57d69bb1-0ced-4a10-801e-b311f622674e"
        },
        "data": {
          "type": "customers",
          "id": "57d69bb1-0ced-4a10-801e-b311f622674e"
        }
      }
    }
  },
  "included": [
    {
      "id": "57d69bb1-0ced-4a10-801e-b311f622674e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T09:39:02+00:00",
        "updated_at": "2023-02-09T09:39:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=57d69bb1-0ced-4a10-801e-b311f622674e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57d69bb1-0ced-4a10-801e-b311f622674e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57d69bb1-0ced-4a10-801e-b311f622674e&filter[owner_type]=customers"
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
          "owner_id": "d97f6694-15fe-4bdb-a8e1-e5bd2bbfeabe",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a9797cef-47f7-44ee-ab96-fc6d5cbacd70",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T09:39:03+00:00",
      "updated_at": "2023-02-09T09:39:03+00:00",
      "number": "http://bqbl.it/a9797cef-47f7-44ee-ab96-fc6d5cbacd70",
      "barcode_type": "qr_code",
      "image_url": "/uploads/175bcfe69862ddce261077d04ec0b397/barcode/image/a9797cef-47f7-44ee-ab96-fc6d5cbacd70/8befb891-8744-431c-ac67-746c8c531e15.svg",
      "owner_id": "d97f6694-15fe-4bdb-a8e1-e5bd2bbfeabe",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5717955e-b792-46d2-b76b-fc630156b00f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5717955e-b792-46d2-b76b-fc630156b00f",
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
    "id": "5717955e-b792-46d2-b76b-fc630156b00f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T09:39:04+00:00",
      "updated_at": "2023-02-09T09:39:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e254c09b2f2a029f47ce7a84cd4cc8c9/barcode/image/5717955e-b792-46d2-b76b-fc630156b00f/b622da5e-0e37-41a5-8338-92a84dba6961.svg",
      "owner_id": "44de7a6d-4425-457d-8532-bfa30970f519",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/719f5957-993e-458c-8e90-08e48edadd17' \
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