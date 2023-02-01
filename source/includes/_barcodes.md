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
      "id": "dc66e9b0-eadb-4044-9e12-2811afa4b63f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T15:17:25+00:00",
        "updated_at": "2023-02-01T15:17:25+00:00",
        "number": "http://bqbl.it/dc66e9b0-eadb-4044-9e12-2811afa4b63f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7977ee41142f0424bd17c51104b38649/barcode/image/dc66e9b0-eadb-4044-9e12-2811afa4b63f/7958ae5f-4a68-4adf-a778-6b5b991f8a3e.svg",
        "owner_id": "7cf445aa-084a-437c-bf57-5a545223f7ce",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7cf445aa-084a-437c-bf57-5a545223f7ce"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc32854e2-9465-4913-834a-f403d8495979&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c32854e2-9465-4913-834a-f403d8495979",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T15:17:25+00:00",
        "updated_at": "2023-02-01T15:17:25+00:00",
        "number": "http://bqbl.it/c32854e2-9465-4913-834a-f403d8495979",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2aefa8f00aff6d0271b4cebb58256167/barcode/image/c32854e2-9465-4913-834a-f403d8495979/0e49070c-ca9e-4702-b011-99290f735b50.svg",
        "owner_id": "7ad16bb1-ef75-44ed-a9b1-240516288633",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7ad16bb1-ef75-44ed-a9b1-240516288633"
          },
          "data": {
            "type": "customers",
            "id": "7ad16bb1-ef75-44ed-a9b1-240516288633"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7ad16bb1-ef75-44ed-a9b1-240516288633",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T15:17:25+00:00",
        "updated_at": "2023-02-01T15:17:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ad16bb1-ef75-44ed-a9b1-240516288633&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ad16bb1-ef75-44ed-a9b1-240516288633&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7ad16bb1-ef75-44ed-a9b1-240516288633&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzE2YTQ3NTgtNWFjYS00ZjA3LTg5NGYtMDBkOWVmOTZjNDc5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "316a4758-5aca-4f07-894f-00d9ef96c479",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T15:17:25+00:00",
        "updated_at": "2023-02-01T15:17:25+00:00",
        "number": "http://bqbl.it/316a4758-5aca-4f07-894f-00d9ef96c479",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6857075e8ba8734bfe7847a32a3c933a/barcode/image/316a4758-5aca-4f07-894f-00d9ef96c479/801f3ef0-db9f-434e-adf1-dac57ce529d4.svg",
        "owner_id": "29df300e-51c1-4e9a-b932-48b93bf9fd21",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/29df300e-51c1-4e9a-b932-48b93bf9fd21"
          },
          "data": {
            "type": "customers",
            "id": "29df300e-51c1-4e9a-b932-48b93bf9fd21"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "29df300e-51c1-4e9a-b932-48b93bf9fd21",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T15:17:25+00:00",
        "updated_at": "2023-02-01T15:17:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=29df300e-51c1-4e9a-b932-48b93bf9fd21&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=29df300e-51c1-4e9a-b932-48b93bf9fd21&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=29df300e-51c1-4e9a-b932-48b93bf9fd21&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:17:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4c0736e5-16e7-41d2-9a1a-5e7b10a3c484?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4c0736e5-16e7-41d2-9a1a-5e7b10a3c484",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T15:17:26+00:00",
      "updated_at": "2023-02-01T15:17:26+00:00",
      "number": "http://bqbl.it/4c0736e5-16e7-41d2-9a1a-5e7b10a3c484",
      "barcode_type": "qr_code",
      "image_url": "/uploads/225e9776846ea4a033aefbb4a7f1290a/barcode/image/4c0736e5-16e7-41d2-9a1a-5e7b10a3c484/657e789a-de2d-44d2-86cd-3a4d6dc7ae75.svg",
      "owner_id": "e387a4e6-2d87-4c0f-aacf-190c65d8c227",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e387a4e6-2d87-4c0f-aacf-190c65d8c227"
        },
        "data": {
          "type": "customers",
          "id": "e387a4e6-2d87-4c0f-aacf-190c65d8c227"
        }
      }
    }
  },
  "included": [
    {
      "id": "e387a4e6-2d87-4c0f-aacf-190c65d8c227",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T15:17:26+00:00",
        "updated_at": "2023-02-01T15:17:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e387a4e6-2d87-4c0f-aacf-190c65d8c227&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e387a4e6-2d87-4c0f-aacf-190c65d8c227&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e387a4e6-2d87-4c0f-aacf-190c65d8c227&filter[owner_type]=customers"
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
          "owner_id": "770bbe7b-814b-4d0e-afc8-cdf993bd42c5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3c8f5ba2-e759-4abb-839c-636dc35b08a0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T15:17:26+00:00",
      "updated_at": "2023-02-01T15:17:26+00:00",
      "number": "http://bqbl.it/3c8f5ba2-e759-4abb-839c-636dc35b08a0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/461dba67fdea93a71c1340cbf129118e/barcode/image/3c8f5ba2-e759-4abb-839c-636dc35b08a0/4da26620-8d75-485e-8adf-768564122389.svg",
      "owner_id": "770bbe7b-814b-4d0e-afc8-cdf993bd42c5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2c76cee0-7d92-4c38-8f46-969b0c2bb93a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2c76cee0-7d92-4c38-8f46-969b0c2bb93a",
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
    "id": "2c76cee0-7d92-4c38-8f46-969b0c2bb93a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T15:17:27+00:00",
      "updated_at": "2023-02-01T15:17:27+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/051d0c8fd10dcf3f1f2ddefb476e4ee4/barcode/image/2c76cee0-7d92-4c38-8f46-969b0c2bb93a/72fded35-5258-4707-a687-b547f7058f5d.svg",
      "owner_id": "f43ae49f-a3a2-41c3-80cd-6267f9db5064",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f926cf4a-efd6-4d65-b89a-d6f90315e0ff' \
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