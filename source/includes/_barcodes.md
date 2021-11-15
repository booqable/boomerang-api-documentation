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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


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
      "id": "4ad255f8-b966-4ade-a957-4686b521c852",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-15T07:45:37+00:00",
        "updated_at": "2021-11-15T07:45:37+00:00",
        "number": "http://bqbl.it/4ad255f8-b966-4ade-a957-4686b521c852",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0e915e1ba6e1495fe0f9d5da0ce1cf09/barcode/image/4ad255f8-b966-4ade-a957-4686b521c852/e138b395-7d21-4462-8f62-c56dc494ed7e.svg",
        "owner_id": "5d4f8227-31b0-49a4-bbe0-9a6fb61ccc89",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5d4f8227-31b0-49a4-bbe0-9a6fb61ccc89"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9608232e-4fb2-465e-84ae-0b6d3f1576cf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9608232e-4fb2-465e-84ae-0b6d3f1576cf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-15T07:45:38+00:00",
        "updated_at": "2021-11-15T07:45:38+00:00",
        "number": "http://bqbl.it/9608232e-4fb2-465e-84ae-0b6d3f1576cf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/99ba3f61951ed7cb537a78c669054127/barcode/image/9608232e-4fb2-465e-84ae-0b6d3f1576cf/44674f7d-e24a-4c1c-8daf-18280849bff7.svg",
        "owner_id": "f506eec8-8e46-40a5-af4a-1888c7c02062",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f506eec8-8e46-40a5-af4a-1888c7c02062"
          },
          "data": {
            "type": "customers",
            "id": "f506eec8-8e46-40a5-af4a-1888c7c02062"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f506eec8-8e46-40a5-af4a-1888c7c02062",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-15T07:45:37+00:00",
        "updated_at": "2021-11-15T07:45:38+00:00",
        "number": 1,
        "name": "Deckow, Gottlieb and Goodwin",
        "email": "gottlieb.goodwin.and.deckow@boyer-roberts.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=f506eec8-8e46-40a5-af4a-1888c7c02062&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f506eec8-8e46-40a5-af4a-1888c7c02062"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=f506eec8-8e46-40a5-af4a-1888c7c02062&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9608232e-4fb2-465e-84ae-0b6d3f1576cf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9608232e-4fb2-465e-84ae-0b6d3f1576cf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9608232e-4fb2-465e-84ae-0b6d3f1576cf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-15T07:45:25Z`
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



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e4bb9bb1-4bae-4739-92c5-1637870c14f0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e4bb9bb1-4bae-4739-92c5-1637870c14f0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-15T07:45:38+00:00",
      "updated_at": "2021-11-15T07:45:38+00:00",
      "number": "http://bqbl.it/e4bb9bb1-4bae-4739-92c5-1637870c14f0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f016f5c1b4971b496b6afad2928a5f5a/barcode/image/e4bb9bb1-4bae-4739-92c5-1637870c14f0/04162743-3dd1-43c7-aff1-528adda41ace.svg",
      "owner_id": "f85284f4-11e7-407a-9cce-ab8f9ca7ed42",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f85284f4-11e7-407a-9cce-ab8f9ca7ed42"
        },
        "data": {
          "type": "customers",
          "id": "f85284f4-11e7-407a-9cce-ab8f9ca7ed42"
        }
      }
    }
  },
  "included": [
    {
      "id": "f85284f4-11e7-407a-9cce-ab8f9ca7ed42",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-15T07:45:38+00:00",
        "updated_at": "2021-11-15T07:45:38+00:00",
        "number": 1,
        "name": "Kuhn, Morissette and Kessler",
        "email": "kessler_and_morissette_kuhn@kub.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=f85284f4-11e7-407a-9cce-ab8f9ca7ed42&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f85284f4-11e7-407a-9cce-ab8f9ca7ed42"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=f85284f4-11e7-407a-9cce-ab8f9ca7ed42&filter[notable_type]=Customer"
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
          "owner_id": "6488591d-e77c-438c-8dfa-f686380b79bb",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "71c26e3f-5ae4-4ebd-bb69-81fd7f741717",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-15T07:45:39+00:00",
      "updated_at": "2021-11-15T07:45:39+00:00",
      "number": "http://bqbl.it/71c26e3f-5ae4-4ebd-bb69-81fd7f741717",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a70dad85dfeb00504468f4d807cf1ed9/barcode/image/71c26e3f-5ae4-4ebd-bb69-81fd7f741717/e09ccd4b-e925-4d9a-93b7-e6d00df25101.svg",
      "owner_id": "6488591d-e77c-438c-8dfa-f686380b79bb",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=6488591d-e77c-438c-8dfa-f686380b79bb&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=6488591d-e77c-438c-8dfa-f686380b79bb&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=6488591d-e77c-438c-8dfa-f686380b79bb&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/fd2ffe42-d926-46ae-99bd-1feea087e240' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fd2ffe42-d926-46ae-99bd-1feea087e240",
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
    "id": "fd2ffe42-d926-46ae-99bd-1feea087e240",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-15T07:45:39+00:00",
      "updated_at": "2021-11-15T07:45:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ba8a1564c3879490f383743697b8bce7/barcode/image/fd2ffe42-d926-46ae-99bd-1feea087e240/b23b7984-50e1-4e5f-a124-8dab2fb31d44.svg",
      "owner_id": "865bfacd-f75d-4eb4-b574-8dd0cc357e10",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/cf9a77db-eb6d-4d1f-897b-f8e3c7645e60' \
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