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
      "id": "88f19832-88a7-4463-a05e-70b5dbf9d2a8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T09:26:50+00:00",
        "updated_at": "2023-02-07T09:26:50+00:00",
        "number": "http://bqbl.it/88f19832-88a7-4463-a05e-70b5dbf9d2a8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7d7fa64b1301bea6d301fa02793d6391/barcode/image/88f19832-88a7-4463-a05e-70b5dbf9d2a8/cd62f87b-f5fe-45d4-ae44-0968605f6971.svg",
        "owner_id": "51990c77-849d-4a6b-a04f-376db6d01aea",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/51990c77-849d-4a6b-a04f-376db6d01aea"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc5234841-4e15-4033-9c29-a18217b16f4c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c5234841-4e15-4033-9c29-a18217b16f4c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T09:26:51+00:00",
        "updated_at": "2023-02-07T09:26:51+00:00",
        "number": "http://bqbl.it/c5234841-4e15-4033-9c29-a18217b16f4c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e35cc468ab5fc4c54958eda16ea89108/barcode/image/c5234841-4e15-4033-9c29-a18217b16f4c/0afd9b79-4171-4e1d-af1f-7e7b12f3de99.svg",
        "owner_id": "fb05cc0f-cde9-4fa0-8bfc-82511939f29e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fb05cc0f-cde9-4fa0-8bfc-82511939f29e"
          },
          "data": {
            "type": "customers",
            "id": "fb05cc0f-cde9-4fa0-8bfc-82511939f29e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fb05cc0f-cde9-4fa0-8bfc-82511939f29e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T09:26:50+00:00",
        "updated_at": "2023-02-07T09:26:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fb05cc0f-cde9-4fa0-8bfc-82511939f29e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fb05cc0f-cde9-4fa0-8bfc-82511939f29e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fb05cc0f-cde9-4fa0-8bfc-82511939f29e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGEzZjU0M2EtMjBjZC00NTM2LWEwOWEtMTZhMTVkZTRiMzhh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8a3f543a-20cd-4536-a09a-16a15de4b38a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T09:26:51+00:00",
        "updated_at": "2023-02-07T09:26:51+00:00",
        "number": "http://bqbl.it/8a3f543a-20cd-4536-a09a-16a15de4b38a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b283ecf625c082c3dc76491a6a15526b/barcode/image/8a3f543a-20cd-4536-a09a-16a15de4b38a/f5121b47-7fe1-47ec-bb38-54757da4fb10.svg",
        "owner_id": "66868dba-3e24-450c-8ee6-2ee35a6e22bf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/66868dba-3e24-450c-8ee6-2ee35a6e22bf"
          },
          "data": {
            "type": "customers",
            "id": "66868dba-3e24-450c-8ee6-2ee35a6e22bf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "66868dba-3e24-450c-8ee6-2ee35a6e22bf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T09:26:51+00:00",
        "updated_at": "2023-02-07T09:26:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=66868dba-3e24-450c-8ee6-2ee35a6e22bf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=66868dba-3e24-450c-8ee6-2ee35a6e22bf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=66868dba-3e24-450c-8ee6-2ee35a6e22bf&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T09:26:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/52a0b5f8-ab2c-42c0-b597-6c0a60bf4cab?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "52a0b5f8-ab2c-42c0-b597-6c0a60bf4cab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T09:26:52+00:00",
      "updated_at": "2023-02-07T09:26:52+00:00",
      "number": "http://bqbl.it/52a0b5f8-ab2c-42c0-b597-6c0a60bf4cab",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bd3120e8b4338fc0128f4657d4d3cd06/barcode/image/52a0b5f8-ab2c-42c0-b597-6c0a60bf4cab/4c9337ac-2d6d-48ff-842d-bc153a8f1b2a.svg",
      "owner_id": "d3767fb7-539c-4a4b-afcc-ba5dfda11bf5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d3767fb7-539c-4a4b-afcc-ba5dfda11bf5"
        },
        "data": {
          "type": "customers",
          "id": "d3767fb7-539c-4a4b-afcc-ba5dfda11bf5"
        }
      }
    }
  },
  "included": [
    {
      "id": "d3767fb7-539c-4a4b-afcc-ba5dfda11bf5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T09:26:51+00:00",
        "updated_at": "2023-02-07T09:26:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d3767fb7-539c-4a4b-afcc-ba5dfda11bf5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d3767fb7-539c-4a4b-afcc-ba5dfda11bf5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d3767fb7-539c-4a4b-afcc-ba5dfda11bf5&filter[owner_type]=customers"
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
          "owner_id": "f7e04299-8500-42d1-90be-2f98e9985dc9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "936c5421-f80f-497c-a806-dfe2aa4be8db",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T09:26:52+00:00",
      "updated_at": "2023-02-07T09:26:52+00:00",
      "number": "http://bqbl.it/936c5421-f80f-497c-a806-dfe2aa4be8db",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9df1cf34797d6a0c214774bbfe792f8c/barcode/image/936c5421-f80f-497c-a806-dfe2aa4be8db/9a52b184-d913-435e-80c5-087a61e20495.svg",
      "owner_id": "f7e04299-8500-42d1-90be-2f98e9985dc9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c708283d-9fad-4a04-802f-950d91b27804' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c708283d-9fad-4a04-802f-950d91b27804",
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
    "id": "c708283d-9fad-4a04-802f-950d91b27804",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T09:26:53+00:00",
      "updated_at": "2023-02-07T09:26:53+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/82bf52a7e53d28d072265b3912360011/barcode/image/c708283d-9fad-4a04-802f-950d91b27804/3ec1feb4-fa5c-4f25-ad97-7c6019c5f63c.svg",
      "owner_id": "a0ef8c96-72c7-48bc-9faa-57584d85e3cc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9cd9e57b-b6ae-4416-b35a-37a278962197' \
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