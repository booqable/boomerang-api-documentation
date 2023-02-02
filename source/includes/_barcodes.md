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
      "id": "8cdbd263-a379-4059-9fe1-843b4d93c9a5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:36:36+00:00",
        "updated_at": "2023-02-02T16:36:36+00:00",
        "number": "http://bqbl.it/8cdbd263-a379-4059-9fe1-843b4d93c9a5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/66ba7a850580233649f6beaf274b51cd/barcode/image/8cdbd263-a379-4059-9fe1-843b4d93c9a5/fd9a79eb-44dc-4196-ab97-431af51a7d94.svg",
        "owner_id": "ae427207-f11a-4c77-8754-c42242e1e387",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ae427207-f11a-4c77-8754-c42242e1e387"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F73f6168b-179c-4fcc-9d97-f3a15b01dc51&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "73f6168b-179c-4fcc-9d97-f3a15b01dc51",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:36:37+00:00",
        "updated_at": "2023-02-02T16:36:37+00:00",
        "number": "http://bqbl.it/73f6168b-179c-4fcc-9d97-f3a15b01dc51",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1d0a03fa54a9414148af0001b77e77e/barcode/image/73f6168b-179c-4fcc-9d97-f3a15b01dc51/89c0a513-e637-4833-a51b-2e28d15b2c58.svg",
        "owner_id": "66e023d6-b9ab-418e-8049-b7ac856a98e3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/66e023d6-b9ab-418e-8049-b7ac856a98e3"
          },
          "data": {
            "type": "customers",
            "id": "66e023d6-b9ab-418e-8049-b7ac856a98e3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "66e023d6-b9ab-418e-8049-b7ac856a98e3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:36:37+00:00",
        "updated_at": "2023-02-02T16:36:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=66e023d6-b9ab-418e-8049-b7ac856a98e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=66e023d6-b9ab-418e-8049-b7ac856a98e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=66e023d6-b9ab-418e-8049-b7ac856a98e3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDgxYzU2YzktZDE3My00MDgzLThiMDItZTVkMDhmNWY3ODY4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d81c56c9-d173-4083-8b02-e5d08f5f7868",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-02T16:36:38+00:00",
        "updated_at": "2023-02-02T16:36:38+00:00",
        "number": "http://bqbl.it/d81c56c9-d173-4083-8b02-e5d08f5f7868",
        "barcode_type": "qr_code",
        "image_url": "/uploads/88e12ef82a4c220bb33bcc522bd2026f/barcode/image/d81c56c9-d173-4083-8b02-e5d08f5f7868/e6c6d100-51db-4717-9651-d39a7ad9ee7b.svg",
        "owner_id": "7bbe9829-d3a8-4fc6-8779-f3e118c46fa5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7bbe9829-d3a8-4fc6-8779-f3e118c46fa5"
          },
          "data": {
            "type": "customers",
            "id": "7bbe9829-d3a8-4fc6-8779-f3e118c46fa5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7bbe9829-d3a8-4fc6-8779-f3e118c46fa5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:36:37+00:00",
        "updated_at": "2023-02-02T16:36:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=7bbe9829-d3a8-4fc6-8779-f3e118c46fa5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7bbe9829-d3a8-4fc6-8779-f3e118c46fa5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7bbe9829-d3a8-4fc6-8779-f3e118c46fa5&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:36:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d7f93e80-735b-4a5a-88dd-3f63265d017b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d7f93e80-735b-4a5a-88dd-3f63265d017b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:36:38+00:00",
      "updated_at": "2023-02-02T16:36:38+00:00",
      "number": "http://bqbl.it/d7f93e80-735b-4a5a-88dd-3f63265d017b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/239fbb75a9c0fd65b04863367a4bc442/barcode/image/d7f93e80-735b-4a5a-88dd-3f63265d017b/9d780c1e-580b-4873-9b5c-ea5b9f416b9e.svg",
      "owner_id": "1a1eb188-28f3-41b3-8505-6892bc4aff30",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1a1eb188-28f3-41b3-8505-6892bc4aff30"
        },
        "data": {
          "type": "customers",
          "id": "1a1eb188-28f3-41b3-8505-6892bc4aff30"
        }
      }
    }
  },
  "included": [
    {
      "id": "1a1eb188-28f3-41b3-8505-6892bc4aff30",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-02T16:36:38+00:00",
        "updated_at": "2023-02-02T16:36:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1a1eb188-28f3-41b3-8505-6892bc4aff30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1a1eb188-28f3-41b3-8505-6892bc4aff30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1a1eb188-28f3-41b3-8505-6892bc4aff30&filter[owner_type]=customers"
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
          "owner_id": "233018d7-063e-4e3c-9b48-38e7d904524a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2d62dc67-cf88-4dce-8647-dbc4888d5721",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:36:39+00:00",
      "updated_at": "2023-02-02T16:36:39+00:00",
      "number": "http://bqbl.it/2d62dc67-cf88-4dce-8647-dbc4888d5721",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e388825dde46c6f2e4c3ed29c6a6aa5c/barcode/image/2d62dc67-cf88-4dce-8647-dbc4888d5721/236b64d9-c915-49d1-9b7f-cb4e37bd37d8.svg",
      "owner_id": "233018d7-063e-4e3c-9b48-38e7d904524a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99fb53d0-a8e4-48eb-ab74-da2656d2c89a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "99fb53d0-a8e4-48eb-ab74-da2656d2c89a",
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
    "id": "99fb53d0-a8e4-48eb-ab74-da2656d2c89a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-02T16:36:39+00:00",
      "updated_at": "2023-02-02T16:36:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a787e95480f1c91b6958c68e115e2693/barcode/image/99fb53d0-a8e4-48eb-ab74-da2656d2c89a/517794b1-8a9b-4823-8e10-887e8a82d872.svg",
      "owner_id": "e074edb2-f164-4b41-b6f8-0749a450f2d6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2bb79a6a-51cd-47dd-aa14-3069eb92875e' \
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