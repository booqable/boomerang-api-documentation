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
      "id": "efaad33c-bf29-4a26-962e-c6d8a1d28e33",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:03:51+00:00",
        "updated_at": "2023-02-14T11:03:51+00:00",
        "number": "http://bqbl.it/efaad33c-bf29-4a26-962e-c6d8a1d28e33",
        "barcode_type": "qr_code",
        "image_url": "/uploads/60047bd27ca5eba2164269faf9245ee3/barcode/image/efaad33c-bf29-4a26-962e-c6d8a1d28e33/ae14f0db-be60-4d87-987b-e9adef3a3215.svg",
        "owner_id": "a2af0bda-e55f-4bf1-9b4b-c1407b6635cd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a2af0bda-e55f-4bf1-9b4b-c1407b6635cd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F708a77e9-d93b-4f73-8066-507bb9f9186e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "708a77e9-d93b-4f73-8066-507bb9f9186e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:03:52+00:00",
        "updated_at": "2023-02-14T11:03:52+00:00",
        "number": "http://bqbl.it/708a77e9-d93b-4f73-8066-507bb9f9186e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/395384184e0c8221a8f6421deee1a9df/barcode/image/708a77e9-d93b-4f73-8066-507bb9f9186e/72c8ecd0-0b1c-4a7c-bbe3-02661415c2e1.svg",
        "owner_id": "8076f2b3-390f-45bc-b5a4-8f16a0f92ccb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8076f2b3-390f-45bc-b5a4-8f16a0f92ccb"
          },
          "data": {
            "type": "customers",
            "id": "8076f2b3-390f-45bc-b5a4-8f16a0f92ccb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8076f2b3-390f-45bc-b5a4-8f16a0f92ccb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:03:52+00:00",
        "updated_at": "2023-02-14T11:03:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8076f2b3-390f-45bc-b5a4-8f16a0f92ccb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8076f2b3-390f-45bc-b5a4-8f16a0f92ccb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8076f2b3-390f-45bc-b5a4-8f16a0f92ccb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTJmYTE0ZjEtZTNmMS00ZDllLTljOTEtZGQ1NWE3OWY0NmU3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a2fa14f1-e3f1-4d9e-9c91-dd55a79f46e7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:03:52+00:00",
        "updated_at": "2023-02-14T11:03:52+00:00",
        "number": "http://bqbl.it/a2fa14f1-e3f1-4d9e-9c91-dd55a79f46e7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/102ef40462fbb0ce9c61170fef5032fb/barcode/image/a2fa14f1-e3f1-4d9e-9c91-dd55a79f46e7/d575f398-64a1-4d3a-96f9-7d329e4a7ddf.svg",
        "owner_id": "96653206-093c-42f7-910c-20cd17ee1ab7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96653206-093c-42f7-910c-20cd17ee1ab7"
          },
          "data": {
            "type": "customers",
            "id": "96653206-093c-42f7-910c-20cd17ee1ab7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "96653206-093c-42f7-910c-20cd17ee1ab7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:03:52+00:00",
        "updated_at": "2023-02-14T11:03:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=96653206-093c-42f7-910c-20cd17ee1ab7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=96653206-093c-42f7-910c-20cd17ee1ab7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=96653206-093c-42f7-910c-20cd17ee1ab7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:03:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/42dbecda-2747-4b74-8d01-7e432b65c360?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "42dbecda-2747-4b74-8d01-7e432b65c360",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:03:53+00:00",
      "updated_at": "2023-02-14T11:03:53+00:00",
      "number": "http://bqbl.it/42dbecda-2747-4b74-8d01-7e432b65c360",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4bad2a2a3d27702913df27c8b253a1a4/barcode/image/42dbecda-2747-4b74-8d01-7e432b65c360/e05c4b1c-2af7-4e70-8583-62a7bcbe94aa.svg",
      "owner_id": "3c8a207c-a9b3-4f71-a796-e1fa583bc7b6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3c8a207c-a9b3-4f71-a796-e1fa583bc7b6"
        },
        "data": {
          "type": "customers",
          "id": "3c8a207c-a9b3-4f71-a796-e1fa583bc7b6"
        }
      }
    }
  },
  "included": [
    {
      "id": "3c8a207c-a9b3-4f71-a796-e1fa583bc7b6",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:03:53+00:00",
        "updated_at": "2023-02-14T11:03:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3c8a207c-a9b3-4f71-a796-e1fa583bc7b6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3c8a207c-a9b3-4f71-a796-e1fa583bc7b6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3c8a207c-a9b3-4f71-a796-e1fa583bc7b6&filter[owner_type]=customers"
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
          "owner_id": "c42fac00-3f57-499c-af96-78ac008838ad",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "82600e08-95c4-432b-b328-4622d9748b95",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:03:53+00:00",
      "updated_at": "2023-02-14T11:03:53+00:00",
      "number": "http://bqbl.it/82600e08-95c4-432b-b328-4622d9748b95",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ca8b5f1b9050a147a0c421e71072ba9d/barcode/image/82600e08-95c4-432b-b328-4622d9748b95/4021dda3-7766-4d0b-9ae7-cfbb9023aa57.svg",
      "owner_id": "c42fac00-3f57-499c-af96-78ac008838ad",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bdeef62a-f8d0-4a68-a7eb-d5f49537ef99' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bdeef62a-f8d0-4a68-a7eb-d5f49537ef99",
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
    "id": "bdeef62a-f8d0-4a68-a7eb-d5f49537ef99",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:03:56+00:00",
      "updated_at": "2023-02-14T11:03:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/12b75e85ee06dc78400e16dc61a3800e/barcode/image/bdeef62a-f8d0-4a68-a7eb-d5f49537ef99/1accc9d7-8f96-4f67-bc49-3e6c54f8982c.svg",
      "owner_id": "d0759f39-cee1-4f19-99e9-c5305b10d4a9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0289b9ac-011a-4063-bf0c-80d058972b8d' \
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