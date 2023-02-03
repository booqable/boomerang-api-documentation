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
      "id": "10c513bf-59f0-4cf0-96fa-98d425636fbc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T09:51:02+00:00",
        "updated_at": "2023-02-03T09:51:02+00:00",
        "number": "http://bqbl.it/10c513bf-59f0-4cf0-96fa-98d425636fbc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/49ca481113c02fe329627fe22283cfde/barcode/image/10c513bf-59f0-4cf0-96fa-98d425636fbc/a38be0f5-d742-4fc6-b968-363414d478f8.svg",
        "owner_id": "b0b97ff6-10f3-4dfe-ade1-4ca49fc965bb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0b97ff6-10f3-4dfe-ade1-4ca49fc965bb"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F60c03cf4-402d-415f-9b1c-f60cd21a35dd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "60c03cf4-402d-415f-9b1c-f60cd21a35dd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T09:51:02+00:00",
        "updated_at": "2023-02-03T09:51:02+00:00",
        "number": "http://bqbl.it/60c03cf4-402d-415f-9b1c-f60cd21a35dd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f643e4fc29af2bfa658da3e335aaff64/barcode/image/60c03cf4-402d-415f-9b1c-f60cd21a35dd/a86ae51c-6f32-417a-bf1f-5ea87af03f5c.svg",
        "owner_id": "6591c470-3ef4-4c64-993b-355ddbea254f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6591c470-3ef4-4c64-993b-355ddbea254f"
          },
          "data": {
            "type": "customers",
            "id": "6591c470-3ef4-4c64-993b-355ddbea254f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6591c470-3ef4-4c64-993b-355ddbea254f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T09:51:02+00:00",
        "updated_at": "2023-02-03T09:51:02+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=6591c470-3ef4-4c64-993b-355ddbea254f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6591c470-3ef4-4c64-993b-355ddbea254f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6591c470-3ef4-4c64-993b-355ddbea254f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOWJlNGE0YjItOWE0Mi00YzEzLTg4NmItNGMwYmU1MzAxZmFk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9be4a4b2-9a42-4c13-886b-4c0be5301fad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-03T09:51:03+00:00",
        "updated_at": "2023-02-03T09:51:03+00:00",
        "number": "http://bqbl.it/9be4a4b2-9a42-4c13-886b-4c0be5301fad",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ffaa1931138b26d5bdc378eee001c14b/barcode/image/9be4a4b2-9a42-4c13-886b-4c0be5301fad/45eb2ced-eeb8-4455-aecf-2dbc3168bbce.svg",
        "owner_id": "19940547-048c-408f-b380-4bd4b8f8ffc3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/19940547-048c-408f-b380-4bd4b8f8ffc3"
          },
          "data": {
            "type": "customers",
            "id": "19940547-048c-408f-b380-4bd4b8f8ffc3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "19940547-048c-408f-b380-4bd4b8f8ffc3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T09:51:03+00:00",
        "updated_at": "2023-02-03T09:51:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=19940547-048c-408f-b380-4bd4b8f8ffc3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=19940547-048c-408f-b380-4bd4b8f8ffc3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=19940547-048c-408f-b380-4bd4b8f8ffc3&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T09:50:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b71317fe-c56f-4957-b980-855751a061ca?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b71317fe-c56f-4957-b980-855751a061ca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T09:51:03+00:00",
      "updated_at": "2023-02-03T09:51:03+00:00",
      "number": "http://bqbl.it/b71317fe-c56f-4957-b980-855751a061ca",
      "barcode_type": "qr_code",
      "image_url": "/uploads/53536d6380b8880f66ecf9c2c7dc660d/barcode/image/b71317fe-c56f-4957-b980-855751a061ca/3c05c8c3-b8ae-47a4-bb37-994bff8fc368.svg",
      "owner_id": "0df42d28-b277-4770-868c-e8a038ae1243",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0df42d28-b277-4770-868c-e8a038ae1243"
        },
        "data": {
          "type": "customers",
          "id": "0df42d28-b277-4770-868c-e8a038ae1243"
        }
      }
    }
  },
  "included": [
    {
      "id": "0df42d28-b277-4770-868c-e8a038ae1243",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-03T09:51:03+00:00",
        "updated_at": "2023-02-03T09:51:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0df42d28-b277-4770-868c-e8a038ae1243&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0df42d28-b277-4770-868c-e8a038ae1243&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0df42d28-b277-4770-868c-e8a038ae1243&filter[owner_type]=customers"
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
          "owner_id": "930e4580-2a61-4aa5-a0b7-bcb4feba699f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c0ee7e54-2a44-43ac-833e-b09488ab5325",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T09:51:04+00:00",
      "updated_at": "2023-02-03T09:51:04+00:00",
      "number": "http://bqbl.it/c0ee7e54-2a44-43ac-833e-b09488ab5325",
      "barcode_type": "qr_code",
      "image_url": "/uploads/64a8638ead2098f40e34462e93b35274/barcode/image/c0ee7e54-2a44-43ac-833e-b09488ab5325/842a4d59-d96f-4f30-847f-43407eb029d6.svg",
      "owner_id": "930e4580-2a61-4aa5-a0b7-bcb4feba699f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3631c845-7243-4e0b-8929-9736a5682332' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3631c845-7243-4e0b-8929-9736a5682332",
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
    "id": "3631c845-7243-4e0b-8929-9736a5682332",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-03T09:51:05+00:00",
      "updated_at": "2023-02-03T09:51:05+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/361fe505f85307cd2121e4e705560897/barcode/image/3631c845-7243-4e0b-8929-9736a5682332/23a724f4-0f4d-4c75-b684-f0ceca801b56.svg",
      "owner_id": "866a9b7d-ca6d-4665-8414-49542f0561ce",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/483ffea2-82f0-46a1-8f75-7857195fdb44' \
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