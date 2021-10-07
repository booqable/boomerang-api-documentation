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
      "id": "2e9fa769-8e1c-493f-8d48-c9f86250585a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-07T08:41:04+00:00",
        "updated_at": "2021-10-07T08:41:04+00:00",
        "number": "http://bqbl.it/2e9fa769-8e1c-493f-8d48-c9f86250585a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/130c73624d98d086df783deb546cee94/barcode/image/2e9fa769-8e1c-493f-8d48-c9f86250585a/fd5ed005-712f-4663-9459-5407d975f830.svg",
        "owner_id": "9aaaf0b6-c008-4b32-bcc3-5b6e88f39bf1",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9aaaf0b6-c008-4b32-bcc3-5b6e88f39bf1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9de0bf58-a70b-4a0b-a215-d89e4bbb432b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9de0bf58-a70b-4a0b-a215-d89e4bbb432b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-07T08:41:05+00:00",
        "updated_at": "2021-10-07T08:41:05+00:00",
        "number": "http://bqbl.it/9de0bf58-a70b-4a0b-a215-d89e4bbb432b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/13b41da5c4f677eba3f3e3513c4809c0/barcode/image/9de0bf58-a70b-4a0b-a215-d89e4bbb432b/d59cb106-d0fb-41bd-95d1-d68939322be6.svg",
        "owner_id": "c63edd01-f8be-4c6b-8d01-c56645c4b1bd",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c63edd01-f8be-4c6b-8d01-c56645c4b1bd"
          },
          "data": {
            "type": "customers",
            "id": "c63edd01-f8be-4c6b-8d01-c56645c4b1bd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c63edd01-f8be-4c6b-8d01-c56645c4b1bd",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-07T08:41:05+00:00",
        "updated_at": "2021-10-07T08:41:05+00:00",
        "number": 1,
        "name": "Lakin LLC",
        "email": "llc_lakin@kovacek.net",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=c63edd01-f8be-4c6b-8d01-c56645c4b1bd"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-07T08:41:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/80dfd790-84fa-4242-89c2-f2d6898489ea?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "80dfd790-84fa-4242-89c2-f2d6898489ea",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-07T08:41:06+00:00",
      "updated_at": "2021-10-07T08:41:06+00:00",
      "number": "http://bqbl.it/80dfd790-84fa-4242-89c2-f2d6898489ea",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5ec7eb0efed705f70e88ce59b4900f24/barcode/image/80dfd790-84fa-4242-89c2-f2d6898489ea/315fc834-14e2-4b3c-8a36-a6baee19d6fb.svg",
      "owner_id": "aafc69a2-2206-4eb0-944c-6a7e6ec15ddb",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/aafc69a2-2206-4eb0-944c-6a7e6ec15ddb"
        },
        "data": {
          "type": "customers",
          "id": "aafc69a2-2206-4eb0-944c-6a7e6ec15ddb"
        }
      }
    }
  },
  "included": [
    {
      "id": "aafc69a2-2206-4eb0-944c-6a7e6ec15ddb",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-07T08:41:06+00:00",
        "updated_at": "2021-10-07T08:41:06+00:00",
        "number": 1,
        "name": "Krajcik, Schroeder and Bednar",
        "email": "krajcik.schroeder.and.bednar@wisoky-kutch.info",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=aafc69a2-2206-4eb0-944c-6a7e6ec15ddb"
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
          "owner_id": "0560182d-032c-4a80-a30f-70b45a17e7e2",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "99572161-02f1-4d54-9680-ef1417a53507",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-07T08:41:06+00:00",
      "updated_at": "2021-10-07T08:41:06+00:00",
      "number": "http://bqbl.it/99572161-02f1-4d54-9680-ef1417a53507",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eee03fac6376385c200fb062cbd7be76/barcode/image/99572161-02f1-4d54-9680-ef1417a53507/369be88b-16ea-43fd-8b3f-c8ce75d9af16.svg",
      "owner_id": "0560182d-032c-4a80-a30f-70b45a17e7e2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/988eb5e2-9888-4647-b86c-375c6035de4a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "988eb5e2-9888-4647-b86c-375c6035de4a",
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
    "id": "988eb5e2-9888-4647-b86c-375c6035de4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-07T08:41:07+00:00",
      "updated_at": "2021-10-07T08:41:07+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0578ee3fe5ada41783d19ba874fe49f1/barcode/image/988eb5e2-9888-4647-b86c-375c6035de4a/8dcc7936-3799-4725-8dc6-27d994956da1.svg",
      "owner_id": "e0466b21-e1c9-4e2d-a8f8-22556b2aada1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c6b1bba4-e4d9-45c6-b0d2-4ef491e323aa' \
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