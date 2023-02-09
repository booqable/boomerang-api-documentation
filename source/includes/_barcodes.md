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
      "id": "26bd5d1e-f54d-49c9-a032-4b38cb011245",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T14:21:07+00:00",
        "updated_at": "2023-02-09T14:21:07+00:00",
        "number": "http://bqbl.it/26bd5d1e-f54d-49c9-a032-4b38cb011245",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b80bccbbf80f02263e96b8f26753d051/barcode/image/26bd5d1e-f54d-49c9-a032-4b38cb011245/9e5865d4-fbd8-4b7f-b273-9dce14a32822.svg",
        "owner_id": "a8c5a779-af93-44d9-8c2d-bf8ba340cb88",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a8c5a779-af93-44d9-8c2d-bf8ba340cb88"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fac318efe-5703-4b16-9b48-e194afe666fc&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ac318efe-5703-4b16-9b48-e194afe666fc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T14:21:07+00:00",
        "updated_at": "2023-02-09T14:21:07+00:00",
        "number": "http://bqbl.it/ac318efe-5703-4b16-9b48-e194afe666fc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/049a988d83c86c52d68908e170906a8b/barcode/image/ac318efe-5703-4b16-9b48-e194afe666fc/1fafcecd-43cf-46f8-a224-cd3b04cef453.svg",
        "owner_id": "a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0"
          },
          "data": {
            "type": "customers",
            "id": "a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T14:21:07+00:00",
        "updated_at": "2023-02-09T14:21:07+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a2e4b22d-4e4f-4b8e-bbe3-1a76643cf0d0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGQxMTE5NjYtM2ZjNy00YzRlLWI5NTktMGZkODRkNTk0NTI1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4d111966-3fc7-4c4e-b959-0fd84d594525",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T14:21:08+00:00",
        "updated_at": "2023-02-09T14:21:08+00:00",
        "number": "http://bqbl.it/4d111966-3fc7-4c4e-b959-0fd84d594525",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d13ab748aaea4ffde30525a0b572c914/barcode/image/4d111966-3fc7-4c4e-b959-0fd84d594525/ba5720e8-f30f-445f-8211-c53521cfd589.svg",
        "owner_id": "fd6f8bff-b98a-4745-89ba-c3b8a66e86e7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fd6f8bff-b98a-4745-89ba-c3b8a66e86e7"
          },
          "data": {
            "type": "customers",
            "id": "fd6f8bff-b98a-4745-89ba-c3b8a66e86e7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fd6f8bff-b98a-4745-89ba-c3b8a66e86e7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T14:21:08+00:00",
        "updated_at": "2023-02-09T14:21:08+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fd6f8bff-b98a-4745-89ba-c3b8a66e86e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fd6f8bff-b98a-4745-89ba-c3b8a66e86e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fd6f8bff-b98a-4745-89ba-c3b8a66e86e7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T14:20:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3173f7e9-a119-424b-82d5-551ee3be5e91?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3173f7e9-a119-424b-82d5-551ee3be5e91",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T14:21:09+00:00",
      "updated_at": "2023-02-09T14:21:09+00:00",
      "number": "http://bqbl.it/3173f7e9-a119-424b-82d5-551ee3be5e91",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a9632079b833fa9257328788cc167ae1/barcode/image/3173f7e9-a119-424b-82d5-551ee3be5e91/e9d97839-1a0b-4454-be47-4c7b3ab99452.svg",
      "owner_id": "176091a1-e6ba-429b-8b2e-005a0449d536",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/176091a1-e6ba-429b-8b2e-005a0449d536"
        },
        "data": {
          "type": "customers",
          "id": "176091a1-e6ba-429b-8b2e-005a0449d536"
        }
      }
    }
  },
  "included": [
    {
      "id": "176091a1-e6ba-429b-8b2e-005a0449d536",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T14:21:09+00:00",
        "updated_at": "2023-02-09T14:21:09+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=176091a1-e6ba-429b-8b2e-005a0449d536&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=176091a1-e6ba-429b-8b2e-005a0449d536&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=176091a1-e6ba-429b-8b2e-005a0449d536&filter[owner_type]=customers"
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
          "owner_id": "b996de79-49db-434d-9e94-3d6382c5e42d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c8b49a26-82a6-4fe6-8ef5-0bb40dd01271",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T14:21:10+00:00",
      "updated_at": "2023-02-09T14:21:10+00:00",
      "number": "http://bqbl.it/c8b49a26-82a6-4fe6-8ef5-0bb40dd01271",
      "barcode_type": "qr_code",
      "image_url": "/uploads/65594a0c43dc8efaf5dead43084f4433/barcode/image/c8b49a26-82a6-4fe6-8ef5-0bb40dd01271/f0493058-d835-4cf4-86ec-caecd6add0f5.svg",
      "owner_id": "b996de79-49db-434d-9e94-3d6382c5e42d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c0df1f78-de1b-44e4-9669-071453a84374' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c0df1f78-de1b-44e4-9669-071453a84374",
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
    "id": "c0df1f78-de1b-44e4-9669-071453a84374",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T14:21:11+00:00",
      "updated_at": "2023-02-09T14:21:11+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c6446a4de0719e39092487e96de0fec3/barcode/image/c0df1f78-de1b-44e4-9669-071453a84374/3d8f474c-67e2-4e7e-b100-d0976863de5b.svg",
      "owner_id": "93dc2a9f-3dcd-401d-90ff-eaad52e279b2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8416697b-a439-459e-88f8-86a5d1efa54b' \
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