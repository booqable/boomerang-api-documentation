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
      "id": "ef435bd5-3064-4eef-825f-fbb962d0f7b1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-12T18:24:36+00:00",
        "updated_at": "2022-04-12T18:24:36+00:00",
        "number": "http://bqbl.it/ef435bd5-3064-4eef-825f-fbb962d0f7b1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/371a33a72de98f356604365aec5f71da/barcode/image/ef435bd5-3064-4eef-825f-fbb962d0f7b1/0763300c-10a8-4aa6-9b78-df231902f018.svg",
        "owner_id": "8f4bad8d-7292-4fb6-9855-7c8c9fa94ee7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8f4bad8d-7292-4fb6-9855-7c8c9fa94ee7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F45be4167-de47-47ec-953d-75b54020cb85&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "45be4167-de47-47ec-953d-75b54020cb85",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-12T18:24:37+00:00",
        "updated_at": "2022-04-12T18:24:37+00:00",
        "number": "http://bqbl.it/45be4167-de47-47ec-953d-75b54020cb85",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0effe838e38ca02d55c6eae646729737/barcode/image/45be4167-de47-47ec-953d-75b54020cb85/8645445a-288f-4bef-81af-c322402d1437.svg",
        "owner_id": "382f13a9-f867-46b3-a7a0-e304b724b77f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/382f13a9-f867-46b3-a7a0-e304b724b77f"
          },
          "data": {
            "type": "customers",
            "id": "382f13a9-f867-46b3-a7a0-e304b724b77f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "382f13a9-f867-46b3-a7a0-e304b724b77f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-12T18:24:37+00:00",
        "updated_at": "2022-04-12T18:24:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Waters-Buckridge",
        "email": "waters_buckridge@bogan-hegmann.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=382f13a9-f867-46b3-a7a0-e304b724b77f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=382f13a9-f867-46b3-a7a0-e304b724b77f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=382f13a9-f867-46b3-a7a0-e304b724b77f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMWJmZTQ0MjMtNzhhMS00NWZmLThiZmEtMzIwMmMxMWY3Y2M2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1bfe4423-78a1-45ff-8bfa-3202c11f7cc6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-12T18:24:37+00:00",
        "updated_at": "2022-04-12T18:24:37+00:00",
        "number": "http://bqbl.it/1bfe4423-78a1-45ff-8bfa-3202c11f7cc6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2377035275fa3aa648dfac735605a845/barcode/image/1bfe4423-78a1-45ff-8bfa-3202c11f7cc6/08369f37-7dc2-4989-a739-22b6b2abed77.svg",
        "owner_id": "cfcd8515-baee-4a2c-90d2-d1ebadbfe490",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cfcd8515-baee-4a2c-90d2-d1ebadbfe490"
          },
          "data": {
            "type": "customers",
            "id": "cfcd8515-baee-4a2c-90d2-d1ebadbfe490"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cfcd8515-baee-4a2c-90d2-d1ebadbfe490",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-12T18:24:37+00:00",
        "updated_at": "2022-04-12T18:24:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Bergstrom and Sons",
        "email": "bergstrom.sons.and@schowalter.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=cfcd8515-baee-4a2c-90d2-d1ebadbfe490&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cfcd8515-baee-4a2c-90d2-d1ebadbfe490&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cfcd8515-baee-4a2c-90d2-d1ebadbfe490&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-12T18:24:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c0f4eab7-cdf3-437e-82ae-ecaf1fd4fa3e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0f4eab7-cdf3-437e-82ae-ecaf1fd4fa3e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-12T18:24:38+00:00",
      "updated_at": "2022-04-12T18:24:38+00:00",
      "number": "http://bqbl.it/c0f4eab7-cdf3-437e-82ae-ecaf1fd4fa3e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1bd303a3a1bc12a1a2995ba0465f6d87/barcode/image/c0f4eab7-cdf3-437e-82ae-ecaf1fd4fa3e/0a6bfc7c-06da-4211-9ee2-a1632cd01c0a.svg",
      "owner_id": "d1df413d-2cde-4527-b46c-26baf2374c9b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d1df413d-2cde-4527-b46c-26baf2374c9b"
        },
        "data": {
          "type": "customers",
          "id": "d1df413d-2cde-4527-b46c-26baf2374c9b"
        }
      }
    }
  },
  "included": [
    {
      "id": "d1df413d-2cde-4527-b46c-26baf2374c9b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-12T18:24:38+00:00",
        "updated_at": "2022-04-12T18:24:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Ebert-Stark",
        "email": "stark_ebert@watsica-murray.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=d1df413d-2cde-4527-b46c-26baf2374c9b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d1df413d-2cde-4527-b46c-26baf2374c9b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d1df413d-2cde-4527-b46c-26baf2374c9b&filter[owner_type]=customers"
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
          "owner_id": "902ea12c-3073-46ab-a11b-2d72cf06c8a2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ed06cb4f-1a4f-4c86-840d-822a57c88405",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-12T18:24:38+00:00",
      "updated_at": "2022-04-12T18:24:38+00:00",
      "number": "http://bqbl.it/ed06cb4f-1a4f-4c86-840d-822a57c88405",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a58955b985edd01b3337087806eb9aa7/barcode/image/ed06cb4f-1a4f-4c86-840d-822a57c88405/3029e9cc-a91c-448b-b035-0ae9d162529c.svg",
      "owner_id": "902ea12c-3073-46ab-a11b-2d72cf06c8a2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/28337589-6650-4c50-9b7f-6dc40a438076' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "28337589-6650-4c50-9b7f-6dc40a438076",
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
    "id": "28337589-6650-4c50-9b7f-6dc40a438076",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-12T18:24:39+00:00",
      "updated_at": "2022-04-12T18:24:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7a946b182ff2b3aa07b86af3fadb82aa/barcode/image/28337589-6650-4c50-9b7f-6dc40a438076/6fda50c2-0ef4-422f-9217-eee2002977a4.svg",
      "owner_id": "2a474303-2813-4e1a-abb9-953f3c70c0ac",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/becf4b19-8951-4e78-9b56-bed7d4c0fb0f' \
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