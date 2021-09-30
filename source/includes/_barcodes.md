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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


## Relationships
A barcodes has the following relationships:

Name | Description
- | -
`owner` | **Customer**<br>Associated Owner


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
      "id": "d4f56093-9997-4b81-96e2-ef840e8022c6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-09-29T15:35:16+00:00",
        "updated_at": "2021-09-29T15:35:16+00:00",
        "number": "http://bqbl.it/d4f56093-9997-4b81-96e2-ef840e8022c6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d97fc109ebda0fea7a9abfdb035ac3c7/barcode/image/d4f56093-9997-4b81-96e2-ef840e8022c6/8b5054f2-30f3-4da4-abe4-37a176c4e003.svg",
        "owner_id": "c0d18e9a-37d8-453c-a836-ea49b1f89942",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c0d18e9a-37d8-453c-a836-ea49b1f89942"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1cfd60c0-c2e9-4a4d-9fb5-4e614a2c96ec&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1cfd60c0-c2e9-4a4d-9fb5-4e614a2c96ec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-09-29T15:35:17+00:00",
        "updated_at": "2021-09-29T15:35:17+00:00",
        "number": "http://bqbl.it/1cfd60c0-c2e9-4a4d-9fb5-4e614a2c96ec",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2f5f66ceca7f1af77f8d91819ee5f7f5/barcode/image/1cfd60c0-c2e9-4a4d-9fb5-4e614a2c96ec/01a33a6c-0cab-438e-8c35-9efea8cb3f94.svg",
        "owner_id": "829cc4df-131e-4f7d-becc-b90b146b4111",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/829cc4df-131e-4f7d-becc-b90b146b4111"
          },
          "data": {
            "type": "customers",
            "id": "829cc4df-131e-4f7d-becc-b90b146b4111"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "829cc4df-131e-4f7d-becc-b90b146b4111",
      "type": "customers",
      "attributes": {
        "created_at": "2021-09-29T15:35:17+00:00",
        "updated_at": "2021-09-29T15:35:17+00:00",
        "number": 1,
        "name": "Hagenes-Strosin",
        "email": "strosin_hagenes@ruecker.info",
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=829cc4df-131e-4f7d-becc-b90b146b4111"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-29T15:35:12Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


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
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode

> How to fetch a barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/3fc2f869-96eb-4697-9390-4bd07bb19715?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3fc2f869-96eb-4697-9390-4bd07bb19715",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-09-29T15:35:17+00:00",
      "updated_at": "2021-09-29T15:35:17+00:00",
      "number": "http://bqbl.it/3fc2f869-96eb-4697-9390-4bd07bb19715",
      "barcode_type": "qr_code",
      "image_url": "/uploads/128672dd68b340412ea0758399b82454/barcode/image/3fc2f869-96eb-4697-9390-4bd07bb19715/e605ba50-8e86-4154-b8b7-f86ef65d0155.svg",
      "owner_id": "e376a412-c2e9-49a7-9311-e23b5afa2327",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e376a412-c2e9-49a7-9311-e23b5afa2327"
        },
        "data": {
          "type": "customers",
          "id": "e376a412-c2e9-49a7-9311-e23b5afa2327"
        }
      }
    }
  },
  "included": [
    {
      "id": "e376a412-c2e9-49a7-9311-e23b5afa2327",
      "type": "customers",
      "attributes": {
        "created_at": "2021-09-29T15:35:17+00:00",
        "updated_at": "2021-09-29T15:35:17+00:00",
        "number": 1,
        "name": "Leannon, Ruecker and Dare",
        "email": "and.leannon.dare.ruecker@schumm-koss.io",
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e376a412-c2e9-49a7-9311-e23b5afa2327"
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
          "owner_id": "3cbf6925-d086-4c63-bac9-a0eb74a74722",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d1d4a98c-22fa-4c29-bdc1-6f8b3077b062",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-09-29T15:35:18+00:00",
      "updated_at": "2021-09-29T15:35:18+00:00",
      "number": "http://bqbl.it/d1d4a98c-22fa-4c29-bdc1-6f8b3077b062",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c6bd0e394950578eb254c85b7879ecf5/barcode/image/d1d4a98c-22fa-4c29-bdc1-6f8b3077b062/b0f63a6c-3d0d-44c1-8bf8-ee8432aae80b.svg",
      "owner_id": "3cbf6925-d086-4c63-bac9-a0eb74a74722",
      "owner_type": "Customer"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode

> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/0c42a99c-61c8-44b2-ab8d-5167a031688a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0c42a99c-61c8-44b2-ab8d-5167a031688a",
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
    "id": "0c42a99c-61c8-44b2-ab8d-5167a031688a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-09-29T15:35:19+00:00",
      "updated_at": "2021-09-29T15:35:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/458a72bc5ad05e5363a237fc41acbe96/barcode/image/0c42a99c-61c8-44b2-ab8d-5167a031688a/834e978b-5cc7-4fb6-b6b1-ddf689a1238e.svg",
      "owner_id": "a548fd8b-574c-4ca6-9a9a-ff4842235e4f",
      "owner_type": "Customer"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode

> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/64dfaa6e-9fba-4f28-a972-e2e2b34669dc' \
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