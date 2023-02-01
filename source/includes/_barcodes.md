# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

Note that when using URLs as numbers, it's advised to base64 encode the number before filtering.

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
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "ffdd99af-1d9d-4d22-abcd-001988088608",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T13:31:34+00:00",
        "updated_at": "2023-02-01T13:31:34+00:00",
        "number": "http://bqbl.it/ffdd99af-1d9d-4d22-abcd-001988088608",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f266ddd06a1c8ffeb19598bdfa265122/barcode/image/ffdd99af-1d9d-4d22-abcd-001988088608/70711190-8171-40ed-8313-2d08378b2a59.svg",
        "owner_id": "7aafaaec-f014-4561-9372-84f5e2b0d17d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7aafaaec-f014-4561-9372-84f5e2b0d17d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F518cc4f0-08b0-490f-9c61-360eab1ce9a1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "518cc4f0-08b0-490f-9c61-360eab1ce9a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T13:31:34+00:00",
        "updated_at": "2023-02-01T13:31:34+00:00",
        "number": "http://bqbl.it/518cc4f0-08b0-490f-9c61-360eab1ce9a1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/330d85cc0caaf5861099778b6e1f384c/barcode/image/518cc4f0-08b0-490f-9c61-360eab1ce9a1/004e3ac0-066c-468c-b0d6-e92af17a86c0.svg",
        "owner_id": "65945ddc-6539-49e8-9679-47669407c7ca",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/65945ddc-6539-49e8-9679-47669407c7ca"
          },
          "data": {
            "type": "customers",
            "id": "65945ddc-6539-49e8-9679-47669407c7ca"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "65945ddc-6539-49e8-9679-47669407c7ca",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T13:31:34+00:00",
        "updated_at": "2023-02-01T13:31:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=65945ddc-6539-49e8-9679-47669407c7ca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=65945ddc-6539-49e8-9679-47669407c7ca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=65945ddc-6539-49e8-9679-47669407c7ca&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjgyMWQ0ZjgtMDdmYy00MDFiLTgzYTktNzlhZWRiMGI3ZWMy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b821d4f8-07fc-401b-83a9-79aedb0b7ec2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T13:31:34+00:00",
        "updated_at": "2023-02-01T13:31:34+00:00",
        "number": "http://bqbl.it/b821d4f8-07fc-401b-83a9-79aedb0b7ec2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/92b45282343224480916eea2081d2522/barcode/image/b821d4f8-07fc-401b-83a9-79aedb0b7ec2/883652c8-ebba-47f2-8724-1c836b42aa2c.svg",
        "owner_id": "dba13057-51a6-493c-95fc-215f927695d6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dba13057-51a6-493c-95fc-215f927695d6"
          },
          "data": {
            "type": "customers",
            "id": "dba13057-51a6-493c-95fc-215f927695d6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dba13057-51a6-493c-95fc-215f927695d6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T13:31:34+00:00",
        "updated_at": "2023-02-01T13:31:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=dba13057-51a6-493c-95fc-215f927695d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dba13057-51a6-493c-95fc-215f927695d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dba13057-51a6-493c-95fc-215f927695d6&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T13:31:17Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/3b74a295-d6a1-4040-840c-c8bea79204b1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3b74a295-d6a1-4040-840c-c8bea79204b1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T13:31:35+00:00",
      "updated_at": "2023-02-01T13:31:35+00:00",
      "number": "http://bqbl.it/3b74a295-d6a1-4040-840c-c8bea79204b1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/920aea6750f69cdb4e8339691ddc74e0/barcode/image/3b74a295-d6a1-4040-840c-c8bea79204b1/df538221-387a-422e-a679-806f8417362f.svg",
      "owner_id": "e057f15f-7f82-4359-b783-4ccc7df4fa5d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e057f15f-7f82-4359-b783-4ccc7df4fa5d"
        },
        "data": {
          "type": "customers",
          "id": "e057f15f-7f82-4359-b783-4ccc7df4fa5d"
        }
      }
    }
  },
  "included": [
    {
      "id": "e057f15f-7f82-4359-b783-4ccc7df4fa5d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T13:31:35+00:00",
        "updated_at": "2023-02-01T13:31:35+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-5@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=e057f15f-7f82-4359-b783-4ccc7df4fa5d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e057f15f-7f82-4359-b783-4ccc7df4fa5d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e057f15f-7f82-4359-b783-4ccc7df4fa5d&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "23b5485f-3e58-49c9-ac85-e9e0e9b5cbaf",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7baf1ab2-6232-4464-b8d2-c50831eab079",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T13:31:35+00:00",
      "updated_at": "2023-02-01T13:31:35+00:00",
      "number": "http://bqbl.it/7baf1ab2-6232-4464-b8d2-c50831eab079",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8afcccd5981de0971f58fb278d05df88/barcode/image/7baf1ab2-6232-4464-b8d2-c50831eab079/c362cc95-a2c8-4e26-90b1-e2df3b81afa1.svg",
      "owner_id": "23b5485f-3e58-49c9-ac85-e9e0e9b5cbaf",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/5f9a9866-a92d-4b83-8925-075a087457f4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5f9a9866-a92d-4b83-8925-075a087457f4",
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
    "id": "5f9a9866-a92d-4b83-8925-075a087457f4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T13:31:36+00:00",
      "updated_at": "2023-02-01T13:31:36+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/17dc60be5b7da25cd03e2d3d8fb1d3ad/barcode/image/5f9a9866-a92d-4b83-8925-075a087457f4/a44c9467-03de-47d8-8f44-afd271809012.svg",
      "owner_id": "c9e6a705-447e-45df-9d6e-f961df40252d",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/d73a05b0-63f5-4e9e-befa-76f6509a5868' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes