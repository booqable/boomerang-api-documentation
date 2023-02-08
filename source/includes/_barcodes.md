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
      "id": "f65f6587-e378-44a9-8b17-4fb4ca0e2cac",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T15:42:42+00:00",
        "updated_at": "2023-02-08T15:42:42+00:00",
        "number": "http://bqbl.it/f65f6587-e378-44a9-8b17-4fb4ca0e2cac",
        "barcode_type": "qr_code",
        "image_url": "/uploads/adbe455f621f1996d7c9f290bd733fbc/barcode/image/f65f6587-e378-44a9-8b17-4fb4ca0e2cac/e7023f35-fabc-4d5f-aa1b-6a4c6564e15d.svg",
        "owner_id": "64204709-fe48-4e71-958e-7cdb280daa3b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/64204709-fe48-4e71-958e-7cdb280daa3b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8bf25312-2c8e-4493-b06a-49cd63349448&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8bf25312-2c8e-4493-b06a-49cd63349448",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T15:42:43+00:00",
        "updated_at": "2023-02-08T15:42:43+00:00",
        "number": "http://bqbl.it/8bf25312-2c8e-4493-b06a-49cd63349448",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9ad335423b0e89c969162c29aada69b5/barcode/image/8bf25312-2c8e-4493-b06a-49cd63349448/52f39fc2-0063-4ce2-8999-6c27facd7e50.svg",
        "owner_id": "3fd83179-1822-472e-9bd7-c3244d8cb525",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3fd83179-1822-472e-9bd7-c3244d8cb525"
          },
          "data": {
            "type": "customers",
            "id": "3fd83179-1822-472e-9bd7-c3244d8cb525"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3fd83179-1822-472e-9bd7-c3244d8cb525",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T15:42:43+00:00",
        "updated_at": "2023-02-08T15:42:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3fd83179-1822-472e-9bd7-c3244d8cb525&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3fd83179-1822-472e-9bd7-c3244d8cb525&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3fd83179-1822-472e-9bd7-c3244d8cb525&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDkzOGExZmEtMzJjZS00NGY2LWFmYmEtMzc4NGMyMzg3MmJj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d938a1fa-32ce-44f6-afba-3784c23872bc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T15:42:44+00:00",
        "updated_at": "2023-02-08T15:42:44+00:00",
        "number": "http://bqbl.it/d938a1fa-32ce-44f6-afba-3784c23872bc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b7178c036214a4097320a60a2a74e2ff/barcode/image/d938a1fa-32ce-44f6-afba-3784c23872bc/c86583b1-dd2b-42b9-af95-7660bf7041d7.svg",
        "owner_id": "f1b671d6-8d2c-45ae-a977-f7521bcc5a6a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f1b671d6-8d2c-45ae-a977-f7521bcc5a6a"
          },
          "data": {
            "type": "customers",
            "id": "f1b671d6-8d2c-45ae-a977-f7521bcc5a6a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f1b671d6-8d2c-45ae-a977-f7521bcc5a6a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T15:42:44+00:00",
        "updated_at": "2023-02-08T15:42:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f1b671d6-8d2c-45ae-a977-f7521bcc5a6a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1b671d6-8d2c-45ae-a977-f7521bcc5a6a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1b671d6-8d2c-45ae-a977-f7521bcc5a6a&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T15:42:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0455d80d-53fc-447a-a0af-bb1fe01a4842?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0455d80d-53fc-447a-a0af-bb1fe01a4842",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T15:42:44+00:00",
      "updated_at": "2023-02-08T15:42:44+00:00",
      "number": "http://bqbl.it/0455d80d-53fc-447a-a0af-bb1fe01a4842",
      "barcode_type": "qr_code",
      "image_url": "/uploads/97f0689cfa5a7e6cb95b420c1655458e/barcode/image/0455d80d-53fc-447a-a0af-bb1fe01a4842/0d215b33-9be5-4436-936d-714aae6acbf5.svg",
      "owner_id": "560b5477-5315-4159-9be7-02fb421a6549",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/560b5477-5315-4159-9be7-02fb421a6549"
        },
        "data": {
          "type": "customers",
          "id": "560b5477-5315-4159-9be7-02fb421a6549"
        }
      }
    }
  },
  "included": [
    {
      "id": "560b5477-5315-4159-9be7-02fb421a6549",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T15:42:44+00:00",
        "updated_at": "2023-02-08T15:42:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=560b5477-5315-4159-9be7-02fb421a6549&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=560b5477-5315-4159-9be7-02fb421a6549&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=560b5477-5315-4159-9be7-02fb421a6549&filter[owner_type]=customers"
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
          "owner_id": "172b1c38-8436-4a82-9cac-796b13dc6f33",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "02127eb7-e34a-441d-80cf-ebba1fef8924",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T15:42:45+00:00",
      "updated_at": "2023-02-08T15:42:45+00:00",
      "number": "http://bqbl.it/02127eb7-e34a-441d-80cf-ebba1fef8924",
      "barcode_type": "qr_code",
      "image_url": "/uploads/34d36e1217dc98b04b14c952a5452d11/barcode/image/02127eb7-e34a-441d-80cf-ebba1fef8924/4b0b2ec5-c562-496a-9c0b-68e97fc54b80.svg",
      "owner_id": "172b1c38-8436-4a82-9cac-796b13dc6f33",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f3977a52-9b2c-4820-9c00-0f0bf6069559' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3977a52-9b2c-4820-9c00-0f0bf6069559",
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
    "id": "f3977a52-9b2c-4820-9c00-0f0bf6069559",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T15:42:45+00:00",
      "updated_at": "2023-02-08T15:42:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a1574c68dbf74e9a2dc1996b8b2b4617/barcode/image/f3977a52-9b2c-4820-9c00-0f0bf6069559/16723ffb-946b-4e16-ad7a-eee187f32583.svg",
      "owner_id": "f3499d62-2ee6-47a1-9193-4e2832068116",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4f6b1a21-65c7-4793-bb0a-b69e639067ea' \
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