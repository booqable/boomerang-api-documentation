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
      "id": "e3a2c748-7d36-49a8-9b90-4baf7d8994a8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:17:38+00:00",
        "updated_at": "2023-02-09T10:17:38+00:00",
        "number": "http://bqbl.it/e3a2c748-7d36-49a8-9b90-4baf7d8994a8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0c4d8b2f6e771cb1f12ac93099d15dff/barcode/image/e3a2c748-7d36-49a8-9b90-4baf7d8994a8/2a9a8529-69e4-4de0-9a8d-ae650d80ac61.svg",
        "owner_id": "43b7f89b-7fee-48d5-beda-5b2d1b006479",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/43b7f89b-7fee-48d5-beda-5b2d1b006479"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb40b5d2b-11e9-4e6b-abbb-f6faf3e1c0e6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b40b5d2b-11e9-4e6b-abbb-f6faf3e1c0e6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:17:38+00:00",
        "updated_at": "2023-02-09T10:17:38+00:00",
        "number": "http://bqbl.it/b40b5d2b-11e9-4e6b-abbb-f6faf3e1c0e6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3635633669af5cb59b181c968b7c117a/barcode/image/b40b5d2b-11e9-4e6b-abbb-f6faf3e1c0e6/be5bf702-e409-459e-84c9-5fc248f8b078.svg",
        "owner_id": "6bef118f-ad52-4513-b676-cb2fd6634437",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6bef118f-ad52-4513-b676-cb2fd6634437"
          },
          "data": {
            "type": "customers",
            "id": "6bef118f-ad52-4513-b676-cb2fd6634437"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6bef118f-ad52-4513-b676-cb2fd6634437",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:17:38+00:00",
        "updated_at": "2023-02-09T10:17:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6bef118f-ad52-4513-b676-cb2fd6634437&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6bef118f-ad52-4513-b676-cb2fd6634437&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6bef118f-ad52-4513-b676-cb2fd6634437&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjdmYjgxYzgtZGNmZC00NmM3LTk3YjItN2UxMjk3YmU2MDJi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67fb81c8-dcfd-46c7-97b2-7e1297be602b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T10:17:39+00:00",
        "updated_at": "2023-02-09T10:17:39+00:00",
        "number": "http://bqbl.it/67fb81c8-dcfd-46c7-97b2-7e1297be602b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8897b5f6d7b1b339117dfe576c5ddbdc/barcode/image/67fb81c8-dcfd-46c7-97b2-7e1297be602b/dfa4bd45-ab60-46f8-982f-a666ee68c435.svg",
        "owner_id": "5e7c5720-f6bf-42ed-b559-bfd5fc03a947",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5e7c5720-f6bf-42ed-b559-bfd5fc03a947"
          },
          "data": {
            "type": "customers",
            "id": "5e7c5720-f6bf-42ed-b559-bfd5fc03a947"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5e7c5720-f6bf-42ed-b559-bfd5fc03a947",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:17:39+00:00",
        "updated_at": "2023-02-09T10:17:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=5e7c5720-f6bf-42ed-b559-bfd5fc03a947&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5e7c5720-f6bf-42ed-b559-bfd5fc03a947&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5e7c5720-f6bf-42ed-b559-bfd5fc03a947&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/58c3f5ee-1e32-41cc-a4df-9ec7e20736eb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "58c3f5ee-1e32-41cc-a4df-9ec7e20736eb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:17:39+00:00",
      "updated_at": "2023-02-09T10:17:39+00:00",
      "number": "http://bqbl.it/58c3f5ee-1e32-41cc-a4df-9ec7e20736eb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6a817a0b26c3c20a3118b3e14b6d71ca/barcode/image/58c3f5ee-1e32-41cc-a4df-9ec7e20736eb/8f94b532-82de-4f8c-b363-18db558d2c37.svg",
      "owner_id": "ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3"
        },
        "data": {
          "type": "customers",
          "id": "ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3"
        }
      }
    }
  },
  "included": [
    {
      "id": "ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T10:17:39+00:00",
        "updated_at": "2023-02-09T10:17:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ac4abf6e-5eb6-489c-8b1a-75c7ba7389f3&filter[owner_type]=customers"
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
          "owner_id": "b5709855-0d4d-49f7-8af1-67f78f61230e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3ecfe027-04b1-42a1-8dcb-4a8823ea2ae7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:17:40+00:00",
      "updated_at": "2023-02-09T10:17:40+00:00",
      "number": "http://bqbl.it/3ecfe027-04b1-42a1-8dcb-4a8823ea2ae7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ad9c49e6f7f8351b3ad3c8066de8dd03/barcode/image/3ecfe027-04b1-42a1-8dcb-4a8823ea2ae7/b0d638bb-f5ea-4699-8e79-aed2563023e1.svg",
      "owner_id": "b5709855-0d4d-49f7-8af1-67f78f61230e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ad8d288e-93a5-46ab-aeb5-6eda32974f30' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ad8d288e-93a5-46ab-aeb5-6eda32974f30",
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
    "id": "ad8d288e-93a5-46ab-aeb5-6eda32974f30",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T10:17:40+00:00",
      "updated_at": "2023-02-09T10:17:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8b2d4fcbeca214d7165871118a017bad/barcode/image/ad8d288e-93a5-46ab-aeb5-6eda32974f30/da8f2184-de73-4292-ae19-c4f5d10547c8.svg",
      "owner_id": "2318e0c7-0c22-47a7-afc4-8541695128eb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fa1db05f-c331-4e4e-a988-ab74b3838a9b' \
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