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
      "id": "897bf2c7-8056-4933-9a50-3d5ba12f087e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:10:12+00:00",
        "updated_at": "2023-02-09T10:10:12+00:00",
        "number": "http://bqbl.it/897bf2c7-8056-4933-9a50-3d5ba12f087e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d0171982d77dcd0c069b8a1dc8f88262/barcode/image/897bf2c7-8056-4933-9a50-3d5ba12f087e/0bef61f2-8b94-41d7-b693-e307c81ddcd4.svg",
        "owner_id": "907b4159-cf16-4ad3-91d3-c29f1196faf1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/907b4159-cf16-4ad3-91d3-c29f1196faf1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd2da44a7-2ee9-4b6d-9783-304a0a46269b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d2da44a7-2ee9-4b6d-9783-304a0a46269b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:10:13+00:00",
        "updated_at": "2023-02-09T10:10:13+00:00",
        "number": "http://bqbl.it/d2da44a7-2ee9-4b6d-9783-304a0a46269b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6bf27ddd5670058712a307ef4dff51c2/barcode/image/d2da44a7-2ee9-4b6d-9783-304a0a46269b/4dcb48d5-bf2d-44c5-903e-1022693947a9.svg",
        "owner_id": "231deece-4737-4593-abbb-a5b423ed313a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/231deece-4737-4593-abbb-a5b423ed313a"
          },
          "data": {
            "type": "customers",
            "id": "231deece-4737-4593-abbb-a5b423ed313a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "231deece-4737-4593-abbb-a5b423ed313a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:10:12+00:00",
        "updated_at": "2023-02-09T10:10:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=231deece-4737-4593-abbb-a5b423ed313a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=231deece-4737-4593-abbb-a5b423ed313a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=231deece-4737-4593-abbb-a5b423ed313a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjQxOWQwZGMtY2NlYi00NGExLTk4YTctYjBiZjAwZGFlODk5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2419d0dc-cceb-44a1-98a7-b0bf00dae899",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:10:13+00:00",
        "updated_at": "2023-02-09T10:10:13+00:00",
        "number": "http://bqbl.it/2419d0dc-cceb-44a1-98a7-b0bf00dae899",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bdcf1469407a71a1a1f6e6975ef46073/barcode/image/2419d0dc-cceb-44a1-98a7-b0bf00dae899/9c2a54d1-4968-4b5d-892c-a57db4973739.svg",
        "owner_id": "46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81"
          },
          "data": {
            "type": "customers",
            "id": "46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:10:13+00:00",
        "updated_at": "2023-02-09T10:10:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=46a8ee4e-b53e-4bf4-8c1c-a7e1fd279c81&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:09:54Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/845c49ea-ad5b-47b7-9b4a-67bf403f537b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "845c49ea-ad5b-47b7-9b4a-67bf403f537b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:10:13+00:00",
      "updated_at": "2023-02-09T10:10:13+00:00",
      "number": "http://bqbl.it/845c49ea-ad5b-47b7-9b4a-67bf403f537b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/094210e5a7bb3fc121ef51ae31ef3b07/barcode/image/845c49ea-ad5b-47b7-9b4a-67bf403f537b/5436ed78-a0d2-4731-9c61-d2afc5fda3a3.svg",
      "owner_id": "01e38cfa-e736-47d6-8d0a-d52f7784c5c0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/01e38cfa-e736-47d6-8d0a-d52f7784c5c0"
        },
        "data": {
          "type": "customers",
          "id": "01e38cfa-e736-47d6-8d0a-d52f7784c5c0"
        }
      }
    }
  },
  "included": [
    {
      "id": "01e38cfa-e736-47d6-8d0a-d52f7784c5c0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:10:13+00:00",
        "updated_at": "2023-02-09T10:10:13+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=01e38cfa-e736-47d6-8d0a-d52f7784c5c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=01e38cfa-e736-47d6-8d0a-d52f7784c5c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=01e38cfa-e736-47d6-8d0a-d52f7784c5c0&filter[owner_type]=customers"
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
          "owner_id": "573be788-c859-44af-a84f-31c709b2c58c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ce93e145-ea67-4e06-ba72-bc9a47ec01ae",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:10:14+00:00",
      "updated_at": "2023-02-09T10:10:14+00:00",
      "number": "http://bqbl.it/ce93e145-ea67-4e06-ba72-bc9a47ec01ae",
      "barcode_type": "qr_code",
      "image_url": "/uploads/09d38372f5bef008b55a23cfb4f3c152/barcode/image/ce93e145-ea67-4e06-ba72-bc9a47ec01ae/eec6b12c-f087-4b55-ba9f-ca13341a0957.svg",
      "owner_id": "573be788-c859-44af-a84f-31c709b2c58c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/59241348-e773-4d9d-a2ac-559d2d98de0a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "59241348-e773-4d9d-a2ac-559d2d98de0a",
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
    "id": "59241348-e773-4d9d-a2ac-559d2d98de0a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:10:14+00:00",
      "updated_at": "2023-02-09T10:10:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f07785824c286dc15f22a34e2e5ada05/barcode/image/59241348-e773-4d9d-a2ac-559d2d98de0a/a63b0304-d4b7-4333-ae59-55ddc77424ad.svg",
      "owner_id": "55df1ddc-aa48-4965-a233-e9f5fa84ffd5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/086f89d0-2a6e-4302-9a2f-df8211e4ddca' \
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