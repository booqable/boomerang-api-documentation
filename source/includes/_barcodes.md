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
      "id": "1d6ebcf1-9c49-423f-bfc8-a642fb73a20c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-13T18:49:58+00:00",
        "updated_at": "2022-01-13T18:49:58+00:00",
        "number": "http://bqbl.it/1d6ebcf1-9c49-423f-bfc8-a642fb73a20c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1d33d9a0fb5ef69aa3e15fc0b6b7a74b/barcode/image/1d6ebcf1-9c49-423f-bfc8-a642fb73a20c/91f93b6e-ff1d-4ae8-afe1-d6fc56fe8398.svg",
        "owner_id": "c87b399d-2068-4d45-9aaf-c470de136204",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c87b399d-2068-4d45-9aaf-c470de136204"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0b84d819-2d5e-494d-a8e1-8854f467da1e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0b84d819-2d5e-494d-a8e1-8854f467da1e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-13T18:49:59+00:00",
        "updated_at": "2022-01-13T18:49:59+00:00",
        "number": "http://bqbl.it/0b84d819-2d5e-494d-a8e1-8854f467da1e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/033c9379aaf56d62d20b2b03b11e8916/barcode/image/0b84d819-2d5e-494d-a8e1-8854f467da1e/7e150d71-bda7-4807-9d4d-e8c826bfba78.svg",
        "owner_id": "c005fc4f-e692-4a17-8b94-b045afda1951",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c005fc4f-e692-4a17-8b94-b045afda1951"
          },
          "data": {
            "type": "customers",
            "id": "c005fc4f-e692-4a17-8b94-b045afda1951"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c005fc4f-e692-4a17-8b94-b045afda1951",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-13T18:49:59+00:00",
        "updated_at": "2022-01-13T18:49:59+00:00",
        "number": 1,
        "name": "Welch, Larson and Feil",
        "email": "feil.and.larson.welch@brekke.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=c005fc4f-e692-4a17-8b94-b045afda1951&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c005fc4f-e692-4a17-8b94-b045afda1951&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c005fc4f-e692-4a17-8b94-b045afda1951&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-13T18:49:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6574feb4-2bfb-47ad-9b04-ec448b9f13a1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6574feb4-2bfb-47ad-9b04-ec448b9f13a1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T18:49:59+00:00",
      "updated_at": "2022-01-13T18:49:59+00:00",
      "number": "http://bqbl.it/6574feb4-2bfb-47ad-9b04-ec448b9f13a1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8889fb4b0f76b2197890af28a56178b4/barcode/image/6574feb4-2bfb-47ad-9b04-ec448b9f13a1/f47d4049-44b5-44cb-95f3-38de30efaa6a.svg",
      "owner_id": "76fde296-5744-4404-a43e-afe6f9c3414a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/76fde296-5744-4404-a43e-afe6f9c3414a"
        },
        "data": {
          "type": "customers",
          "id": "76fde296-5744-4404-a43e-afe6f9c3414a"
        }
      }
    }
  },
  "included": [
    {
      "id": "76fde296-5744-4404-a43e-afe6f9c3414a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-13T18:49:59+00:00",
        "updated_at": "2022-01-13T18:49:59+00:00",
        "number": 1,
        "name": "Lubowitz, Quitzon and Effertz",
        "email": "lubowitz_quitzon_effertz_and@hammes.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=76fde296-5744-4404-a43e-afe6f9c3414a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=76fde296-5744-4404-a43e-afe6f9c3414a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=76fde296-5744-4404-a43e-afe6f9c3414a&filter[owner_type]=customers"
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
          "owner_id": "55257d5e-4aae-4ff6-83b3-8d9999dc997f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5e1b6cb3-7858-4d49-bb23-b4090330967a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T18:50:00+00:00",
      "updated_at": "2022-01-13T18:50:00+00:00",
      "number": "http://bqbl.it/5e1b6cb3-7858-4d49-bb23-b4090330967a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ab8a6e81ea80dedf89f5a8ba48e17512/barcode/image/5e1b6cb3-7858-4d49-bb23-b4090330967a/f37ff29b-4979-45fd-8158-0d2f3b584743.svg",
      "owner_id": "55257d5e-4aae-4ff6-83b3-8d9999dc997f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0101709e-a390-46ec-8354-c515f6521c02' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0101709e-a390-46ec-8354-c515f6521c02",
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
    "id": "0101709e-a390-46ec-8354-c515f6521c02",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T18:50:00+00:00",
      "updated_at": "2022-01-13T18:50:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/da46efade74a3f4876911236e385447f/barcode/image/0101709e-a390-46ec-8354-c515f6521c02/51f9ebb5-99f9-4597-868b-d6a67e3c6c67.svg",
      "owner_id": "fc13a1be-a5bb-47ba-86dd-9327ba455eea",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f17fa769-03ec-4d8d-837b-2dd9f5d65cf2' \
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