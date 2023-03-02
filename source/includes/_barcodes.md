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
      "id": "5d3626c2-162f-4b33-8f8c-4ad9dfad96dd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T12:39:18+00:00",
        "updated_at": "2023-03-02T12:39:18+00:00",
        "number": "http://bqbl.it/5d3626c2-162f-4b33-8f8c-4ad9dfad96dd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0d52a712b1ecc9ab917b8daade9699d7/barcode/image/5d3626c2-162f-4b33-8f8c-4ad9dfad96dd/c1ca33a6-f571-4585-8672-e9077363ee91.svg",
        "owner_id": "708987d4-c96d-4127-9396-bc9a80917099",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/708987d4-c96d-4127-9396-bc9a80917099"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F35fb3ea3-d31a-4e2d-9603-3c1a582cbda8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "35fb3ea3-d31a-4e2d-9603-3c1a582cbda8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T12:39:18+00:00",
        "updated_at": "2023-03-02T12:39:18+00:00",
        "number": "http://bqbl.it/35fb3ea3-d31a-4e2d-9603-3c1a582cbda8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a50c05bd64ffcda2f644eea9e6568d99/barcode/image/35fb3ea3-d31a-4e2d-9603-3c1a582cbda8/3ffb3a98-14ff-4d55-86f2-1d01af3c0ffd.svg",
        "owner_id": "c69334fc-5ffa-4ba6-b385-2fb868732cf5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c69334fc-5ffa-4ba6-b385-2fb868732cf5"
          },
          "data": {
            "type": "customers",
            "id": "c69334fc-5ffa-4ba6-b385-2fb868732cf5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c69334fc-5ffa-4ba6-b385-2fb868732cf5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T12:39:18+00:00",
        "updated_at": "2023-03-02T12:39:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c69334fc-5ffa-4ba6-b385-2fb868732cf5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c69334fc-5ffa-4ba6-b385-2fb868732cf5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c69334fc-5ffa-4ba6-b385-2fb868732cf5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvY2RiM2Y3ZDctMzliOC00OTVmLThlOTctNjQzYmUxYTM3YmRh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cdb3f7d7-39b8-495f-8e97-643be1a37bda",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T12:39:19+00:00",
        "updated_at": "2023-03-02T12:39:19+00:00",
        "number": "http://bqbl.it/cdb3f7d7-39b8-495f-8e97-643be1a37bda",
        "barcode_type": "qr_code",
        "image_url": "/uploads/08a4d364bae5f6b41bf619cc3ed11a3a/barcode/image/cdb3f7d7-39b8-495f-8e97-643be1a37bda/c0ddc1a8-92d6-4ab3-9440-74178899b416.svg",
        "owner_id": "2c98bc00-b657-41f4-8ca7-a7af71ff21d4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2c98bc00-b657-41f4-8ca7-a7af71ff21d4"
          },
          "data": {
            "type": "customers",
            "id": "2c98bc00-b657-41f4-8ca7-a7af71ff21d4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2c98bc00-b657-41f4-8ca7-a7af71ff21d4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T12:39:19+00:00",
        "updated_at": "2023-03-02T12:39:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2c98bc00-b657-41f4-8ca7-a7af71ff21d4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2c98bc00-b657-41f4-8ca7-a7af71ff21d4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2c98bc00-b657-41f4-8ca7-a7af71ff21d4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T12:39:02Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a7443ae6-e0e3-4b02-b45f-466303254f18?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a7443ae6-e0e3-4b02-b45f-466303254f18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T12:39:19+00:00",
      "updated_at": "2023-03-02T12:39:19+00:00",
      "number": "http://bqbl.it/a7443ae6-e0e3-4b02-b45f-466303254f18",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fd15e2af91233c78b85155d9a9e3edc4/barcode/image/a7443ae6-e0e3-4b02-b45f-466303254f18/9eb18d3c-bbc5-493c-b7c8-e75b5d1237be.svg",
      "owner_id": "34644d96-c73c-449b-8fab-5e47a7b2fcd0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/34644d96-c73c-449b-8fab-5e47a7b2fcd0"
        },
        "data": {
          "type": "customers",
          "id": "34644d96-c73c-449b-8fab-5e47a7b2fcd0"
        }
      }
    }
  },
  "included": [
    {
      "id": "34644d96-c73c-449b-8fab-5e47a7b2fcd0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T12:39:19+00:00",
        "updated_at": "2023-03-02T12:39:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=34644d96-c73c-449b-8fab-5e47a7b2fcd0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=34644d96-c73c-449b-8fab-5e47a7b2fcd0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=34644d96-c73c-449b-8fab-5e47a7b2fcd0&filter[owner_type]=customers"
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
          "owner_id": "b16695bb-e055-4fd6-a01b-95b4f02f015b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "00b3a69d-4608-480a-87b0-2650da1dc257",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T12:39:20+00:00",
      "updated_at": "2023-03-02T12:39:20+00:00",
      "number": "http://bqbl.it/00b3a69d-4608-480a-87b0-2650da1dc257",
      "barcode_type": "qr_code",
      "image_url": "/uploads/afaa3757ebe964f0e8fb162f2ace52c5/barcode/image/00b3a69d-4608-480a-87b0-2650da1dc257/ceff3387-57fe-4788-8ad2-8f36777ade74.svg",
      "owner_id": "b16695bb-e055-4fd6-a01b-95b4f02f015b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/34577a57-452f-4b81-adc9-7d19e266647a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "34577a57-452f-4b81-adc9-7d19e266647a",
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
    "id": "34577a57-452f-4b81-adc9-7d19e266647a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T12:39:21+00:00",
      "updated_at": "2023-03-02T12:39:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d2b8134f4044030b50f358428178b807/barcode/image/34577a57-452f-4b81-adc9-7d19e266647a/7ff54f18-8fd2-4494-a258-37a80aa8a2d1.svg",
      "owner_id": "1a08a510-6a4f-46d3-aa6c-8ca919aa7673",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1440b00a-582c-4401-b556-feddbd4f92f9' \
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