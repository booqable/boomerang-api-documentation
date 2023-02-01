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
      "id": "5c7df6ae-8f24-4233-9d1a-d5d148bf82f5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T15:14:01+00:00",
        "updated_at": "2023-02-01T15:14:01+00:00",
        "number": "http://bqbl.it/5c7df6ae-8f24-4233-9d1a-d5d148bf82f5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ee3815e4b7b217e953bc706ecfceae68/barcode/image/5c7df6ae-8f24-4233-9d1a-d5d148bf82f5/70a67cea-5c2f-4a23-90bb-21458148a8c1.svg",
        "owner_id": "f7a25935-c2da-4af1-901f-b394bce3fdcd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f7a25935-c2da-4af1-901f-b394bce3fdcd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2343e1b6-d73a-4071-8363-c9353e269a54&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2343e1b6-d73a-4071-8363-c9353e269a54",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T15:14:01+00:00",
        "updated_at": "2023-02-01T15:14:01+00:00",
        "number": "http://bqbl.it/2343e1b6-d73a-4071-8363-c9353e269a54",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b193acce68294a838d79a4637d8af77b/barcode/image/2343e1b6-d73a-4071-8363-c9353e269a54/bdae497a-4738-4310-a04f-1e205121f0c8.svg",
        "owner_id": "71307fab-382f-4fe7-a3eb-80f3f00c7831",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/71307fab-382f-4fe7-a3eb-80f3f00c7831"
          },
          "data": {
            "type": "customers",
            "id": "71307fab-382f-4fe7-a3eb-80f3f00c7831"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "71307fab-382f-4fe7-a3eb-80f3f00c7831",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T15:14:01+00:00",
        "updated_at": "2023-02-01T15:14:01+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=71307fab-382f-4fe7-a3eb-80f3f00c7831&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=71307fab-382f-4fe7-a3eb-80f3f00c7831&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=71307fab-382f-4fe7-a3eb-80f3f00c7831&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTQ3OWNjOTAtMWQxNy00ZWY5LWJlMDUtMTVkZDIwMTBhZTZl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9479cc90-1d17-4ef9-be05-15dd2010ae6e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-01T15:14:02+00:00",
        "updated_at": "2023-02-01T15:14:02+00:00",
        "number": "http://bqbl.it/9479cc90-1d17-4ef9-be05-15dd2010ae6e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/af87c637ee64d5590ccd4e6afe7c4ecb/barcode/image/9479cc90-1d17-4ef9-be05-15dd2010ae6e/8ab1dec3-6a7c-46e6-a19a-3ef3a8921c7c.svg",
        "owner_id": "55015aec-c60b-4aa7-9dc0-e3dc710b1ba4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/55015aec-c60b-4aa7-9dc0-e3dc710b1ba4"
          },
          "data": {
            "type": "customers",
            "id": "55015aec-c60b-4aa7-9dc0-e3dc710b1ba4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "55015aec-c60b-4aa7-9dc0-e3dc710b1ba4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T15:14:02+00:00",
        "updated_at": "2023-02-01T15:14:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=55015aec-c60b-4aa7-9dc0-e3dc710b1ba4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=55015aec-c60b-4aa7-9dc0-e3dc710b1ba4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=55015aec-c60b-4aa7-9dc0-e3dc710b1ba4&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:13:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/17639806-4842-4e6a-9f86-63466c831797?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "17639806-4842-4e6a-9f86-63466c831797",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T15:14:02+00:00",
      "updated_at": "2023-02-01T15:14:02+00:00",
      "number": "http://bqbl.it/17639806-4842-4e6a-9f86-63466c831797",
      "barcode_type": "qr_code",
      "image_url": "/uploads/894b32b3186dc9def8c6e3a5b9b118b7/barcode/image/17639806-4842-4e6a-9f86-63466c831797/6c6ad6fb-ad09-435f-933f-2aa3cc802971.svg",
      "owner_id": "102fb2b7-b44e-4918-948d-b73da9530c43",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/102fb2b7-b44e-4918-948d-b73da9530c43"
        },
        "data": {
          "type": "customers",
          "id": "102fb2b7-b44e-4918-948d-b73da9530c43"
        }
      }
    }
  },
  "included": [
    {
      "id": "102fb2b7-b44e-4918-948d-b73da9530c43",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-01T15:14:02+00:00",
        "updated_at": "2023-02-01T15:14:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=102fb2b7-b44e-4918-948d-b73da9530c43&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=102fb2b7-b44e-4918-948d-b73da9530c43&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=102fb2b7-b44e-4918-948d-b73da9530c43&filter[owner_type]=customers"
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
          "owner_id": "8316b6d0-c345-4393-ae62-48625632497e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2c2f4b1b-4b6c-47c6-bd8e-9b83a4f40e22",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T15:14:03+00:00",
      "updated_at": "2023-02-01T15:14:03+00:00",
      "number": "http://bqbl.it/2c2f4b1b-4b6c-47c6-bd8e-9b83a4f40e22",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1950cc77911bbb4216422a3468ab9d76/barcode/image/2c2f4b1b-4b6c-47c6-bd8e-9b83a4f40e22/5304edf2-1ade-40ea-aa29-63132dc0cb30.svg",
      "owner_id": "8316b6d0-c345-4393-ae62-48625632497e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/839cf890-91d6-45d1-9f14-db50487d293b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "839cf890-91d6-45d1-9f14-db50487d293b",
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
    "id": "839cf890-91d6-45d1-9f14-db50487d293b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-01T15:14:03+00:00",
      "updated_at": "2023-02-01T15:14:03+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f2a8fad9ef7c157e8c016d7196a27711/barcode/image/839cf890-91d6-45d1-9f14-db50487d293b/dc6ae2df-39bb-4017-a486-f714361609d9.svg",
      "owner_id": "cd61303b-daba-4692-92f3-fc5daaba0e07",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6312f460-145d-41f4-9059-c5d9320ce968' \
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