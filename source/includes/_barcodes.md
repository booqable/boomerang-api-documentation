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
      "id": "f89b160a-b1fb-41a9-b215-de7da0da936c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-08T13:51:59+00:00",
        "updated_at": "2022-11-08T13:51:59+00:00",
        "number": "http://bqbl.it/f89b160a-b1fb-41a9-b215-de7da0da936c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/519e881b7632b9bf711e484bcf4fed14/barcode/image/f89b160a-b1fb-41a9-b215-de7da0da936c/90ba3996-ba2a-4234-aa65-92934fe495ad.svg",
        "owner_id": "3435b4f1-c801-49bb-9309-aef7a15eb4e1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3435b4f1-c801-49bb-9309-aef7a15eb4e1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8fd365a7-847d-4d75-8739-effd39602955&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8fd365a7-847d-4d75-8739-effd39602955",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-08T13:51:59+00:00",
        "updated_at": "2022-11-08T13:51:59+00:00",
        "number": "http://bqbl.it/8fd365a7-847d-4d75-8739-effd39602955",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c5114130500f56cdf4b3ffa8f446d497/barcode/image/8fd365a7-847d-4d75-8739-effd39602955/95f45a06-90ee-43c1-99bf-58842f4f9c72.svg",
        "owner_id": "7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a"
          },
          "data": {
            "type": "customers",
            "id": "7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-08T13:51:59+00:00",
        "updated_at": "2022-11-08T13:51:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7b0fa3b4-5a59-4a65-9f9f-7bada94e9f3a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzcyZWQyYTEtMDMwNi00ZGM2LWJiZWYtNGFhMDQ2ZjE0MGJm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c72ed2a1-0306-4dc6-bbef-4aa046f140bf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-08T13:52:00+00:00",
        "updated_at": "2022-11-08T13:52:00+00:00",
        "number": "http://bqbl.it/c72ed2a1-0306-4dc6-bbef-4aa046f140bf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3233d866f915ae36a3a9a3f2bbf972c6/barcode/image/c72ed2a1-0306-4dc6-bbef-4aa046f140bf/3d0fa5b3-22a2-4024-84a4-ca9c72692602.svg",
        "owner_id": "9cc329dd-0101-40db-9a1e-be102314a519",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9cc329dd-0101-40db-9a1e-be102314a519"
          },
          "data": {
            "type": "customers",
            "id": "9cc329dd-0101-40db-9a1e-be102314a519"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9cc329dd-0101-40db-9a1e-be102314a519",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-08T13:52:00+00:00",
        "updated_at": "2022-11-08T13:52:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9cc329dd-0101-40db-9a1e-be102314a519&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9cc329dd-0101-40db-9a1e-be102314a519&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9cc329dd-0101-40db-9a1e-be102314a519&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-08T13:51:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd81068a-4f58-4d0c-b99e-c39c7833f3f9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dd81068a-4f58-4d0c-b99e-c39c7833f3f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-08T13:52:00+00:00",
      "updated_at": "2022-11-08T13:52:00+00:00",
      "number": "http://bqbl.it/dd81068a-4f58-4d0c-b99e-c39c7833f3f9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f57705dc6d89e45b1486624d7c170dfd/barcode/image/dd81068a-4f58-4d0c-b99e-c39c7833f3f9/f5b7d128-9f96-4a83-ad48-62f0108fd19e.svg",
      "owner_id": "2567c941-be59-4b55-b2d0-c09c6cda66fb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2567c941-be59-4b55-b2d0-c09c6cda66fb"
        },
        "data": {
          "type": "customers",
          "id": "2567c941-be59-4b55-b2d0-c09c6cda66fb"
        }
      }
    }
  },
  "included": [
    {
      "id": "2567c941-be59-4b55-b2d0-c09c6cda66fb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-08T13:52:00+00:00",
        "updated_at": "2022-11-08T13:52:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2567c941-be59-4b55-b2d0-c09c6cda66fb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2567c941-be59-4b55-b2d0-c09c6cda66fb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2567c941-be59-4b55-b2d0-c09c6cda66fb&filter[owner_type]=customers"
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
          "owner_id": "53b37b41-85c5-414f-9a73-99a3aba5213d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5ce1bb96-825e-40f1-a274-591e967abad1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-08T13:52:01+00:00",
      "updated_at": "2022-11-08T13:52:01+00:00",
      "number": "http://bqbl.it/5ce1bb96-825e-40f1-a274-591e967abad1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0b61a6868c77b48f60b3fe3a1a84db4f/barcode/image/5ce1bb96-825e-40f1-a274-591e967abad1/c8a3e954-4f4f-4c14-9150-8ebb18660e61.svg",
      "owner_id": "53b37b41-85c5-414f-9a73-99a3aba5213d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/16e5aa40-814d-4ac4-bfa8-d47efe66597d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "16e5aa40-814d-4ac4-bfa8-d47efe66597d",
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
    "id": "16e5aa40-814d-4ac4-bfa8-d47efe66597d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-08T13:52:01+00:00",
      "updated_at": "2022-11-08T13:52:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6b965db3ab0e9c04da2ecc8026f66f1f/barcode/image/16e5aa40-814d-4ac4-bfa8-d47efe66597d/ad5be341-8d48-4fa8-9af9-d09173054235.svg",
      "owner_id": "e2ca465e-bf88-46f2-87b9-77c22dcf9134",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df304054-2999-4c7f-823b-88560f3e32fb' \
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