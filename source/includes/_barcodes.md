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
      "id": "8a3f5726-3e30-4bae-a5a7-ea780d780706",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T09:44:06+00:00",
        "updated_at": "2022-06-30T09:44:06+00:00",
        "number": "http://bqbl.it/8a3f5726-3e30-4bae-a5a7-ea780d780706",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c93b463a6b05108a2a43d94585b007b3/barcode/image/8a3f5726-3e30-4bae-a5a7-ea780d780706/cbf9b4ff-9254-4ce6-a865-98370067b2bf.svg",
        "owner_id": "6c037022-0ec7-4759-95e1-00b502d39829",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6c037022-0ec7-4759-95e1-00b502d39829"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F8049c98f-83c8-41e8-a036-8718de58e72c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8049c98f-83c8-41e8-a036-8718de58e72c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T09:44:06+00:00",
        "updated_at": "2022-06-30T09:44:06+00:00",
        "number": "http://bqbl.it/8049c98f-83c8-41e8-a036-8718de58e72c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e6178151610da69bb1af3c1d3401278a/barcode/image/8049c98f-83c8-41e8-a036-8718de58e72c/0e6a09bb-d95a-44f6-8dde-49fca4a1c59d.svg",
        "owner_id": "3508c540-c515-4d3a-9c27-381663a720eb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3508c540-c515-4d3a-9c27-381663a720eb"
          },
          "data": {
            "type": "customers",
            "id": "3508c540-c515-4d3a-9c27-381663a720eb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3508c540-c515-4d3a-9c27-381663a720eb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T09:44:06+00:00",
        "updated_at": "2022-06-30T09:44:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Strosin, Hahn and Adams",
        "email": "adams_hahn_and_strosin@langworth.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=3508c540-c515-4d3a-9c27-381663a720eb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3508c540-c515-4d3a-9c27-381663a720eb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3508c540-c515-4d3a-9c27-381663a720eb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTk2NWRlNTItYjA3My00Nzc1LWEyMTEtNzYwZDFkNmQ3YWI4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e965de52-b073-4775-a211-760d1d6d7ab8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T09:44:07+00:00",
        "updated_at": "2022-06-30T09:44:07+00:00",
        "number": "http://bqbl.it/e965de52-b073-4775-a211-760d1d6d7ab8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1ce50b171cf8db5bebc794eade575cc4/barcode/image/e965de52-b073-4775-a211-760d1d6d7ab8/9a2b3325-cedd-4286-aa5d-93f8f8587f4f.svg",
        "owner_id": "04937f9e-5de2-43b4-a450-f19e2442f044",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/04937f9e-5de2-43b4-a450-f19e2442f044"
          },
          "data": {
            "type": "customers",
            "id": "04937f9e-5de2-43b4-a450-f19e2442f044"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "04937f9e-5de2-43b4-a450-f19e2442f044",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T09:44:07+00:00",
        "updated_at": "2022-06-30T09:44:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Hickle, Schaden and Schinner",
        "email": "hickle.schaden.schinner.and@oconner.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=04937f9e-5de2-43b4-a450-f19e2442f044&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=04937f9e-5de2-43b4-a450-f19e2442f044&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=04937f9e-5de2-43b4-a450-f19e2442f044&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T09:43:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4537bc4-467d-4b0a-ae6e-1a19f9ade690?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c4537bc4-467d-4b0a-ae6e-1a19f9ade690",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T09:44:07+00:00",
      "updated_at": "2022-06-30T09:44:07+00:00",
      "number": "http://bqbl.it/c4537bc4-467d-4b0a-ae6e-1a19f9ade690",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6b61d0c43066d09190c8433385608bed/barcode/image/c4537bc4-467d-4b0a-ae6e-1a19f9ade690/11866347-8a34-4dc2-9a82-0b339a51dd49.svg",
      "owner_id": "666e56c0-59d6-469a-ba3a-b9fab81cd9f5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/666e56c0-59d6-469a-ba3a-b9fab81cd9f5"
        },
        "data": {
          "type": "customers",
          "id": "666e56c0-59d6-469a-ba3a-b9fab81cd9f5"
        }
      }
    }
  },
  "included": [
    {
      "id": "666e56c0-59d6-469a-ba3a-b9fab81cd9f5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T09:44:07+00:00",
        "updated_at": "2022-06-30T09:44:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Wiza LLC",
        "email": "wiza_llc@turner.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=666e56c0-59d6-469a-ba3a-b9fab81cd9f5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=666e56c0-59d6-469a-ba3a-b9fab81cd9f5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=666e56c0-59d6-469a-ba3a-b9fab81cd9f5&filter[owner_type]=customers"
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
          "owner_id": "5c5d5c2b-ee12-4df4-9a93-b5f08c4d87b8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d09ac27a-3df6-4d8d-93f4-d3ab5447bb7f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T09:44:08+00:00",
      "updated_at": "2022-06-30T09:44:08+00:00",
      "number": "http://bqbl.it/d09ac27a-3df6-4d8d-93f4-d3ab5447bb7f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/43679875b3d789f7dfa6d684bf5cb899/barcode/image/d09ac27a-3df6-4d8d-93f4-d3ab5447bb7f/eed1755d-4741-4a86-8a55-d30bef10b023.svg",
      "owner_id": "5c5d5c2b-ee12-4df4-9a93-b5f08c4d87b8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f1af5a22-1409-4bf2-a20b-91dacab30702' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f1af5a22-1409-4bf2-a20b-91dacab30702",
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
    "id": "f1af5a22-1409-4bf2-a20b-91dacab30702",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T09:44:08+00:00",
      "updated_at": "2022-06-30T09:44:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/190ab45ccae5037851880c6fccc31e5e/barcode/image/f1af5a22-1409-4bf2-a20b-91dacab30702/230964b3-e9d4-45c6-8ca8-dda351bcf015.svg",
      "owner_id": "0153276f-155e-4244-87a1-d969a5cab89a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0888c7b4-2ec0-46ff-b36d-da45ffee0578' \
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