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
      "id": "91bddf06-d56e-4267-8671-58905f90cfe0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-06T12:42:10+00:00",
        "updated_at": "2021-10-06T12:42:10+00:00",
        "number": "http://bqbl.it/91bddf06-d56e-4267-8671-58905f90cfe0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9c65b8a2a062db2413cbdedec28381a4/barcode/image/91bddf06-d56e-4267-8671-58905f90cfe0/4a35fe9e-0c36-427a-b699-ce25edb00325.svg",
        "owner_id": "f3c3f156-e516-4d88-853a-fd7795afeb67",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f3c3f156-e516-4d88-853a-fd7795afeb67"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd61d0a9c-107d-41b2-9f9f-81d188d0019f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d61d0a9c-107d-41b2-9f9f-81d188d0019f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-06T12:42:11+00:00",
        "updated_at": "2021-10-06T12:42:11+00:00",
        "number": "http://bqbl.it/d61d0a9c-107d-41b2-9f9f-81d188d0019f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3d2fb2759c6c72957b32b22b8e5f2fac/barcode/image/d61d0a9c-107d-41b2-9f9f-81d188d0019f/123bf4f2-5d67-4f9f-b59c-b53574841519.svg",
        "owner_id": "0777fb96-19ea-455c-8e02-2c1a9d48bb82",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0777fb96-19ea-455c-8e02-2c1a9d48bb82"
          },
          "data": {
            "type": "customers",
            "id": "0777fb96-19ea-455c-8e02-2c1a9d48bb82"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0777fb96-19ea-455c-8e02-2c1a9d48bb82",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-06T12:42:11+00:00",
        "updated_at": "2021-10-06T12:42:11+00:00",
        "number": 1,
        "name": "Schuster Inc",
        "email": "schuster.inc@murphy.net",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=0777fb96-19ea-455c-8e02-2c1a9d48bb82"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-06T12:42:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4bbde924-699c-4678-8bac-fa7f0fdceb4b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4bbde924-699c-4678-8bac-fa7f0fdceb4b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-06T12:42:11+00:00",
      "updated_at": "2021-10-06T12:42:11+00:00",
      "number": "http://bqbl.it/4bbde924-699c-4678-8bac-fa7f0fdceb4b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3d1f6e97e6e31df1a4511115ef50127f/barcode/image/4bbde924-699c-4678-8bac-fa7f0fdceb4b/37642ede-f63d-48a4-a16a-e05f0720f200.svg",
      "owner_id": "e427e870-d92b-4627-bfd4-72f122012d01",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e427e870-d92b-4627-bfd4-72f122012d01"
        },
        "data": {
          "type": "customers",
          "id": "e427e870-d92b-4627-bfd4-72f122012d01"
        }
      }
    }
  },
  "included": [
    {
      "id": "e427e870-d92b-4627-bfd4-72f122012d01",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-06T12:42:11+00:00",
        "updated_at": "2021-10-06T12:42:11+00:00",
        "number": 1,
        "name": "Wolff, Johns and Borer",
        "email": "wolff.johns.and.borer@gleason.org",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=e427e870-d92b-4627-bfd4-72f122012d01"
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
          "owner_id": "95e2c616-b33f-403e-bb48-bfc163a8d3ba",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "53b959f0-de89-4577-8ac7-5e913aec6a57",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-06T12:42:12+00:00",
      "updated_at": "2021-10-06T12:42:12+00:00",
      "number": "http://bqbl.it/53b959f0-de89-4577-8ac7-5e913aec6a57",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2de092127c6e363e93bf444235b54d7d/barcode/image/53b959f0-de89-4577-8ac7-5e913aec6a57/ba849b7e-87b4-4bd1-8abd-d04d5db8b037.svg",
      "owner_id": "95e2c616-b33f-403e-bb48-bfc163a8d3ba",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ab157b89-ab22-406e-8c5d-96be183dd5d0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ab157b89-ab22-406e-8c5d-96be183dd5d0",
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
    "id": "ab157b89-ab22-406e-8c5d-96be183dd5d0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-06T12:42:12+00:00",
      "updated_at": "2021-10-06T12:42:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/086d178e4311ce98e4eceeef91116521/barcode/image/ab157b89-ab22-406e-8c5d-96be183dd5d0/99bf8118-f964-4695-bf7f-0251136b8daf.svg",
      "owner_id": "55cb30dd-1dd7-48c6-ab47-fe3395a7ea10",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd10f074-bfbd-41ac-9495-39832fe60725' \
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