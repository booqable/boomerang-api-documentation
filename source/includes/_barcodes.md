# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "4e1a8d5f-3adb-48d2-b6d8-83f834a3a806",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-23T12:47:44+00:00",
        "updated_at": "2021-11-23T12:47:44+00:00",
        "number": "http://bqbl.it/4e1a8d5f-3adb-48d2-b6d8-83f834a3a806",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a71ec6d64c8eb1f651c5d7ceed269907/barcode/image/4e1a8d5f-3adb-48d2-b6d8-83f834a3a806/c59a5283-6bd1-4df4-b340-e7bd822b6267.svg",
        "owner_id": "dd8ca4b2-5d76-4c18-be9b-05f9c8585f9c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dd8ca4b2-5d76-4c18-be9b-05f9c8585f9c"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe7b2d1a4-56f6-4b06-8104-22ead4d017da&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e7b2d1a4-56f6-4b06-8104-22ead4d017da",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-23T12:47:45+00:00",
        "updated_at": "2021-11-23T12:47:45+00:00",
        "number": "http://bqbl.it/e7b2d1a4-56f6-4b06-8104-22ead4d017da",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2a9214392506a65f143c6ba4b283c54f/barcode/image/e7b2d1a4-56f6-4b06-8104-22ead4d017da/ff63cf9d-7fd7-48ad-acbe-47c850b1d649.svg",
        "owner_id": "a0e3c93a-999c-4aca-a234-59aea6cc0dbc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a0e3c93a-999c-4aca-a234-59aea6cc0dbc"
          },
          "data": {
            "type": "customers",
            "id": "a0e3c93a-999c-4aca-a234-59aea6cc0dbc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a0e3c93a-999c-4aca-a234-59aea6cc0dbc",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-23T12:47:45+00:00",
        "updated_at": "2021-11-23T12:47:45+00:00",
        "number": 1,
        "name": "Kris-Pacocha",
        "email": "kris.pacocha@hilpert.name",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=a0e3c93a-999c-4aca-a234-59aea6cc0dbc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a0e3c93a-999c-4aca-a234-59aea6cc0dbc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a0e3c93a-999c-4aca-a234-59aea6cc0dbc&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe7b2d1a4-56f6-4b06-8104-22ead4d017da&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe7b2d1a4-56f6-4b06-8104-22ead4d017da&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe7b2d1a4-56f6-4b06-8104-22ead4d017da&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-23T12:47:36Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2aa32933-5044-4974-bdda-f2735581033d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2aa32933-5044-4974-bdda-f2735581033d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-23T12:47:45+00:00",
      "updated_at": "2021-11-23T12:47:45+00:00",
      "number": "http://bqbl.it/2aa32933-5044-4974-bdda-f2735581033d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1e7590f1327f7526028d80d525da01dd/barcode/image/2aa32933-5044-4974-bdda-f2735581033d/6dd401d3-6c01-4b07-9f6c-f85d4fe24148.svg",
      "owner_id": "8940fe82-fcbf-4fe5-bc5a-73dc675228d9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8940fe82-fcbf-4fe5-bc5a-73dc675228d9"
        },
        "data": {
          "type": "customers",
          "id": "8940fe82-fcbf-4fe5-bc5a-73dc675228d9"
        }
      }
    }
  },
  "included": [
    {
      "id": "8940fe82-fcbf-4fe5-bc5a-73dc675228d9",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-23T12:47:45+00:00",
        "updated_at": "2021-11-23T12:47:45+00:00",
        "number": 1,
        "name": "Kling-Little",
        "email": "little.kling@macgyver-price.co",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=8940fe82-fcbf-4fe5-bc5a-73dc675228d9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8940fe82-fcbf-4fe5-bc5a-73dc675228d9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8940fe82-fcbf-4fe5-bc5a-73dc675228d9&filter[owner_type]=customers"
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
          "owner_id": "80d6fcd0-a79b-447e-836e-4d116d93c34e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d32fd857-aa7e-42ad-ab0d-77be08d6603f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-23T12:47:46+00:00",
      "updated_at": "2021-11-23T12:47:46+00:00",
      "number": "http://bqbl.it/d32fd857-aa7e-42ad-ab0d-77be08d6603f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2b1c7fa6f076a272d3711085b91023ff/barcode/image/d32fd857-aa7e-42ad-ab0d-77be08d6603f/da2a2ec1-350a-47ba-8688-9a611c08b4ea.svg",
      "owner_id": "80d6fcd0-a79b-447e-836e-4d116d93c34e",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=80d6fcd0-a79b-447e-836e-4d116d93c34e&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=80d6fcd0-a79b-447e-836e-4d116d93c34e&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=80d6fcd0-a79b-447e-836e-4d116d93c34e&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/161f60e7-c760-4c35-bc62-f89d83e18d29' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "161f60e7-c760-4c35-bc62-f89d83e18d29",
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
    "id": "161f60e7-c760-4c35-bc62-f89d83e18d29",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-23T12:47:46+00:00",
      "updated_at": "2021-11-23T12:47:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/daa44372669b8ffef7e43a526de98119/barcode/image/161f60e7-c760-4c35-bc62-f89d83e18d29/78c1ce1e-f640-411f-8e7d-86899bbc3217.svg",
      "owner_id": "640eaf2a-e4e6-4961-b875-b7b16f384b61",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b3369000-9d21-4b15-9c7c-a44accfc13ce' \
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