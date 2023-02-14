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
      "id": "0f996478-281b-46b0-ab7e-f2ce973be1f8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T13:00:37+00:00",
        "updated_at": "2023-02-14T13:00:37+00:00",
        "number": "http://bqbl.it/0f996478-281b-46b0-ab7e-f2ce973be1f8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/34c53e3c938426d6f19642425e5902bc/barcode/image/0f996478-281b-46b0-ab7e-f2ce973be1f8/80bdec42-3a43-4935-b379-eb81defa6593.svg",
        "owner_id": "cd3cd8fd-4de5-4670-b88d-45ef4eccbb87",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cd3cd8fd-4de5-4670-b88d-45ef4eccbb87"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe30c1ff8-4af5-422e-acaf-71b519268be6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e30c1ff8-4af5-422e-acaf-71b519268be6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T13:00:37+00:00",
        "updated_at": "2023-02-14T13:00:37+00:00",
        "number": "http://bqbl.it/e30c1ff8-4af5-422e-acaf-71b519268be6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a04b0b8e79a0725ecf4beb3d2652f786/barcode/image/e30c1ff8-4af5-422e-acaf-71b519268be6/cbbc4e7b-1f87-486c-ae73-57e607665f10.svg",
        "owner_id": "014df728-5bd2-44b5-9a50-f3e9aaf76d47",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/014df728-5bd2-44b5-9a50-f3e9aaf76d47"
          },
          "data": {
            "type": "customers",
            "id": "014df728-5bd2-44b5-9a50-f3e9aaf76d47"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "014df728-5bd2-44b5-9a50-f3e9aaf76d47",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T13:00:37+00:00",
        "updated_at": "2023-02-14T13:00:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=014df728-5bd2-44b5-9a50-f3e9aaf76d47&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=014df728-5bd2-44b5-9a50-f3e9aaf76d47&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=014df728-5bd2-44b5-9a50-f3e9aaf76d47&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjljYjllNWMtNTE3ZS00NjdkLThhZDAtOGU2MzU1M2MzY2Mx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "69cb9e5c-517e-467d-8ad0-8e63553c3cc1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T13:00:38+00:00",
        "updated_at": "2023-02-14T13:00:38+00:00",
        "number": "http://bqbl.it/69cb9e5c-517e-467d-8ad0-8e63553c3cc1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b2b5ba1d930436161bd9e68dac3fceb7/barcode/image/69cb9e5c-517e-467d-8ad0-8e63553c3cc1/3546176b-df67-4a9a-b212-cdc63be7a964.svg",
        "owner_id": "ee50eceb-d488-4e99-b685-ef2b5f89b682",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ee50eceb-d488-4e99-b685-ef2b5f89b682"
          },
          "data": {
            "type": "customers",
            "id": "ee50eceb-d488-4e99-b685-ef2b5f89b682"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ee50eceb-d488-4e99-b685-ef2b5f89b682",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T13:00:38+00:00",
        "updated_at": "2023-02-14T13:00:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee50eceb-d488-4e99-b685-ef2b5f89b682&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee50eceb-d488-4e99-b685-ef2b5f89b682&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee50eceb-d488-4e99-b685-ef2b5f89b682&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T13:00:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b0fbab8b-1743-4898-973c-eb2ccd2a9502?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b0fbab8b-1743-4898-973c-eb2ccd2a9502",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T13:00:39+00:00",
      "updated_at": "2023-02-14T13:00:39+00:00",
      "number": "http://bqbl.it/b0fbab8b-1743-4898-973c-eb2ccd2a9502",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6a2c59f3625e81ad480d0ae4e7b7a342/barcode/image/b0fbab8b-1743-4898-973c-eb2ccd2a9502/82eecd2f-f024-41ae-b14a-69ead285b30e.svg",
      "owner_id": "446ce725-16e3-4797-860d-d256fc4187d6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/446ce725-16e3-4797-860d-d256fc4187d6"
        },
        "data": {
          "type": "customers",
          "id": "446ce725-16e3-4797-860d-d256fc4187d6"
        }
      }
    }
  },
  "included": [
    {
      "id": "446ce725-16e3-4797-860d-d256fc4187d6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T13:00:39+00:00",
        "updated_at": "2023-02-14T13:00:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=446ce725-16e3-4797-860d-d256fc4187d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=446ce725-16e3-4797-860d-d256fc4187d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=446ce725-16e3-4797-860d-d256fc4187d6&filter[owner_type]=customers"
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
          "owner_id": "1e0009b2-ec8e-4a6d-b528-a8fad615cf67",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bbd52f9b-081a-4dd6-93d8-b82ddf8008fd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T13:00:39+00:00",
      "updated_at": "2023-02-14T13:00:39+00:00",
      "number": "http://bqbl.it/bbd52f9b-081a-4dd6-93d8-b82ddf8008fd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/637bde32e49a6d26562540d63aa219e8/barcode/image/bbd52f9b-081a-4dd6-93d8-b82ddf8008fd/f33d4e84-b06f-4177-b6e7-3b77f13a6553.svg",
      "owner_id": "1e0009b2-ec8e-4a6d-b528-a8fad615cf67",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e9d03e61-ae8d-4218-a55f-3237548de32e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e9d03e61-ae8d-4218-a55f-3237548de32e",
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
    "id": "e9d03e61-ae8d-4218-a55f-3237548de32e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T13:00:40+00:00",
      "updated_at": "2023-02-14T13:00:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7bcf01d2070b2f22bd2c5c28f315e69c/barcode/image/e9d03e61-ae8d-4218-a55f-3237548de32e/13457f76-cabf-40f3-9b59-13ee3e6b8d87.svg",
      "owner_id": "1256873e-84ea-47e2-9e8f-fa52583bfd47",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ba73b5ff-7ced-47ee-8575-976542d98666' \
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