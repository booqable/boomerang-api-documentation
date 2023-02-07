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
      "id": "46567abb-9729-4cfc-852a-749979f22fce",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:32:05+00:00",
        "updated_at": "2023-02-07T14:32:05+00:00",
        "number": "http://bqbl.it/46567abb-9729-4cfc-852a-749979f22fce",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e216c1900e3b9d819f6d3d811282446e/barcode/image/46567abb-9729-4cfc-852a-749979f22fce/67af5d02-12b6-4a46-a575-68473254ab29.svg",
        "owner_id": "29e14af5-3ad8-422b-a737-b487af7a849c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/29e14af5-3ad8-422b-a737-b487af7a849c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa9df719d-b406-40d5-a315-175d78df4045&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a9df719d-b406-40d5-a315-175d78df4045",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:32:05+00:00",
        "updated_at": "2023-02-07T14:32:05+00:00",
        "number": "http://bqbl.it/a9df719d-b406-40d5-a315-175d78df4045",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1e1d026864a897ce63c77e72538744d1/barcode/image/a9df719d-b406-40d5-a315-175d78df4045/24e64bce-160a-4f47-8473-727f219e7e61.svg",
        "owner_id": "a9237cc1-3f38-4407-b381-99b47f7d877c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a9237cc1-3f38-4407-b381-99b47f7d877c"
          },
          "data": {
            "type": "customers",
            "id": "a9237cc1-3f38-4407-b381-99b47f7d877c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a9237cc1-3f38-4407-b381-99b47f7d877c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:32:05+00:00",
        "updated_at": "2023-02-07T14:32:05+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a9237cc1-3f38-4407-b381-99b47f7d877c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a9237cc1-3f38-4407-b381-99b47f7d877c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a9237cc1-3f38-4407-b381-99b47f7d877c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2JlNWFmNjgtMTkxYS00MDEyLTgwNmMtNWM1ZDQ2MDM1YmY0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3be5af68-191a-4012-806c-5c5d46035bf4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:32:06+00:00",
        "updated_at": "2023-02-07T14:32:06+00:00",
        "number": "http://bqbl.it/3be5af68-191a-4012-806c-5c5d46035bf4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3b58e0ba5a67f4efd383129e4c372dc4/barcode/image/3be5af68-191a-4012-806c-5c5d46035bf4/46410c0c-1528-4ee1-9e79-aee067e5c312.svg",
        "owner_id": "ddd13ced-eae5-49a4-8458-75e804897fd4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ddd13ced-eae5-49a4-8458-75e804897fd4"
          },
          "data": {
            "type": "customers",
            "id": "ddd13ced-eae5-49a4-8458-75e804897fd4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ddd13ced-eae5-49a4-8458-75e804897fd4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:32:06+00:00",
        "updated_at": "2023-02-07T14:32:06+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ddd13ced-eae5-49a4-8458-75e804897fd4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ddd13ced-eae5-49a4-8458-75e804897fd4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ddd13ced-eae5-49a4-8458-75e804897fd4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:31:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/db92fc7d-3a84-4d86-9f2c-af8695c31c79?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "db92fc7d-3a84-4d86-9f2c-af8695c31c79",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:32:07+00:00",
      "updated_at": "2023-02-07T14:32:07+00:00",
      "number": "http://bqbl.it/db92fc7d-3a84-4d86-9f2c-af8695c31c79",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e0ca47b7324f64247cb36ae99f90bd38/barcode/image/db92fc7d-3a84-4d86-9f2c-af8695c31c79/63c42bba-4f21-4496-8e93-b00df8afdd94.svg",
      "owner_id": "7fa3aee8-6167-48b8-9bc3-fb394e19fb05",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7fa3aee8-6167-48b8-9bc3-fb394e19fb05"
        },
        "data": {
          "type": "customers",
          "id": "7fa3aee8-6167-48b8-9bc3-fb394e19fb05"
        }
      }
    }
  },
  "included": [
    {
      "id": "7fa3aee8-6167-48b8-9bc3-fb394e19fb05",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:32:07+00:00",
        "updated_at": "2023-02-07T14:32:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7fa3aee8-6167-48b8-9bc3-fb394e19fb05&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7fa3aee8-6167-48b8-9bc3-fb394e19fb05&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7fa3aee8-6167-48b8-9bc3-fb394e19fb05&filter[owner_type]=customers"
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
          "owner_id": "fb2b82e1-e6a7-402e-a42a-5e2938c166b0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ec58250e-630f-46a1-be7b-5f9b9488ae7a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:32:07+00:00",
      "updated_at": "2023-02-07T14:32:07+00:00",
      "number": "http://bqbl.it/ec58250e-630f-46a1-be7b-5f9b9488ae7a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/33009ee768ef823d8400afbf56886e03/barcode/image/ec58250e-630f-46a1-be7b-5f9b9488ae7a/e9b903a6-00b8-4f6e-9d47-de4a7babfe41.svg",
      "owner_id": "fb2b82e1-e6a7-402e-a42a-5e2938c166b0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f063389a-1cf7-4fe8-acb8-4eaebb7a317d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f063389a-1cf7-4fe8-acb8-4eaebb7a317d",
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
    "id": "f063389a-1cf7-4fe8-acb8-4eaebb7a317d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:32:08+00:00",
      "updated_at": "2023-02-07T14:32:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d5ba40eb651dc1b59dce58c9f16244ba/barcode/image/f063389a-1cf7-4fe8-acb8-4eaebb7a317d/8e5721c6-bc55-495a-b8a7-51c19dba637f.svg",
      "owner_id": "d1083c90-8174-49e6-8c6d-01471c27d7f3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cb56fbd0-b1ac-4fa9-9788-d94a4c65c369' \
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