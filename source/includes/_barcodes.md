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
      "id": "f37807be-c767-4857-8d17-5e1fc846a59b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-02T08:02:29+00:00",
        "updated_at": "2022-02-02T08:02:29+00:00",
        "number": "http://bqbl.it/f37807be-c767-4857-8d17-5e1fc846a59b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ac1f4818ab7e150f6a91b00ad78b8c4e/barcode/image/f37807be-c767-4857-8d17-5e1fc846a59b/9d27491c-8132-403c-b61a-b306f2b0de32.svg",
        "owner_id": "aa79cfa4-d8fd-41f0-b2e7-e5fc8fff9daf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aa79cfa4-d8fd-41f0-b2e7-e5fc8fff9daf"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb7b5f4b5-a14c-41eb-9a20-1149a0480afc&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b7b5f4b5-a14c-41eb-9a20-1149a0480afc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-02T08:02:30+00:00",
        "updated_at": "2022-02-02T08:02:30+00:00",
        "number": "http://bqbl.it/b7b5f4b5-a14c-41eb-9a20-1149a0480afc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1fc7bee68616133883b7bfd2fb6e16cf/barcode/image/b7b5f4b5-a14c-41eb-9a20-1149a0480afc/b22afe39-cecb-408b-8170-c66f2e823bf2.svg",
        "owner_id": "361e9660-0af0-4533-b03c-b7cbb3ea8a00",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/361e9660-0af0-4533-b03c-b7cbb3ea8a00"
          },
          "data": {
            "type": "customers",
            "id": "361e9660-0af0-4533-b03c-b7cbb3ea8a00"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "361e9660-0af0-4533-b03c-b7cbb3ea8a00",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-02T08:02:30+00:00",
        "updated_at": "2022-02-02T08:02:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Corkery Group",
        "email": "group.corkery@hoeger-russel.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=361e9660-0af0-4533-b03c-b7cbb3ea8a00&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=361e9660-0af0-4533-b03c-b7cbb3ea8a00&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=361e9660-0af0-4533-b03c-b7cbb3ea8a00&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjQyYjQ5NjItN2FmOS00YmQyLTkzYzYtYmY3NzgwZjYxOTg4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "642b4962-7af9-4bd2-93c6-bf7780f61988",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-02T08:02:30+00:00",
        "updated_at": "2022-02-02T08:02:30+00:00",
        "number": "http://bqbl.it/642b4962-7af9-4bd2-93c6-bf7780f61988",
        "barcode_type": "qr_code",
        "image_url": "/uploads/16cc2318405472a22fa052063e2a98f4/barcode/image/642b4962-7af9-4bd2-93c6-bf7780f61988/7fbdee72-b9a8-4197-859b-7b049aedcf2c.svg",
        "owner_id": "3cc24310-26b3-4e64-b3e6-7694bcf55f80",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3cc24310-26b3-4e64-b3e6-7694bcf55f80"
          },
          "data": {
            "type": "customers",
            "id": "3cc24310-26b3-4e64-b3e6-7694bcf55f80"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3cc24310-26b3-4e64-b3e6-7694bcf55f80",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-02T08:02:30+00:00",
        "updated_at": "2022-02-02T08:02:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Lehner-Bashirian",
        "email": "lehner.bashirian@dickinson-shields.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=3cc24310-26b3-4e64-b3e6-7694bcf55f80&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3cc24310-26b3-4e64-b3e6-7694bcf55f80&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3cc24310-26b3-4e64-b3e6-7694bcf55f80&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-02T08:02:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0f90ea94-5966-4f05-87cd-b7ad183d610a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0f90ea94-5966-4f05-87cd-b7ad183d610a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-02T08:02:31+00:00",
      "updated_at": "2022-02-02T08:02:31+00:00",
      "number": "http://bqbl.it/0f90ea94-5966-4f05-87cd-b7ad183d610a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6aafaba8c9e512ac0fc74635ab39fd07/barcode/image/0f90ea94-5966-4f05-87cd-b7ad183d610a/8eb4e953-a829-4f92-a5c8-aebb9409f202.svg",
      "owner_id": "9dee431c-c47d-4193-aabc-adc423f0b4ca",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9dee431c-c47d-4193-aabc-adc423f0b4ca"
        },
        "data": {
          "type": "customers",
          "id": "9dee431c-c47d-4193-aabc-adc423f0b4ca"
        }
      }
    }
  },
  "included": [
    {
      "id": "9dee431c-c47d-4193-aabc-adc423f0b4ca",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-02T08:02:31+00:00",
        "updated_at": "2022-02-02T08:02:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Schuppe, D'Amore and Maggio",
        "email": "maggio_amore_and_d_schuppe@effertz.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=9dee431c-c47d-4193-aabc-adc423f0b4ca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9dee431c-c47d-4193-aabc-adc423f0b4ca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9dee431c-c47d-4193-aabc-adc423f0b4ca&filter[owner_type]=customers"
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
          "owner_id": "03f120f9-750f-4c05-88f3-f778537c20a4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "73d699c9-2bd3-487f-9eb6-0699269f114e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-02T08:02:32+00:00",
      "updated_at": "2022-02-02T08:02:32+00:00",
      "number": "http://bqbl.it/73d699c9-2bd3-487f-9eb6-0699269f114e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ecf4513e69e649241beb29c238fe70ba/barcode/image/73d699c9-2bd3-487f-9eb6-0699269f114e/a46fff36-5504-4cd4-bfcc-163581dad26a.svg",
      "owner_id": "03f120f9-750f-4c05-88f3-f778537c20a4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/96c89f74-822c-4168-9733-9432602acb5b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "96c89f74-822c-4168-9733-9432602acb5b",
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
    "id": "96c89f74-822c-4168-9733-9432602acb5b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-02T08:02:32+00:00",
      "updated_at": "2022-02-02T08:02:32+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f8834380a5f1a86e351937c469f7351f/barcode/image/96c89f74-822c-4168-9733-9432602acb5b/78b2bc86-5c3b-40da-b648-5c3b10d9c4f9.svg",
      "owner_id": "ef71817f-f38c-4b5b-9c6c-5d931afd8d6a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2fcee84f-e72e-4744-9e90-17142c9212b0' \
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