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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
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
      "id": "4a6d051a-12e9-40a0-823c-f9bf2e7900e0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T13:10:23+00:00",
        "updated_at": "2022-07-08T13:10:23+00:00",
        "number": "http://bqbl.it/4a6d051a-12e9-40a0-823c-f9bf2e7900e0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1ec5fa9c3ffc004a7538f9de0b98ada/barcode/image/4a6d051a-12e9-40a0-823c-f9bf2e7900e0/37b91924-b0b1-4c6d-b557-87abc179d9db.svg",
        "owner_id": "108e1f88-951d-458c-9427-c1ca8be88c84",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/108e1f88-951d-458c-9427-c1ca8be88c84"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffff07fff-22a6-4749-853a-33dffd85f20a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fff07fff-22a6-4749-853a-33dffd85f20a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T13:10:23+00:00",
        "updated_at": "2022-07-08T13:10:23+00:00",
        "number": "http://bqbl.it/fff07fff-22a6-4749-853a-33dffd85f20a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a1abb6505ca949e21d9eff1360430618/barcode/image/fff07fff-22a6-4749-853a-33dffd85f20a/8934a10f-74e2-4093-9ec1-0083bce967a1.svg",
        "owner_id": "aae258a7-7d37-4c67-9495-eaf79353d676",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aae258a7-7d37-4c67-9495-eaf79353d676"
          },
          "data": {
            "type": "customers",
            "id": "aae258a7-7d37-4c67-9495-eaf79353d676"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aae258a7-7d37-4c67-9495-eaf79353d676",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T13:10:23+00:00",
        "updated_at": "2022-07-08T13:10:23+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Gottlieb, Nicolas and Kunde",
        "email": "nicolas_gottlieb_kunde_and@leannon.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=aae258a7-7d37-4c67-9495-eaf79353d676&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aae258a7-7d37-4c67-9495-eaf79353d676&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aae258a7-7d37-4c67-9495-eaf79353d676&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOWUxYTUyMDctNjQyYi00MGEwLTk2YTctMjU4MDdmOGFiY2Y4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9e1a5207-642b-40a0-96a7-25807f8abcf8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-08T13:10:24+00:00",
        "updated_at": "2022-07-08T13:10:24+00:00",
        "number": "http://bqbl.it/9e1a5207-642b-40a0-96a7-25807f8abcf8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8ceea8c63b9c05b54a87053493767363/barcode/image/9e1a5207-642b-40a0-96a7-25807f8abcf8/a22b521b-b190-4371-a891-693ed1a7bfb0.svg",
        "owner_id": "db917228-0838-470c-944a-5433fb413c22",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/db917228-0838-470c-944a-5433fb413c22"
          },
          "data": {
            "type": "customers",
            "id": "db917228-0838-470c-944a-5433fb413c22"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "db917228-0838-470c-944a-5433fb413c22",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T13:10:23+00:00",
        "updated_at": "2022-07-08T13:10:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mayert, Schulist and Rutherford",
        "email": "mayert.rutherford.schulist.and@connelly.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=db917228-0838-470c-944a-5433fb413c22&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=db917228-0838-470c-944a-5433fb413c22&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=db917228-0838-470c-944a-5433fb413c22&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T13:10:09Z`
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
`number` | **String**<br>`eq`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4654a1c6-8465-4473-bbba-17fd122cdbe2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4654a1c6-8465-4473-bbba-17fd122cdbe2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T13:10:24+00:00",
      "updated_at": "2022-07-08T13:10:24+00:00",
      "number": "http://bqbl.it/4654a1c6-8465-4473-bbba-17fd122cdbe2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0d2042e5c45a6bb992f8b3c6499c632b/barcode/image/4654a1c6-8465-4473-bbba-17fd122cdbe2/06123b8d-5854-48fb-8958-78f1362a3225.svg",
      "owner_id": "7be8cd44-a2c7-4bea-8747-e264403ca644",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7be8cd44-a2c7-4bea-8747-e264403ca644"
        },
        "data": {
          "type": "customers",
          "id": "7be8cd44-a2c7-4bea-8747-e264403ca644"
        }
      }
    }
  },
  "included": [
    {
      "id": "7be8cd44-a2c7-4bea-8747-e264403ca644",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-08T13:10:24+00:00",
        "updated_at": "2022-07-08T13:10:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Mueller Group",
        "email": "group.mueller@conroy.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=7be8cd44-a2c7-4bea-8747-e264403ca644&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7be8cd44-a2c7-4bea-8747-e264403ca644&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7be8cd44-a2c7-4bea-8747-e264403ca644&filter[owner_type]=customers"
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
          "owner_id": "480da385-d745-4727-b93f-74c3b60007f0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b521db59-4df3-435d-a9a0-00da15686718",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T13:10:24+00:00",
      "updated_at": "2022-07-08T13:10:24+00:00",
      "number": "http://bqbl.it/b521db59-4df3-435d-a9a0-00da15686718",
      "barcode_type": "qr_code",
      "image_url": "/uploads/66f012f39e474a48a2b9265f0f0a0120/barcode/image/b521db59-4df3-435d-a9a0-00da15686718/74043d5e-985d-4282-b32b-7b58918255b0.svg",
      "owner_id": "480da385-d745-4727-b93f-74c3b60007f0",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0d799a8f-43cf-44f1-a1d6-233e84218f4a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0d799a8f-43cf-44f1-a1d6-233e84218f4a",
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
    "id": "0d799a8f-43cf-44f1-a1d6-233e84218f4a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-08T13:10:25+00:00",
      "updated_at": "2022-07-08T13:10:25+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54a50060df34145afc35f1ad71e1fcd2/barcode/image/0d799a8f-43cf-44f1-a1d6-233e84218f4a/63c82477-3b35-4227-a929-22cee4f584dc.svg",
      "owner_id": "6d89906c-f60c-4dba-9556-7a10d4619fc5",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/23ca61cd-d834-4dba-9c9e-c3ce31b487e8' \
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