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
      "id": "8e128433-69ac-4c5d-b7f7-1677f37e8829",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-12T14:02:19+00:00",
        "updated_at": "2022-01-12T14:02:19+00:00",
        "number": "http://bqbl.it/8e128433-69ac-4c5d-b7f7-1677f37e8829",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cfc41eb72027c599f6296ffc8b017124/barcode/image/8e128433-69ac-4c5d-b7f7-1677f37e8829/a4efbcc2-0d25-4080-a51a-68b950994533.svg",
        "owner_id": "c8bed72a-a159-4682-b58a-9b34c3ef7ad9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c8bed72a-a159-4682-b58a-9b34c3ef7ad9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0047163a-427b-449a-91ef-29029b4fa5cf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0047163a-427b-449a-91ef-29029b4fa5cf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-12T14:02:20+00:00",
        "updated_at": "2022-01-12T14:02:20+00:00",
        "number": "http://bqbl.it/0047163a-427b-449a-91ef-29029b4fa5cf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e225a745f1ac51bf4d6c8973e855a23b/barcode/image/0047163a-427b-449a-91ef-29029b4fa5cf/49ce9f59-7f91-4b97-b5ee-c01afd49f444.svg",
        "owner_id": "d3e397cb-708a-4a79-9168-ba2e61ad85ea",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d3e397cb-708a-4a79-9168-ba2e61ad85ea"
          },
          "data": {
            "type": "customers",
            "id": "d3e397cb-708a-4a79-9168-ba2e61ad85ea"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d3e397cb-708a-4a79-9168-ba2e61ad85ea",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T14:02:20+00:00",
        "updated_at": "2022-01-12T14:02:20+00:00",
        "number": 1,
        "name": "Kerluke Inc",
        "email": "inc_kerluke@hirthe.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=d3e397cb-708a-4a79-9168-ba2e61ad85ea&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d3e397cb-708a-4a79-9168-ba2e61ad85ea&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d3e397cb-708a-4a79-9168-ba2e61ad85ea&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0047163a-427b-449a-91ef-29029b4fa5cf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0047163a-427b-449a-91ef-29029b4fa5cf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0047163a-427b-449a-91ef-29029b4fa5cf&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T14:02:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/13b7470f-27bd-409c-9861-18e9396a4e2e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13b7470f-27bd-409c-9861-18e9396a4e2e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T14:02:20+00:00",
      "updated_at": "2022-01-12T14:02:20+00:00",
      "number": "http://bqbl.it/13b7470f-27bd-409c-9861-18e9396a4e2e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/17802b33c09db47f9a67b15eacd845f7/barcode/image/13b7470f-27bd-409c-9861-18e9396a4e2e/881fcdff-29e6-4701-9fae-071668d075b0.svg",
      "owner_id": "ba952fbc-a219-46e6-bda5-02283c256d30",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ba952fbc-a219-46e6-bda5-02283c256d30"
        },
        "data": {
          "type": "customers",
          "id": "ba952fbc-a219-46e6-bda5-02283c256d30"
        }
      }
    }
  },
  "included": [
    {
      "id": "ba952fbc-a219-46e6-bda5-02283c256d30",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T14:02:20+00:00",
        "updated_at": "2022-01-12T14:02:20+00:00",
        "number": 1,
        "name": "Huel, Buckridge and Keeling",
        "email": "and_buckridge_keeling_huel@yundt.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=ba952fbc-a219-46e6-bda5-02283c256d30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ba952fbc-a219-46e6-bda5-02283c256d30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ba952fbc-a219-46e6-bda5-02283c256d30&filter[owner_type]=customers"
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
          "owner_id": "557a2a10-7a3e-43d6-bb53-42a541bde780",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fcdb85cd-0d9b-43f5-8f7a-5b1d75a32120",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T14:02:21+00:00",
      "updated_at": "2022-01-12T14:02:21+00:00",
      "number": "http://bqbl.it/fcdb85cd-0d9b-43f5-8f7a-5b1d75a32120",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4ef24fbd31167b15fed819c19c5141da/barcode/image/fcdb85cd-0d9b-43f5-8f7a-5b1d75a32120/c7f0ebbf-3c68-4576-b3dd-0c09886720f8.svg",
      "owner_id": "557a2a10-7a3e-43d6-bb53-42a541bde780",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=557a2a10-7a3e-43d6-bb53-42a541bde780&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=557a2a10-7a3e-43d6-bb53-42a541bde780&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=557a2a10-7a3e-43d6-bb53-42a541bde780&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd5775d6-f479-4580-924e-04c920df87f5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dd5775d6-f479-4580-924e-04c920df87f5",
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
    "id": "dd5775d6-f479-4580-924e-04c920df87f5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T14:02:21+00:00",
      "updated_at": "2022-01-12T14:02:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fbfc219475ccc71db73df46919b10534/barcode/image/dd5775d6-f479-4580-924e-04c920df87f5/b03b8558-ffb4-4460-8506-83404a54a21a.svg",
      "owner_id": "023cd6a9-a222-467a-aba3-efe63d50f758",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/43e8ad6e-f65f-4544-bd07-4b431cfc2339' \
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