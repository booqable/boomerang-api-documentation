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
      "id": "be5715fe-a100-4125-8752-4a1018c5d53d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-08T18:19:23+00:00",
        "updated_at": "2022-04-08T18:19:23+00:00",
        "number": "http://bqbl.it/be5715fe-a100-4125-8752-4a1018c5d53d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d414d248e9191eacb56650e381df2f71/barcode/image/be5715fe-a100-4125-8752-4a1018c5d53d/8432b7f6-be81-4170-8367-15cbc97fc0a2.svg",
        "owner_id": "98c90d4e-1083-4c88-b17d-2813a36db5e0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/98c90d4e-1083-4c88-b17d-2813a36db5e0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F99a71870-1a58-4cc3-9635-641420a09e42&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "99a71870-1a58-4cc3-9635-641420a09e42",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-08T18:19:24+00:00",
        "updated_at": "2022-04-08T18:19:24+00:00",
        "number": "http://bqbl.it/99a71870-1a58-4cc3-9635-641420a09e42",
        "barcode_type": "qr_code",
        "image_url": "/uploads/acc25fc1e21e1ec783f792feb8768ecc/barcode/image/99a71870-1a58-4cc3-9635-641420a09e42/115a83ca-ac62-4df8-bf45-b6f49e12593c.svg",
        "owner_id": "cbc8f943-302e-4f94-9031-d9ce689ca401",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cbc8f943-302e-4f94-9031-d9ce689ca401"
          },
          "data": {
            "type": "customers",
            "id": "cbc8f943-302e-4f94-9031-d9ce689ca401"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cbc8f943-302e-4f94-9031-d9ce689ca401",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T18:19:24+00:00",
        "updated_at": "2022-04-08T18:19:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Conroy-Tromp",
        "email": "conroy.tromp@ebert.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=cbc8f943-302e-4f94-9031-d9ce689ca401&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cbc8f943-302e-4f94-9031-d9ce689ca401&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cbc8f943-302e-4f94-9031-d9ce689ca401&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2QyOTc0ZTEtNjQwYi00ZTdhLWJhN2YtNmRhMTIyMDk2MTVm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3d2974e1-640b-4e7a-ba7f-6da12209615f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-08T18:19:24+00:00",
        "updated_at": "2022-04-08T18:19:24+00:00",
        "number": "http://bqbl.it/3d2974e1-640b-4e7a-ba7f-6da12209615f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f49e87dbd547c1fcc62253fc3efb28d5/barcode/image/3d2974e1-640b-4e7a-ba7f-6da12209615f/d2077300-dd4c-4483-87e2-49b63cffbad2.svg",
        "owner_id": "f67dd89d-25c4-4016-84f5-c933725276da",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f67dd89d-25c4-4016-84f5-c933725276da"
          },
          "data": {
            "type": "customers",
            "id": "f67dd89d-25c4-4016-84f5-c933725276da"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f67dd89d-25c4-4016-84f5-c933725276da",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T18:19:24+00:00",
        "updated_at": "2022-04-08T18:19:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Moen, Marks and Stehr",
        "email": "and_moen_marks_stehr@homenick.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=f67dd89d-25c4-4016-84f5-c933725276da&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f67dd89d-25c4-4016-84f5-c933725276da&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f67dd89d-25c4-4016-84f5-c933725276da&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8331847b-41cf-4f28-aeb0-257e6db103dc?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8331847b-41cf-4f28-aeb0-257e6db103dc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-08T18:19:25+00:00",
      "updated_at": "2022-04-08T18:19:25+00:00",
      "number": "http://bqbl.it/8331847b-41cf-4f28-aeb0-257e6db103dc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e5ca7f38ea8ca98463ad153c518a7c7b/barcode/image/8331847b-41cf-4f28-aeb0-257e6db103dc/fb44ab22-e52a-49a5-920d-a259aca330fb.svg",
      "owner_id": "3f886281-64ae-4972-87fe-c4214546f4e3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3f886281-64ae-4972-87fe-c4214546f4e3"
        },
        "data": {
          "type": "customers",
          "id": "3f886281-64ae-4972-87fe-c4214546f4e3"
        }
      }
    }
  },
  "included": [
    {
      "id": "3f886281-64ae-4972-87fe-c4214546f4e3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T18:19:25+00:00",
        "updated_at": "2022-04-08T18:19:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kling, Okuneva and Abshire",
        "email": "and_okuneva_abshire_kling@rice-schneider.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=3f886281-64ae-4972-87fe-c4214546f4e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3f886281-64ae-4972-87fe-c4214546f4e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3f886281-64ae-4972-87fe-c4214546f4e3&filter[owner_type]=customers"
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
          "owner_id": "f8a5f08b-8880-4506-a241-e7618915d57f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "eed1dc40-49b4-47c7-b406-0853563c87c2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-08T18:19:25+00:00",
      "updated_at": "2022-04-08T18:19:25+00:00",
      "number": "http://bqbl.it/eed1dc40-49b4-47c7-b406-0853563c87c2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a5ef4dc1ae65d3345905cc774cf7dded/barcode/image/eed1dc40-49b4-47c7-b406-0853563c87c2/cc58c91f-5898-46da-a1b6-aafef3c48c46.svg",
      "owner_id": "f8a5f08b-8880-4506-a241-e7618915d57f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f1d1f836-d2d8-42d1-8d38-bd461001d5f2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f1d1f836-d2d8-42d1-8d38-bd461001d5f2",
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
    "id": "f1d1f836-d2d8-42d1-8d38-bd461001d5f2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-08T18:19:26+00:00",
      "updated_at": "2022-04-08T18:19:26+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ee2b82074bddb381a9d45aab75cd701a/barcode/image/f1d1f836-d2d8-42d1-8d38-bd461001d5f2/e641bc55-88fd-4afe-8224-5d8f4c325480.svg",
      "owner_id": "82d315ee-f5ad-44e3-90ae-2d4362cc6d87",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cce7cbd7-7d65-487c-b276-d5272776c1de' \
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