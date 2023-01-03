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
      "id": "6eecced3-6da0-44b9-9f63-8e10ace75411",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-03T12:11:24+00:00",
        "updated_at": "2023-01-03T12:11:24+00:00",
        "number": "http://bqbl.it/6eecced3-6da0-44b9-9f63-8e10ace75411",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9be4062f85b355352fcbfc8a9e1174a5/barcode/image/6eecced3-6da0-44b9-9f63-8e10ace75411/e42ebfea-044b-43dc-a058-148a86e04deb.svg",
        "owner_id": "e6786d59-4061-4d96-96ae-d7ad56973cd5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e6786d59-4061-4d96-96ae-d7ad56973cd5"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F99b938b0-7115-4ba9-93a5-841ec30eda1d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "99b938b0-7115-4ba9-93a5-841ec30eda1d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-03T12:11:25+00:00",
        "updated_at": "2023-01-03T12:11:25+00:00",
        "number": "http://bqbl.it/99b938b0-7115-4ba9-93a5-841ec30eda1d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/09ec837a1a886b6fd91623a0c9adab38/barcode/image/99b938b0-7115-4ba9-93a5-841ec30eda1d/5ac003e2-b94a-4c3a-8d5a-91644630db17.svg",
        "owner_id": "54a56ed2-1431-4856-8783-b13e96b43fd5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/54a56ed2-1431-4856-8783-b13e96b43fd5"
          },
          "data": {
            "type": "customers",
            "id": "54a56ed2-1431-4856-8783-b13e96b43fd5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "54a56ed2-1431-4856-8783-b13e96b43fd5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-03T12:11:25+00:00",
        "updated_at": "2023-01-03T12:11:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=54a56ed2-1431-4856-8783-b13e96b43fd5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=54a56ed2-1431-4856-8783-b13e96b43fd5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=54a56ed2-1431-4856-8783-b13e96b43fd5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjMwNTk0OWItN2UyNi00MjZhLWEzYzMtNjRiNDNkMzMzYzc1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6305949b-7e26-426a-a3c3-64b43d333c75",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-01-03T12:11:26+00:00",
        "updated_at": "2023-01-03T12:11:26+00:00",
        "number": "http://bqbl.it/6305949b-7e26-426a-a3c3-64b43d333c75",
        "barcode_type": "qr_code",
        "image_url": "/uploads/776c181f21c4d6158fbeabff10c8c57b/barcode/image/6305949b-7e26-426a-a3c3-64b43d333c75/974e28ee-7d43-4244-a9e9-7bef96cff823.svg",
        "owner_id": "44c1acae-2b4f-4018-886d-b24363447f30",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/44c1acae-2b4f-4018-886d-b24363447f30"
          },
          "data": {
            "type": "customers",
            "id": "44c1acae-2b4f-4018-886d-b24363447f30"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "44c1acae-2b4f-4018-886d-b24363447f30",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-03T12:11:25+00:00",
        "updated_at": "2023-01-03T12:11:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=44c1acae-2b4f-4018-886d-b24363447f30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=44c1acae-2b4f-4018-886d-b24363447f30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=44c1acae-2b4f-4018-886d-b24363447f30&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-03T12:11:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/752f2c34-28e5-4546-9ab9-0dfa4d783414?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "752f2c34-28e5-4546-9ab9-0dfa4d783414",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-03T12:11:26+00:00",
      "updated_at": "2023-01-03T12:11:26+00:00",
      "number": "http://bqbl.it/752f2c34-28e5-4546-9ab9-0dfa4d783414",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f10a042195cfeae4fa3a9485389fd017/barcode/image/752f2c34-28e5-4546-9ab9-0dfa4d783414/f7047fd5-1cf7-45d5-baba-82a86faae812.svg",
      "owner_id": "635a5c97-4567-4deb-a7d0-a95e755ebb4f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/635a5c97-4567-4deb-a7d0-a95e755ebb4f"
        },
        "data": {
          "type": "customers",
          "id": "635a5c97-4567-4deb-a7d0-a95e755ebb4f"
        }
      }
    }
  },
  "included": [
    {
      "id": "635a5c97-4567-4deb-a7d0-a95e755ebb4f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-01-03T12:11:26+00:00",
        "updated_at": "2023-01-03T12:11:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=635a5c97-4567-4deb-a7d0-a95e755ebb4f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=635a5c97-4567-4deb-a7d0-a95e755ebb4f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=635a5c97-4567-4deb-a7d0-a95e755ebb4f&filter[owner_type]=customers"
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
          "owner_id": "c0067eeb-0ef0-4b81-8e44-cb3f2466fcd3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9802db96-d39b-4fab-abdb-ad01e0368ac2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-03T12:11:27+00:00",
      "updated_at": "2023-01-03T12:11:27+00:00",
      "number": "http://bqbl.it/9802db96-d39b-4fab-abdb-ad01e0368ac2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/246f820fac8fd36dd86fde7f1e6a9c04/barcode/image/9802db96-d39b-4fab-abdb-ad01e0368ac2/101fb1ec-7706-48db-9e56-ed8fc8aedac1.svg",
      "owner_id": "c0067eeb-0ef0-4b81-8e44-cb3f2466fcd3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1aa13fdb-d659-4496-bd2b-06e26cd19648' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1aa13fdb-d659-4496-bd2b-06e26cd19648",
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
    "id": "1aa13fdb-d659-4496-bd2b-06e26cd19648",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-01-03T12:11:27+00:00",
      "updated_at": "2023-01-03T12:11:27+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a90b9a6edbb24291e3019e4c1ec8020f/barcode/image/1aa13fdb-d659-4496-bd2b-06e26cd19648/a3def1ce-7bfd-4bca-bc21-c1d35ee26aa0.svg",
      "owner_id": "17dcd2fc-1f0b-4cb2-afcb-f6404a542429",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/baefbf22-c595-4e40-80ad-06278f425cc6' \
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