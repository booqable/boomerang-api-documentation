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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "b1d63907-56a6-426d-bd43-e3a17f99eb7f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-08T08:04:53+00:00",
        "updated_at": "2022-06-08T08:04:53+00:00",
        "number": "http://bqbl.it/b1d63907-56a6-426d-bd43-e3a17f99eb7f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b63d60b10f2f8c3f9a57c0f46ff795ec/barcode/image/b1d63907-56a6-426d-bd43-e3a17f99eb7f/1085056d-ac31-43b2-a065-2e79d2182029.svg",
        "owner_id": "bf11ee0d-c0e2-472b-80c3-6d762475c69b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bf11ee0d-c0e2-472b-80c3-6d762475c69b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd8597ecc-8efb-4b57-9090-714da9f2296a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d8597ecc-8efb-4b57-9090-714da9f2296a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-08T08:04:54+00:00",
        "updated_at": "2022-06-08T08:04:54+00:00",
        "number": "http://bqbl.it/d8597ecc-8efb-4b57-9090-714da9f2296a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/80f5b43dc29b380ef1bd1036065a1c3f/barcode/image/d8597ecc-8efb-4b57-9090-714da9f2296a/769c1672-e27a-4acf-be49-7589fd41f2fa.svg",
        "owner_id": "a1661837-a5e0-4d15-8b9e-3d64187a098f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a1661837-a5e0-4d15-8b9e-3d64187a098f"
          },
          "data": {
            "type": "customers",
            "id": "a1661837-a5e0-4d15-8b9e-3d64187a098f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a1661837-a5e0-4d15-8b9e-3d64187a098f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-08T08:04:54+00:00",
        "updated_at": "2022-06-08T08:04:54+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Dickens, Medhurst and Runolfsson",
        "email": "runolfsson.dickens.and.medhurst@yost.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=a1661837-a5e0-4d15-8b9e-3d64187a098f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a1661837-a5e0-4d15-8b9e-3d64187a098f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a1661837-a5e0-4d15-8b9e-3d64187a098f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDdjMzk4MTktNWQwYi00ODJiLTlkMTUtZmRhOTBiMTk2ZDll&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "47c39819-5d0b-482b-9d15-fda90b196d9e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-08T08:04:54+00:00",
        "updated_at": "2022-06-08T08:04:54+00:00",
        "number": "http://bqbl.it/47c39819-5d0b-482b-9d15-fda90b196d9e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f14c3ac75eed667647a1d9f2a7e58cfb/barcode/image/47c39819-5d0b-482b-9d15-fda90b196d9e/c81ad181-fc1f-4b22-8033-3d5af3731ecf.svg",
        "owner_id": "9a25d7ba-1bea-44ea-998f-6cefb9bfc452",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9a25d7ba-1bea-44ea-998f-6cefb9bfc452"
          },
          "data": {
            "type": "customers",
            "id": "9a25d7ba-1bea-44ea-998f-6cefb9bfc452"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9a25d7ba-1bea-44ea-998f-6cefb9bfc452",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-08T08:04:54+00:00",
        "updated_at": "2022-06-08T08:04:54+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Runte-Nolan",
        "email": "nolan.runte@murazik.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=9a25d7ba-1bea-44ea-998f-6cefb9bfc452&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9a25d7ba-1bea-44ea-998f-6cefb9bfc452&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9a25d7ba-1bea-44ea-998f-6cefb9bfc452&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-08T08:04:43Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/360d87cb-ec19-48c4-90c8-330b4e5e14c6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "360d87cb-ec19-48c4-90c8-330b4e5e14c6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-08T08:04:55+00:00",
      "updated_at": "2022-06-08T08:04:55+00:00",
      "number": "http://bqbl.it/360d87cb-ec19-48c4-90c8-330b4e5e14c6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7c982ea54a33373e3273f30bdb756fce/barcode/image/360d87cb-ec19-48c4-90c8-330b4e5e14c6/e25a3c50-42fa-4ec3-8650-0d1e34faa11c.svg",
      "owner_id": "50e66af1-baf1-45cf-bf00-8628ea31b3d7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/50e66af1-baf1-45cf-bf00-8628ea31b3d7"
        },
        "data": {
          "type": "customers",
          "id": "50e66af1-baf1-45cf-bf00-8628ea31b3d7"
        }
      }
    }
  },
  "included": [
    {
      "id": "50e66af1-baf1-45cf-bf00-8628ea31b3d7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-08T08:04:55+00:00",
        "updated_at": "2022-06-08T08:04:55+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Pouros-Bernier",
        "email": "bernier_pouros@kuhlman.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=50e66af1-baf1-45cf-bf00-8628ea31b3d7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=50e66af1-baf1-45cf-bf00-8628ea31b3d7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=50e66af1-baf1-45cf-bf00-8628ea31b3d7&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "bef31c35-50d2-4c7c-b25c-2fddc768b853",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f9716502-ec80-49ee-84c9-649f04c8b69d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-08T08:04:55+00:00",
      "updated_at": "2022-06-08T08:04:55+00:00",
      "number": "http://bqbl.it/f9716502-ec80-49ee-84c9-649f04c8b69d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4ba5549cb6ba2b54809e0e2ad89e9ea1/barcode/image/f9716502-ec80-49ee-84c9-649f04c8b69d/82421d7b-23a4-405b-b0fd-a950090d3f4b.svg",
      "owner_id": "bef31c35-50d2-4c7c-b25c-2fddc768b853",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d75ccff-e6f0-4278-b9e6-1f5f2ca7e868' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d75ccff-e6f0-4278-b9e6-1f5f2ca7e868",
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
    "id": "2d75ccff-e6f0-4278-b9e6-1f5f2ca7e868",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-08T08:04:56+00:00",
      "updated_at": "2022-06-08T08:04:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4601f79497997640722a84b84f92b0ca/barcode/image/2d75ccff-e6f0-4278-b9e6-1f5f2ca7e868/12404d54-c38c-4097-940c-c2b432f430c9.svg",
      "owner_id": "f2c8f51a-da3a-4e8c-9e71-00fc9785d428",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/086a9b90-d141-416a-8329-0929ca7e781c' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes