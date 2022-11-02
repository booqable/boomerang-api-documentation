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
      "id": "34c8bc28-d1d0-4ea4-90c5-62293a632dc2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-02T10:18:29+00:00",
        "updated_at": "2022-11-02T10:18:29+00:00",
        "number": "http://bqbl.it/34c8bc28-d1d0-4ea4-90c5-62293a632dc2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/68bba099a46a4d4c53af0335c934ff3d/barcode/image/34c8bc28-d1d0-4ea4-90c5-62293a632dc2/06288bcf-f974-4d48-b145-0c0453f69f7c.svg",
        "owner_id": "3bb4e659-5b34-41f3-ab11-ca2120a4eebf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3bb4e659-5b34-41f3-ab11-ca2120a4eebf"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fac0695b0-3f9a-4cba-b9b5-51ef66479055&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ac0695b0-3f9a-4cba-b9b5-51ef66479055",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-02T10:18:30+00:00",
        "updated_at": "2022-11-02T10:18:30+00:00",
        "number": "http://bqbl.it/ac0695b0-3f9a-4cba-b9b5-51ef66479055",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e8f4edc03163e9ea4c2b65130120bbb7/barcode/image/ac0695b0-3f9a-4cba-b9b5-51ef66479055/6087ee3c-8e3b-4520-861e-dffbc8bf765f.svg",
        "owner_id": "99728840-a11e-49a3-83c1-269a5196cfe8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/99728840-a11e-49a3-83c1-269a5196cfe8"
          },
          "data": {
            "type": "customers",
            "id": "99728840-a11e-49a3-83c1-269a5196cfe8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "99728840-a11e-49a3-83c1-269a5196cfe8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-02T10:18:30+00:00",
        "updated_at": "2022-11-02T10:18:30+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=99728840-a11e-49a3-83c1-269a5196cfe8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=99728840-a11e-49a3-83c1-269a5196cfe8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=99728840-a11e-49a3-83c1-269a5196cfe8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjBkNzE0MTctZWQ0OS00YjIwLTk2ODMtYzc1ODVhNWUzNTZh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f0d71417-ed49-4b20-9683-c7585a5e356a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-02T10:18:30+00:00",
        "updated_at": "2022-11-02T10:18:30+00:00",
        "number": "http://bqbl.it/f0d71417-ed49-4b20-9683-c7585a5e356a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b51ea46419f2c1abda4fac25e4bc6b7c/barcode/image/f0d71417-ed49-4b20-9683-c7585a5e356a/2c9748c0-98a6-4be9-8668-63104ce5fea2.svg",
        "owner_id": "2916b6b0-0160-41da-81c5-9d3e50790eac",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2916b6b0-0160-41da-81c5-9d3e50790eac"
          },
          "data": {
            "type": "customers",
            "id": "2916b6b0-0160-41da-81c5-9d3e50790eac"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2916b6b0-0160-41da-81c5-9d3e50790eac",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-02T10:18:30+00:00",
        "updated_at": "2022-11-02T10:18:30+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2916b6b0-0160-41da-81c5-9d3e50790eac&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2916b6b0-0160-41da-81c5-9d3e50790eac&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2916b6b0-0160-41da-81c5-9d3e50790eac&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-02T10:18:13Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a5fd665b-d291-44d9-8fd2-dc334c56a69f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a5fd665b-d291-44d9-8fd2-dc334c56a69f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-02T10:18:31+00:00",
      "updated_at": "2022-11-02T10:18:31+00:00",
      "number": "http://bqbl.it/a5fd665b-d291-44d9-8fd2-dc334c56a69f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/57d472003d1105775cf00d37297d98a9/barcode/image/a5fd665b-d291-44d9-8fd2-dc334c56a69f/bdc94885-11dc-4005-86d2-287654b474c9.svg",
      "owner_id": "8fd55a8b-7376-49e0-bed1-ed5fc5fbf558",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8fd55a8b-7376-49e0-bed1-ed5fc5fbf558"
        },
        "data": {
          "type": "customers",
          "id": "8fd55a8b-7376-49e0-bed1-ed5fc5fbf558"
        }
      }
    }
  },
  "included": [
    {
      "id": "8fd55a8b-7376-49e0-bed1-ed5fc5fbf558",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-02T10:18:31+00:00",
        "updated_at": "2022-11-02T10:18:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8fd55a8b-7376-49e0-bed1-ed5fc5fbf558&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8fd55a8b-7376-49e0-bed1-ed5fc5fbf558&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8fd55a8b-7376-49e0-bed1-ed5fc5fbf558&filter[owner_type]=customers"
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
          "owner_id": "3e653fc8-faf4-4c14-931f-9a8fd478e684",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2ebf9c64-aeb8-4838-9b13-4c8c42334aa4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-02T10:18:31+00:00",
      "updated_at": "2022-11-02T10:18:31+00:00",
      "number": "http://bqbl.it/2ebf9c64-aeb8-4838-9b13-4c8c42334aa4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7c03644f7eb1b2792b69856cedbc0031/barcode/image/2ebf9c64-aeb8-4838-9b13-4c8c42334aa4/a214c91a-4977-4d6d-8418-169b0b6630de.svg",
      "owner_id": "3e653fc8-faf4-4c14-931f-9a8fd478e684",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6ebacccf-a367-448a-95c1-34a99a416789' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6ebacccf-a367-448a-95c1-34a99a416789",
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
    "id": "6ebacccf-a367-448a-95c1-34a99a416789",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-02T10:18:32+00:00",
      "updated_at": "2022-11-02T10:18:32+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aaa47d09f9ef7e360e9b63e1a3a15021/barcode/image/6ebacccf-a367-448a-95c1-34a99a416789/cf17aec5-c977-44f2-a62c-5436357dbec3.svg",
      "owner_id": "088476d5-9e86-4b2d-8338-74e9f1abc68e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8c0f71ab-baa6-4a29-ac22-59ff325369d8' \
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