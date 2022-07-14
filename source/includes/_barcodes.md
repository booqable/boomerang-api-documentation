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
      "id": "fdae31dd-a939-41e2-8852-f55d7868c176",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T12:39:14+00:00",
        "updated_at": "2022-07-14T12:39:14+00:00",
        "number": "http://bqbl.it/fdae31dd-a939-41e2-8852-f55d7868c176",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1325547009c424a606c52b249d4fd66f/barcode/image/fdae31dd-a939-41e2-8852-f55d7868c176/4a14e9e9-2eea-437b-9b7a-26321718e771.svg",
        "owner_id": "2922d7c1-1d01-4f24-bbd3-145b136c2b6b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2922d7c1-1d01-4f24-bbd3-145b136c2b6b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2222fbc1-11bd-4270-9dfa-3a91710ec151&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2222fbc1-11bd-4270-9dfa-3a91710ec151",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T12:39:14+00:00",
        "updated_at": "2022-07-14T12:39:14+00:00",
        "number": "http://bqbl.it/2222fbc1-11bd-4270-9dfa-3a91710ec151",
        "barcode_type": "qr_code",
        "image_url": "/uploads/30b0c307ed704120111474b9b88b8c70/barcode/image/2222fbc1-11bd-4270-9dfa-3a91710ec151/59dc07eb-0206-40d3-b899-1284e4920b0a.svg",
        "owner_id": "a124ead9-75fd-4fec-9022-24b2176b5cf3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a124ead9-75fd-4fec-9022-24b2176b5cf3"
          },
          "data": {
            "type": "customers",
            "id": "a124ead9-75fd-4fec-9022-24b2176b5cf3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a124ead9-75fd-4fec-9022-24b2176b5cf3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T12:39:14+00:00",
        "updated_at": "2022-07-14T12:39:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Shields, Hand and Morar",
        "email": "shields.hand.and.morar@king-nicolas.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=a124ead9-75fd-4fec-9022-24b2176b5cf3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a124ead9-75fd-4fec-9022-24b2176b5cf3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a124ead9-75fd-4fec-9022-24b2176b5cf3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGE4YzI4ZTktODM0Zi00YWZmLWI0YjItNmVkNDlhMTAzZmM5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8a8c28e9-834f-4aff-b4b2-6ed49a103fc9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T12:39:15+00:00",
        "updated_at": "2022-07-14T12:39:15+00:00",
        "number": "http://bqbl.it/8a8c28e9-834f-4aff-b4b2-6ed49a103fc9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5a1494d1001cfaa87228f73aff3ecc6e/barcode/image/8a8c28e9-834f-4aff-b4b2-6ed49a103fc9/7c86c6c9-a52f-4521-8947-f43218099fa8.svg",
        "owner_id": "fd0e43b0-17b1-4b41-aeaa-c1e397be98f4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fd0e43b0-17b1-4b41-aeaa-c1e397be98f4"
          },
          "data": {
            "type": "customers",
            "id": "fd0e43b0-17b1-4b41-aeaa-c1e397be98f4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fd0e43b0-17b1-4b41-aeaa-c1e397be98f4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T12:39:15+00:00",
        "updated_at": "2022-07-14T12:39:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mertz, Welch and Torphy",
        "email": "mertz.torphy.and.welch@greenholt.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=fd0e43b0-17b1-4b41-aeaa-c1e397be98f4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fd0e43b0-17b1-4b41-aeaa-c1e397be98f4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fd0e43b0-17b1-4b41-aeaa-c1e397be98f4&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T12:38:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d37a2564-b2be-402e-8218-c4c718b6d600?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d37a2564-b2be-402e-8218-c4c718b6d600",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T12:39:15+00:00",
      "updated_at": "2022-07-14T12:39:15+00:00",
      "number": "http://bqbl.it/d37a2564-b2be-402e-8218-c4c718b6d600",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cd873cc15537a5e3565aed3314ca3495/barcode/image/d37a2564-b2be-402e-8218-c4c718b6d600/32d64ffb-2882-4b9e-b17d-be379bc95981.svg",
      "owner_id": "5ae0d250-96c9-4320-bce6-dd1f40aca861",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5ae0d250-96c9-4320-bce6-dd1f40aca861"
        },
        "data": {
          "type": "customers",
          "id": "5ae0d250-96c9-4320-bce6-dd1f40aca861"
        }
      }
    }
  },
  "included": [
    {
      "id": "5ae0d250-96c9-4320-bce6-dd1f40aca861",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T12:39:15+00:00",
        "updated_at": "2022-07-14T12:39:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Blick, Ziemann and Tillman",
        "email": "and.ziemann.tillman.blick@schuppe.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=5ae0d250-96c9-4320-bce6-dd1f40aca861&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5ae0d250-96c9-4320-bce6-dd1f40aca861&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5ae0d250-96c9-4320-bce6-dd1f40aca861&filter[owner_type]=customers"
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
          "owner_id": "6fb97028-94bf-4730-9a90-03d9264bba3b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "855fb511-2fd4-4f65-b116-8d52023c0754",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T12:39:16+00:00",
      "updated_at": "2022-07-14T12:39:16+00:00",
      "number": "http://bqbl.it/855fb511-2fd4-4f65-b116-8d52023c0754",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d8f3a66bd081cbe6a4b458c587a10da3/barcode/image/855fb511-2fd4-4f65-b116-8d52023c0754/4dfd1d4c-9850-4fa6-ae50-79ff3deaa30f.svg",
      "owner_id": "6fb97028-94bf-4730-9a90-03d9264bba3b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eaf65a82-29b8-4d0e-9cb5-44f97297f559' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eaf65a82-29b8-4d0e-9cb5-44f97297f559",
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
    "id": "eaf65a82-29b8-4d0e-9cb5-44f97297f559",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T12:39:17+00:00",
      "updated_at": "2022-07-14T12:39:17+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2df5f07b4544bf7556aad8390a8b7991/barcode/image/eaf65a82-29b8-4d0e-9cb5-44f97297f559/d01bee52-be8a-4c20-9bdc-47a76c6b1b42.svg",
      "owner_id": "dbdbfcf7-dcd3-4e04-9ee3-64a0da1449dc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ef7e7e26-6df7-4b1a-98a9-1eb9f3d51336' \
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