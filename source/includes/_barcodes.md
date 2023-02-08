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
      "id": "cc4013fa-09e8-4d45-9833-1dd410e62ed6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T13:50:43+00:00",
        "updated_at": "2023-02-08T13:50:43+00:00",
        "number": "http://bqbl.it/cc4013fa-09e8-4d45-9833-1dd410e62ed6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/92179d970b579b25befd683bad45b06f/barcode/image/cc4013fa-09e8-4d45-9833-1dd410e62ed6/c62d212b-0415-4bb5-a746-ed6512f7bf7d.svg",
        "owner_id": "50b76897-d58d-4f7a-af79-903394d0a2d5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/50b76897-d58d-4f7a-af79-903394d0a2d5"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F99ea4971-f55a-4a4a-8fc6-8339a346431b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "99ea4971-f55a-4a4a-8fc6-8339a346431b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T13:50:44+00:00",
        "updated_at": "2023-02-08T13:50:44+00:00",
        "number": "http://bqbl.it/99ea4971-f55a-4a4a-8fc6-8339a346431b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/10c235534d52310b577877d98df16fc3/barcode/image/99ea4971-f55a-4a4a-8fc6-8339a346431b/9c2459b9-4652-47a6-b912-13c1da5b1323.svg",
        "owner_id": "b0f5b3e6-48eb-432c-80d4-f0e0d02f861d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0f5b3e6-48eb-432c-80d4-f0e0d02f861d"
          },
          "data": {
            "type": "customers",
            "id": "b0f5b3e6-48eb-432c-80d4-f0e0d02f861d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b0f5b3e6-48eb-432c-80d4-f0e0d02f861d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T13:50:44+00:00",
        "updated_at": "2023-02-08T13:50:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b0f5b3e6-48eb-432c-80d4-f0e0d02f861d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b0f5b3e6-48eb-432c-80d4-f0e0d02f861d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b0f5b3e6-48eb-432c-80d4-f0e0d02f861d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmQyYTFlOWYtZTY4NS00ODQxLWJjNzgtMjFkZjk3Y2FiMDBh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2d2a1e9f-e685-4841-bc78-21df97cab00a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T13:50:45+00:00",
        "updated_at": "2023-02-08T13:50:45+00:00",
        "number": "http://bqbl.it/2d2a1e9f-e685-4841-bc78-21df97cab00a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b03983e6d3bcbb11f70c3f7dd99e147/barcode/image/2d2a1e9f-e685-4841-bc78-21df97cab00a/34541633-d669-46dc-ad9c-dd43f1a74d20.svg",
        "owner_id": "a25f4719-b6d5-448e-bb8d-9f357a10cb48",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a25f4719-b6d5-448e-bb8d-9f357a10cb48"
          },
          "data": {
            "type": "customers",
            "id": "a25f4719-b6d5-448e-bb8d-9f357a10cb48"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a25f4719-b6d5-448e-bb8d-9f357a10cb48",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T13:50:45+00:00",
        "updated_at": "2023-02-08T13:50:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a25f4719-b6d5-448e-bb8d-9f357a10cb48&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a25f4719-b6d5-448e-bb8d-9f357a10cb48&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a25f4719-b6d5-448e-bb8d-9f357a10cb48&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b12b6a93-b698-420b-b2eb-4e8280460587?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b12b6a93-b698-420b-b2eb-4e8280460587",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T13:50:45+00:00",
      "updated_at": "2023-02-08T13:50:45+00:00",
      "number": "http://bqbl.it/b12b6a93-b698-420b-b2eb-4e8280460587",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5a96c6df3cafc312a5277656aa94f2ef/barcode/image/b12b6a93-b698-420b-b2eb-4e8280460587/2f6565fa-53ab-4531-bde2-b6cbf4005eb0.svg",
      "owner_id": "18109fb5-5056-4f14-abb2-f97b134b32da",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/18109fb5-5056-4f14-abb2-f97b134b32da"
        },
        "data": {
          "type": "customers",
          "id": "18109fb5-5056-4f14-abb2-f97b134b32da"
        }
      }
    }
  },
  "included": [
    {
      "id": "18109fb5-5056-4f14-abb2-f97b134b32da",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T13:50:45+00:00",
        "updated_at": "2023-02-08T13:50:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=18109fb5-5056-4f14-abb2-f97b134b32da&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=18109fb5-5056-4f14-abb2-f97b134b32da&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=18109fb5-5056-4f14-abb2-f97b134b32da&filter[owner_type]=customers"
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
          "owner_id": "be8a3467-3295-4d01-b3c8-9814f25f2313",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "675e65f1-fa91-4950-8ab8-ef2607c94aad",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T13:50:46+00:00",
      "updated_at": "2023-02-08T13:50:46+00:00",
      "number": "http://bqbl.it/675e65f1-fa91-4950-8ab8-ef2607c94aad",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d2c168dab5631cb4be7c52f29f4832cf/barcode/image/675e65f1-fa91-4950-8ab8-ef2607c94aad/28d367bc-f060-49db-bd4a-9c1c0d8b374d.svg",
      "owner_id": "be8a3467-3295-4d01-b3c8-9814f25f2313",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/97ec299e-8617-4ad7-b6cb-368ac1c85e5b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97ec299e-8617-4ad7-b6cb-368ac1c85e5b",
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
    "id": "97ec299e-8617-4ad7-b6cb-368ac1c85e5b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T13:50:47+00:00",
      "updated_at": "2023-02-08T13:50:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c2789784fe6eecb9e5fa287b83d91a62/barcode/image/97ec299e-8617-4ad7-b6cb-368ac1c85e5b/6cc4541b-7fef-4a6d-bbe3-e442932d8337.svg",
      "owner_id": "d921d8f2-46f1-4682-b8bf-48dbe7b63287",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e5786c22-3641-4808-a0ca-47f21f7486f7' \
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