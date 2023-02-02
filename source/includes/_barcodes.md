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
      "id": "cf21a482-20a8-4c59-8e80-03eb65832ab6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:58:07+00:00",
        "updated_at": "2023-02-02T16:58:07+00:00",
        "number": "http://bqbl.it/cf21a482-20a8-4c59-8e80-03eb65832ab6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/44a5b53ed97c17922d523f579039766c/barcode/image/cf21a482-20a8-4c59-8e80-03eb65832ab6/d80d1119-fad2-41b4-9f28-22a2372f9abe.svg",
        "owner_id": "3b7604a2-8af0-42f8-bbe7-c1cd766bf1ce",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3b7604a2-8af0-42f8-bbe7-c1cd766bf1ce"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F63ad3876-35f6-4b33-9785-7c232ba77c7e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "63ad3876-35f6-4b33-9785-7c232ba77c7e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:58:08+00:00",
        "updated_at": "2023-02-02T16:58:08+00:00",
        "number": "http://bqbl.it/63ad3876-35f6-4b33-9785-7c232ba77c7e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/03bd27d2d4d72d01b1ac389543431f6b/barcode/image/63ad3876-35f6-4b33-9785-7c232ba77c7e/f29d4925-2fce-4ff2-9317-743a2fd88f44.svg",
        "owner_id": "c18ddec9-4fd6-4cde-926c-8052a47ab88d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c18ddec9-4fd6-4cde-926c-8052a47ab88d"
          },
          "data": {
            "type": "customers",
            "id": "c18ddec9-4fd6-4cde-926c-8052a47ab88d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c18ddec9-4fd6-4cde-926c-8052a47ab88d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:58:08+00:00",
        "updated_at": "2023-02-02T16:58:08+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c18ddec9-4fd6-4cde-926c-8052a47ab88d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c18ddec9-4fd6-4cde-926c-8052a47ab88d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c18ddec9-4fd6-4cde-926c-8052a47ab88d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDI3YjdmNDEtOWQ1NC00Y2M5LWEwZDQtM2JjMTE3ODU0YTA0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "027b7f41-9d54-4cc9-a0d4-3bc117854a04",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:58:08+00:00",
        "updated_at": "2023-02-02T16:58:08+00:00",
        "number": "http://bqbl.it/027b7f41-9d54-4cc9-a0d4-3bc117854a04",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e66d4cf5ecdbc3fcd81246dee23e9cb2/barcode/image/027b7f41-9d54-4cc9-a0d4-3bc117854a04/b25f177d-3cc1-42b8-b994-6e3c41ca116b.svg",
        "owner_id": "cbbdcc82-2f81-4bcc-8884-968b38fb4c6f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cbbdcc82-2f81-4bcc-8884-968b38fb4c6f"
          },
          "data": {
            "type": "customers",
            "id": "cbbdcc82-2f81-4bcc-8884-968b38fb4c6f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cbbdcc82-2f81-4bcc-8884-968b38fb4c6f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:58:08+00:00",
        "updated_at": "2023-02-02T16:58:08+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cbbdcc82-2f81-4bcc-8884-968b38fb4c6f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cbbdcc82-2f81-4bcc-8884-968b38fb4c6f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cbbdcc82-2f81-4bcc-8884-968b38fb4c6f&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:57:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2ccddd42-f392-4614-96c5-c73588b2ae03?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2ccddd42-f392-4614-96c5-c73588b2ae03",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:58:09+00:00",
      "updated_at": "2023-02-02T16:58:09+00:00",
      "number": "http://bqbl.it/2ccddd42-f392-4614-96c5-c73588b2ae03",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6546ae940a2eaacc9b4ae8e6fd57aa9a/barcode/image/2ccddd42-f392-4614-96c5-c73588b2ae03/5e472a30-eca3-463a-aebb-2c035ad90818.svg",
      "owner_id": "a286b39e-2d4e-4c83-9c6b-2cde5feeb900",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a286b39e-2d4e-4c83-9c6b-2cde5feeb900"
        },
        "data": {
          "type": "customers",
          "id": "a286b39e-2d4e-4c83-9c6b-2cde5feeb900"
        }
      }
    }
  },
  "included": [
    {
      "id": "a286b39e-2d4e-4c83-9c6b-2cde5feeb900",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:58:09+00:00",
        "updated_at": "2023-02-02T16:58:09+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a286b39e-2d4e-4c83-9c6b-2cde5feeb900&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a286b39e-2d4e-4c83-9c6b-2cde5feeb900&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a286b39e-2d4e-4c83-9c6b-2cde5feeb900&filter[owner_type]=customers"
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
          "owner_id": "c0f28495-d48e-4689-b5c7-d8cf899c3bb4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ba97c093-d680-4acd-a956-55bc4a7c5377",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:58:09+00:00",
      "updated_at": "2023-02-02T16:58:09+00:00",
      "number": "http://bqbl.it/ba97c093-d680-4acd-a956-55bc4a7c5377",
      "barcode_type": "qr_code",
      "image_url": "/uploads/67241e3fcfad24408e2f8f3f56b5b8bd/barcode/image/ba97c093-d680-4acd-a956-55bc4a7c5377/bda9d044-0041-490d-9956-2c385c70b292.svg",
      "owner_id": "c0f28495-d48e-4689-b5c7-d8cf899c3bb4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/aca1a940-b8a9-4477-933c-07b50de26524' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aca1a940-b8a9-4477-933c-07b50de26524",
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
    "id": "aca1a940-b8a9-4477-933c-07b50de26524",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:58:10+00:00",
      "updated_at": "2023-02-02T16:58:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/75517668f6faf2f20652016736671d3b/barcode/image/aca1a940-b8a9-4477-933c-07b50de26524/3b0acc88-6aff-4d99-8f76-4ee78bfdf557.svg",
      "owner_id": "bb1ccc04-c220-463c-a262-1e709f14bbdb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/632435ad-9a26-40c9-8aac-d60a49639abd' \
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