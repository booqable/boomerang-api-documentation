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
      "id": "7e375a06-9f72-4cbb-8ec3-5db9351d277c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T13:57:36+00:00",
        "updated_at": "2022-05-19T13:57:36+00:00",
        "number": "http://bqbl.it/7e375a06-9f72-4cbb-8ec3-5db9351d277c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/be592424abbe380686a3d972af51032d/barcode/image/7e375a06-9f72-4cbb-8ec3-5db9351d277c/aacb416a-f630-4f9e-af3c-1072e9a27d60.svg",
        "owner_id": "ade52156-abb7-4975-a2ac-8d35638440a3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ade52156-abb7-4975-a2ac-8d35638440a3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9e0642ef-ec39-48fc-9d44-32756a168448&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9e0642ef-ec39-48fc-9d44-32756a168448",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T13:57:36+00:00",
        "updated_at": "2022-05-19T13:57:36+00:00",
        "number": "http://bqbl.it/9e0642ef-ec39-48fc-9d44-32756a168448",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0e2c84d9a11cebf842b4a5c6b25482da/barcode/image/9e0642ef-ec39-48fc-9d44-32756a168448/ee667155-99be-4e9c-ae8d-52be0a8c6c45.svg",
        "owner_id": "1fcdd6fb-5b08-4a94-9eae-a284cb9f727b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1fcdd6fb-5b08-4a94-9eae-a284cb9f727b"
          },
          "data": {
            "type": "customers",
            "id": "1fcdd6fb-5b08-4a94-9eae-a284cb9f727b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1fcdd6fb-5b08-4a94-9eae-a284cb9f727b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T13:57:36+00:00",
        "updated_at": "2022-05-19T13:57:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Mitchell Group",
        "email": "group_mitchell@kris-runolfsson.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=1fcdd6fb-5b08-4a94-9eae-a284cb9f727b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1fcdd6fb-5b08-4a94-9eae-a284cb9f727b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1fcdd6fb-5b08-4a94-9eae-a284cb9f727b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTRjOTZjMTEtOWU5ZC00MDgyLWIwOGEtM2E3MjlmNGU3NGRl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "54c96c11-9e9d-4082-b08a-3a729f4e74de",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T13:57:37+00:00",
        "updated_at": "2022-05-19T13:57:37+00:00",
        "number": "http://bqbl.it/54c96c11-9e9d-4082-b08a-3a729f4e74de",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bd849a5087f618ca8a12fc7a7333f42c/barcode/image/54c96c11-9e9d-4082-b08a-3a729f4e74de/205fb9a9-fb88-4d1f-922d-4e23e69675f1.svg",
        "owner_id": "74ce8416-4909-4500-ab73-21d1a4bd2ea3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/74ce8416-4909-4500-ab73-21d1a4bd2ea3"
          },
          "data": {
            "type": "customers",
            "id": "74ce8416-4909-4500-ab73-21d1a4bd2ea3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "74ce8416-4909-4500-ab73-21d1a4bd2ea3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T13:57:37+00:00",
        "updated_at": "2022-05-19T13:57:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Wiegand-Breitenberg",
        "email": "breitenberg.wiegand@hoppe.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=74ce8416-4909-4500-ab73-21d1a4bd2ea3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=74ce8416-4909-4500-ab73-21d1a4bd2ea3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=74ce8416-4909-4500-ab73-21d1a4bd2ea3&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T13:57:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/615fefda-541a-4368-a32e-b0532affe4b8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "615fefda-541a-4368-a32e-b0532affe4b8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T13:57:37+00:00",
      "updated_at": "2022-05-19T13:57:37+00:00",
      "number": "http://bqbl.it/615fefda-541a-4368-a32e-b0532affe4b8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e313f50a47c8239fb1fd6d5c94d1b11a/barcode/image/615fefda-541a-4368-a32e-b0532affe4b8/198b455a-5dc2-4808-9b68-9ced4ab162d1.svg",
      "owner_id": "3e98cdc8-c618-4952-9d95-ad9cdc667e3e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3e98cdc8-c618-4952-9d95-ad9cdc667e3e"
        },
        "data": {
          "type": "customers",
          "id": "3e98cdc8-c618-4952-9d95-ad9cdc667e3e"
        }
      }
    }
  },
  "included": [
    {
      "id": "3e98cdc8-c618-4952-9d95-ad9cdc667e3e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T13:57:37+00:00",
        "updated_at": "2022-05-19T13:57:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Ratke-Schultz",
        "email": "ratke_schultz@feeney-bernhard.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=3e98cdc8-c618-4952-9d95-ad9cdc667e3e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3e98cdc8-c618-4952-9d95-ad9cdc667e3e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3e98cdc8-c618-4952-9d95-ad9cdc667e3e&filter[owner_type]=customers"
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
          "owner_id": "c87449d2-7232-4733-a159-2d2a5c601d0b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "35730348-8112-49ae-b19b-35253e39ca69",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T13:57:38+00:00",
      "updated_at": "2022-05-19T13:57:38+00:00",
      "number": "http://bqbl.it/35730348-8112-49ae-b19b-35253e39ca69",
      "barcode_type": "qr_code",
      "image_url": "/uploads/95820357e162d4c68707e5c798af9803/barcode/image/35730348-8112-49ae-b19b-35253e39ca69/c532bcce-29af-4313-94c6-8911f2fb2732.svg",
      "owner_id": "c87449d2-7232-4733-a159-2d2a5c601d0b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5496e796-599a-4a37-8734-9764e1e8170a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5496e796-599a-4a37-8734-9764e1e8170a",
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
    "id": "5496e796-599a-4a37-8734-9764e1e8170a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T13:57:38+00:00",
      "updated_at": "2022-05-19T13:57:38+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cd462448ecbe6f00509fbc29979b8e1d/barcode/image/5496e796-599a-4a37-8734-9764e1e8170a/bc79ac72-28e0-49a3-91ab-3b0c44922d92.svg",
      "owner_id": "6a1630d1-430c-45b9-88f9-f8e3841910eb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/816e636a-274b-4b99-a8ca-5b6053b0f7d9' \
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