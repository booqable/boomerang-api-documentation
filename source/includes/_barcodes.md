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
      "id": "67a19eab-cd76-4176-acae-fa2de4ae8917",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-15T08:04:33+00:00",
        "updated_at": "2022-11-15T08:04:33+00:00",
        "number": "http://bqbl.it/67a19eab-cd76-4176-acae-fa2de4ae8917",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7e7f5827af6aed002df0f2cbe9f25d8b/barcode/image/67a19eab-cd76-4176-acae-fa2de4ae8917/52fdafe0-1047-492c-b345-11a395f75381.svg",
        "owner_id": "63ac54c0-de40-44b1-9746-3ee6500b3056",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/63ac54c0-de40-44b1-9746-3ee6500b3056"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F05e924a5-f314-4179-9fee-152afa4ddde5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "05e924a5-f314-4179-9fee-152afa4ddde5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-15T08:04:34+00:00",
        "updated_at": "2022-11-15T08:04:34+00:00",
        "number": "http://bqbl.it/05e924a5-f314-4179-9fee-152afa4ddde5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/daa339405170285550cdcf19c699e2e2/barcode/image/05e924a5-f314-4179-9fee-152afa4ddde5/77eed116-0f3c-4adc-8f2c-6e828a41c3da.svg",
        "owner_id": "02ab02f0-018a-4506-94a8-d0324fa3b33e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/02ab02f0-018a-4506-94a8-d0324fa3b33e"
          },
          "data": {
            "type": "customers",
            "id": "02ab02f0-018a-4506-94a8-d0324fa3b33e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "02ab02f0-018a-4506-94a8-d0324fa3b33e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-15T08:04:34+00:00",
        "updated_at": "2022-11-15T08:04:34+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=02ab02f0-018a-4506-94a8-d0324fa3b33e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=02ab02f0-018a-4506-94a8-d0324fa3b33e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=02ab02f0-018a-4506-94a8-d0324fa3b33e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2RiMmMwZWMtNDYwOC00NDY0LTljMDQtZDFlMzhkNDlhOWYx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3db2c0ec-4608-4464-9c04-d1e38d49a9f1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-15T08:04:35+00:00",
        "updated_at": "2022-11-15T08:04:35+00:00",
        "number": "http://bqbl.it/3db2c0ec-4608-4464-9c04-d1e38d49a9f1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/74ee8ad77a18cdd19a072c1fcdda399b/barcode/image/3db2c0ec-4608-4464-9c04-d1e38d49a9f1/623c2b9e-64c3-4824-99b7-2ab7328447dd.svg",
        "owner_id": "b21dd04a-e855-47bf-b231-fd55d41a9dbe",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b21dd04a-e855-47bf-b231-fd55d41a9dbe"
          },
          "data": {
            "type": "customers",
            "id": "b21dd04a-e855-47bf-b231-fd55d41a9dbe"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b21dd04a-e855-47bf-b231-fd55d41a9dbe",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-15T08:04:35+00:00",
        "updated_at": "2022-11-15T08:04:35+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b21dd04a-e855-47bf-b231-fd55d41a9dbe&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b21dd04a-e855-47bf-b231-fd55d41a9dbe&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b21dd04a-e855-47bf-b231-fd55d41a9dbe&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-15T08:04:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/afcbb796-eac5-45c1-aa85-4188195aa79d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "afcbb796-eac5-45c1-aa85-4188195aa79d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-15T08:04:36+00:00",
      "updated_at": "2022-11-15T08:04:36+00:00",
      "number": "http://bqbl.it/afcbb796-eac5-45c1-aa85-4188195aa79d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aa1579e68d7bcc025fa41e2df60b1a60/barcode/image/afcbb796-eac5-45c1-aa85-4188195aa79d/8a100f76-cc69-4ee8-b2a3-82467302f184.svg",
      "owner_id": "613d23ea-83da-4b71-966f-22a444ff3936",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/613d23ea-83da-4b71-966f-22a444ff3936"
        },
        "data": {
          "type": "customers",
          "id": "613d23ea-83da-4b71-966f-22a444ff3936"
        }
      }
    }
  },
  "included": [
    {
      "id": "613d23ea-83da-4b71-966f-22a444ff3936",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-15T08:04:36+00:00",
        "updated_at": "2022-11-15T08:04:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=613d23ea-83da-4b71-966f-22a444ff3936&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=613d23ea-83da-4b71-966f-22a444ff3936&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=613d23ea-83da-4b71-966f-22a444ff3936&filter[owner_type]=customers"
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
          "owner_id": "e448308a-14eb-4104-926f-83a7d01f2c1b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "354dc8be-cd90-4267-a66d-72e927c64c5e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-15T08:04:37+00:00",
      "updated_at": "2022-11-15T08:04:37+00:00",
      "number": "http://bqbl.it/354dc8be-cd90-4267-a66d-72e927c64c5e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2995494aa554a132eada4346ee34a9d9/barcode/image/354dc8be-cd90-4267-a66d-72e927c64c5e/c7b2b0c8-ec5e-4230-8dea-0e951d863298.svg",
      "owner_id": "e448308a-14eb-4104-926f-83a7d01f2c1b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c7d1aed-21d1-47c3-b85e-a79bb8bfd2a1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c7d1aed-21d1-47c3-b85e-a79bb8bfd2a1",
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
    "id": "1c7d1aed-21d1-47c3-b85e-a79bb8bfd2a1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-15T08:04:37+00:00",
      "updated_at": "2022-11-15T08:04:37+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7129cb4118fe49dd1873b7309565fe42/barcode/image/1c7d1aed-21d1-47c3-b85e-a79bb8bfd2a1/a672d406-c731-44c6-85e5-bc40165bd0ce.svg",
      "owner_id": "b214e71b-aa43-4986-baeb-0fcb40251159",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e80d0fd6-14cd-4887-85f0-62117760ab0b' \
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