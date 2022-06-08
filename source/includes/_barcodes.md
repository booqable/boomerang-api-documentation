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
      "id": "8cd1d5e8-479d-4187-a5a3-783ba9622962",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-08T14:24:10+00:00",
        "updated_at": "2022-06-08T14:24:10+00:00",
        "number": "http://bqbl.it/8cd1d5e8-479d-4187-a5a3-783ba9622962",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d8a8bb5ea9da579787d5c216b87e4410/barcode/image/8cd1d5e8-479d-4187-a5a3-783ba9622962/f5c0c6cb-21c7-4cf6-ba44-629da3487b5b.svg",
        "owner_id": "3c002fd4-b4eb-4779-8581-4f343dc5bf74",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3c002fd4-b4eb-4779-8581-4f343dc5bf74"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6a204dfc-ceb5-4e82-af47-cb3f8910fbff&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6a204dfc-ceb5-4e82-af47-cb3f8910fbff",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-08T14:24:11+00:00",
        "updated_at": "2022-06-08T14:24:11+00:00",
        "number": "http://bqbl.it/6a204dfc-ceb5-4e82-af47-cb3f8910fbff",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e85c7a7ca06f8ad470edad14ebdff2ec/barcode/image/6a204dfc-ceb5-4e82-af47-cb3f8910fbff/f2e4226a-0855-4fde-988b-0c95a07365db.svg",
        "owner_id": "a35db4ca-0cdd-443b-ad20-84fa048fbc37",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a35db4ca-0cdd-443b-ad20-84fa048fbc37"
          },
          "data": {
            "type": "customers",
            "id": "a35db4ca-0cdd-443b-ad20-84fa048fbc37"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a35db4ca-0cdd-443b-ad20-84fa048fbc37",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-08T14:24:11+00:00",
        "updated_at": "2022-06-08T14:24:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Fay-Olson",
        "email": "olson_fay@heller.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=a35db4ca-0cdd-443b-ad20-84fa048fbc37&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a35db4ca-0cdd-443b-ad20-84fa048fbc37&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a35db4ca-0cdd-443b-ad20-84fa048fbc37&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvY2EzY2Y4ZDMtNTc5Yy00ZDVjLTljZjktODViYmMwZDY0YWNk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ca3cf8d3-579c-4d5c-9cf9-85bbc0d64acd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-08T14:24:12+00:00",
        "updated_at": "2022-06-08T14:24:12+00:00",
        "number": "http://bqbl.it/ca3cf8d3-579c-4d5c-9cf9-85bbc0d64acd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/893ab84db958ead494f4be4c68d8f1b7/barcode/image/ca3cf8d3-579c-4d5c-9cf9-85bbc0d64acd/d288f10d-ce5c-4745-985b-64bd0685b362.svg",
        "owner_id": "9f1442b7-51f3-4eff-b078-096550af8cbc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9f1442b7-51f3-4eff-b078-096550af8cbc"
          },
          "data": {
            "type": "customers",
            "id": "9f1442b7-51f3-4eff-b078-096550af8cbc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9f1442b7-51f3-4eff-b078-096550af8cbc",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-08T14:24:12+00:00",
        "updated_at": "2022-06-08T14:24:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Schultz Inc",
        "email": "inc.schultz@kautzer-luettgen.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=9f1442b7-51f3-4eff-b078-096550af8cbc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9f1442b7-51f3-4eff-b078-096550af8cbc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9f1442b7-51f3-4eff-b078-096550af8cbc&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-08T14:23:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/38f69338-9e31-4480-b2bb-fc90e7a576b9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "38f69338-9e31-4480-b2bb-fc90e7a576b9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-08T14:24:13+00:00",
      "updated_at": "2022-06-08T14:24:13+00:00",
      "number": "http://bqbl.it/38f69338-9e31-4480-b2bb-fc90e7a576b9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/40fce3d091c96f0cd1397948e66b1bbd/barcode/image/38f69338-9e31-4480-b2bb-fc90e7a576b9/11e15b3a-9933-47a3-bc81-a134d796f86f.svg",
      "owner_id": "fb8b3da4-84de-4ba9-8ce5-a80749c76561",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fb8b3da4-84de-4ba9-8ce5-a80749c76561"
        },
        "data": {
          "type": "customers",
          "id": "fb8b3da4-84de-4ba9-8ce5-a80749c76561"
        }
      }
    }
  },
  "included": [
    {
      "id": "fb8b3da4-84de-4ba9-8ce5-a80749c76561",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-08T14:24:13+00:00",
        "updated_at": "2022-06-08T14:24:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Sawayn LLC",
        "email": "llc.sawayn@murphy.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=fb8b3da4-84de-4ba9-8ce5-a80749c76561&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fb8b3da4-84de-4ba9-8ce5-a80749c76561&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fb8b3da4-84de-4ba9-8ce5-a80749c76561&filter[owner_type]=customers"
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
          "owner_id": "87eddb04-1b2d-4a01-9970-899a76cc10f7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6aff2c51-deac-4e92-b819-b10e3ea60b36",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-08T14:24:14+00:00",
      "updated_at": "2022-06-08T14:24:14+00:00",
      "number": "http://bqbl.it/6aff2c51-deac-4e92-b819-b10e3ea60b36",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0d0e75983396a5ed48fd56ff919bd493/barcode/image/6aff2c51-deac-4e92-b819-b10e3ea60b36/d59a1109-313b-4f1a-9dff-214a82cb1631.svg",
      "owner_id": "87eddb04-1b2d-4a01-9970-899a76cc10f7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2fd04d7f-3681-4339-8a68-ac4af8ae7428' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2fd04d7f-3681-4339-8a68-ac4af8ae7428",
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
    "id": "2fd04d7f-3681-4339-8a68-ac4af8ae7428",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-08T14:24:14+00:00",
      "updated_at": "2022-06-08T14:24:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/96351b71f1a01ad5f4a18257571d7733/barcode/image/2fd04d7f-3681-4339-8a68-ac4af8ae7428/d8ea5507-72ba-479b-8b2c-bb2b36752c08.svg",
      "owner_id": "864276d3-f39a-4037-a856-da47680520ea",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/969c0d93-7eb6-4bdc-b0a3-0d4244d67a66' \
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