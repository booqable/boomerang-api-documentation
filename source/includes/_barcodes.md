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
      "id": "436e1ca5-a234-4be0-9cb7-de90367a2b32",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:16:15+00:00",
        "updated_at": "2023-02-09T12:16:15+00:00",
        "number": "http://bqbl.it/436e1ca5-a234-4be0-9cb7-de90367a2b32",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7511d38bc30501844d288ce82f29e757/barcode/image/436e1ca5-a234-4be0-9cb7-de90367a2b32/0a490de5-76a1-4141-b353-3922131e8d6a.svg",
        "owner_id": "258810e2-7151-452e-868f-47802b8e3a7c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/258810e2-7151-452e-868f-47802b8e3a7c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2a5f77db-8d73-42d6-a484-911456548b05&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2a5f77db-8d73-42d6-a484-911456548b05",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:16:16+00:00",
        "updated_at": "2023-02-09T12:16:16+00:00",
        "number": "http://bqbl.it/2a5f77db-8d73-42d6-a484-911456548b05",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5d3076ff7936f72674fa1ab0dc66f1e5/barcode/image/2a5f77db-8d73-42d6-a484-911456548b05/cefaa1ba-6c6f-4dfd-97a4-c948e7f236b7.svg",
        "owner_id": "544c0e9f-e168-4355-8c86-877247d1f742",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/544c0e9f-e168-4355-8c86-877247d1f742"
          },
          "data": {
            "type": "customers",
            "id": "544c0e9f-e168-4355-8c86-877247d1f742"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "544c0e9f-e168-4355-8c86-877247d1f742",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:16:16+00:00",
        "updated_at": "2023-02-09T12:16:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=544c0e9f-e168-4355-8c86-877247d1f742&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=544c0e9f-e168-4355-8c86-877247d1f742&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=544c0e9f-e168-4355-8c86-877247d1f742&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMGQ0YTUzZDUtNTkxNC00N2I4LWFmNzUtYjk3MGY4OTk1NmQz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0d4a53d5-5914-47b8-af75-b970f89956d3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:16:16+00:00",
        "updated_at": "2023-02-09T12:16:16+00:00",
        "number": "http://bqbl.it/0d4a53d5-5914-47b8-af75-b970f89956d3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0e18c658cde196919a90482cca2c6a62/barcode/image/0d4a53d5-5914-47b8-af75-b970f89956d3/07f036b9-8a3f-4c44-8477-4171af560799.svg",
        "owner_id": "53a8c946-746b-494d-9d5e-e9822720708f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/53a8c946-746b-494d-9d5e-e9822720708f"
          },
          "data": {
            "type": "customers",
            "id": "53a8c946-746b-494d-9d5e-e9822720708f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "53a8c946-746b-494d-9d5e-e9822720708f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:16:16+00:00",
        "updated_at": "2023-02-09T12:16:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=53a8c946-746b-494d-9d5e-e9822720708f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=53a8c946-746b-494d-9d5e-e9822720708f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=53a8c946-746b-494d-9d5e-e9822720708f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:15:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/53563ad0-950f-4782-80ce-e186b5af9ca5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "53563ad0-950f-4782-80ce-e186b5af9ca5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:16:17+00:00",
      "updated_at": "2023-02-09T12:16:17+00:00",
      "number": "http://bqbl.it/53563ad0-950f-4782-80ce-e186b5af9ca5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/016fe502e776e3ba63718b6c40bb0585/barcode/image/53563ad0-950f-4782-80ce-e186b5af9ca5/127bf1a3-6a6b-46b3-9115-a7d2a479f3ce.svg",
      "owner_id": "f5436187-5e21-4791-8814-cfb0c9e05c08",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f5436187-5e21-4791-8814-cfb0c9e05c08"
        },
        "data": {
          "type": "customers",
          "id": "f5436187-5e21-4791-8814-cfb0c9e05c08"
        }
      }
    }
  },
  "included": [
    {
      "id": "f5436187-5e21-4791-8814-cfb0c9e05c08",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:16:17+00:00",
        "updated_at": "2023-02-09T12:16:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f5436187-5e21-4791-8814-cfb0c9e05c08&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f5436187-5e21-4791-8814-cfb0c9e05c08&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f5436187-5e21-4791-8814-cfb0c9e05c08&filter[owner_type]=customers"
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
          "owner_id": "fc1f094e-b0b0-4815-9afc-e80d0c2a5f24",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "759e1f19-3c69-4a1e-9fae-2fb92dcba90f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:16:18+00:00",
      "updated_at": "2023-02-09T12:16:18+00:00",
      "number": "http://bqbl.it/759e1f19-3c69-4a1e-9fae-2fb92dcba90f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c2b822afbfba0af7583ebd205dffd469/barcode/image/759e1f19-3c69-4a1e-9fae-2fb92dcba90f/ee95f546-e7ba-4e43-b917-5ef01be4b402.svg",
      "owner_id": "fc1f094e-b0b0-4815-9afc-e80d0c2a5f24",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c4c2905-f1f0-4fff-a5b0-07cb35da09ff' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c4c2905-f1f0-4fff-a5b0-07cb35da09ff",
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
    "id": "1c4c2905-f1f0-4fff-a5b0-07cb35da09ff",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:16:18+00:00",
      "updated_at": "2023-02-09T12:16:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/afd3cd5e1ce7e06d637c7b6b4ca5839f/barcode/image/1c4c2905-f1f0-4fff-a5b0-07cb35da09ff/6084a1e6-3df5-47f1-a8ec-eb7886a3566d.svg",
      "owner_id": "9d54d3e6-9da5-4682-9fd1-967a74dee82b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/668d6f3f-5da7-4532-acd0-565d36f84a84' \
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