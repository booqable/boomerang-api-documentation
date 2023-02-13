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
      "id": "3009ae7c-1dda-49d7-87bd-e4d08a4eea2f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:12:30+00:00",
        "updated_at": "2023-02-13T12:12:30+00:00",
        "number": "http://bqbl.it/3009ae7c-1dda-49d7-87bd-e4d08a4eea2f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/588b6026b70d175730de151a20c77194/barcode/image/3009ae7c-1dda-49d7-87bd-e4d08a4eea2f/c1c23e16-e317-4c6b-b1f7-f544d384e705.svg",
        "owner_id": "1715db25-8ab3-478d-99a2-60d52d2b3e5f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1715db25-8ab3-478d-99a2-60d52d2b3e5f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7d7212bf-5284-4765-98e3-bd85bf2ac7b6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7d7212bf-5284-4765-98e3-bd85bf2ac7b6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:12:31+00:00",
        "updated_at": "2023-02-13T12:12:31+00:00",
        "number": "http://bqbl.it/7d7212bf-5284-4765-98e3-bd85bf2ac7b6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dc2b76465969df75d7a61bed75e3aea2/barcode/image/7d7212bf-5284-4765-98e3-bd85bf2ac7b6/7a347fe9-038e-42b0-94ea-09c945e457c0.svg",
        "owner_id": "be239a2e-0540-4aec-ab19-5bbc1ad187f9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/be239a2e-0540-4aec-ab19-5bbc1ad187f9"
          },
          "data": {
            "type": "customers",
            "id": "be239a2e-0540-4aec-ab19-5bbc1ad187f9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "be239a2e-0540-4aec-ab19-5bbc1ad187f9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:12:31+00:00",
        "updated_at": "2023-02-13T12:12:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=be239a2e-0540-4aec-ab19-5bbc1ad187f9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=be239a2e-0540-4aec-ab19-5bbc1ad187f9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=be239a2e-0540-4aec-ab19-5bbc1ad187f9&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWEwZWFmMjgtMjI2ZS00NDM3LWE3NzktNmZkZjFjOWI0NWZh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ea0eaf28-226e-4437-a779-6fdf1c9b45fa",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-13T12:12:31+00:00",
        "updated_at": "2023-02-13T12:12:31+00:00",
        "number": "http://bqbl.it/ea0eaf28-226e-4437-a779-6fdf1c9b45fa",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2a15e09f2f7e31310c87d47dea6fe0a0/barcode/image/ea0eaf28-226e-4437-a779-6fdf1c9b45fa/5bc7bf47-8ef6-49b3-a13e-0e2fa706a896.svg",
        "owner_id": "16686ea8-f287-446a-b074-d4e7dcc1eed1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/16686ea8-f287-446a-b074-d4e7dcc1eed1"
          },
          "data": {
            "type": "customers",
            "id": "16686ea8-f287-446a-b074-d4e7dcc1eed1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "16686ea8-f287-446a-b074-d4e7dcc1eed1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:12:31+00:00",
        "updated_at": "2023-02-13T12:12:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=16686ea8-f287-446a-b074-d4e7dcc1eed1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=16686ea8-f287-446a-b074-d4e7dcc1eed1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=16686ea8-f287-446a-b074-d4e7dcc1eed1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:12:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e2193e2e-ddd6-4242-8a22-db25f052b1b7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e2193e2e-ddd6-4242-8a22-db25f052b1b7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:12:32+00:00",
      "updated_at": "2023-02-13T12:12:32+00:00",
      "number": "http://bqbl.it/e2193e2e-ddd6-4242-8a22-db25f052b1b7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c66e0a3d29497987944fb27d94b38193/barcode/image/e2193e2e-ddd6-4242-8a22-db25f052b1b7/1bae1196-ace1-4b79-95fd-43c4bf403702.svg",
      "owner_id": "1b36997e-b209-4afa-98e7-f39a767f0526",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1b36997e-b209-4afa-98e7-f39a767f0526"
        },
        "data": {
          "type": "customers",
          "id": "1b36997e-b209-4afa-98e7-f39a767f0526"
        }
      }
    }
  },
  "included": [
    {
      "id": "1b36997e-b209-4afa-98e7-f39a767f0526",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-13T12:12:32+00:00",
        "updated_at": "2023-02-13T12:12:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1b36997e-b209-4afa-98e7-f39a767f0526&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1b36997e-b209-4afa-98e7-f39a767f0526&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1b36997e-b209-4afa-98e7-f39a767f0526&filter[owner_type]=customers"
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
          "owner_id": "459eb7a6-1671-4db3-aae4-2b5ba20ef621",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4752eeaa-06ff-4983-8af7-25379d75a7fc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:12:33+00:00",
      "updated_at": "2023-02-13T12:12:33+00:00",
      "number": "http://bqbl.it/4752eeaa-06ff-4983-8af7-25379d75a7fc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6761a6709832e913fb5c126be7668226/barcode/image/4752eeaa-06ff-4983-8af7-25379d75a7fc/5df22a3d-42e2-497b-9c51-01a8a85e05bf.svg",
      "owner_id": "459eb7a6-1671-4db3-aae4-2b5ba20ef621",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2b135a9a-013d-4537-9e8e-3e48819c6bba' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2b135a9a-013d-4537-9e8e-3e48819c6bba",
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
    "id": "2b135a9a-013d-4537-9e8e-3e48819c6bba",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-13T12:12:33+00:00",
      "updated_at": "2023-02-13T12:12:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b7faacd958318d35d887462782b2ee4c/barcode/image/2b135a9a-013d-4537-9e8e-3e48819c6bba/4a381fc8-f1ce-4948-bde8-ff415b4b978c.svg",
      "owner_id": "fa06007f-aed9-4482-85e4-f024877f328d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2ab5fb98-dc01-43bc-8d4e-876baf1e06d1' \
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