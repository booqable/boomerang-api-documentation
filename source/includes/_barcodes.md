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
`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`PUT /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes`

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


## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/910ad415-0531-460d-bd1a-a2ba6154954c' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b573b97b-0f46-4293-8e51-2979068299eb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b573b97b-0f46-4293-8e51-2979068299eb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-08T09:20:56+00:00",
      "updated_at": "2024-01-08T09:20:56+00:00",
      "number": "http://bqbl.it/b573b97b-0f46-4293-8e51-2979068299eb",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-281.shop.lvh.me:/barcodes/b573b97b-0f46-4293-8e51-2979068299eb/image",
      "owner_id": "e79a5ba4-9919-48a7-8848-e9f7575c30e3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e79a5ba4-9919-48a7-8848-e9f7575c30e3"
        },
        "data": {
          "type": "customers",
          "id": "e79a5ba4-9919-48a7-8848-e9f7575c30e3"
        }
      }
    }
  },
  "included": [
    {
      "id": "e79a5ba4-9919-48a7-8848-e9f7575c30e3",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-08T09:20:56+00:00",
        "updated_at": "2024-01-08T09:20:56+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-78@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=e79a5ba4-9919-48a7-8848-e9f7575c30e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e79a5ba4-9919-48a7-8848-e9f7575c30e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e79a5ba4-9919-48a7-8848-e9f7575c30e3&filter[owner_type]=customers"
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/04ccd081-105d-4ac8-8dba-a4347a9a1bdd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "04ccd081-105d-4ac8-8dba-a4347a9a1bdd",
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
    "id": "04ccd081-105d-4ac8-8dba-a4347a9a1bdd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-08T09:20:57+00:00",
      "updated_at": "2024-01-08T09:20:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-282.shop.lvh.me:/barcodes/04ccd081-105d-4ac8-8dba-a4347a9a1bdd/image",
      "owner_id": "c2669013-4baf-40cc-9f41-24c99cb0b651",
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
          "owner_id": "66cdbd31-e530-4a18-9429-0386a0d11185",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "40f4bf72-4f1d-4530-b31e-8d9af7fccc34",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-01-08T09:20:58+00:00",
      "updated_at": "2024-01-08T09:20:58+00:00",
      "number": "http://bqbl.it/40f4bf72-4f1d-4530-b31e-8d9af7fccc34",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-283.shop.lvh.me:/barcodes/40f4bf72-4f1d-4530-b31e-8d9af7fccc34/image",
      "owner_id": "66cdbd31-e530-4a18-9429-0386a0d11185",
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






## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdc536d73-c2b5-4287-b1a5-b481bf4a0071&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dc536d73-c2b5-4287-b1a5-b481bf4a0071",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-08T09:20:59+00:00",
        "updated_at": "2024-01-08T09:20:59+00:00",
        "number": "http://bqbl.it/dc536d73-c2b5-4287-b1a5-b481bf4a0071",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-284.shop.lvh.me:/barcodes/dc536d73-c2b5-4287-b1a5-b481bf4a0071/image",
        "owner_id": "9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82"
          },
          "data": {
            "type": "customers",
            "id": "9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-08T09:20:59+00:00",
        "updated_at": "2024-01-08T09:20:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-82@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9faf2bd2-ff4e-44a9-b72c-cbeae78bfc82&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "da4e132c-200d-496a-9bc4-474c75c24f36",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-08T09:21:00+00:00",
        "updated_at": "2024-01-08T09:21:00+00:00",
        "number": "http://bqbl.it/da4e132c-200d-496a-9bc4-474c75c24f36",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-285.shop.lvh.me:/barcodes/da4e132c-200d-496a-9bc4-474c75c24f36/image",
        "owner_id": "94156230-0d9a-4047-9ee6-a303a4066a7c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/94156230-0d9a-4047-9ee6-a303a4066a7c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGU0NDdmYjctOTlmMC00YzA5LTk3YzMtYjczYTI5N2IzNzVi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8e447fb7-99f0-4c09-97c3-b73a297b375b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-01-08T09:21:01+00:00",
        "updated_at": "2024-01-08T09:21:01+00:00",
        "number": "http://bqbl.it/8e447fb7-99f0-4c09-97c3-b73a297b375b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-286.shop.lvh.me:/barcodes/8e447fb7-99f0-4c09-97c3-b73a297b375b/image",
        "owner_id": "a549246c-8895-49ed-9ddc-ccdcf655dcff",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a549246c-8895-49ed-9ddc-ccdcf655dcff"
          },
          "data": {
            "type": "customers",
            "id": "a549246c-8895-49ed-9ddc-ccdcf655dcff"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a549246c-8895-49ed-9ddc-ccdcf655dcff",
      "type": "customers",
      "attributes": {
        "created_at": "2024-01-08T09:21:01+00:00",
        "updated_at": "2024-01-08T09:21:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-85@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=a549246c-8895-49ed-9ddc-ccdcf655dcff&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a549246c-8895-49ed-9ddc-ccdcf655dcff&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a549246c-8895-49ed-9ddc-ccdcf655dcff&filter[owner_type]=customers"
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





