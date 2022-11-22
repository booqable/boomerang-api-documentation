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
      "id": "002c2604-dc5e-4767-ba1c-8a68a7c5363d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T14:40:59+00:00",
        "updated_at": "2022-11-22T14:40:59+00:00",
        "number": "http://bqbl.it/002c2604-dc5e-4767-ba1c-8a68a7c5363d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/91e43b785d0fb75d7e99fbab2037ed36/barcode/image/002c2604-dc5e-4767-ba1c-8a68a7c5363d/5740ec03-d6be-492d-b780-5c4c6fa99ac6.svg",
        "owner_id": "0e10e2f1-0bc0-4192-94f6-5cd0e9cc36d6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0e10e2f1-0bc0-4192-94f6-5cd0e9cc36d6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7412d444-4fac-4ddb-9ae9-56cace67aa05&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7412d444-4fac-4ddb-9ae9-56cace67aa05",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T14:40:59+00:00",
        "updated_at": "2022-11-22T14:40:59+00:00",
        "number": "http://bqbl.it/7412d444-4fac-4ddb-9ae9-56cace67aa05",
        "barcode_type": "qr_code",
        "image_url": "/uploads/11a5ba013d6a3578fff7d600706eeca7/barcode/image/7412d444-4fac-4ddb-9ae9-56cace67aa05/d9a92683-7201-45e3-ba1d-b251edbb97f2.svg",
        "owner_id": "318844f1-94f9-4e0e-9fa5-32c878fabdc8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/318844f1-94f9-4e0e-9fa5-32c878fabdc8"
          },
          "data": {
            "type": "customers",
            "id": "318844f1-94f9-4e0e-9fa5-32c878fabdc8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "318844f1-94f9-4e0e-9fa5-32c878fabdc8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:40:59+00:00",
        "updated_at": "2022-11-22T14:40:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=318844f1-94f9-4e0e-9fa5-32c878fabdc8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=318844f1-94f9-4e0e-9fa5-32c878fabdc8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=318844f1-94f9-4e0e-9fa5-32c878fabdc8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWM3MjY5NTgtMGE4ZS00YjQxLTgyYmMtZTQ5NjY1MDc1Y2Yw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ec726958-0a8e-4b41-82bc-e49665075cf0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-22T14:41:00+00:00",
        "updated_at": "2022-11-22T14:41:00+00:00",
        "number": "http://bqbl.it/ec726958-0a8e-4b41-82bc-e49665075cf0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/41de94e643efb5fe7caecc758d600af2/barcode/image/ec726958-0a8e-4b41-82bc-e49665075cf0/ca3a5510-3797-40fd-9d20-72a5f9cbdd83.svg",
        "owner_id": "8c33a046-ff29-4ea8-ba95-84d9d04a7284",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8c33a046-ff29-4ea8-ba95-84d9d04a7284"
          },
          "data": {
            "type": "customers",
            "id": "8c33a046-ff29-4ea8-ba95-84d9d04a7284"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8c33a046-ff29-4ea8-ba95-84d9d04a7284",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:41:00+00:00",
        "updated_at": "2022-11-22T14:41:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8c33a046-ff29-4ea8-ba95-84d9d04a7284&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8c33a046-ff29-4ea8-ba95-84d9d04a7284&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8c33a046-ff29-4ea8-ba95-84d9d04a7284&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:40:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ec6530df-2ac9-4484-95a6-06ce3def0b7b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ec6530df-2ac9-4484-95a6-06ce3def0b7b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T14:41:00+00:00",
      "updated_at": "2022-11-22T14:41:00+00:00",
      "number": "http://bqbl.it/ec6530df-2ac9-4484-95a6-06ce3def0b7b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9d6176e0dfbdc274fab0cac564ad8078/barcode/image/ec6530df-2ac9-4484-95a6-06ce3def0b7b/e3dd5eb6-0693-4d86-9d65-de15ccc48f3d.svg",
      "owner_id": "e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7"
        },
        "data": {
          "type": "customers",
          "id": "e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7"
        }
      }
    }
  },
  "included": [
    {
      "id": "e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:41:00+00:00",
        "updated_at": "2022-11-22T14:41:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e75cca65-94bc-4f12-a4d7-0fa6f2d1f2a7&filter[owner_type]=customers"
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
          "owner_id": "cb7774aa-c489-4974-8688-d42e09b3ec8c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "898eab8f-7000-479d-b476-3c7dcf81ae09",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T14:41:01+00:00",
      "updated_at": "2022-11-22T14:41:01+00:00",
      "number": "http://bqbl.it/898eab8f-7000-479d-b476-3c7dcf81ae09",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a52d3eb597e3457801b00e3935143f05/barcode/image/898eab8f-7000-479d-b476-3c7dcf81ae09/74b37cf8-238e-438f-80dc-8fdc0dd6ef5d.svg",
      "owner_id": "cb7774aa-c489-4974-8688-d42e09b3ec8c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d0333ecc-0ead-4c4a-9e77-46f8dc84ba0d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d0333ecc-0ead-4c4a-9e77-46f8dc84ba0d",
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
    "id": "d0333ecc-0ead-4c4a-9e77-46f8dc84ba0d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-22T14:41:01+00:00",
      "updated_at": "2022-11-22T14:41:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eec8c3c04adfbab6b8ee7117c28be996/barcode/image/d0333ecc-0ead-4c4a-9e77-46f8dc84ba0d/f9e3dff4-bbd6-4c74-bd90-c2e67dac57e3.svg",
      "owner_id": "9879ff7c-31eb-41bf-95ae-1275a7b1ce37",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9e1700bd-2153-4ee0-8ebd-dbd162fde7c0' \
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