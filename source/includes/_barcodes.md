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
      "id": "1c3ecae8-1a91-422f-9e68-f8ff02902c01",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T14:56:14+00:00",
        "updated_at": "2023-02-24T14:56:14+00:00",
        "number": "http://bqbl.it/1c3ecae8-1a91-422f-9e68-f8ff02902c01",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d9505620d607d664f656890d652fee0a/barcode/image/1c3ecae8-1a91-422f-9e68-f8ff02902c01/32812359-7c78-41c7-b417-9eb60090f883.svg",
        "owner_id": "aac77ac3-a4c2-4bc8-96c8-20b86d144bc7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aac77ac3-a4c2-4bc8-96c8-20b86d144bc7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5ec17b57-139d-42ba-a493-6e7e297ac543&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5ec17b57-139d-42ba-a493-6e7e297ac543",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T14:56:15+00:00",
        "updated_at": "2023-02-24T14:56:15+00:00",
        "number": "http://bqbl.it/5ec17b57-139d-42ba-a493-6e7e297ac543",
        "barcode_type": "qr_code",
        "image_url": "/uploads/29034db4181e17a75c9189da79808160/barcode/image/5ec17b57-139d-42ba-a493-6e7e297ac543/3849beb4-3f85-4f47-902f-a6a55c00d2ae.svg",
        "owner_id": "83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de"
          },
          "data": {
            "type": "customers",
            "id": "83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T14:56:15+00:00",
        "updated_at": "2023-02-24T14:56:15+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=83aea6fc-7ac0-4eb9-bc16-b88cbe09e3de&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTM3YWY1NTktM2Y1MS00ZjUzLTllMWUtMjQ2MzYwMjZiYmEy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "137af559-3f51-4f53-9e1e-24636026bba2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T14:56:16+00:00",
        "updated_at": "2023-02-24T14:56:16+00:00",
        "number": "http://bqbl.it/137af559-3f51-4f53-9e1e-24636026bba2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/93f746df9d2c0c6060db617e36aca05f/barcode/image/137af559-3f51-4f53-9e1e-24636026bba2/ba304386-3ee3-49e9-bfed-2ca1061d7d18.svg",
        "owner_id": "003d483e-fe31-42d0-9f32-dc9c386daa90",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/003d483e-fe31-42d0-9f32-dc9c386daa90"
          },
          "data": {
            "type": "customers",
            "id": "003d483e-fe31-42d0-9f32-dc9c386daa90"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "003d483e-fe31-42d0-9f32-dc9c386daa90",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T14:56:16+00:00",
        "updated_at": "2023-02-24T14:56:16+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=003d483e-fe31-42d0-9f32-dc9c386daa90&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=003d483e-fe31-42d0-9f32-dc9c386daa90&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=003d483e-fe31-42d0-9f32-dc9c386daa90&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:55:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3c062805-3350-48ce-a7cb-940bba04cb54?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3c062805-3350-48ce-a7cb-940bba04cb54",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T14:56:17+00:00",
      "updated_at": "2023-02-24T14:56:17+00:00",
      "number": "http://bqbl.it/3c062805-3350-48ce-a7cb-940bba04cb54",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7d45c4c495f9ad694e1c603eb0929d69/barcode/image/3c062805-3350-48ce-a7cb-940bba04cb54/a105dc2a-c7ce-4134-8d10-b846fff847aa.svg",
      "owner_id": "3b7d7803-f652-418b-a227-de9fb87d7f15",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3b7d7803-f652-418b-a227-de9fb87d7f15"
        },
        "data": {
          "type": "customers",
          "id": "3b7d7803-f652-418b-a227-de9fb87d7f15"
        }
      }
    }
  },
  "included": [
    {
      "id": "3b7d7803-f652-418b-a227-de9fb87d7f15",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T14:56:17+00:00",
        "updated_at": "2023-02-24T14:56:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3b7d7803-f652-418b-a227-de9fb87d7f15&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3b7d7803-f652-418b-a227-de9fb87d7f15&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3b7d7803-f652-418b-a227-de9fb87d7f15&filter[owner_type]=customers"
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
          "owner_id": "73eee040-99d9-4db5-8707-986eeb94bc6f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "154c1ef9-61f5-4f0e-a026-724dbb9e93be",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T14:56:17+00:00",
      "updated_at": "2023-02-24T14:56:17+00:00",
      "number": "http://bqbl.it/154c1ef9-61f5-4f0e-a026-724dbb9e93be",
      "barcode_type": "qr_code",
      "image_url": "/uploads/80a0a2af1e724590db8dcc3f9f5e0ceb/barcode/image/154c1ef9-61f5-4f0e-a026-724dbb9e93be/cd5c3bca-153a-4ad3-b91f-3163d40fcf71.svg",
      "owner_id": "73eee040-99d9-4db5-8707-986eeb94bc6f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a09e92fd-4194-455c-9b60-83fd29b044e6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a09e92fd-4194-455c-9b60-83fd29b044e6",
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
    "id": "a09e92fd-4194-455c-9b60-83fd29b044e6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T14:56:18+00:00",
      "updated_at": "2023-02-24T14:56:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cec98ecbd3581bbff466b6d97faadba6/barcode/image/a09e92fd-4194-455c-9b60-83fd29b044e6/0461ac89-3347-4532-a53c-5501346713f8.svg",
      "owner_id": "6c7e2105-e899-455a-ad4a-575797fa48b3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cd437c09-17df-4219-b5d7-27bce017af8c' \
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