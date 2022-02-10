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
      "id": "7e212ab2-0c03-4e66-91c6-fcbf7b286a6f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-10T10:31:00+00:00",
        "updated_at": "2022-02-10T10:31:00+00:00",
        "number": "http://bqbl.it/7e212ab2-0c03-4e66-91c6-fcbf7b286a6f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2619b4a1ac418bcf1cca8845749b4909/barcode/image/7e212ab2-0c03-4e66-91c6-fcbf7b286a6f/1fa5d7fb-f16e-4522-a477-78c4fd1dedd1.svg",
        "owner_id": "c3fd4e5a-7656-4d4c-bf1b-335e0d1238cb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c3fd4e5a-7656-4d4c-bf1b-335e0d1238cb"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2cd34370-e1b1-4dad-af5d-33bd396a1602&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2cd34370-e1b1-4dad-af5d-33bd396a1602",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-10T10:31:00+00:00",
        "updated_at": "2022-02-10T10:31:00+00:00",
        "number": "http://bqbl.it/2cd34370-e1b1-4dad-af5d-33bd396a1602",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ca6042190270b2bbe7174bcab742e2c4/barcode/image/2cd34370-e1b1-4dad-af5d-33bd396a1602/bdbfa491-d2b3-4d2e-9f7a-c666f9de702a.svg",
        "owner_id": "2a5e5574-c118-4f91-b3bc-13815ace1de3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2a5e5574-c118-4f91-b3bc-13815ace1de3"
          },
          "data": {
            "type": "customers",
            "id": "2a5e5574-c118-4f91-b3bc-13815ace1de3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2a5e5574-c118-4f91-b3bc-13815ace1de3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-10T10:31:00+00:00",
        "updated_at": "2022-02-10T10:31:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Ebert LLC",
        "email": "llc_ebert@cruickshank.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=2a5e5574-c118-4f91-b3bc-13815ace1de3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2a5e5574-c118-4f91-b3bc-13815ace1de3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2a5e5574-c118-4f91-b3bc-13815ace1de3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTg4MGE0ZGItN2JkNi00ZTRkLWJiNTItNzNiMTNhM2MyNWE3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5880a4db-7bd6-4e4d-bb52-73b13a3c25a7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-10T10:31:01+00:00",
        "updated_at": "2022-02-10T10:31:01+00:00",
        "number": "http://bqbl.it/5880a4db-7bd6-4e4d-bb52-73b13a3c25a7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8fff0a5fe98a307d42dddadfc7fd9840/barcode/image/5880a4db-7bd6-4e4d-bb52-73b13a3c25a7/a7a39ec4-a038-4a0f-9e0d-f826c62492a5.svg",
        "owner_id": "0d6b8376-71af-488c-800a-ead2e65a3d30",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0d6b8376-71af-488c-800a-ead2e65a3d30"
          },
          "data": {
            "type": "customers",
            "id": "0d6b8376-71af-488c-800a-ead2e65a3d30"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0d6b8376-71af-488c-800a-ead2e65a3d30",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-10T10:31:01+00:00",
        "updated_at": "2022-02-10T10:31:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Braun, Walsh and Larson",
        "email": "braun.walsh.and.larson@hahn.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d6b8376-71af-488c-800a-ead2e65a3d30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d6b8376-71af-488c-800a-ead2e65a3d30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d6b8376-71af-488c-800a-ead2e65a3d30&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-10T10:30:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e639a968-208e-405c-94ab-ecfb6fc3dc60?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e639a968-208e-405c-94ab-ecfb6fc3dc60",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-10T10:31:01+00:00",
      "updated_at": "2022-02-10T10:31:01+00:00",
      "number": "http://bqbl.it/e639a968-208e-405c-94ab-ecfb6fc3dc60",
      "barcode_type": "qr_code",
      "image_url": "/uploads/27700cc41a4a9120af028bb0bbf101bf/barcode/image/e639a968-208e-405c-94ab-ecfb6fc3dc60/90f2f5f6-0b48-41a4-a3f1-9d4d37b59caf.svg",
      "owner_id": "760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b"
        },
        "data": {
          "type": "customers",
          "id": "760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b"
        }
      }
    }
  },
  "included": [
    {
      "id": "760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-10T10:31:01+00:00",
        "updated_at": "2022-02-10T10:31:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Schinner-Lakin",
        "email": "schinner.lakin@moore.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=760ef4d7-4b68-4cf1-94e9-36eb5cb5d48b&filter[owner_type]=customers"
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
          "owner_id": "892c9c70-984a-4d91-8f7b-e1e266fa82ff",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f87a8375-14fc-4e20-831b-cc05e2d5a36c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-10T10:31:02+00:00",
      "updated_at": "2022-02-10T10:31:02+00:00",
      "number": "http://bqbl.it/f87a8375-14fc-4e20-831b-cc05e2d5a36c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/acf2c16743c73cf6cdcc04af2781db7c/barcode/image/f87a8375-14fc-4e20-831b-cc05e2d5a36c/c1383521-22ea-449d-a9fd-8fdfe624c12b.svg",
      "owner_id": "892c9c70-984a-4d91-8f7b-e1e266fa82ff",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e052561b-0b41-4b9a-91e8-98d2b2987090' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e052561b-0b41-4b9a-91e8-98d2b2987090",
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
    "id": "e052561b-0b41-4b9a-91e8-98d2b2987090",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-10T10:31:02+00:00",
      "updated_at": "2022-02-10T10:31:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dafa75fdaf9baa32889318bb1ec64574/barcode/image/e052561b-0b41-4b9a-91e8-98d2b2987090/2e1cebac-a5cf-425a-87b2-d9d1049226f7.svg",
      "owner_id": "cb9f4187-1568-4352-9acd-c77db0e431f2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ff0bb7cf-b9a8-4576-824f-ce6130491875' \
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