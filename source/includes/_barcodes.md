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

`POST /api/boomerang/barcodes`

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`PUT /api/boomerang/barcodes/{id}`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbc15b9ce-c7d3-474f-92ae-9f65589d9a4a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bc15b9ce-c7d3-474f-92ae-9f65589d9a4a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-09T07:43:25+00:00",
        "updated_at": "2024-04-09T07:43:25+00:00",
        "number": "http://bqbl.it/bc15b9ce-c7d3-474f-92ae-9f65589d9a4a",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-284.lvh.me:/barcodes/bc15b9ce-c7d3-474f-92ae-9f65589d9a4a/image",
        "owner_id": "61353b6b-54c6-4a47-a2a0-c630905d7313",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/61353b6b-54c6-4a47-a2a0-c630905d7313"
          },
          "data": {
            "type": "customers",
            "id": "61353b6b-54c6-4a47-a2a0-c630905d7313"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "61353b6b-54c6-4a47-a2a0-c630905d7313",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-09T07:43:25+00:00",
        "updated_at": "2024-04-09T07:43:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-70@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=61353b6b-54c6-4a47-a2a0-c630905d7313&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=61353b6b-54c6-4a47-a2a0-c630905d7313&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=61353b6b-54c6-4a47-a2a0-c630905d7313&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTQyMTdiMTktYTI3My00M2VjLTk2ZGYtNTJlMzJlZWIyMTcy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "54217b19-a273-43ec-96df-52e32eeb2172",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-09T07:43:26+00:00",
        "updated_at": "2024-04-09T07:43:26+00:00",
        "number": "http://bqbl.it/54217b19-a273-43ec-96df-52e32eeb2172",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-285.lvh.me:/barcodes/54217b19-a273-43ec-96df-52e32eeb2172/image",
        "owner_id": "2049580e-d6f4-4a42-ae7d-fb1798eff75b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2049580e-d6f4-4a42-ae7d-fb1798eff75b"
          },
          "data": {
            "type": "customers",
            "id": "2049580e-d6f4-4a42-ae7d-fb1798eff75b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2049580e-d6f4-4a42-ae7d-fb1798eff75b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-09T07:43:26+00:00",
        "updated_at": "2024-04-09T07:43:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-72@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=2049580e-d6f4-4a42-ae7d-fb1798eff75b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2049580e-d6f4-4a42-ae7d-fb1798eff75b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2049580e-d6f4-4a42-ae7d-fb1798eff75b&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "918f6b74-6ed4-40e7-b474-d47d549c9e92",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-09T07:43:27+00:00",
        "updated_at": "2024-04-09T07:43:27+00:00",
        "number": "http://bqbl.it/918f6b74-6ed4-40e7-b474-d47d549c9e92",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-286.lvh.me:/barcodes/918f6b74-6ed4-40e7-b474-d47d549c9e92/image",
        "owner_id": "f90f8364-bb2b-4b97-91e4-1197e81c13b1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f90f8364-bb2b-4b97-91e4-1197e81c13b1"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


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
          "owner_id": "b8ba56a9-1076-49b7-842a-b07480b1f9b7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "79f47345-2834-4ddd-89da-da4b13260c92",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-09T07:43:28+00:00",
      "updated_at": "2024-04-09T07:43:28+00:00",
      "number": "http://bqbl.it/79f47345-2834-4ddd-89da-da4b13260c92",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-287.lvh.me:/barcodes/79f47345-2834-4ddd-89da-da4b13260c92/image",
      "owner_id": "b8ba56a9-1076-49b7-842a-b07480b1f9b7",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c372f238-60dd-4569-b0a5-db453e0f95c6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c372f238-60dd-4569-b0a5-db453e0f95c6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-09T07:43:29+00:00",
      "updated_at": "2024-04-09T07:43:29+00:00",
      "number": "http://bqbl.it/c372f238-60dd-4569-b0a5-db453e0f95c6",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-288.lvh.me:/barcodes/c372f238-60dd-4569-b0a5-db453e0f95c6/image",
      "owner_id": "66f78943-1234-48fa-b14a-2361d3192398",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/66f78943-1234-48fa-b14a-2361d3192398"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/5e2e68fb-c416-40f0-b3ca-9e24fbaa5c1a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5e2e68fb-c416-40f0-b3ca-9e24fbaa5c1a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-09T07:43:30+00:00",
      "updated_at": "2024-04-09T07:43:30+00:00",
      "number": "http://bqbl.it/5e2e68fb-c416-40f0-b3ca-9e24fbaa5c1a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-289.lvh.me:/barcodes/5e2e68fb-c416-40f0-b3ca-9e24fbaa5c1a/image",
      "owner_id": "ee943191-ea73-4b88-82ef-2caa526b5482",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ee943191-ea73-4b88-82ef-2caa526b5482"
        },
        "data": {
          "type": "customers",
          "id": "ee943191-ea73-4b88-82ef-2caa526b5482"
        }
      }
    }
  },
  "included": [
    {
      "id": "ee943191-ea73-4b88-82ef-2caa526b5482",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-09T07:43:30+00:00",
        "updated_at": "2024-04-09T07:43:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-77@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee943191-ea73-4b88-82ef-2caa526b5482&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee943191-ea73-4b88-82ef-2caa526b5482&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee943191-ea73-4b88-82ef-2caa526b5482&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/982c775e-a49d-453d-872e-2504d4a090d8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "982c775e-a49d-453d-872e-2504d4a090d8",
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
    "id": "982c775e-a49d-453d-872e-2504d4a090d8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-09T07:43:31+00:00",
      "updated_at": "2024-04-09T07:43:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-290.lvh.me:/barcodes/982c775e-a49d-453d-872e-2504d4a090d8/image",
      "owner_id": "d57e56c1-bed7-4414-b3c9-ac9143db2ca9",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`





