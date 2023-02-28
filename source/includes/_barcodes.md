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
      "id": "443b6e71-0526-4d47-b317-82093ffcd542",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T07:29:22+00:00",
        "updated_at": "2023-02-28T07:29:22+00:00",
        "number": "http://bqbl.it/443b6e71-0526-4d47-b317-82093ffcd542",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4592397e64c729cd89ed4e65d5504a08/barcode/image/443b6e71-0526-4d47-b317-82093ffcd542/de12ceaf-23c9-4e69-81d7-d288d71ba7a0.svg",
        "owner_id": "3b5f61fb-247d-4502-b4be-9fba15c7a344",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3b5f61fb-247d-4502-b4be-9fba15c7a344"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F302ac266-472c-4857-8ee5-899cdce0388a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "302ac266-472c-4857-8ee5-899cdce0388a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T07:29:23+00:00",
        "updated_at": "2023-02-28T07:29:23+00:00",
        "number": "http://bqbl.it/302ac266-472c-4857-8ee5-899cdce0388a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b2a4d92a269e1e73991dd91b30c51b74/barcode/image/302ac266-472c-4857-8ee5-899cdce0388a/f3ea29f0-8330-443f-9d4a-1accf77ff527.svg",
        "owner_id": "587a846a-b422-40ba-904a-74ba7e83fca7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/587a846a-b422-40ba-904a-74ba7e83fca7"
          },
          "data": {
            "type": "customers",
            "id": "587a846a-b422-40ba-904a-74ba7e83fca7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "587a846a-b422-40ba-904a-74ba7e83fca7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T07:29:23+00:00",
        "updated_at": "2023-02-28T07:29:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=587a846a-b422-40ba-904a-74ba7e83fca7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=587a846a-b422-40ba-904a-74ba7e83fca7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=587a846a-b422-40ba-904a-74ba7e83fca7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjVjYTJhZWEtNDE0YS00NGEzLWFmNmItOTIxNGU2MDdjNDFi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b5ca2aea-414a-44a3-af6b-9214e607c41b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T07:29:23+00:00",
        "updated_at": "2023-02-28T07:29:23+00:00",
        "number": "http://bqbl.it/b5ca2aea-414a-44a3-af6b-9214e607c41b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d98109ac0e228c227c6b054ea9597110/barcode/image/b5ca2aea-414a-44a3-af6b-9214e607c41b/8fe8ce1d-6020-4b6c-8883-925ed95c51b7.svg",
        "owner_id": "8688e159-c0db-484b-a209-abbf00ce8956",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8688e159-c0db-484b-a209-abbf00ce8956"
          },
          "data": {
            "type": "customers",
            "id": "8688e159-c0db-484b-a209-abbf00ce8956"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8688e159-c0db-484b-a209-abbf00ce8956",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T07:29:23+00:00",
        "updated_at": "2023-02-28T07:29:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8688e159-c0db-484b-a209-abbf00ce8956&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8688e159-c0db-484b-a209-abbf00ce8956&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8688e159-c0db-484b-a209-abbf00ce8956&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T07:29:00Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/147afdd3-1e2d-4990-b705-7ea530857f1e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "147afdd3-1e2d-4990-b705-7ea530857f1e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T07:29:24+00:00",
      "updated_at": "2023-02-28T07:29:24+00:00",
      "number": "http://bqbl.it/147afdd3-1e2d-4990-b705-7ea530857f1e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/533fa0221135f4faab156a623863db05/barcode/image/147afdd3-1e2d-4990-b705-7ea530857f1e/b3393ce0-8f5f-4c4b-81c9-533302555393.svg",
      "owner_id": "e1643034-e6fb-44ab-bb98-a359ca1abb8a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e1643034-e6fb-44ab-bb98-a359ca1abb8a"
        },
        "data": {
          "type": "customers",
          "id": "e1643034-e6fb-44ab-bb98-a359ca1abb8a"
        }
      }
    }
  },
  "included": [
    {
      "id": "e1643034-e6fb-44ab-bb98-a359ca1abb8a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T07:29:24+00:00",
        "updated_at": "2023-02-28T07:29:24+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e1643034-e6fb-44ab-bb98-a359ca1abb8a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e1643034-e6fb-44ab-bb98-a359ca1abb8a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e1643034-e6fb-44ab-bb98-a359ca1abb8a&filter[owner_type]=customers"
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
          "owner_id": "6aa03dbe-b93e-4113-b082-618ba32f0ba0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6c8749ce-ee31-4da1-8cee-aad48abc5cce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T07:29:24+00:00",
      "updated_at": "2023-02-28T07:29:24+00:00",
      "number": "http://bqbl.it/6c8749ce-ee31-4da1-8cee-aad48abc5cce",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7d8a74ca07aa0da68ddc9d246e78b35f/barcode/image/6c8749ce-ee31-4da1-8cee-aad48abc5cce/259fad50-c7e8-4b26-8b16-b6076dafb6b5.svg",
      "owner_id": "6aa03dbe-b93e-4113-b082-618ba32f0ba0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a7b6cbb4-baf0-49c9-8590-7c27f30bf49b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a7b6cbb4-baf0-49c9-8590-7c27f30bf49b",
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
    "id": "a7b6cbb4-baf0-49c9-8590-7c27f30bf49b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T07:29:25+00:00",
      "updated_at": "2023-02-28T07:29:25+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c26eb91574f9e9c1ef444db7c1ac5917/barcode/image/a7b6cbb4-baf0-49c9-8590-7c27f30bf49b/9c5010ec-6cef-4bb6-8395-b4ec40968c0b.svg",
      "owner_id": "634fd670-4113-4836-9c1a-210ac0f1ee00",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/98c677e1-155b-40e5-8e8f-4324c28c0d23' \
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