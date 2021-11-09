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
      "id": "8a0f06ab-2b6b-4d96-a5be-61d12c4a6e1b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-09T00:08:13+00:00",
        "updated_at": "2021-11-09T00:08:13+00:00",
        "number": "http://bqbl.it/8a0f06ab-2b6b-4d96-a5be-61d12c4a6e1b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a6f0bea9ca3b3689ee284c7497b047f0/barcode/image/8a0f06ab-2b6b-4d96-a5be-61d12c4a6e1b/d73f7198-eacc-4434-a39c-94b42f5a6678.svg",
        "owner_id": "07d9805c-06ae-467b-a3a7-e665ad2a0f98",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/07d9805c-06ae-467b-a3a7-e665ad2a0f98"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe3417caf-bfa9-4479-9923-44607865a836&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e3417caf-bfa9-4479-9923-44607865a836",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-09T00:08:13+00:00",
        "updated_at": "2021-11-09T00:08:13+00:00",
        "number": "http://bqbl.it/e3417caf-bfa9-4479-9923-44607865a836",
        "barcode_type": "qr_code",
        "image_url": "/uploads/555fb50ae5e321ce16ff8b45bce3472f/barcode/image/e3417caf-bfa9-4479-9923-44607865a836/19d92957-032f-403b-866a-064d3b846ee2.svg",
        "owner_id": "491af10a-c579-4433-a8b2-c7b6bf038d27",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/491af10a-c579-4433-a8b2-c7b6bf038d27"
          },
          "data": {
            "type": "customers",
            "id": "491af10a-c579-4433-a8b2-c7b6bf038d27"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "491af10a-c579-4433-a8b2-c7b6bf038d27",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T00:08:13+00:00",
        "updated_at": "2021-11-09T00:08:13+00:00",
        "number": 1,
        "name": "Feest, Gleason and Mitchell",
        "email": "gleason.and.feest.mitchell@gorczany.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=491af10a-c579-4433-a8b2-c7b6bf038d27&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=491af10a-c579-4433-a8b2-c7b6bf038d27"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=491af10a-c579-4433-a8b2-c7b6bf038d27&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe3417caf-bfa9-4479-9923-44607865a836&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe3417caf-bfa9-4479-9923-44607865a836&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe3417caf-bfa9-4479-9923-44607865a836&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-09T00:07:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a09821f1-c0a9-4e1a-b2f5-cc1234903f47?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a09821f1-c0a9-4e1a-b2f5-cc1234903f47",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-09T00:08:14+00:00",
      "updated_at": "2021-11-09T00:08:14+00:00",
      "number": "http://bqbl.it/a09821f1-c0a9-4e1a-b2f5-cc1234903f47",
      "barcode_type": "qr_code",
      "image_url": "/uploads/134f479970c859b26ebb01d431622b9d/barcode/image/a09821f1-c0a9-4e1a-b2f5-cc1234903f47/53e43987-2d82-42b0-a3be-d5ddf2a1ed24.svg",
      "owner_id": "cfec7f91-2054-4551-91b6-2f69ddde202b",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/cfec7f91-2054-4551-91b6-2f69ddde202b"
        },
        "data": {
          "type": "customers",
          "id": "cfec7f91-2054-4551-91b6-2f69ddde202b"
        }
      }
    }
  },
  "included": [
    {
      "id": "cfec7f91-2054-4551-91b6-2f69ddde202b",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T00:08:14+00:00",
        "updated_at": "2021-11-09T00:08:14+00:00",
        "number": 1,
        "name": "Erdman-Harris",
        "email": "harris_erdman@ondricka.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=cfec7f91-2054-4551-91b6-2f69ddde202b&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cfec7f91-2054-4551-91b6-2f69ddde202b"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=cfec7f91-2054-4551-91b6-2f69ddde202b&filter[notable_type]=Customer"
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
          "owner_id": "2a4e47be-6a12-4436-bc76-6a6054f42bd9",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9c2c7eee-40b7-455a-9151-b04ba334f23d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-09T00:08:15+00:00",
      "updated_at": "2021-11-09T00:08:15+00:00",
      "number": "http://bqbl.it/9c2c7eee-40b7-455a-9151-b04ba334f23d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/60eae1bc4f1baea32d06a181adf6662a/barcode/image/9c2c7eee-40b7-455a-9151-b04ba334f23d/b0983453-b26f-401d-9752-3276d2f16ed6.svg",
      "owner_id": "2a4e47be-6a12-4436-bc76-6a6054f42bd9",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=2a4e47be-6a12-4436-bc76-6a6054f42bd9&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=2a4e47be-6a12-4436-bc76-6a6054f42bd9&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=2a4e47be-6a12-4436-bc76-6a6054f42bd9&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8566c9e3-85fb-4292-aa34-5c4826d79086' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8566c9e3-85fb-4292-aa34-5c4826d79086",
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
    "id": "8566c9e3-85fb-4292-aa34-5c4826d79086",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-09T00:08:15+00:00",
      "updated_at": "2021-11-09T00:08:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/52663adafe51c001f7a43557b5bade5b/barcode/image/8566c9e3-85fb-4292-aa34-5c4826d79086/259d72eb-bb31-4c5b-b363-9e6136484090.svg",
      "owner_id": "52aaff56-f10a-44c6-9974-083566eb74c5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eadd9a6c-4168-46a9-833b-d1d6d96acc19' \
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