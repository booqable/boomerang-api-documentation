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
      "id": "ead1cbd5-c75b-4743-94aa-c1d34930ddf8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T12:19:08+00:00",
        "updated_at": "2023-03-02T12:19:08+00:00",
        "number": "http://bqbl.it/ead1cbd5-c75b-4743-94aa-c1d34930ddf8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/795c1a4407177ce7e705222d52965ec1/barcode/image/ead1cbd5-c75b-4743-94aa-c1d34930ddf8/628cf2fb-3059-435a-b7ae-9b0579c44054.svg",
        "owner_id": "0258b4b9-68a7-42af-9946-b0891160e29b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0258b4b9-68a7-42af-9946-b0891160e29b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F59693a8e-8aa1-4790-87b2-e3a329fa9ec0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "59693a8e-8aa1-4790-87b2-e3a329fa9ec0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T12:19:09+00:00",
        "updated_at": "2023-03-02T12:19:09+00:00",
        "number": "http://bqbl.it/59693a8e-8aa1-4790-87b2-e3a329fa9ec0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/85b4aa732e316ea87ea6e350670b6329/barcode/image/59693a8e-8aa1-4790-87b2-e3a329fa9ec0/c9f229eb-5fd8-4828-b4b0-7752818601dc.svg",
        "owner_id": "7de5e2ec-98c3-4f8e-9d33-3e20160bbb98",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7de5e2ec-98c3-4f8e-9d33-3e20160bbb98"
          },
          "data": {
            "type": "customers",
            "id": "7de5e2ec-98c3-4f8e-9d33-3e20160bbb98"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7de5e2ec-98c3-4f8e-9d33-3e20160bbb98",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T12:19:08+00:00",
        "updated_at": "2023-03-02T12:19:09+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7de5e2ec-98c3-4f8e-9d33-3e20160bbb98&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7de5e2ec-98c3-4f8e-9d33-3e20160bbb98&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7de5e2ec-98c3-4f8e-9d33-3e20160bbb98&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODZjM2M1NTItMzcwOC00MGZhLWI4MWUtODM5YWE3MzA3ODll&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "86c3c552-3708-40fa-b81e-839aa730789e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-02T12:19:09+00:00",
        "updated_at": "2023-03-02T12:19:09+00:00",
        "number": "http://bqbl.it/86c3c552-3708-40fa-b81e-839aa730789e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/27b71f3499ef0d882ed8e94557da6f77/barcode/image/86c3c552-3708-40fa-b81e-839aa730789e/ac4294c1-4de3-4c39-b82a-69b0c5f3edb1.svg",
        "owner_id": "261c7df8-c8d0-445d-a6f8-eaf70926d98d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/261c7df8-c8d0-445d-a6f8-eaf70926d98d"
          },
          "data": {
            "type": "customers",
            "id": "261c7df8-c8d0-445d-a6f8-eaf70926d98d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "261c7df8-c8d0-445d-a6f8-eaf70926d98d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T12:19:09+00:00",
        "updated_at": "2023-03-02T12:19:09+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=261c7df8-c8d0-445d-a6f8-eaf70926d98d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=261c7df8-c8d0-445d-a6f8-eaf70926d98d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=261c7df8-c8d0-445d-a6f8-eaf70926d98d&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T12:18:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1a058aa2-dda5-4348-b953-f992ca2e641e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1a058aa2-dda5-4348-b953-f992ca2e641e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T12:19:10+00:00",
      "updated_at": "2023-03-02T12:19:10+00:00",
      "number": "http://bqbl.it/1a058aa2-dda5-4348-b953-f992ca2e641e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0974942811e336cfa5e42fd468ad9b8e/barcode/image/1a058aa2-dda5-4348-b953-f992ca2e641e/639431b9-e27f-4f4a-a7ce-6a38f26e319a.svg",
      "owner_id": "fea3e8ba-b13c-47df-a982-8037040ada2a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fea3e8ba-b13c-47df-a982-8037040ada2a"
        },
        "data": {
          "type": "customers",
          "id": "fea3e8ba-b13c-47df-a982-8037040ada2a"
        }
      }
    }
  },
  "included": [
    {
      "id": "fea3e8ba-b13c-47df-a982-8037040ada2a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-02T12:19:10+00:00",
        "updated_at": "2023-03-02T12:19:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fea3e8ba-b13c-47df-a982-8037040ada2a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fea3e8ba-b13c-47df-a982-8037040ada2a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fea3e8ba-b13c-47df-a982-8037040ada2a&filter[owner_type]=customers"
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
          "owner_id": "01c564bd-ab4c-4032-b0bd-478cec3a4136",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "34cfe925-b533-448d-b0ca-0b7c1e9d922b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T12:19:11+00:00",
      "updated_at": "2023-03-02T12:19:11+00:00",
      "number": "http://bqbl.it/34cfe925-b533-448d-b0ca-0b7c1e9d922b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6d19116d33e02afea860ed3249e6f817/barcode/image/34cfe925-b533-448d-b0ca-0b7c1e9d922b/238300b3-58bf-481a-aed8-ba77b31cd5d0.svg",
      "owner_id": "01c564bd-ab4c-4032-b0bd-478cec3a4136",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/763d73e2-34df-47a2-a4dc-b3e44eea4ae4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "763d73e2-34df-47a2-a4dc-b3e44eea4ae4",
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
    "id": "763d73e2-34df-47a2-a4dc-b3e44eea4ae4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-02T12:19:12+00:00",
      "updated_at": "2023-03-02T12:19:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6b9b7136adbbecc67ab3df28c332f77b/barcode/image/763d73e2-34df-47a2-a4dc-b3e44eea4ae4/7534d93c-d642-4143-adfe-c451dceb33d4.svg",
      "owner_id": "7b06dd58-e60d-4930-b9ff-507e93b1f940",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9cff710a-de6c-43ae-83e3-b04acfe9248d' \
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