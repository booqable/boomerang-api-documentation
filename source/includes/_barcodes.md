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
      "id": "e9a310dc-6f36-435e-a5a1-2e7a435ddd2d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T09:10:48+00:00",
        "updated_at": "2023-02-24T09:10:48+00:00",
        "number": "http://bqbl.it/e9a310dc-6f36-435e-a5a1-2e7a435ddd2d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d55bacdd1f899e1c8cb452170f23ff55/barcode/image/e9a310dc-6f36-435e-a5a1-2e7a435ddd2d/05181297-85d7-4dc7-a45f-5c4daf0ef9b0.svg",
        "owner_id": "18b86164-0fac-4c1a-bfc5-81b03c9a5d34",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/18b86164-0fac-4c1a-bfc5-81b03c9a5d34"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F755fd99e-c877-4546-b239-7cc76d58caed&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "755fd99e-c877-4546-b239-7cc76d58caed",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T09:10:48+00:00",
        "updated_at": "2023-02-24T09:10:48+00:00",
        "number": "http://bqbl.it/755fd99e-c877-4546-b239-7cc76d58caed",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c256e440a3b7f0e6a7dc4b964421213a/barcode/image/755fd99e-c877-4546-b239-7cc76d58caed/89fe7e18-f5c8-487f-bc68-5ee932f7d223.svg",
        "owner_id": "d4ad8c9b-f001-49c1-87f2-240117c25a29",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d4ad8c9b-f001-49c1-87f2-240117c25a29"
          },
          "data": {
            "type": "customers",
            "id": "d4ad8c9b-f001-49c1-87f2-240117c25a29"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d4ad8c9b-f001-49c1-87f2-240117c25a29",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T09:10:48+00:00",
        "updated_at": "2023-02-24T09:10:48+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d4ad8c9b-f001-49c1-87f2-240117c25a29&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d4ad8c9b-f001-49c1-87f2-240117c25a29&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d4ad8c9b-f001-49c1-87f2-240117c25a29&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTc2ZmM4MWMtZWIwNS00ZDVmLTkwNWMtYTA3NTQzZTkyODNj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "576fc81c-eb05-4d5f-905c-a07543e9283c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-24T09:10:49+00:00",
        "updated_at": "2023-02-24T09:10:49+00:00",
        "number": "http://bqbl.it/576fc81c-eb05-4d5f-905c-a07543e9283c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dd456bcd33c3e7de811731ffaae20ee3/barcode/image/576fc81c-eb05-4d5f-905c-a07543e9283c/f1176a15-9358-479b-94e7-405731a80089.svg",
        "owner_id": "01227661-a51c-46d8-b247-133138e51460",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/01227661-a51c-46d8-b247-133138e51460"
          },
          "data": {
            "type": "customers",
            "id": "01227661-a51c-46d8-b247-133138e51460"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "01227661-a51c-46d8-b247-133138e51460",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T09:10:49+00:00",
        "updated_at": "2023-02-24T09:10:49+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=01227661-a51c-46d8-b247-133138e51460&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=01227661-a51c-46d8-b247-133138e51460&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=01227661-a51c-46d8-b247-133138e51460&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:10:32Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/635d0828-a198-46bb-8ce7-bcba30a58316?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "635d0828-a198-46bb-8ce7-bcba30a58316",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T09:10:49+00:00",
      "updated_at": "2023-02-24T09:10:49+00:00",
      "number": "http://bqbl.it/635d0828-a198-46bb-8ce7-bcba30a58316",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8deba659bb2c4a994e740cd7dab48864/barcode/image/635d0828-a198-46bb-8ce7-bcba30a58316/24a2b42c-f02c-4f05-a506-5f9c7509d4f6.svg",
      "owner_id": "a06ccc30-99f6-43e2-8917-ff7eb5f81507",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a06ccc30-99f6-43e2-8917-ff7eb5f81507"
        },
        "data": {
          "type": "customers",
          "id": "a06ccc30-99f6-43e2-8917-ff7eb5f81507"
        }
      }
    }
  },
  "included": [
    {
      "id": "a06ccc30-99f6-43e2-8917-ff7eb5f81507",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-24T09:10:49+00:00",
        "updated_at": "2023-02-24T09:10:49+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a06ccc30-99f6-43e2-8917-ff7eb5f81507&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a06ccc30-99f6-43e2-8917-ff7eb5f81507&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a06ccc30-99f6-43e2-8917-ff7eb5f81507&filter[owner_type]=customers"
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
          "owner_id": "0f3075e1-8b89-41f9-a9a6-c31920bc8176",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "95206276-281b-4f65-b23a-2a240573c116",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T09:10:50+00:00",
      "updated_at": "2023-02-24T09:10:50+00:00",
      "number": "http://bqbl.it/95206276-281b-4f65-b23a-2a240573c116",
      "barcode_type": "qr_code",
      "image_url": "/uploads/741c6da6b8f8b6ca6918b7a52af3a442/barcode/image/95206276-281b-4f65-b23a-2a240573c116/a26a8121-944c-43e3-8894-fb2236abc342.svg",
      "owner_id": "0f3075e1-8b89-41f9-a9a6-c31920bc8176",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d300e4c-6780-4d33-904e-f7cd75bed518' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1d300e4c-6780-4d33-904e-f7cd75bed518",
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
    "id": "1d300e4c-6780-4d33-904e-f7cd75bed518",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-24T09:10:50+00:00",
      "updated_at": "2023-02-24T09:10:50+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0ba04a19c779f3bc643b3617111b3783/barcode/image/1d300e4c-6780-4d33-904e-f7cd75bed518/fee03869-b70a-4173-be6a-d162f6310e9d.svg",
      "owner_id": "a66a0ac4-08fd-45af-9b5e-7358c185e1b2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f8d29d6c-e5fc-4a14-b0ed-5326189f8de8' \
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