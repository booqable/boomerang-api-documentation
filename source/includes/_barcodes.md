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
      "id": "473188d5-6753-44b9-922a-429c05ef0bdc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T09:33:26+00:00",
        "updated_at": "2023-03-09T09:33:26+00:00",
        "number": "http://bqbl.it/473188d5-6753-44b9-922a-429c05ef0bdc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d6f211ddb048b8e905e56100c06c3abc/barcode/image/473188d5-6753-44b9-922a-429c05ef0bdc/0a333561-e2ff-4cb6-b9c8-f9e80a1a7990.svg",
        "owner_id": "bae055a7-49fb-462a-91b2-6f40d972803d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bae055a7-49fb-462a-91b2-6f40d972803d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9d91db38-ed37-48a6-b221-16c00285b57a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9d91db38-ed37-48a6-b221-16c00285b57a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T09:33:26+00:00",
        "updated_at": "2023-03-09T09:33:26+00:00",
        "number": "http://bqbl.it/9d91db38-ed37-48a6-b221-16c00285b57a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/64399725a25b6d1653674b8121e5376f/barcode/image/9d91db38-ed37-48a6-b221-16c00285b57a/eebef0d4-6a12-457f-83ff-fa7811aa4963.svg",
        "owner_id": "6882ff2b-2412-4828-b837-635ad8a4d76a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6882ff2b-2412-4828-b837-635ad8a4d76a"
          },
          "data": {
            "type": "customers",
            "id": "6882ff2b-2412-4828-b837-635ad8a4d76a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6882ff2b-2412-4828-b837-635ad8a4d76a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T09:33:26+00:00",
        "updated_at": "2023-03-09T09:33:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6882ff2b-2412-4828-b837-635ad8a4d76a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6882ff2b-2412-4828-b837-635ad8a4d76a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6882ff2b-2412-4828-b837-635ad8a4d76a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTFmNTNlM2QtYTdhMC00N2U1LWEyYjQtOTcwNzgxZDk0Njcx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "11f53e3d-a7a0-47e5-a2b4-970781d94671",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-09T09:33:27+00:00",
        "updated_at": "2023-03-09T09:33:27+00:00",
        "number": "http://bqbl.it/11f53e3d-a7a0-47e5-a2b4-970781d94671",
        "barcode_type": "qr_code",
        "image_url": "/uploads/baee76b9bc0912f9ae2b26b0b762bbb0/barcode/image/11f53e3d-a7a0-47e5-a2b4-970781d94671/7dd02230-c206-41a5-b117-9ff4a8ae593f.svg",
        "owner_id": "373c7da2-dd39-4c7e-9357-f31ffc2e16c0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/373c7da2-dd39-4c7e-9357-f31ffc2e16c0"
          },
          "data": {
            "type": "customers",
            "id": "373c7da2-dd39-4c7e-9357-f31ffc2e16c0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "373c7da2-dd39-4c7e-9357-f31ffc2e16c0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T09:33:27+00:00",
        "updated_at": "2023-03-09T09:33:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=373c7da2-dd39-4c7e-9357-f31ffc2e16c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=373c7da2-dd39-4c7e-9357-f31ffc2e16c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=373c7da2-dd39-4c7e-9357-f31ffc2e16c0&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T09:33:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/42fa22c6-bc4e-460b-a611-f1bdd325a4e4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "42fa22c6-bc4e-460b-a611-f1bdd325a4e4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T09:33:27+00:00",
      "updated_at": "2023-03-09T09:33:27+00:00",
      "number": "http://bqbl.it/42fa22c6-bc4e-460b-a611-f1bdd325a4e4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d75c44ab388473112f582c7a0fcd6379/barcode/image/42fa22c6-bc4e-460b-a611-f1bdd325a4e4/dedefe61-87e4-4c87-ae5a-e725477db9ad.svg",
      "owner_id": "99064cfc-8628-4173-8867-ade67fe86e2f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/99064cfc-8628-4173-8867-ade67fe86e2f"
        },
        "data": {
          "type": "customers",
          "id": "99064cfc-8628-4173-8867-ade67fe86e2f"
        }
      }
    }
  },
  "included": [
    {
      "id": "99064cfc-8628-4173-8867-ade67fe86e2f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T09:33:27+00:00",
        "updated_at": "2023-03-09T09:33:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=99064cfc-8628-4173-8867-ade67fe86e2f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=99064cfc-8628-4173-8867-ade67fe86e2f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=99064cfc-8628-4173-8867-ade67fe86e2f&filter[owner_type]=customers"
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
          "owner_id": "bf629ea8-0219-4afb-ba30-b6777159a396",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7ce36a8e-307b-4516-9151-8939acac3b19",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T09:33:28+00:00",
      "updated_at": "2023-03-09T09:33:28+00:00",
      "number": "http://bqbl.it/7ce36a8e-307b-4516-9151-8939acac3b19",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ab383dc1ae0412e4cbe30bf0783fe486/barcode/image/7ce36a8e-307b-4516-9151-8939acac3b19/9624347c-82bd-4f44-8dc6-668d60606e23.svg",
      "owner_id": "bf629ea8-0219-4afb-ba30-b6777159a396",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cd80d136-8350-46d3-9633-9448c1758b20' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cd80d136-8350-46d3-9633-9448c1758b20",
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
    "id": "cd80d136-8350-46d3-9633-9448c1758b20",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-09T09:33:28+00:00",
      "updated_at": "2023-03-09T09:33:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/026b0c6d7d9e16aad4429045bd31d507/barcode/image/cd80d136-8350-46d3-9633-9448c1758b20/c2a268ea-05b1-42f8-8fa8-f0816dbe4087.svg",
      "owner_id": "eb070fd0-6feb-457c-99e6-0ab390bdbf92",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/939354ac-48b0-4088-a4fb-f91a3856e1eb' \
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