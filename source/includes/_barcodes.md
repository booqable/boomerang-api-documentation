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
`GET /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b24c3f6e-33fd-43bc-a095-9aee0fc0a7bb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b24c3f6e-33fd-43bc-a095-9aee0fc0a7bb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-20T09:25:41+00:00",
      "updated_at": "2024-05-20T09:25:41+00:00",
      "number": "http://bqbl.it/b24c3f6e-33fd-43bc-a095-9aee0fc0a7bb",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-116.lvh.me:/barcodes/b24c3f6e-33fd-43bc-a095-9aee0fc0a7bb/image",
      "owner_id": "1db2ed3c-468c-4353-8ec8-b045d44df620",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1db2ed3c-468c-4353-8ec8-b045d44df620"
        },
        "data": {
          "type": "customers",
          "id": "1db2ed3c-468c-4353-8ec8-b045d44df620"
        }
      }
    }
  },
  "included": [
    {
      "id": "1db2ed3c-468c-4353-8ec8-b045d44df620",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-20T09:25:41+00:00",
        "updated_at": "2024-05-20T09:25:41+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-54@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=1db2ed3c-468c-4353-8ec8-b045d44df620&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1db2ed3c-468c-4353-8ec8-b045d44df620&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1db2ed3c-468c-4353-8ec8-b045d44df620&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner`






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
      "id": "82441bbf-c451-46ed-aaab-00c161c2dcf4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-20T09:25:42+00:00",
        "updated_at": "2024-05-20T09:25:42+00:00",
        "number": "http://bqbl.it/82441bbf-c451-46ed-aaab-00c161c2dcf4",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-117.lvh.me:/barcodes/82441bbf-c451-46ed-aaab-00c161c2dcf4/image",
        "owner_id": "1fe9fab9-4f71-4467-91cd-56a977a3d2ef",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1fe9fab9-4f71-4467-91cd-56a977a3d2ef"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWZiOWI2NjItOGU1Mi00ZmFmLWIwOTItMDA0ZDdlM2I2NzQ1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "afb9b662-8e52-4faf-b092-004d7e3b6745",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-20T09:25:48+00:00",
        "updated_at": "2024-05-20T09:25:48+00:00",
        "number": "http://bqbl.it/afb9b662-8e52-4faf-b092-004d7e3b6745",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-118.lvh.me:/barcodes/afb9b662-8e52-4faf-b092-004d7e3b6745/image",
        "owner_id": "4f37dec8-3eef-4e5a-9b00-2c769721c7b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4f37dec8-3eef-4e5a-9b00-2c769721c7b2"
          },
          "data": {
            "type": "customers",
            "id": "4f37dec8-3eef-4e5a-9b00-2c769721c7b2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4f37dec8-3eef-4e5a-9b00-2c769721c7b2",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-20T09:25:47+00:00",
        "updated_at": "2024-05-20T09:25:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-57@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=4f37dec8-3eef-4e5a-9b00-2c769721c7b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4f37dec8-3eef-4e5a-9b00-2c769721c7b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4f37dec8-3eef-4e5a-9b00-2c769721c7b2&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5f37f582-bd30-4c82-93a6-04aff65422a1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5f37f582-bd30-4c82-93a6-04aff65422a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-20T09:25:48+00:00",
        "updated_at": "2024-05-20T09:25:48+00:00",
        "number": "http://bqbl.it/5f37f582-bd30-4c82-93a6-04aff65422a1",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-119.lvh.me:/barcodes/5f37f582-bd30-4c82-93a6-04aff65422a1/image",
        "owner_id": "7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d"
          },
          "data": {
            "type": "customers",
            "id": "7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-20T09:25:48+00:00",
        "updated_at": "2024-05-20T09:25:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-58@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7e73ef67-44cc-4af2-b2ec-8d22cb81cb4d&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/9e0e085c-b855-4303-9d2c-fa84c3810ba2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9e0e085c-b855-4303-9d2c-fa84c3810ba2",
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
    "id": "9e0e085c-b855-4303-9d2c-fa84c3810ba2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-20T09:25:49+00:00",
      "updated_at": "2024-05-20T09:25:49+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-120.lvh.me:/barcodes/9e0e085c-b855-4303-9d2c-fa84c3810ba2/image",
      "owner_id": "422606ef-e789-4933-888d-0dbc8552e596",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e87f87d0-569a-49fa-bc7a-4ed938fceea2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e87f87d0-569a-49fa-bc7a-4ed938fceea2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-20T09:25:50+00:00",
      "updated_at": "2024-05-20T09:25:50+00:00",
      "number": "http://bqbl.it/e87f87d0-569a-49fa-bc7a-4ed938fceea2",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-121.lvh.me:/barcodes/e87f87d0-569a-49fa-bc7a-4ed938fceea2/image",
      "owner_id": "e234423a-892d-4f0c-afdc-6b885c2366e1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e234423a-892d-4f0c-afdc-6b885c2366e1"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


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
          "owner_id": "e267996a-aae5-498a-bfc9-ed9b33bec06c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "98ed675e-48cb-4358-ab0c-7e4a7e5f1429",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-20T09:25:51+00:00",
      "updated_at": "2024-05-20T09:25:51+00:00",
      "number": "http://bqbl.it/98ed675e-48cb-4358-ab0c-7e4a7e5f1429",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-122.lvh.me:/barcodes/98ed675e-48cb-4358-ab0c-7e4a7e5f1429/image",
      "owner_id": "e267996a-aae5-498a-bfc9-ed9b33bec06c",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`





