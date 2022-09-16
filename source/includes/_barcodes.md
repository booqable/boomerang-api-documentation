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
      "id": "338eb907-a3e2-464e-8d71-1cc0576341b2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T11:48:16+00:00",
        "updated_at": "2022-09-16T11:48:16+00:00",
        "number": "http://bqbl.it/338eb907-a3e2-464e-8d71-1cc0576341b2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1c1e66359de3f72704ab9705387a29fa/barcode/image/338eb907-a3e2-464e-8d71-1cc0576341b2/47d2dc42-983a-48dd-b0b2-38cb4e5e45a7.svg",
        "owner_id": "61587430-e1bd-441c-9487-c92ed4bfd8c9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/61587430-e1bd-441c-9487-c92ed4bfd8c9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F82b6d685-51c0-4818-adb9-d9cceb5053bb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "82b6d685-51c0-4818-adb9-d9cceb5053bb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T11:48:17+00:00",
        "updated_at": "2022-09-16T11:48:17+00:00",
        "number": "http://bqbl.it/82b6d685-51c0-4818-adb9-d9cceb5053bb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0b9d0df54a99193018f0aa382e521e75/barcode/image/82b6d685-51c0-4818-adb9-d9cceb5053bb/4c0bb2bc-9b73-489e-b12b-ff7478646a2d.svg",
        "owner_id": "4d113a09-ef97-4622-a38c-dc67a9bc2e92",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4d113a09-ef97-4622-a38c-dc67a9bc2e92"
          },
          "data": {
            "type": "customers",
            "id": "4d113a09-ef97-4622-a38c-dc67a9bc2e92"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4d113a09-ef97-4622-a38c-dc67a9bc2e92",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T11:48:16+00:00",
        "updated_at": "2022-09-16T11:48:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4d113a09-ef97-4622-a38c-dc67a9bc2e92&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4d113a09-ef97-4622-a38c-dc67a9bc2e92&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4d113a09-ef97-4622-a38c-dc67a9bc2e92&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjZjMDcxZDEtODg1OS00ZjM5LWIxNjEtNDA2NGNkYWYxMjUy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "26c071d1-8859-4f39-b161-4064cdaf1252",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T11:48:17+00:00",
        "updated_at": "2022-09-16T11:48:17+00:00",
        "number": "http://bqbl.it/26c071d1-8859-4f39-b161-4064cdaf1252",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7ed054a349ed6ef47131624d50090f54/barcode/image/26c071d1-8859-4f39-b161-4064cdaf1252/5f0aee3d-32e7-4221-a9cb-212d017cc427.svg",
        "owner_id": "87feead2-52fa-44cb-a746-4086a4f99e12",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87feead2-52fa-44cb-a746-4086a4f99e12"
          },
          "data": {
            "type": "customers",
            "id": "87feead2-52fa-44cb-a746-4086a4f99e12"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "87feead2-52fa-44cb-a746-4086a4f99e12",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T11:48:17+00:00",
        "updated_at": "2022-09-16T11:48:17+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=87feead2-52fa-44cb-a746-4086a4f99e12&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87feead2-52fa-44cb-a746-4086a4f99e12&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87feead2-52fa-44cb-a746-4086a4f99e12&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T11:48:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/46c305ab-8f51-4807-a8e8-0740e3273cdf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "46c305ab-8f51-4807-a8e8-0740e3273cdf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T11:48:18+00:00",
      "updated_at": "2022-09-16T11:48:18+00:00",
      "number": "http://bqbl.it/46c305ab-8f51-4807-a8e8-0740e3273cdf",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c66fcd06bd492584d46c195c218234df/barcode/image/46c305ab-8f51-4807-a8e8-0740e3273cdf/8f2dabd9-fecb-4854-885f-3b1400659baf.svg",
      "owner_id": "9fa5e759-5532-422f-ace5-e6b2eb617c73",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9fa5e759-5532-422f-ace5-e6b2eb617c73"
        },
        "data": {
          "type": "customers",
          "id": "9fa5e759-5532-422f-ace5-e6b2eb617c73"
        }
      }
    }
  },
  "included": [
    {
      "id": "9fa5e759-5532-422f-ace5-e6b2eb617c73",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T11:48:17+00:00",
        "updated_at": "2022-09-16T11:48:18+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9fa5e759-5532-422f-ace5-e6b2eb617c73&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9fa5e759-5532-422f-ace5-e6b2eb617c73&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9fa5e759-5532-422f-ace5-e6b2eb617c73&filter[owner_type]=customers"
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
          "owner_id": "21041644-ecd2-4442-adfd-370716446344",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3b6d05de-6614-460e-aa24-abc8544acb6d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T11:48:18+00:00",
      "updated_at": "2022-09-16T11:48:18+00:00",
      "number": "http://bqbl.it/3b6d05de-6614-460e-aa24-abc8544acb6d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f9725b3c25a0d56d8c579ff527a202b4/barcode/image/3b6d05de-6614-460e-aa24-abc8544acb6d/74165938-2bc2-4eaa-8e6a-9fb6e1676207.svg",
      "owner_id": "21041644-ecd2-4442-adfd-370716446344",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1b7a6c2f-77ce-4205-ad3d-2761f20666d3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1b7a6c2f-77ce-4205-ad3d-2761f20666d3",
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
    "id": "1b7a6c2f-77ce-4205-ad3d-2761f20666d3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T11:48:19+00:00",
      "updated_at": "2022-09-16T11:48:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5bfec4b7cd7b6d02fe60f05f19a57f8c/barcode/image/1b7a6c2f-77ce-4205-ad3d-2761f20666d3/6780fbfd-1b0e-4dc5-8251-201a69fd4ea9.svg",
      "owner_id": "828cb7d5-f662-478a-9e7b-372354c51683",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a4bc52c9-4f6d-4150-baf8-855fc72a975d' \
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