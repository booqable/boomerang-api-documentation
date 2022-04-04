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
      "id": "bc911085-7a36-4192-b8e2-76d234d78598",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-04T13:21:23+00:00",
        "updated_at": "2022-04-04T13:21:23+00:00",
        "number": "http://bqbl.it/bc911085-7a36-4192-b8e2-76d234d78598",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a922242f297e5f6fb0201e3ceef17a5f/barcode/image/bc911085-7a36-4192-b8e2-76d234d78598/47483764-e953-4ab0-a388-664a027c8137.svg",
        "owner_id": "bf7d729d-65ab-4a16-9ad4-111f722431de",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bf7d729d-65ab-4a16-9ad4-111f722431de"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0f66949b-9335-420f-b1cd-6ccc86de7719&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0f66949b-9335-420f-b1cd-6ccc86de7719",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-04T13:21:24+00:00",
        "updated_at": "2022-04-04T13:21:24+00:00",
        "number": "http://bqbl.it/0f66949b-9335-420f-b1cd-6ccc86de7719",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f5cc080bbe2d17371d3507ae5f69ebcf/barcode/image/0f66949b-9335-420f-b1cd-6ccc86de7719/48f73ddc-9ea9-42bd-97f4-19826db3cef6.svg",
        "owner_id": "49810131-b345-43d7-862a-fdd0058b74ed",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/49810131-b345-43d7-862a-fdd0058b74ed"
          },
          "data": {
            "type": "customers",
            "id": "49810131-b345-43d7-862a-fdd0058b74ed"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "49810131-b345-43d7-862a-fdd0058b74ed",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-04T13:21:24+00:00",
        "updated_at": "2022-04-04T13:21:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Graham, Franecki and Grant",
        "email": "and.grant.franecki.graham@walsh.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=49810131-b345-43d7-862a-fdd0058b74ed&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=49810131-b345-43d7-862a-fdd0058b74ed&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=49810131-b345-43d7-862a-fdd0058b74ed&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTFkMTQ5MTMtODBkNS00ODI5LTk4ZjktMjdjMDhmMTIxNDRi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "91d14913-80d5-4829-98f9-27c08f12144b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-04T13:21:24+00:00",
        "updated_at": "2022-04-04T13:21:24+00:00",
        "number": "http://bqbl.it/91d14913-80d5-4829-98f9-27c08f12144b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/42c979ee3e71a528912550e38c75ef64/barcode/image/91d14913-80d5-4829-98f9-27c08f12144b/af7113e3-0de2-4e35-86b1-f6333ca5b302.svg",
        "owner_id": "08fe9f2e-0504-4e8a-8610-0601fac5fd13",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/08fe9f2e-0504-4e8a-8610-0601fac5fd13"
          },
          "data": {
            "type": "customers",
            "id": "08fe9f2e-0504-4e8a-8610-0601fac5fd13"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "08fe9f2e-0504-4e8a-8610-0601fac5fd13",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-04T13:21:24+00:00",
        "updated_at": "2022-04-04T13:21:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Dickens-Hamill",
        "email": "hamill.dickens@schumm-schamberger.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=08fe9f2e-0504-4e8a-8610-0601fac5fd13&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=08fe9f2e-0504-4e8a-8610-0601fac5fd13&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=08fe9f2e-0504-4e8a-8610-0601fac5fd13&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-04T13:21:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c603c1f5-53ad-4ba3-be1e-9cbf21bd0ae1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c603c1f5-53ad-4ba3-be1e-9cbf21bd0ae1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-04T13:21:25+00:00",
      "updated_at": "2022-04-04T13:21:25+00:00",
      "number": "http://bqbl.it/c603c1f5-53ad-4ba3-be1e-9cbf21bd0ae1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/060507900a25469168f912a138ce73ff/barcode/image/c603c1f5-53ad-4ba3-be1e-9cbf21bd0ae1/35e46134-b985-4645-b0ed-b67bc581089c.svg",
      "owner_id": "e3ccdbcc-07dd-4b52-ba32-af380b95a84d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e3ccdbcc-07dd-4b52-ba32-af380b95a84d"
        },
        "data": {
          "type": "customers",
          "id": "e3ccdbcc-07dd-4b52-ba32-af380b95a84d"
        }
      }
    }
  },
  "included": [
    {
      "id": "e3ccdbcc-07dd-4b52-ba32-af380b95a84d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-04T13:21:25+00:00",
        "updated_at": "2022-04-04T13:21:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Luettgen-Feeney",
        "email": "feeney_luettgen@paucek.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=e3ccdbcc-07dd-4b52-ba32-af380b95a84d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e3ccdbcc-07dd-4b52-ba32-af380b95a84d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e3ccdbcc-07dd-4b52-ba32-af380b95a84d&filter[owner_type]=customers"
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
          "owner_id": "12e9de1e-5cdf-476c-a1c6-ae383f1847f8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "57031761-ff18-4af8-9cfe-06762f7e0662",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-04T13:21:25+00:00",
      "updated_at": "2022-04-04T13:21:25+00:00",
      "number": "http://bqbl.it/57031761-ff18-4af8-9cfe-06762f7e0662",
      "barcode_type": "qr_code",
      "image_url": "/uploads/acf926456082d6ab3d296bd1cb6393ab/barcode/image/57031761-ff18-4af8-9cfe-06762f7e0662/f34145bc-f338-4aa3-8030-76b593b3c373.svg",
      "owner_id": "12e9de1e-5cdf-476c-a1c6-ae383f1847f8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99936d21-1a23-4012-829a-7272f68edb8a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "99936d21-1a23-4012-829a-7272f68edb8a",
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
    "id": "99936d21-1a23-4012-829a-7272f68edb8a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-04T13:21:25+00:00",
      "updated_at": "2022-04-04T13:21:26+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bc043dad417c69db901f290bb496c5c9/barcode/image/99936d21-1a23-4012-829a-7272f68edb8a/7b449604-e2fe-43ac-bc73-770aeb959321.svg",
      "owner_id": "29c08b57-0ca2-4291-936c-dc3c79b83d0e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d9744374-c15c-44d7-939e-4cd3e929b620' \
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