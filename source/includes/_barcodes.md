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
      "id": "532465e9-0f30-48f8-a685-74e15c1a1bec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-17T09:29:48+00:00",
        "updated_at": "2021-11-17T09:29:48+00:00",
        "number": "http://bqbl.it/532465e9-0f30-48f8-a685-74e15c1a1bec",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b83daeb6931379f1c8675ebfde138556/barcode/image/532465e9-0f30-48f8-a685-74e15c1a1bec/75e058fa-48c7-48a5-b859-76e14d1d0f2a.svg",
        "owner_id": "7fd65810-e0c6-42cf-afbd-d792389586fd",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7fd65810-e0c6-42cf-afbd-d792389586fd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F30e2b521-584a-496c-aefc-b39dc755a46c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "30e2b521-584a-496c-aefc-b39dc755a46c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-17T09:29:49+00:00",
        "updated_at": "2021-11-17T09:29:49+00:00",
        "number": "http://bqbl.it/30e2b521-584a-496c-aefc-b39dc755a46c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/22d3451c072595c707ba528468f9b699/barcode/image/30e2b521-584a-496c-aefc-b39dc755a46c/e6cd98ec-ae21-4f5f-af4a-2e6967e441e2.svg",
        "owner_id": "f10ff559-a56f-48ce-9d25-c4080c005cf5",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f10ff559-a56f-48ce-9d25-c4080c005cf5"
          },
          "data": {
            "type": "customers",
            "id": "f10ff559-a56f-48ce-9d25-c4080c005cf5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f10ff559-a56f-48ce-9d25-c4080c005cf5",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-17T09:29:49+00:00",
        "updated_at": "2021-11-17T09:29:49+00:00",
        "number": 1,
        "name": "Ondricka-Spencer",
        "email": "spencer.ondricka@veum.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=f10ff559-a56f-48ce-9d25-c4080c005cf5&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f10ff559-a56f-48ce-9d25-c4080c005cf5"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=f10ff559-a56f-48ce-9d25-c4080c005cf5&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F30e2b521-584a-496c-aefc-b39dc755a46c&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F30e2b521-584a-496c-aefc-b39dc755a46c&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F30e2b521-584a-496c-aefc-b39dc755a46c&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-17T09:29:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/13c7c57a-224d-44a6-9a13-2f98df885810?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13c7c57a-224d-44a6-9a13-2f98df885810",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-17T09:29:49+00:00",
      "updated_at": "2021-11-17T09:29:49+00:00",
      "number": "http://bqbl.it/13c7c57a-224d-44a6-9a13-2f98df885810",
      "barcode_type": "qr_code",
      "image_url": "/uploads/718a1f99e482a790368ec2c18af68095/barcode/image/13c7c57a-224d-44a6-9a13-2f98df885810/fac11dc6-2112-4623-8ed4-48549d18acf3.svg",
      "owner_id": "ae716249-fd2a-4dbd-b48e-fbd38c2b41e6",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ae716249-fd2a-4dbd-b48e-fbd38c2b41e6"
        },
        "data": {
          "type": "customers",
          "id": "ae716249-fd2a-4dbd-b48e-fbd38c2b41e6"
        }
      }
    }
  },
  "included": [
    {
      "id": "ae716249-fd2a-4dbd-b48e-fbd38c2b41e6",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-17T09:29:49+00:00",
        "updated_at": "2021-11-17T09:29:49+00:00",
        "number": 1,
        "name": "Hegmann-McDermott",
        "email": "mcdermott_hegmann@schmitt.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=ae716249-fd2a-4dbd-b48e-fbd38c2b41e6&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ae716249-fd2a-4dbd-b48e-fbd38c2b41e6"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=ae716249-fd2a-4dbd-b48e-fbd38c2b41e6&filter[notable_type]=Customer"
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
          "owner_id": "46564034-2781-42df-ae59-b246b1ba1c40",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dea7fe4f-7c07-4251-80f7-a6f5f598ddfd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-17T09:29:50+00:00",
      "updated_at": "2021-11-17T09:29:50+00:00",
      "number": "http://bqbl.it/dea7fe4f-7c07-4251-80f7-a6f5f598ddfd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0d84104e11f4725cf72e81d20811117a/barcode/image/dea7fe4f-7c07-4251-80f7-a6f5f598ddfd/71543915-8c5e-4f77-968c-becc7df924d5.svg",
      "owner_id": "46564034-2781-42df-ae59-b246b1ba1c40",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=46564034-2781-42df-ae59-b246b1ba1c40&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=46564034-2781-42df-ae59-b246b1ba1c40&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=46564034-2781-42df-ae59-b246b1ba1c40&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/10bc602c-a368-486c-867a-a11c4c66afd2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "10bc602c-a368-486c-867a-a11c4c66afd2",
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
    "id": "10bc602c-a368-486c-867a-a11c4c66afd2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-17T09:29:50+00:00",
      "updated_at": "2021-11-17T09:29:50+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/de74dae81f3dfed4529b9627f309fa25/barcode/image/10bc602c-a368-486c-867a-a11c4c66afd2/5697202a-d064-4e81-b78e-2495d573ba84.svg",
      "owner_id": "00043a74-6fdd-407e-9e30-32c40145018f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d2f294c-becc-4b0b-8262-7a7f9c495329' \
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