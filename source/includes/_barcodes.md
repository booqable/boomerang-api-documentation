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
      "id": "21b4a737-2202-4f8d-93ce-b076fe948d4e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T11:51:36+00:00",
        "updated_at": "2023-02-22T11:51:36+00:00",
        "number": "http://bqbl.it/21b4a737-2202-4f8d-93ce-b076fe948d4e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/659bf322787a408bab1dc487ec28a696/barcode/image/21b4a737-2202-4f8d-93ce-b076fe948d4e/8160a036-c9d1-4ce9-b0f2-a0d67c5765f7.svg",
        "owner_id": "6afbe40e-267b-4473-9f77-d4c006c43d29",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6afbe40e-267b-4473-9f77-d4c006c43d29"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7e0ec80c-4409-4dfc-99a1-06440203393f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7e0ec80c-4409-4dfc-99a1-06440203393f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T11:51:37+00:00",
        "updated_at": "2023-02-22T11:51:37+00:00",
        "number": "http://bqbl.it/7e0ec80c-4409-4dfc-99a1-06440203393f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bd961ca2375d0891f2044878c96e5772/barcode/image/7e0ec80c-4409-4dfc-99a1-06440203393f/d0ab038e-f3db-4fdf-bb5b-cd10b7839043.svg",
        "owner_id": "28e891de-243d-44e9-8ef9-5e815693e708",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/28e891de-243d-44e9-8ef9-5e815693e708"
          },
          "data": {
            "type": "customers",
            "id": "28e891de-243d-44e9-8ef9-5e815693e708"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "28e891de-243d-44e9-8ef9-5e815693e708",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T11:51:37+00:00",
        "updated_at": "2023-02-22T11:51:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=28e891de-243d-44e9-8ef9-5e815693e708&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=28e891de-243d-44e9-8ef9-5e815693e708&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=28e891de-243d-44e9-8ef9-5e815693e708&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDAyNDJmZjEtODViYy00MDVkLTlkMDctODQwYzRhNmE5ZGZj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "40242ff1-85bc-405d-9d07-840c4a6a9dfc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-22T11:51:37+00:00",
        "updated_at": "2023-02-22T11:51:37+00:00",
        "number": "http://bqbl.it/40242ff1-85bc-405d-9d07-840c4a6a9dfc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/915d721d2015abd05f7a4172cf54aa92/barcode/image/40242ff1-85bc-405d-9d07-840c4a6a9dfc/0da1025b-17e9-4ae8-8af8-89d1782d09ec.svg",
        "owner_id": "8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc"
          },
          "data": {
            "type": "customers",
            "id": "8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T11:51:37+00:00",
        "updated_at": "2023-02-22T11:51:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8430e6a8-eb78-4e5d-a1e1-c3733cf15ffc&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T11:51:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d42e5a6-e76f-4d7d-b6ee-1f1fce41c300?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1d42e5a6-e76f-4d7d-b6ee-1f1fce41c300",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T11:51:38+00:00",
      "updated_at": "2023-02-22T11:51:38+00:00",
      "number": "http://bqbl.it/1d42e5a6-e76f-4d7d-b6ee-1f1fce41c300",
      "barcode_type": "qr_code",
      "image_url": "/uploads/258a24172cf9b9c9ff7759afa3b0ef83/barcode/image/1d42e5a6-e76f-4d7d-b6ee-1f1fce41c300/a8cd2209-53a9-4c6c-bc32-ce818f615f36.svg",
      "owner_id": "9ffc85be-48c5-4410-a1f8-22865d148b95",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9ffc85be-48c5-4410-a1f8-22865d148b95"
        },
        "data": {
          "type": "customers",
          "id": "9ffc85be-48c5-4410-a1f8-22865d148b95"
        }
      }
    }
  },
  "included": [
    {
      "id": "9ffc85be-48c5-4410-a1f8-22865d148b95",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-22T11:51:37+00:00",
        "updated_at": "2023-02-22T11:51:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9ffc85be-48c5-4410-a1f8-22865d148b95&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9ffc85be-48c5-4410-a1f8-22865d148b95&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9ffc85be-48c5-4410-a1f8-22865d148b95&filter[owner_type]=customers"
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
          "owner_id": "0f71165f-46d1-4e7b-8659-e2d2575bd066",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7a152cd5-0e9d-49a4-8267-72426219ca84",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T11:51:38+00:00",
      "updated_at": "2023-02-22T11:51:38+00:00",
      "number": "http://bqbl.it/7a152cd5-0e9d-49a4-8267-72426219ca84",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c28ad0721d552571315e2c7de93e44bd/barcode/image/7a152cd5-0e9d-49a4-8267-72426219ca84/d7b3947b-fa66-4362-ae9a-fee90b0e9fd7.svg",
      "owner_id": "0f71165f-46d1-4e7b-8659-e2d2575bd066",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9179447f-6fb7-4811-b016-699c3386a893' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9179447f-6fb7-4811-b016-699c3386a893",
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
    "id": "9179447f-6fb7-4811-b016-699c3386a893",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-22T11:51:39+00:00",
      "updated_at": "2023-02-22T11:51:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1a3640d281b6e8d556afca4d51aac090/barcode/image/9179447f-6fb7-4811-b016-699c3386a893/14635daa-be68-413e-bccc-51ab5da6fbbe.svg",
      "owner_id": "7af0fece-15da-4685-b0aa-305d192dbe73",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/06fef352-beff-4774-a76f-e805146a0d2f' \
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