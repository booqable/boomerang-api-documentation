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
      "id": "06a093f1-f96b-4c68-86e2-748b0caf0f43",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-18T15:31:29+00:00",
        "updated_at": "2021-11-18T15:31:29+00:00",
        "number": "http://bqbl.it/06a093f1-f96b-4c68-86e2-748b0caf0f43",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b2133df47b320a7ca904393bb6456886/barcode/image/06a093f1-f96b-4c68-86e2-748b0caf0f43/ec37d8c0-ef53-46a6-9abb-b891e4d65b62.svg",
        "owner_id": "bfa1159a-1b4b-492b-93a1-b186becf9847",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bfa1159a-1b4b-492b-93a1-b186becf9847"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9bd08a1-056a-49a7-a041-2ef826c9423d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b9bd08a1-056a-49a7-a041-2ef826c9423d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-18T15:31:30+00:00",
        "updated_at": "2021-11-18T15:31:30+00:00",
        "number": "http://bqbl.it/b9bd08a1-056a-49a7-a041-2ef826c9423d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ac5889fb88569d18d0dbcbce31635bd4/barcode/image/b9bd08a1-056a-49a7-a041-2ef826c9423d/b26f9c6d-1ff3-4766-866b-17d416795b76.svg",
        "owner_id": "0370cb06-d33c-4970-a0f8-8eed9ba55bb8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0370cb06-d33c-4970-a0f8-8eed9ba55bb8"
          },
          "data": {
            "type": "customers",
            "id": "0370cb06-d33c-4970-a0f8-8eed9ba55bb8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0370cb06-d33c-4970-a0f8-8eed9ba55bb8",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-18T15:31:29+00:00",
        "updated_at": "2021-11-18T15:31:30+00:00",
        "number": 1,
        "name": "Larkin, Schultz and Terry",
        "email": "schultz_terry_larkin_and@zulauf.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=0370cb06-d33c-4970-a0f8-8eed9ba55bb8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0370cb06-d33c-4970-a0f8-8eed9ba55bb8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0370cb06-d33c-4970-a0f8-8eed9ba55bb8&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9bd08a1-056a-49a7-a041-2ef826c9423d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9bd08a1-056a-49a7-a041-2ef826c9423d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb9bd08a1-056a-49a7-a041-2ef826c9423d&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-18T15:31:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2dce0b52-c042-4465-a2c6-12bc0b8322d2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2dce0b52-c042-4465-a2c6-12bc0b8322d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T15:31:30+00:00",
      "updated_at": "2021-11-18T15:31:30+00:00",
      "number": "http://bqbl.it/2dce0b52-c042-4465-a2c6-12bc0b8322d2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1a664a074b813b5e3b5e9ae121708d50/barcode/image/2dce0b52-c042-4465-a2c6-12bc0b8322d2/03e8c922-8e21-4460-b0bb-bf2c731b8f38.svg",
      "owner_id": "020459e4-0887-4a94-9080-c597b3d782ca",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/020459e4-0887-4a94-9080-c597b3d782ca"
        },
        "data": {
          "type": "customers",
          "id": "020459e4-0887-4a94-9080-c597b3d782ca"
        }
      }
    }
  },
  "included": [
    {
      "id": "020459e4-0887-4a94-9080-c597b3d782ca",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-18T15:31:30+00:00",
        "updated_at": "2021-11-18T15:31:30+00:00",
        "number": 1,
        "name": "Blick Inc",
        "email": "inc.blick@kerluke-harvey.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=020459e4-0887-4a94-9080-c597b3d782ca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=020459e4-0887-4a94-9080-c597b3d782ca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=020459e4-0887-4a94-9080-c597b3d782ca&filter[owner_type]=customers"
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
          "owner_id": "c2dcdf10-5524-4f41-b8a8-1b847c68a2b4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4d872218-903b-44e4-b9c7-506a39dda861",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T15:31:31+00:00",
      "updated_at": "2021-11-18T15:31:31+00:00",
      "number": "http://bqbl.it/4d872218-903b-44e4-b9c7-506a39dda861",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eb054363945f8983c387bfda55f1fd99/barcode/image/4d872218-903b-44e4-b9c7-506a39dda861/1b5d37e2-a237-459f-98ae-5ad42fecf278.svg",
      "owner_id": "c2dcdf10-5524-4f41-b8a8-1b847c68a2b4",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=c2dcdf10-5524-4f41-b8a8-1b847c68a2b4&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=c2dcdf10-5524-4f41-b8a8-1b847c68a2b4&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=c2dcdf10-5524-4f41-b8a8-1b847c68a2b4&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bdd11cdd-a239-42bc-808e-8380928af28b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bdd11cdd-a239-42bc-808e-8380928af28b",
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
    "id": "bdd11cdd-a239-42bc-808e-8380928af28b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T15:31:31+00:00",
      "updated_at": "2021-11-18T15:31:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b844f03c21279449b60bd98d1c21d33e/barcode/image/bdd11cdd-a239-42bc-808e-8380928af28b/549df641-ba9b-4a0e-8f9c-e39393db61ad.svg",
      "owner_id": "6ea77e21-6218-41ef-8731-7469e4d09b97",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/75a89966-4310-4d86-ad44-00208b1ccbd3' \
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