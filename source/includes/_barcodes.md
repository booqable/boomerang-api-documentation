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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`


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
      "id": "96658830-fbe4-4c87-9026-dfb35447a029",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-09-29T09:38:09+00:00",
        "updated_at": "2021-09-29T09:38:09+00:00",
        "number": "http://bqbl.it/96658830-fbe4-4c87-9026-dfb35447a029",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b1d6e36464620775b958e57874ebf3e1/barcode/image/96658830-fbe4-4c87-9026-dfb35447a029/80bddd5e-f3b5-4186-b114-cc3b80215bd2.svg",
        "owner_id": "afa21616-84b2-4071-811f-e864252802ea",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/afa21616-84b2-4071-811f-e864252802ea"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa13f5b70-7fb4-4a6e-af66-3ecd75f4b74f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a13f5b70-7fb4-4a6e-af66-3ecd75f4b74f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-09-29T09:38:10+00:00",
        "updated_at": "2021-09-29T09:38:10+00:00",
        "number": "http://bqbl.it/a13f5b70-7fb4-4a6e-af66-3ecd75f4b74f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/648e737bad3c52391e01ecf046be4d4c/barcode/image/a13f5b70-7fb4-4a6e-af66-3ecd75f4b74f/e4762239-d3e4-4902-996e-0c8c9971911c.svg",
        "owner_id": "0ff5b9ad-4c7d-450e-9c54-b7fb9a2f952b",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0ff5b9ad-4c7d-450e-9c54-b7fb9a2f952b"
          },
          "data": {
            "type": "customers",
            "id": "0ff5b9ad-4c7d-450e-9c54-b7fb9a2f952b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0ff5b9ad-4c7d-450e-9c54-b7fb9a2f952b",
      "type": "customers",
      "attributes": {
        "created_at": "2021-09-29T09:38:10+00:00",
        "updated_at": "2021-09-29T09:38:10+00:00",
        "number": 1,
        "name": "Strosin Inc",
        "email": "strosin_inc@davis.co",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=0ff5b9ad-4c7d-450e-9c54-b7fb9a2f952b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-09-29T09:38:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3eb5ae1b-0066-44be-b490-690be58e7318?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3eb5ae1b-0066-44be-b490-690be58e7318",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-09-29T09:38:11+00:00",
      "updated_at": "2021-09-29T09:38:11+00:00",
      "number": "http://bqbl.it/3eb5ae1b-0066-44be-b490-690be58e7318",
      "barcode_type": "qr_code",
      "image_url": "/uploads/50f3d58eb20275f954342d8a2f575b96/barcode/image/3eb5ae1b-0066-44be-b490-690be58e7318/67211b1c-3915-4168-995a-8dcc69cdc670.svg",
      "owner_id": "ff39210d-dadc-44a1-a507-2275e0e62e39",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ff39210d-dadc-44a1-a507-2275e0e62e39"
        },
        "data": {
          "type": "customers",
          "id": "ff39210d-dadc-44a1-a507-2275e0e62e39"
        }
      }
    }
  },
  "included": [
    {
      "id": "ff39210d-dadc-44a1-a507-2275e0e62e39",
      "type": "customers",
      "attributes": {
        "created_at": "2021-09-29T09:38:11+00:00",
        "updated_at": "2021-09-29T09:38:11+00:00",
        "number": 1,
        "name": "Ryan, MacGyver and Collins",
        "email": "collins.and.macgyver.ryan@smitham-nienow.com",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=ff39210d-dadc-44a1-a507-2275e0e62e39"
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
          "owner_id": "8088f8df-305e-4c0e-b92a-4760d1a21950",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a65ff05d-c8cf-4113-b081-c60584944bf0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-09-29T09:38:11+00:00",
      "updated_at": "2021-09-29T09:38:11+00:00",
      "number": "http://bqbl.it/a65ff05d-c8cf-4113-b081-c60584944bf0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/129dbe349fe0b60a3df1b122427363af/barcode/image/a65ff05d-c8cf-4113-b081-c60584944bf0/f4ec3b95-8fe6-4e05-ae9e-95ae5df22806.svg",
      "owner_id": "8088f8df-305e-4c0e-b92a-4760d1a21950",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode

> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/ddb2a145-30c7-4efd-94f7-6080d5862935' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ddb2a145-30c7-4efd-94f7-6080d5862935",
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
    "id": "ddb2a145-30c7-4efd-94f7-6080d5862935",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-09-29T09:38:12+00:00",
      "updated_at": "2021-09-29T09:38:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aac40bb3a9b42fd31794900961a2a57d/barcode/image/ddb2a145-30c7-4efd-94f7-6080d5862935/d3ffb7a7-d6b2-44ae-9429-24662c57e665.svg",
      "owner_id": "7773258d-85e4-4c53-9977-8925ce85b9f9",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode

> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a2efbdf5-fd68-42b7-9968-77748a286da9' \
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