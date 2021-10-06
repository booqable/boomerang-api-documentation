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
      "id": "14356cd8-0ba9-4724-97b2-64d0fdc75630",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-06T10:04:16+00:00",
        "updated_at": "2021-10-06T10:04:16+00:00",
        "number": "http://bqbl.it/14356cd8-0ba9-4724-97b2-64d0fdc75630",
        "barcode_type": "qr_code",
        "image_url": "/uploads/20eb5961abdadebe1e43592e9287db36/barcode/image/14356cd8-0ba9-4724-97b2-64d0fdc75630/8cfea575-560f-4bfa-99ea-984d96525700.svg",
        "owner_id": "a633e780-b668-43ab-acb1-05b525a7d45d",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a633e780-b668-43ab-acb1-05b525a7d45d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F79f479b7-ae72-4832-b881-55dbbeda5f83&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "79f479b7-ae72-4832-b881-55dbbeda5f83",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-06T10:04:17+00:00",
        "updated_at": "2021-10-06T10:04:17+00:00",
        "number": "http://bqbl.it/79f479b7-ae72-4832-b881-55dbbeda5f83",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b20aa71c08282f176bca80bb56a871a1/barcode/image/79f479b7-ae72-4832-b881-55dbbeda5f83/9498d72c-0ca0-4b51-8a4b-0f4a3acd78f5.svg",
        "owner_id": "0f22d8d8-c897-4b36-a3c2-28aa4a09da91",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0f22d8d8-c897-4b36-a3c2-28aa4a09da91"
          },
          "data": {
            "type": "customers",
            "id": "0f22d8d8-c897-4b36-a3c2-28aa4a09da91"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0f22d8d8-c897-4b36-a3c2-28aa4a09da91",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-06T10:04:17+00:00",
        "updated_at": "2021-10-06T10:04:17+00:00",
        "number": 1,
        "name": "Franecki-Johnson",
        "email": "franecki.johnson@konopelski.org",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=0f22d8d8-c897-4b36-a3c2-28aa4a09da91"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-06T10:04:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/58063b38-7791-4625-aa95-410819d8769f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "58063b38-7791-4625-aa95-410819d8769f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-06T10:04:18+00:00",
      "updated_at": "2021-10-06T10:04:18+00:00",
      "number": "http://bqbl.it/58063b38-7791-4625-aa95-410819d8769f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3e3ab4dbd6a635a4e7d81505665656fa/barcode/image/58063b38-7791-4625-aa95-410819d8769f/a46d4413-8983-4c69-a9cd-c3406871ea65.svg",
      "owner_id": "81c0b1f1-5855-4727-8f32-0f861db34302",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/81c0b1f1-5855-4727-8f32-0f861db34302"
        },
        "data": {
          "type": "customers",
          "id": "81c0b1f1-5855-4727-8f32-0f861db34302"
        }
      }
    }
  },
  "included": [
    {
      "id": "81c0b1f1-5855-4727-8f32-0f861db34302",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-06T10:04:18+00:00",
        "updated_at": "2021-10-06T10:04:18+00:00",
        "number": 1,
        "name": "Schiller LLC",
        "email": "schiller_llc@lang.io",
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
            "related": "api/boomerang/barcodes?filter[owner_id]=81c0b1f1-5855-4727-8f32-0f861db34302"
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
          "owner_id": "a29325d3-65c1-4bf9-90e8-083841316cee",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4adc0c3b-2a25-4357-9fb4-8aa4ea502c72",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-06T10:04:18+00:00",
      "updated_at": "2021-10-06T10:04:18+00:00",
      "number": "http://bqbl.it/4adc0c3b-2a25-4357-9fb4-8aa4ea502c72",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1e9d83b816ff68eb9b4a596dacd62cd7/barcode/image/4adc0c3b-2a25-4357-9fb4-8aa4ea502c72/fae84bf1-5d0b-43fd-bf1d-63ac0970c1ec.svg",
      "owner_id": "a29325d3-65c1-4bf9-90e8-083841316cee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b50945d7-3e10-474b-9719-0bc7ffbee9d2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b50945d7-3e10-474b-9719-0bc7ffbee9d2",
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
    "id": "b50945d7-3e10-474b-9719-0bc7ffbee9d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-06T10:04:19+00:00",
      "updated_at": "2021-10-06T10:04:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2eecb05bd8b8794e7a526f59f01f09c9/barcode/image/b50945d7-3e10-474b-9719-0bc7ffbee9d2/c63778c6-c039-4955-a6dc-4bedce26cb83.svg",
      "owner_id": "a906b55b-52c7-464c-9f9c-043d6bef32a8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c8ac1f39-b4bd-4378-849e-9234524dc9a1' \
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