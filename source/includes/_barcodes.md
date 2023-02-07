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
      "id": "c196b5a5-f058-4f09-8730-c1f91ced0748",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T15:17:33+00:00",
        "updated_at": "2023-02-07T15:17:33+00:00",
        "number": "http://bqbl.it/c196b5a5-f058-4f09-8730-c1f91ced0748",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1ee923325f24d30cdc1fe06e32046e8c/barcode/image/c196b5a5-f058-4f09-8730-c1f91ced0748/c78c5269-9ce0-4a14-afc6-bad1fd7a6495.svg",
        "owner_id": "7b322d84-c0e0-4e42-9467-8eb269df7936",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7b322d84-c0e0-4e42-9467-8eb269df7936"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9a5f08e4-8733-4e77-9855-3d0ba30d118f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9a5f08e4-8733-4e77-9855-3d0ba30d118f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T15:17:34+00:00",
        "updated_at": "2023-02-07T15:17:34+00:00",
        "number": "http://bqbl.it/9a5f08e4-8733-4e77-9855-3d0ba30d118f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3d94055c130968a25cd0c54808744344/barcode/image/9a5f08e4-8733-4e77-9855-3d0ba30d118f/843a92bd-4480-4753-b9fa-e1a1e07e551b.svg",
        "owner_id": "139ef7fd-1fb6-41df-9d64-ae0092ba7e06",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/139ef7fd-1fb6-41df-9d64-ae0092ba7e06"
          },
          "data": {
            "type": "customers",
            "id": "139ef7fd-1fb6-41df-9d64-ae0092ba7e06"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "139ef7fd-1fb6-41df-9d64-ae0092ba7e06",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T15:17:34+00:00",
        "updated_at": "2023-02-07T15:17:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=139ef7fd-1fb6-41df-9d64-ae0092ba7e06&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=139ef7fd-1fb6-41df-9d64-ae0092ba7e06&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=139ef7fd-1fb6-41df-9d64-ae0092ba7e06&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmZhMmQyNTctMjA2ZC00NDQ0LTk0MWEtZjYxODBkODVhMzk3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6fa2d257-206d-4444-941a-f6180d85a397",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T15:17:34+00:00",
        "updated_at": "2023-02-07T15:17:34+00:00",
        "number": "http://bqbl.it/6fa2d257-206d-4444-941a-f6180d85a397",
        "barcode_type": "qr_code",
        "image_url": "/uploads/97c885a6bc19afe40273a2e7d1d86b21/barcode/image/6fa2d257-206d-4444-941a-f6180d85a397/9c7a6afa-e72f-4fb5-9713-8c4190fce7de.svg",
        "owner_id": "bd887770-883b-4722-bce0-3231d8d87161",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bd887770-883b-4722-bce0-3231d8d87161"
          },
          "data": {
            "type": "customers",
            "id": "bd887770-883b-4722-bce0-3231d8d87161"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bd887770-883b-4722-bce0-3231d8d87161",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T15:17:34+00:00",
        "updated_at": "2023-02-07T15:17:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=bd887770-883b-4722-bce0-3231d8d87161&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bd887770-883b-4722-bce0-3231d8d87161&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bd887770-883b-4722-bce0-3231d8d87161&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T15:17:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e65a06c9-074a-4c7c-a40f-20fcea35d575?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e65a06c9-074a-4c7c-a40f-20fcea35d575",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T15:17:35+00:00",
      "updated_at": "2023-02-07T15:17:35+00:00",
      "number": "http://bqbl.it/e65a06c9-074a-4c7c-a40f-20fcea35d575",
      "barcode_type": "qr_code",
      "image_url": "/uploads/988df4800ca4260fce973bc67195d66f/barcode/image/e65a06c9-074a-4c7c-a40f-20fcea35d575/374ba1e7-5f38-467d-866b-1eaf6727b5dd.svg",
      "owner_id": "587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6"
        },
        "data": {
          "type": "customers",
          "id": "587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6"
        }
      }
    }
  },
  "included": [
    {
      "id": "587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T15:17:35+00:00",
        "updated_at": "2023-02-07T15:17:35+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=587a5471-a7e5-4c6b-890f-8e7fdc4cc9b6&filter[owner_type]=customers"
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
          "owner_id": "e4e68919-357d-4238-9d42-a88ea1264dd7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b0a703a5-9df8-45e6-833d-d5280ccd928c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T15:17:35+00:00",
      "updated_at": "2023-02-07T15:17:35+00:00",
      "number": "http://bqbl.it/b0a703a5-9df8-45e6-833d-d5280ccd928c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ead038fb6fdad6ad513c4fb12a58b472/barcode/image/b0a703a5-9df8-45e6-833d-d5280ccd928c/5ec9f5c8-7fb0-4640-9f0a-e61dc611d344.svg",
      "owner_id": "e4e68919-357d-4238-9d42-a88ea1264dd7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/56cec600-4ea6-4566-8006-26a41bd475ca' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "56cec600-4ea6-4566-8006-26a41bd475ca",
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
    "id": "56cec600-4ea6-4566-8006-26a41bd475ca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T15:17:36+00:00",
      "updated_at": "2023-02-07T15:17:36+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/34539434626f3b9576863a7de12c706a/barcode/image/56cec600-4ea6-4566-8006-26a41bd475ca/417cce56-0d5c-4471-ad05-da47f4f9a30d.svg",
      "owner_id": "36f943e4-4310-473d-bad6-3223e413d140",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c9e3c533-abe5-4b89-8f3c-97203b8b3f13' \
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