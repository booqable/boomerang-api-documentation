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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "a0bc5816-53ab-4c9e-8b66-a43fc3329ec7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T07:02:10+00:00",
        "updated_at": "2022-04-07T07:02:10+00:00",
        "number": "http://bqbl.it/a0bc5816-53ab-4c9e-8b66-a43fc3329ec7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a53d8b74322da3bbbdb70edfad2f2878/barcode/image/a0bc5816-53ab-4c9e-8b66-a43fc3329ec7/cd898f15-2e99-4b59-8769-2c2b1a7dcc9e.svg",
        "owner_id": "ce34dbf3-bb78-4610-866b-87b8995cbbbe",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ce34dbf3-bb78-4610-866b-87b8995cbbbe"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3ce9c8e3-42b0-41a6-a318-c1b069ce1004&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3ce9c8e3-42b0-41a6-a318-c1b069ce1004",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T07:02:11+00:00",
        "updated_at": "2022-04-07T07:02:11+00:00",
        "number": "http://bqbl.it/3ce9c8e3-42b0-41a6-a318-c1b069ce1004",
        "barcode_type": "qr_code",
        "image_url": "/uploads/569711a35c712e7510fb2eec01117552/barcode/image/3ce9c8e3-42b0-41a6-a318-c1b069ce1004/09e701a0-aa32-4854-86cb-4a4a96442369.svg",
        "owner_id": "75cf13bb-decb-491e-ae6c-e00377de1acf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/75cf13bb-decb-491e-ae6c-e00377de1acf"
          },
          "data": {
            "type": "customers",
            "id": "75cf13bb-decb-491e-ae6c-e00377de1acf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "75cf13bb-decb-491e-ae6c-e00377de1acf",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T07:02:11+00:00",
        "updated_at": "2022-04-07T07:02:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Cremin, Adams and Harber",
        "email": "cremin_adams_and_harber@reilly.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=75cf13bb-decb-491e-ae6c-e00377de1acf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=75cf13bb-decb-491e-ae6c-e00377de1acf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=75cf13bb-decb-491e-ae6c-e00377de1acf&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNWNiZTEyMmEtMWRmYS00YzNmLWIzNTQtZGNjYTg2YWQzODgz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5cbe122a-1dfa-4c3f-b354-dcca86ad3883",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T07:02:11+00:00",
        "updated_at": "2022-04-07T07:02:11+00:00",
        "number": "http://bqbl.it/5cbe122a-1dfa-4c3f-b354-dcca86ad3883",
        "barcode_type": "qr_code",
        "image_url": "/uploads/39d03c52d829110b50e658de344c32b3/barcode/image/5cbe122a-1dfa-4c3f-b354-dcca86ad3883/4e5fc018-a7c1-41d8-b868-8abf5db76eca.svg",
        "owner_id": "1af89a6b-153f-461c-abb0-57e8e1afa69d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1af89a6b-153f-461c-abb0-57e8e1afa69d"
          },
          "data": {
            "type": "customers",
            "id": "1af89a6b-153f-461c-abb0-57e8e1afa69d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1af89a6b-153f-461c-abb0-57e8e1afa69d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T07:02:11+00:00",
        "updated_at": "2022-04-07T07:02:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Brakus and Sons",
        "email": "and.brakus.sons@rogahn.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=1af89a6b-153f-461c-abb0-57e8e1afa69d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1af89a6b-153f-461c-abb0-57e8e1afa69d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1af89a6b-153f-461c-abb0-57e8e1afa69d&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T07:01:59Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/12964c9f-a2c5-479e-9d14-4fec1cebfeb4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "12964c9f-a2c5-479e-9d14-4fec1cebfeb4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T07:02:12+00:00",
      "updated_at": "2022-04-07T07:02:12+00:00",
      "number": "http://bqbl.it/12964c9f-a2c5-479e-9d14-4fec1cebfeb4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e8bff451fa94f845961e74804ac2203b/barcode/image/12964c9f-a2c5-479e-9d14-4fec1cebfeb4/e2915a1e-0ec6-401e-a5f0-7ada7f576348.svg",
      "owner_id": "ddc4343f-92f0-4f62-9cc7-4af5228a6c08",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ddc4343f-92f0-4f62-9cc7-4af5228a6c08"
        },
        "data": {
          "type": "customers",
          "id": "ddc4343f-92f0-4f62-9cc7-4af5228a6c08"
        }
      }
    }
  },
  "included": [
    {
      "id": "ddc4343f-92f0-4f62-9cc7-4af5228a6c08",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T07:02:12+00:00",
        "updated_at": "2022-04-07T07:02:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Harris-Langosh",
        "email": "harris.langosh@sporer.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=ddc4343f-92f0-4f62-9cc7-4af5228a6c08&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ddc4343f-92f0-4f62-9cc7-4af5228a6c08&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ddc4343f-92f0-4f62-9cc7-4af5228a6c08&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "62deae32-f12a-4362-95a8-9b206bee0ff1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7e695b18-2445-4601-ae37-9b8406630138",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T07:02:13+00:00",
      "updated_at": "2022-04-07T07:02:13+00:00",
      "number": "http://bqbl.it/7e695b18-2445-4601-ae37-9b8406630138",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b6fbf0038046ae589b8e85c992663059/barcode/image/7e695b18-2445-4601-ae37-9b8406630138/7d850db8-0aaa-4d6a-a41a-09279eb862ac.svg",
      "owner_id": "62deae32-f12a-4362-95a8-9b206bee0ff1",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/53d7a9f1-7a31-4450-bee1-f6d8668fe741' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "53d7a9f1-7a31-4450-bee1-f6d8668fe741",
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
    "id": "53d7a9f1-7a31-4450-bee1-f6d8668fe741",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T07:02:13+00:00",
      "updated_at": "2022-04-07T07:02:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7408171287fb8fb7480030d002321677/barcode/image/53d7a9f1-7a31-4450-bee1-f6d8668fe741/b950668d-f75f-4116-9b43-75f718f54868.svg",
      "owner_id": "246fd02a-bb4c-46e8-872c-ff71c348679d",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/43ff428b-494f-4ac5-aff4-dcc362417e05' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes