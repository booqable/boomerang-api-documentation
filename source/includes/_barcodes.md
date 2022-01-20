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
      "id": "56384d73-1a7f-41b1-807a-8412ac3cf15b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-20T12:33:07+00:00",
        "updated_at": "2022-01-20T12:33:07+00:00",
        "number": "http://bqbl.it/56384d73-1a7f-41b1-807a-8412ac3cf15b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/52d087d3b10d847f9eb0b9b7c52563c9/barcode/image/56384d73-1a7f-41b1-807a-8412ac3cf15b/682526f2-a314-4864-952c-59a1becd9c03.svg",
        "owner_id": "0d8855c6-9d4a-4d9a-9ffc-9fac58aff967",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0d8855c6-9d4a-4d9a-9ffc-9fac58aff967"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbb135730-db69-4838-8990-b48d98cb4c57&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bb135730-db69-4838-8990-b48d98cb4c57",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-20T12:33:08+00:00",
        "updated_at": "2022-01-20T12:33:08+00:00",
        "number": "http://bqbl.it/bb135730-db69-4838-8990-b48d98cb4c57",
        "barcode_type": "qr_code",
        "image_url": "/uploads/86fcd9dbd706fa28d06527321a2b1a7c/barcode/image/bb135730-db69-4838-8990-b48d98cb4c57/892110f3-03e8-446d-be32-537409b722ca.svg",
        "owner_id": "8ced8990-eadc-47e3-9573-96c7e6257b0c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8ced8990-eadc-47e3-9573-96c7e6257b0c"
          },
          "data": {
            "type": "customers",
            "id": "8ced8990-eadc-47e3-9573-96c7e6257b0c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8ced8990-eadc-47e3-9573-96c7e6257b0c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-20T12:33:08+00:00",
        "updated_at": "2022-01-20T12:33:08+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kutch, Heaney and Kling",
        "email": "and.kutch.heaney.kling@fritsch.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=8ced8990-eadc-47e3-9573-96c7e6257b0c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8ced8990-eadc-47e3-9573-96c7e6257b0c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8ced8990-eadc-47e3-9573-96c7e6257b0c&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-20T12:32:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e53b907c-f2ce-4970-b8a0-970f79c2d6d8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e53b907c-f2ce-4970-b8a0-970f79c2d6d8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-20T12:33:09+00:00",
      "updated_at": "2022-01-20T12:33:09+00:00",
      "number": "http://bqbl.it/e53b907c-f2ce-4970-b8a0-970f79c2d6d8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/592764d12a77f4b15b4acdc4ef45e4df/barcode/image/e53b907c-f2ce-4970-b8a0-970f79c2d6d8/5b43fb09-e518-4d38-b0eb-91f013fe8510.svg",
      "owner_id": "3fae8863-acc7-41b9-9878-1435e8e8bc4c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3fae8863-acc7-41b9-9878-1435e8e8bc4c"
        },
        "data": {
          "type": "customers",
          "id": "3fae8863-acc7-41b9-9878-1435e8e8bc4c"
        }
      }
    }
  },
  "included": [
    {
      "id": "3fae8863-acc7-41b9-9878-1435e8e8bc4c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-20T12:33:08+00:00",
        "updated_at": "2022-01-20T12:33:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Stroman and Sons",
        "email": "and.sons.stroman@okon-welch.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=3fae8863-acc7-41b9-9878-1435e8e8bc4c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3fae8863-acc7-41b9-9878-1435e8e8bc4c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3fae8863-acc7-41b9-9878-1435e8e8bc4c&filter[owner_type]=customers"
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
          "owner_id": "f8a1a1eb-dd9c-4c36-a163-6a461f497481",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "abd51e8e-2a66-4e89-81ab-74228c51485f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-20T12:33:09+00:00",
      "updated_at": "2022-01-20T12:33:09+00:00",
      "number": "http://bqbl.it/abd51e8e-2a66-4e89-81ab-74228c51485f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/23ceea2e723357cc631135e0511f6e08/barcode/image/abd51e8e-2a66-4e89-81ab-74228c51485f/5f4349f5-0548-4189-b18c-bcccd39d0556.svg",
      "owner_id": "f8a1a1eb-dd9c-4c36-a163-6a461f497481",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/95424ce5-e188-429b-9594-dae7ae66ac72' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "95424ce5-e188-429b-9594-dae7ae66ac72",
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
    "id": "95424ce5-e188-429b-9594-dae7ae66ac72",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-20T12:33:10+00:00",
      "updated_at": "2022-01-20T12:33:10+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/65de44995d96d06491d915369719302a/barcode/image/95424ce5-e188-429b-9594-dae7ae66ac72/796ef24e-031e-4311-8b23-1755f8533ee0.svg",
      "owner_id": "8ac504d7-08ba-4029-9ca7-b9936bf432be",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/845f0321-9a81-4ca6-ba12-cc49f3dd4da5' \
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