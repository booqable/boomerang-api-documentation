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
      "id": "0b173a6b-50e3-4ea9-b94f-4f4f72523cc5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T14:32:29+00:00",
        "updated_at": "2022-11-22T14:32:29+00:00",
        "number": "http://bqbl.it/0b173a6b-50e3-4ea9-b94f-4f4f72523cc5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9e1614a72c3f3253ab091e5ff4a09262/barcode/image/0b173a6b-50e3-4ea9-b94f-4f4f72523cc5/f9f33100-a296-4cf7-9b4b-4770763ff386.svg",
        "owner_id": "45cc689c-06cd-4329-ad89-312bbf706e2c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/45cc689c-06cd-4329-ad89-312bbf706e2c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4434abf5-c74d-4a9e-863a-ab9af5704501&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4434abf5-c74d-4a9e-863a-ab9af5704501",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T14:32:29+00:00",
        "updated_at": "2022-11-22T14:32:29+00:00",
        "number": "http://bqbl.it/4434abf5-c74d-4a9e-863a-ab9af5704501",
        "barcode_type": "qr_code",
        "image_url": "/uploads/18b4ca2e87069fe65f32ab749a82c811/barcode/image/4434abf5-c74d-4a9e-863a-ab9af5704501/bbc91d4f-426b-4f45-83af-d883d3a58d43.svg",
        "owner_id": "60e5e3a9-7743-4b4f-9732-ce86369fce8d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/60e5e3a9-7743-4b4f-9732-ce86369fce8d"
          },
          "data": {
            "type": "customers",
            "id": "60e5e3a9-7743-4b4f-9732-ce86369fce8d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "60e5e3a9-7743-4b4f-9732-ce86369fce8d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:32:29+00:00",
        "updated_at": "2022-11-22T14:32:29+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=60e5e3a9-7743-4b4f-9732-ce86369fce8d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=60e5e3a9-7743-4b4f-9732-ce86369fce8d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=60e5e3a9-7743-4b4f-9732-ce86369fce8d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzUyZTMxZDAtMTc1MC00MjNiLWE2NGQtOTJjODM2ZjZmYzcw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "352e31d0-1750-423b-a64d-92c836f6fc70",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T14:32:30+00:00",
        "updated_at": "2022-11-22T14:32:30+00:00",
        "number": "http://bqbl.it/352e31d0-1750-423b-a64d-92c836f6fc70",
        "barcode_type": "qr_code",
        "image_url": "/uploads/323a673448c10ce056f65a5a4edda069/barcode/image/352e31d0-1750-423b-a64d-92c836f6fc70/93bf5e6a-0db6-4b68-9f88-040d0ef87f86.svg",
        "owner_id": "7782f2b3-173c-483a-93af-7f67e907e024",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7782f2b3-173c-483a-93af-7f67e907e024"
          },
          "data": {
            "type": "customers",
            "id": "7782f2b3-173c-483a-93af-7f67e907e024"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7782f2b3-173c-483a-93af-7f67e907e024",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:32:30+00:00",
        "updated_at": "2022-11-22T14:32:30+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7782f2b3-173c-483a-93af-7f67e907e024&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7782f2b3-173c-483a-93af-7f67e907e024&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7782f2b3-173c-483a-93af-7f67e907e024&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:32:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99a1ea50-b067-4f0e-9bcc-05dc4c540a01?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99a1ea50-b067-4f0e-9bcc-05dc4c540a01",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T14:32:31+00:00",
      "updated_at": "2022-11-22T14:32:31+00:00",
      "number": "http://bqbl.it/99a1ea50-b067-4f0e-9bcc-05dc4c540a01",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ec15f9373440cfa1f89bfb76cefd00a/barcode/image/99a1ea50-b067-4f0e-9bcc-05dc4c540a01/c9a14623-a054-4975-94ca-c4d1999e6626.svg",
      "owner_id": "1211eb3f-dfc7-4a0b-80e0-904d97202ad2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1211eb3f-dfc7-4a0b-80e0-904d97202ad2"
        },
        "data": {
          "type": "customers",
          "id": "1211eb3f-dfc7-4a0b-80e0-904d97202ad2"
        }
      }
    }
  },
  "included": [
    {
      "id": "1211eb3f-dfc7-4a0b-80e0-904d97202ad2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:32:31+00:00",
        "updated_at": "2022-11-22T14:32:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1211eb3f-dfc7-4a0b-80e0-904d97202ad2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1211eb3f-dfc7-4a0b-80e0-904d97202ad2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1211eb3f-dfc7-4a0b-80e0-904d97202ad2&filter[owner_type]=customers"
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
          "owner_id": "43b73ee7-e4a9-4f19-b93d-fad723b4d58d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "39034f4c-0bb0-45a4-a1c7-643920787e6e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T14:32:32+00:00",
      "updated_at": "2022-11-22T14:32:32+00:00",
      "number": "http://bqbl.it/39034f4c-0bb0-45a4-a1c7-643920787e6e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1d8ab70fce3cbb899c9edbf2ead7791f/barcode/image/39034f4c-0bb0-45a4-a1c7-643920787e6e/fc0643fb-3ac8-4a1e-be39-1a2fd101a398.svg",
      "owner_id": "43b73ee7-e4a9-4f19-b93d-fad723b4d58d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4dcb0f40-2cd0-44c4-b750-3c4115adff83' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4dcb0f40-2cd0-44c4-b750-3c4115adff83",
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
    "id": "4dcb0f40-2cd0-44c4-b750-3c4115adff83",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T14:32:33+00:00",
      "updated_at": "2022-11-22T14:32:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2f9a7ffa3d079ffd559c31564b5920bf/barcode/image/4dcb0f40-2cd0-44c4-b750-3c4115adff83/eca4c29c-eeb4-478b-a3f5-a37093046cc7.svg",
      "owner_id": "1c90e750-210a-4a57-a07d-32abfc778d77",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/de88d334-5ac6-4d2e-8781-97775945d28a' \
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