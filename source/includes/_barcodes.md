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
      "id": "3254b6c6-349b-44d8-bcc4-9746f6276a52",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-17T10:31:57+00:00",
        "updated_at": "2023-02-17T10:31:57+00:00",
        "number": "http://bqbl.it/3254b6c6-349b-44d8-bcc4-9746f6276a52",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1fe7f010dcdd855dd440098e6f7aaf45/barcode/image/3254b6c6-349b-44d8-bcc4-9746f6276a52/e228a56d-9547-4e40-9461-009d436ef150.svg",
        "owner_id": "b3fefde0-027f-46f6-94a7-54b1e07df80b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b3fefde0-027f-46f6-94a7-54b1e07df80b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa1ffa6a3-ad67-4c63-817e-fdde1c08f355&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a1ffa6a3-ad67-4c63-817e-fdde1c08f355",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-17T10:31:58+00:00",
        "updated_at": "2023-02-17T10:31:58+00:00",
        "number": "http://bqbl.it/a1ffa6a3-ad67-4c63-817e-fdde1c08f355",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1d55e95a0ee566bec0d861678e2ccbb9/barcode/image/a1ffa6a3-ad67-4c63-817e-fdde1c08f355/1a308d36-ad36-4a81-8d7f-c45b1311254b.svg",
        "owner_id": "f6b77127-7103-4e3e-8769-bf83140e31c1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f6b77127-7103-4e3e-8769-bf83140e31c1"
          },
          "data": {
            "type": "customers",
            "id": "f6b77127-7103-4e3e-8769-bf83140e31c1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f6b77127-7103-4e3e-8769-bf83140e31c1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-17T10:31:58+00:00",
        "updated_at": "2023-02-17T10:31:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f6b77127-7103-4e3e-8769-bf83140e31c1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f6b77127-7103-4e3e-8769-bf83140e31c1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f6b77127-7103-4e3e-8769-bf83140e31c1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjRmZDY0Y2UtYzhmZS00MWIzLWFkOTgtZjU5ZGNiNDkyOTI1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4fd64ce-c8fe-41b3-ad98-f59dcb492925",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-17T10:31:59+00:00",
        "updated_at": "2023-02-17T10:31:59+00:00",
        "number": "http://bqbl.it/b4fd64ce-c8fe-41b3-ad98-f59dcb492925",
        "barcode_type": "qr_code",
        "image_url": "/uploads/aa0a50072edd07a09403b1cf5f0225a2/barcode/image/b4fd64ce-c8fe-41b3-ad98-f59dcb492925/f7bbb721-bb04-4c0e-b8aa-9f7c59e79be6.svg",
        "owner_id": "0d55629d-72f7-4f03-8e8d-cc3b2def1224",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0d55629d-72f7-4f03-8e8d-cc3b2def1224"
          },
          "data": {
            "type": "customers",
            "id": "0d55629d-72f7-4f03-8e8d-cc3b2def1224"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0d55629d-72f7-4f03-8e8d-cc3b2def1224",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-17T10:31:59+00:00",
        "updated_at": "2023-02-17T10:31:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0d55629d-72f7-4f03-8e8d-cc3b2def1224&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0d55629d-72f7-4f03-8e8d-cc3b2def1224&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0d55629d-72f7-4f03-8e8d-cc3b2def1224&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-17T10:31:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6227e3f5-17f7-4ec4-b0bf-9fcccbbf97a3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6227e3f5-17f7-4ec4-b0bf-9fcccbbf97a3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-17T10:32:00+00:00",
      "updated_at": "2023-02-17T10:32:00+00:00",
      "number": "http://bqbl.it/6227e3f5-17f7-4ec4-b0bf-9fcccbbf97a3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db37dfd432a7b0caccc46a888287421c/barcode/image/6227e3f5-17f7-4ec4-b0bf-9fcccbbf97a3/9e95e93e-33f9-4ec4-8d49-a0b51f77e949.svg",
      "owner_id": "c13a3fa1-eeab-4153-bcdd-53251d1148d6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c13a3fa1-eeab-4153-bcdd-53251d1148d6"
        },
        "data": {
          "type": "customers",
          "id": "c13a3fa1-eeab-4153-bcdd-53251d1148d6"
        }
      }
    }
  },
  "included": [
    {
      "id": "c13a3fa1-eeab-4153-bcdd-53251d1148d6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-17T10:32:00+00:00",
        "updated_at": "2023-02-17T10:32:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c13a3fa1-eeab-4153-bcdd-53251d1148d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c13a3fa1-eeab-4153-bcdd-53251d1148d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c13a3fa1-eeab-4153-bcdd-53251d1148d6&filter[owner_type]=customers"
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
          "owner_id": "409fc523-96b6-4665-880a-bf96b39ba604",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2f0b1751-636f-43de-8b8a-6a713a23c072",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-17T10:32:01+00:00",
      "updated_at": "2023-02-17T10:32:01+00:00",
      "number": "http://bqbl.it/2f0b1751-636f-43de-8b8a-6a713a23c072",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f796019a369a1c40ca5e73e21f1d3da1/barcode/image/2f0b1751-636f-43de-8b8a-6a713a23c072/8b806fd0-9e60-45d2-a760-e89643e8d8d0.svg",
      "owner_id": "409fc523-96b6-4665-880a-bf96b39ba604",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd59ddf6-b6d5-4f45-bd9d-4667785bff68' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dd59ddf6-b6d5-4f45-bd9d-4667785bff68",
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
    "id": "dd59ddf6-b6d5-4f45-bd9d-4667785bff68",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-17T10:32:02+00:00",
      "updated_at": "2023-02-17T10:32:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/de3a6197c9366e7ae5b8e41ee30e5ad4/barcode/image/dd59ddf6-b6d5-4f45-bd9d-4667785bff68/4119c2cf-936c-4c53-844b-ac57dba96ce1.svg",
      "owner_id": "cc206bd3-2833-44a4-a9fd-2b95e683f763",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6c53e841-98ed-45c9-b61a-659be57ef5ff' \
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