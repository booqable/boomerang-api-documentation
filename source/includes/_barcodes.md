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
      "id": "1669edad-73f4-4ef6-953e-46258eee394e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T16:47:21+00:00",
        "updated_at": "2021-12-02T16:47:21+00:00",
        "number": "http://bqbl.it/1669edad-73f4-4ef6-953e-46258eee394e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e9a34b2e0d01fcb469a449d855d74b43/barcode/image/1669edad-73f4-4ef6-953e-46258eee394e/4a96977d-b80a-4bab-82eb-01aa45738cf3.svg",
        "owner_id": "44b047b9-1ba0-41ba-8d0c-5c7cfbe5b604",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/44b047b9-1ba0-41ba-8d0c-5c7cfbe5b604"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd33ead06-90e7-4614-8028-20de3ae22f54&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d33ead06-90e7-4614-8028-20de3ae22f54",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T16:47:22+00:00",
        "updated_at": "2021-12-02T16:47:22+00:00",
        "number": "http://bqbl.it/d33ead06-90e7-4614-8028-20de3ae22f54",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ab1bdab87eb8e27e7bb0e727ad9a0f07/barcode/image/d33ead06-90e7-4614-8028-20de3ae22f54/9e576ba5-e30d-4881-80a6-01905f0f0c14.svg",
        "owner_id": "72ed420d-e905-4dc9-995e-0f5c4458ac27",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/72ed420d-e905-4dc9-995e-0f5c4458ac27"
          },
          "data": {
            "type": "customers",
            "id": "72ed420d-e905-4dc9-995e-0f5c4458ac27"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "72ed420d-e905-4dc9-995e-0f5c4458ac27",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T16:47:22+00:00",
        "updated_at": "2021-12-02T16:47:22+00:00",
        "number": 1,
        "name": "Beatty, Larson and Stracke",
        "email": "larson.beatty.stracke.and@kohler-reilly.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=72ed420d-e905-4dc9-995e-0f5c4458ac27&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=72ed420d-e905-4dc9-995e-0f5c4458ac27&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=72ed420d-e905-4dc9-995e-0f5c4458ac27&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd33ead06-90e7-4614-8028-20de3ae22f54&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd33ead06-90e7-4614-8028-20de3ae22f54&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd33ead06-90e7-4614-8028-20de3ae22f54&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T16:47:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/23c71918-1358-4ca2-bbf0-c4292f5b457c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "23c71918-1358-4ca2-bbf0-c4292f5b457c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T16:47:22+00:00",
      "updated_at": "2021-12-02T16:47:22+00:00",
      "number": "http://bqbl.it/23c71918-1358-4ca2-bbf0-c4292f5b457c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a5c02206d65146d7340a90f35ec6eb38/barcode/image/23c71918-1358-4ca2-bbf0-c4292f5b457c/802b087f-d5e7-4dae-881d-ef7b9ec03200.svg",
      "owner_id": "0e85705a-fe5b-482a-bcba-ab92bd88e317",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0e85705a-fe5b-482a-bcba-ab92bd88e317"
        },
        "data": {
          "type": "customers",
          "id": "0e85705a-fe5b-482a-bcba-ab92bd88e317"
        }
      }
    }
  },
  "included": [
    {
      "id": "0e85705a-fe5b-482a-bcba-ab92bd88e317",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T16:47:22+00:00",
        "updated_at": "2021-12-02T16:47:22+00:00",
        "number": 1,
        "name": "Will, Sporer and Runolfsdottir",
        "email": "and_sporer_runolfsdottir_will@blanda.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=0e85705a-fe5b-482a-bcba-ab92bd88e317&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0e85705a-fe5b-482a-bcba-ab92bd88e317&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0e85705a-fe5b-482a-bcba-ab92bd88e317&filter[owner_type]=customers"
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
          "owner_id": "ae4fa745-7bf5-4035-9058-f18fcdeb8f99",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e71100e1-3cba-45eb-b7d4-df177c79f92f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T16:47:23+00:00",
      "updated_at": "2021-12-02T16:47:23+00:00",
      "number": "http://bqbl.it/e71100e1-3cba-45eb-b7d4-df177c79f92f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d18d446350910d63d8348bc14866b855/barcode/image/e71100e1-3cba-45eb-b7d4-df177c79f92f/bbd930bb-34eb-4b0d-8971-97a8604a0cf3.svg",
      "owner_id": "ae4fa745-7bf5-4035-9058-f18fcdeb8f99",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ae4fa745-7bf5-4035-9058-f18fcdeb8f99&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ae4fa745-7bf5-4035-9058-f18fcdeb8f99&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=ae4fa745-7bf5-4035-9058-f18fcdeb8f99&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2e5b2ade-da81-46b3-9b12-9fb822b717d8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2e5b2ade-da81-46b3-9b12-9fb822b717d8",
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
    "id": "2e5b2ade-da81-46b3-9b12-9fb822b717d8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T16:47:24+00:00",
      "updated_at": "2021-12-02T16:47:25+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a0282ea7a4f89cf26d6662fcbe54206b/barcode/image/2e5b2ade-da81-46b3-9b12-9fb822b717d8/4837a4bf-8642-4b82-8939-69414eb83fb3.svg",
      "owner_id": "1ef05f47-c506-47f5-98c6-1069c9579708",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/04f0e16c-533a-4682-bf54-5d5bfeafa0f6' \
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