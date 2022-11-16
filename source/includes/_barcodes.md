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
      "id": "62d19ba1-ae9d-4f9e-9dfb-601c97c51bed",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-16T14:30:24+00:00",
        "updated_at": "2022-11-16T14:30:24+00:00",
        "number": "http://bqbl.it/62d19ba1-ae9d-4f9e-9dfb-601c97c51bed",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3889dad68abcdfec2ab2637733216613/barcode/image/62d19ba1-ae9d-4f9e-9dfb-601c97c51bed/edf8bd9e-1d98-4d41-b1f8-f4a54783d1d1.svg",
        "owner_id": "12afd44f-bfce-4204-bee9-6a1892916fbe",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/12afd44f-bfce-4204-bee9-6a1892916fbe"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffddef148-f1a0-4444-881e-e9f1583b44ee&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fddef148-f1a0-4444-881e-e9f1583b44ee",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-16T14:30:25+00:00",
        "updated_at": "2022-11-16T14:30:25+00:00",
        "number": "http://bqbl.it/fddef148-f1a0-4444-881e-e9f1583b44ee",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0bcb6058a172677f70f6e5e4ea84ab2d/barcode/image/fddef148-f1a0-4444-881e-e9f1583b44ee/70dd7994-c683-4724-ae29-f031dcad51b6.svg",
        "owner_id": "16f86bd3-5c41-4fa7-a668-e09dfda27362",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/16f86bd3-5c41-4fa7-a668-e09dfda27362"
          },
          "data": {
            "type": "customers",
            "id": "16f86bd3-5c41-4fa7-a668-e09dfda27362"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "16f86bd3-5c41-4fa7-a668-e09dfda27362",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-16T14:30:25+00:00",
        "updated_at": "2022-11-16T14:30:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=16f86bd3-5c41-4fa7-a668-e09dfda27362&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=16f86bd3-5c41-4fa7-a668-e09dfda27362&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=16f86bd3-5c41-4fa7-a668-e09dfda27362&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGE3MDJmNzUtZjQzYS00M2JkLWFlY2UtODcwNTg4YWQ1NmFm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "da702f75-f43a-43bd-aece-870588ad56af",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-16T14:30:25+00:00",
        "updated_at": "2022-11-16T14:30:25+00:00",
        "number": "http://bqbl.it/da702f75-f43a-43bd-aece-870588ad56af",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b938d5439c9f170a1b07f940b280149b/barcode/image/da702f75-f43a-43bd-aece-870588ad56af/8785ffb5-c6f8-4fe3-b2ba-eda201ce94b8.svg",
        "owner_id": "8cf0f797-3faa-4d24-8525-e73e1d3668dd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8cf0f797-3faa-4d24-8525-e73e1d3668dd"
          },
          "data": {
            "type": "customers",
            "id": "8cf0f797-3faa-4d24-8525-e73e1d3668dd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8cf0f797-3faa-4d24-8525-e73e1d3668dd",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-16T14:30:25+00:00",
        "updated_at": "2022-11-16T14:30:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8cf0f797-3faa-4d24-8525-e73e1d3668dd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8cf0f797-3faa-4d24-8525-e73e1d3668dd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8cf0f797-3faa-4d24-8525-e73e1d3668dd&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:30:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0b7a3039-1632-444a-bccc-558a0044b1ab?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0b7a3039-1632-444a-bccc-558a0044b1ab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-16T14:30:26+00:00",
      "updated_at": "2022-11-16T14:30:26+00:00",
      "number": "http://bqbl.it/0b7a3039-1632-444a-bccc-558a0044b1ab",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b3d3f7abfe4248eb0e67ff75703a1382/barcode/image/0b7a3039-1632-444a-bccc-558a0044b1ab/e47b50e2-65c5-4535-9605-8d44cee5473b.svg",
      "owner_id": "3f0f5e24-8c48-4bb9-a428-c4c486d4e34d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3f0f5e24-8c48-4bb9-a428-c4c486d4e34d"
        },
        "data": {
          "type": "customers",
          "id": "3f0f5e24-8c48-4bb9-a428-c4c486d4e34d"
        }
      }
    }
  },
  "included": [
    {
      "id": "3f0f5e24-8c48-4bb9-a428-c4c486d4e34d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-16T14:30:26+00:00",
        "updated_at": "2022-11-16T14:30:26+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3f0f5e24-8c48-4bb9-a428-c4c486d4e34d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3f0f5e24-8c48-4bb9-a428-c4c486d4e34d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3f0f5e24-8c48-4bb9-a428-c4c486d4e34d&filter[owner_type]=customers"
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
          "owner_id": "e298e108-c7aa-4a22-9514-5f18811bc4f4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e62fa518-ed39-482c-a113-f7e5bb5a341d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-16T14:30:27+00:00",
      "updated_at": "2022-11-16T14:30:27+00:00",
      "number": "http://bqbl.it/e62fa518-ed39-482c-a113-f7e5bb5a341d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3c2ae485fdc88a382dee778883f49d8b/barcode/image/e62fa518-ed39-482c-a113-f7e5bb5a341d/724dbcef-3009-46a1-b9ee-31364cc5a453.svg",
      "owner_id": "e298e108-c7aa-4a22-9514-5f18811bc4f4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/44af47a7-8515-4eb5-a641-e3b0739ef497' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "44af47a7-8515-4eb5-a641-e3b0739ef497",
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
    "id": "44af47a7-8515-4eb5-a641-e3b0739ef497",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-16T14:30:27+00:00",
      "updated_at": "2022-11-16T14:30:28+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7854eb3641216e8b13fd0a4099c6f669/barcode/image/44af47a7-8515-4eb5-a641-e3b0739ef497/fc5144b0-2344-4baa-8477-2d150086975e.svg",
      "owner_id": "0e5dff01-eb54-48d6-8272-8751099fdcc5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fb240421-edc9-4c9d-893e-0f0c9a777dbb' \
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