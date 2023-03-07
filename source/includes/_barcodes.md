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
      "id": "c5986909-ede2-4041-aa33-3c4109d1a4e1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T07:55:33+00:00",
        "updated_at": "2023-03-07T07:55:33+00:00",
        "number": "http://bqbl.it/c5986909-ede2-4041-aa33-3c4109d1a4e1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/769e209a1903ffa9fe05d9b19bcdfdeb/barcode/image/c5986909-ede2-4041-aa33-3c4109d1a4e1/5e25c768-dc42-4f04-8f29-71fefcc3bca9.svg",
        "owner_id": "5e4ee5af-58ad-42c0-b414-ba4a292d6cde",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5e4ee5af-58ad-42c0-b414-ba4a292d6cde"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff2d59f68-db78-4ad6-a1ea-98070505db77&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f2d59f68-db78-4ad6-a1ea-98070505db77",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T07:55:34+00:00",
        "updated_at": "2023-03-07T07:55:34+00:00",
        "number": "http://bqbl.it/f2d59f68-db78-4ad6-a1ea-98070505db77",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e79090aebd546a6ce60c4b3163100b6c/barcode/image/f2d59f68-db78-4ad6-a1ea-98070505db77/a8dc98ba-8440-4d31-8f0d-19b99303c88c.svg",
        "owner_id": "5141d69a-d3c8-4663-a0de-6a69f29e5f7d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5141d69a-d3c8-4663-a0de-6a69f29e5f7d"
          },
          "data": {
            "type": "customers",
            "id": "5141d69a-d3c8-4663-a0de-6a69f29e5f7d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5141d69a-d3c8-4663-a0de-6a69f29e5f7d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T07:55:34+00:00",
        "updated_at": "2023-03-07T07:55:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5141d69a-d3c8-4663-a0de-6a69f29e5f7d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5141d69a-d3c8-4663-a0de-6a69f29e5f7d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5141d69a-d3c8-4663-a0de-6a69f29e5f7d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTJlMTA1ZmItMzM4NC00YjE4LTg5NDgtNzBkZTY3ZjRjMWY5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e2e105fb-3384-4b18-8948-70de67f4c1f9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T07:55:34+00:00",
        "updated_at": "2023-03-07T07:55:34+00:00",
        "number": "http://bqbl.it/e2e105fb-3384-4b18-8948-70de67f4c1f9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0ec5329cf18ebae05120c720281fd487/barcode/image/e2e105fb-3384-4b18-8948-70de67f4c1f9/dbf36147-4330-471e-938d-b2743865ec98.svg",
        "owner_id": "93279121-8112-4c43-96be-b5f2e3533567",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/93279121-8112-4c43-96be-b5f2e3533567"
          },
          "data": {
            "type": "customers",
            "id": "93279121-8112-4c43-96be-b5f2e3533567"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "93279121-8112-4c43-96be-b5f2e3533567",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T07:55:34+00:00",
        "updated_at": "2023-03-07T07:55:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=93279121-8112-4c43-96be-b5f2e3533567&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=93279121-8112-4c43-96be-b5f2e3533567&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=93279121-8112-4c43-96be-b5f2e3533567&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T07:55:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3823bdbf-e915-4575-9fe0-4303ee71372a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3823bdbf-e915-4575-9fe0-4303ee71372a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T07:55:35+00:00",
      "updated_at": "2023-03-07T07:55:35+00:00",
      "number": "http://bqbl.it/3823bdbf-e915-4575-9fe0-4303ee71372a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4420650d4584662065a502df8f39d6b6/barcode/image/3823bdbf-e915-4575-9fe0-4303ee71372a/b3385580-3423-4e56-b01d-a4d35bd19c05.svg",
      "owner_id": "101cdced-7e92-42d4-8a2c-6e6c365a802e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/101cdced-7e92-42d4-8a2c-6e6c365a802e"
        },
        "data": {
          "type": "customers",
          "id": "101cdced-7e92-42d4-8a2c-6e6c365a802e"
        }
      }
    }
  },
  "included": [
    {
      "id": "101cdced-7e92-42d4-8a2c-6e6c365a802e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T07:55:35+00:00",
        "updated_at": "2023-03-07T07:55:35+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=101cdced-7e92-42d4-8a2c-6e6c365a802e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=101cdced-7e92-42d4-8a2c-6e6c365a802e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=101cdced-7e92-42d4-8a2c-6e6c365a802e&filter[owner_type]=customers"
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
          "owner_id": "0ecf0873-a670-4e56-a1ae-1a90c52337d2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "51f33ebb-8cd1-4707-8be1-7dedb9e6440b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T07:55:36+00:00",
      "updated_at": "2023-03-07T07:55:36+00:00",
      "number": "http://bqbl.it/51f33ebb-8cd1-4707-8be1-7dedb9e6440b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c3bed2caca250ad243f3890acfe62fca/barcode/image/51f33ebb-8cd1-4707-8be1-7dedb9e6440b/f0c77bda-96a4-4437-9908-7863f9daa2a6.svg",
      "owner_id": "0ecf0873-a670-4e56-a1ae-1a90c52337d2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9b0f38a-1573-4c24-a2f3-c675b9bba4fb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a9b0f38a-1573-4c24-a2f3-c675b9bba4fb",
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
    "id": "a9b0f38a-1573-4c24-a2f3-c675b9bba4fb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T07:55:36+00:00",
      "updated_at": "2023-03-07T07:55:36+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5269902200eca53d68024fd014767c24/barcode/image/a9b0f38a-1573-4c24-a2f3-c675b9bba4fb/99a86180-2dcf-42bc-baa4-261462f5d18e.svg",
      "owner_id": "697ea8cb-6a8b-4078-b7e6-65b956581d1c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/80bf27a6-1b66-41d9-a733-d76440db9aa5' \
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