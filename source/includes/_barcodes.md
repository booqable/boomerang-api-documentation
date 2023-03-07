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
      "id": "e6b7c627-7d8e-482a-84ee-20957de17291",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T11:34:56+00:00",
        "updated_at": "2023-03-07T11:34:56+00:00",
        "number": "http://bqbl.it/e6b7c627-7d8e-482a-84ee-20957de17291",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b4c77f1d074b5d06a232a90909038f58/barcode/image/e6b7c627-7d8e-482a-84ee-20957de17291/fcf933c9-fe99-472f-bd42-3d3bb18c6ec5.svg",
        "owner_id": "ec05451a-07eb-4187-8d53-4f8e23c180f1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ec05451a-07eb-4187-8d53-4f8e23c180f1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1e96d93e-b721-4a14-8269-82adc6b3afc8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1e96d93e-b721-4a14-8269-82adc6b3afc8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T11:34:57+00:00",
        "updated_at": "2023-03-07T11:34:57+00:00",
        "number": "http://bqbl.it/1e96d93e-b721-4a14-8269-82adc6b3afc8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f2e248c65aee6f30f759185ea1155f9f/barcode/image/1e96d93e-b721-4a14-8269-82adc6b3afc8/1800d3e2-0dfb-49f3-939e-dab1e7046c61.svg",
        "owner_id": "9a92fb3a-9003-40c9-b05b-480a4cd198c3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9a92fb3a-9003-40c9-b05b-480a4cd198c3"
          },
          "data": {
            "type": "customers",
            "id": "9a92fb3a-9003-40c9-b05b-480a4cd198c3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9a92fb3a-9003-40c9-b05b-480a4cd198c3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T11:34:56+00:00",
        "updated_at": "2023-03-07T11:34:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9a92fb3a-9003-40c9-b05b-480a4cd198c3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9a92fb3a-9003-40c9-b05b-480a4cd198c3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9a92fb3a-9003-40c9-b05b-480a4cd198c3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWE5YjkzOWQtODMwMS00OTE2LTg3MWUtODkzNzc4NGY2MzY3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ea9b939d-8301-4916-871e-8937784f6367",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T11:34:57+00:00",
        "updated_at": "2023-03-07T11:34:57+00:00",
        "number": "http://bqbl.it/ea9b939d-8301-4916-871e-8937784f6367",
        "barcode_type": "qr_code",
        "image_url": "/uploads/de996f35da5964789683c859f551a842/barcode/image/ea9b939d-8301-4916-871e-8937784f6367/6363c27a-e0b5-45fa-b224-4ec8a2d91edc.svg",
        "owner_id": "fc9631e3-e2f1-490c-8c38-586421695079",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fc9631e3-e2f1-490c-8c38-586421695079"
          },
          "data": {
            "type": "customers",
            "id": "fc9631e3-e2f1-490c-8c38-586421695079"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fc9631e3-e2f1-490c-8c38-586421695079",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T11:34:57+00:00",
        "updated_at": "2023-03-07T11:34:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fc9631e3-e2f1-490c-8c38-586421695079&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fc9631e3-e2f1-490c-8c38-586421695079&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fc9631e3-e2f1-490c-8c38-586421695079&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T11:34:32Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c9e300e1-5800-48aa-a321-7d44b8503c7f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c9e300e1-5800-48aa-a321-7d44b8503c7f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T11:34:58+00:00",
      "updated_at": "2023-03-07T11:34:58+00:00",
      "number": "http://bqbl.it/c9e300e1-5800-48aa-a321-7d44b8503c7f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a8731a6088c5781e7cd9df506a305a19/barcode/image/c9e300e1-5800-48aa-a321-7d44b8503c7f/2f04508c-09a6-4bda-b588-34483160d66a.svg",
      "owner_id": "e3ef371b-310c-4768-8654-abfa5b51ea59",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e3ef371b-310c-4768-8654-abfa5b51ea59"
        },
        "data": {
          "type": "customers",
          "id": "e3ef371b-310c-4768-8654-abfa5b51ea59"
        }
      }
    }
  },
  "included": [
    {
      "id": "e3ef371b-310c-4768-8654-abfa5b51ea59",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T11:34:58+00:00",
        "updated_at": "2023-03-07T11:34:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e3ef371b-310c-4768-8654-abfa5b51ea59&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e3ef371b-310c-4768-8654-abfa5b51ea59&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e3ef371b-310c-4768-8654-abfa5b51ea59&filter[owner_type]=customers"
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
          "owner_id": "4c6dfc49-289b-4c37-983d-a10fb93a395f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8624a1c1-4867-4994-84ff-2a5882cabc23",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T11:34:58+00:00",
      "updated_at": "2023-03-07T11:34:58+00:00",
      "number": "http://bqbl.it/8624a1c1-4867-4994-84ff-2a5882cabc23",
      "barcode_type": "qr_code",
      "image_url": "/uploads/276b2a795794de7a43081dd061d4314a/barcode/image/8624a1c1-4867-4994-84ff-2a5882cabc23/9fb86305-1173-403d-9066-01827778ff94.svg",
      "owner_id": "4c6dfc49-289b-4c37-983d-a10fb93a395f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/666beb20-91c8-4732-9df8-c6d94f5f9a42' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "666beb20-91c8-4732-9df8-c6d94f5f9a42",
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
    "id": "666beb20-91c8-4732-9df8-c6d94f5f9a42",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T11:34:59+00:00",
      "updated_at": "2023-03-07T11:34:59+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7cd7bd89d1df1f8c2ad6c9d4e63a9d21/barcode/image/666beb20-91c8-4732-9df8-c6d94f5f9a42/5bf1cc00-38dc-4591-bea8-11f2595fc57d.svg",
      "owner_id": "334af461-7a48-479e-aa87-f03c05970e5c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6a6d926d-874e-4390-8699-36897f5e8c99' \
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