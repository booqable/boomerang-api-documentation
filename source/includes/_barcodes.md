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
      "id": "98053724-d8f3-4116-b4dd-ddc10a76051b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-07T11:58:01+00:00",
        "updated_at": "2022-07-07T11:58:01+00:00",
        "number": "http://bqbl.it/98053724-d8f3-4116-b4dd-ddc10a76051b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4cee6251ac558d162c1e090bd5bac574/barcode/image/98053724-d8f3-4116-b4dd-ddc10a76051b/0bcb03db-dd19-4baf-99ce-c937733c7342.svg",
        "owner_id": "f1e56d03-db50-4afa-8834-853cacf0eba7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f1e56d03-db50-4afa-8834-853cacf0eba7"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9fcd7d88-3bfb-4690-bddc-ff21bb7ac471&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9fcd7d88-3bfb-4690-bddc-ff21bb7ac471",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-07T11:58:02+00:00",
        "updated_at": "2022-07-07T11:58:02+00:00",
        "number": "http://bqbl.it/9fcd7d88-3bfb-4690-bddc-ff21bb7ac471",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1a0156d5bf3a2421d4ca6035c98ffd53/barcode/image/9fcd7d88-3bfb-4690-bddc-ff21bb7ac471/862f88fa-5de0-417d-96cd-bf6f2addf775.svg",
        "owner_id": "cb655fc1-49eb-4a14-8ad5-5ff14d8312b8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cb655fc1-49eb-4a14-8ad5-5ff14d8312b8"
          },
          "data": {
            "type": "customers",
            "id": "cb655fc1-49eb-4a14-8ad5-5ff14d8312b8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cb655fc1-49eb-4a14-8ad5-5ff14d8312b8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-07T11:58:01+00:00",
        "updated_at": "2022-07-07T11:58:02+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kertzmann-Mann",
        "email": "mann_kertzmann@boyer.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=cb655fc1-49eb-4a14-8ad5-5ff14d8312b8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cb655fc1-49eb-4a14-8ad5-5ff14d8312b8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cb655fc1-49eb-4a14-8ad5-5ff14d8312b8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzY4NTkyNTQtNjg1ZC00MWU5LTkxODktNjIwN2MzZTk1YzAx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "76859254-685d-41e9-9189-6207c3e95c01",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-07T11:58:02+00:00",
        "updated_at": "2022-07-07T11:58:02+00:00",
        "number": "http://bqbl.it/76859254-685d-41e9-9189-6207c3e95c01",
        "barcode_type": "qr_code",
        "image_url": "/uploads/982489d441ad3b45aebb77d1657e69ff/barcode/image/76859254-685d-41e9-9189-6207c3e95c01/271a39a9-9fce-4288-b667-afd499268e85.svg",
        "owner_id": "9e5742a3-8628-44fe-92e2-e0f88f6d6aa9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9e5742a3-8628-44fe-92e2-e0f88f6d6aa9"
          },
          "data": {
            "type": "customers",
            "id": "9e5742a3-8628-44fe-92e2-e0f88f6d6aa9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9e5742a3-8628-44fe-92e2-e0f88f6d6aa9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-07T11:58:02+00:00",
        "updated_at": "2022-07-07T11:58:02+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Graham-Dooley",
        "email": "dooley.graham@langworth.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=9e5742a3-8628-44fe-92e2-e0f88f6d6aa9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9e5742a3-8628-44fe-92e2-e0f88f6d6aa9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9e5742a3-8628-44fe-92e2-e0f88f6d6aa9&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-07T11:57:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c0102cd3-a28d-4480-9f3f-1156da92f3bf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0102cd3-a28d-4480-9f3f-1156da92f3bf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-07T11:58:02+00:00",
      "updated_at": "2022-07-07T11:58:02+00:00",
      "number": "http://bqbl.it/c0102cd3-a28d-4480-9f3f-1156da92f3bf",
      "barcode_type": "qr_code",
      "image_url": "/uploads/acc0cbe4d85c301ca2e04a299c68cd1e/barcode/image/c0102cd3-a28d-4480-9f3f-1156da92f3bf/33a5afa4-37ce-4ba0-a8b4-89c42f16d2fd.svg",
      "owner_id": "1057dfd8-2573-4574-976a-0c02d55f268a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1057dfd8-2573-4574-976a-0c02d55f268a"
        },
        "data": {
          "type": "customers",
          "id": "1057dfd8-2573-4574-976a-0c02d55f268a"
        }
      }
    }
  },
  "included": [
    {
      "id": "1057dfd8-2573-4574-976a-0c02d55f268a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-07T11:58:02+00:00",
        "updated_at": "2022-07-07T11:58:02+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Turcotte-Abernathy",
        "email": "turcotte.abernathy@dicki-dooley.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=1057dfd8-2573-4574-976a-0c02d55f268a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1057dfd8-2573-4574-976a-0c02d55f268a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1057dfd8-2573-4574-976a-0c02d55f268a&filter[owner_type]=customers"
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
          "owner_id": "46a301be-c6db-406f-9c36-38fbb80a5bb0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "60cc0c9e-26c2-4976-af41-74d0089bf0cc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-07T11:58:03+00:00",
      "updated_at": "2022-07-07T11:58:03+00:00",
      "number": "http://bqbl.it/60cc0c9e-26c2-4976-af41-74d0089bf0cc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fcf45a3e7856e1278c1ae0bf1d61a715/barcode/image/60cc0c9e-26c2-4976-af41-74d0089bf0cc/8a8f0a3e-1627-4375-b73d-3cdbf81b0d78.svg",
      "owner_id": "46a301be-c6db-406f-9c36-38fbb80a5bb0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/850a1c02-f1cd-4571-97ed-419c053cdfa0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "850a1c02-f1cd-4571-97ed-419c053cdfa0",
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
    "id": "850a1c02-f1cd-4571-97ed-419c053cdfa0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-07T11:58:04+00:00",
      "updated_at": "2022-07-07T11:58:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eb44bf4936b219ac6a4ca179d726c431/barcode/image/850a1c02-f1cd-4571-97ed-419c053cdfa0/7d406894-1bd3-4e46-afbb-c42c861f8544.svg",
      "owner_id": "8330a493-5809-447c-b28f-c5edc03ff04f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/76098fab-bd02-48a1-8ccb-82f4157eb260' \
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