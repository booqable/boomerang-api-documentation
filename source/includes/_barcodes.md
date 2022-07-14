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
      "id": "209acb64-a5e2-4b2c-a69e-aebdfd24b9c4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T14:26:25+00:00",
        "updated_at": "2022-07-14T14:26:25+00:00",
        "number": "http://bqbl.it/209acb64-a5e2-4b2c-a69e-aebdfd24b9c4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/749ab4e28ec486f0adacaea62f0f2f5c/barcode/image/209acb64-a5e2-4b2c-a69e-aebdfd24b9c4/b3f119bb-46d5-4961-8398-536eba500165.svg",
        "owner_id": "be501d28-708b-4688-a0bd-77f7dfc2c418",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/be501d28-708b-4688-a0bd-77f7dfc2c418"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6098a9e5-290d-48a2-a7dc-f259d2c87aa9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6098a9e5-290d-48a2-a7dc-f259d2c87aa9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T14:26:26+00:00",
        "updated_at": "2022-07-14T14:26:26+00:00",
        "number": "http://bqbl.it/6098a9e5-290d-48a2-a7dc-f259d2c87aa9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cfc4633b77f173a256f1ebde11c1da6b/barcode/image/6098a9e5-290d-48a2-a7dc-f259d2c87aa9/65941796-82b9-454f-974d-15c199a55b1e.svg",
        "owner_id": "8f6a7ea2-65a2-4b80-9be4-26fe16150197",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8f6a7ea2-65a2-4b80-9be4-26fe16150197"
          },
          "data": {
            "type": "customers",
            "id": "8f6a7ea2-65a2-4b80-9be4-26fe16150197"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8f6a7ea2-65a2-4b80-9be4-26fe16150197",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T14:26:26+00:00",
        "updated_at": "2022-07-14T14:26:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Lemke-Watsica",
        "email": "lemke_watsica@schulist-bins.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=8f6a7ea2-65a2-4b80-9be4-26fe16150197&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8f6a7ea2-65a2-4b80-9be4-26fe16150197&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8f6a7ea2-65a2-4b80-9be4-26fe16150197&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjVhOWE4NzMtZDRiYi00NDdhLTk5N2QtYzViYTI3N2NjZmNl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "25a9a873-d4bb-447a-997d-c5ba277ccfce",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T14:26:28+00:00",
        "updated_at": "2022-07-14T14:26:28+00:00",
        "number": "http://bqbl.it/25a9a873-d4bb-447a-997d-c5ba277ccfce",
        "barcode_type": "qr_code",
        "image_url": "/uploads/aa3c846cb2a86de74d270e97522ef463/barcode/image/25a9a873-d4bb-447a-997d-c5ba277ccfce/fe3abab0-0571-4f52-9e98-8b637fc0a63b.svg",
        "owner_id": "c9121b1d-09bc-4220-9971-3afd20678d77",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c9121b1d-09bc-4220-9971-3afd20678d77"
          },
          "data": {
            "type": "customers",
            "id": "c9121b1d-09bc-4220-9971-3afd20678d77"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c9121b1d-09bc-4220-9971-3afd20678d77",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T14:26:28+00:00",
        "updated_at": "2022-07-14T14:26:28+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Kilback, Beer and McClure",
        "email": "kilback.mcclure.beer.and@sipes.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=c9121b1d-09bc-4220-9971-3afd20678d77&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c9121b1d-09bc-4220-9971-3afd20678d77&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c9121b1d-09bc-4220-9971-3afd20678d77&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T14:26:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/18c197fa-aba4-4fa7-a8bc-3ecd1cce1fbf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "18c197fa-aba4-4fa7-a8bc-3ecd1cce1fbf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T14:26:28+00:00",
      "updated_at": "2022-07-14T14:26:28+00:00",
      "number": "http://bqbl.it/18c197fa-aba4-4fa7-a8bc-3ecd1cce1fbf",
      "barcode_type": "qr_code",
      "image_url": "/uploads/12137d6ffbc3d534d5860f74847c31e1/barcode/image/18c197fa-aba4-4fa7-a8bc-3ecd1cce1fbf/1b760016-5479-44eb-ae6b-f92e822b8bf6.svg",
      "owner_id": "67232277-e6ce-451a-9167-3c08612567b2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/67232277-e6ce-451a-9167-3c08612567b2"
        },
        "data": {
          "type": "customers",
          "id": "67232277-e6ce-451a-9167-3c08612567b2"
        }
      }
    }
  },
  "included": [
    {
      "id": "67232277-e6ce-451a-9167-3c08612567b2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T14:26:28+00:00",
        "updated_at": "2022-07-14T14:26:28+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kiehn Group",
        "email": "group.kiehn@greenfelder-hessel.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=67232277-e6ce-451a-9167-3c08612567b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=67232277-e6ce-451a-9167-3c08612567b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=67232277-e6ce-451a-9167-3c08612567b2&filter[owner_type]=customers"
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
          "owner_id": "7b7d2c1e-2556-4162-90ac-d9a6ce0394df",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9dc79fc1-8051-41fe-914a-508c479b8062",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T14:26:29+00:00",
      "updated_at": "2022-07-14T14:26:29+00:00",
      "number": "http://bqbl.it/9dc79fc1-8051-41fe-914a-508c479b8062",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4732d5bc9c8fc930531ee838096d44d9/barcode/image/9dc79fc1-8051-41fe-914a-508c479b8062/9754ba1c-e676-45f3-8197-251427e79e4b.svg",
      "owner_id": "7b7d2c1e-2556-4162-90ac-d9a6ce0394df",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8e788349-eca7-4d91-855a-6aa31cd8b4b2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8e788349-eca7-4d91-855a-6aa31cd8b4b2",
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
    "id": "8e788349-eca7-4d91-855a-6aa31cd8b4b2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T14:26:29+00:00",
      "updated_at": "2022-07-14T14:26:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f1d843381e7b54b470e9fbb9e7d1a658/barcode/image/8e788349-eca7-4d91-855a-6aa31cd8b4b2/1dfa3abf-3260-4167-a535-db3a8dc0fbd9.svg",
      "owner_id": "a3702f85-a052-403d-8d7d-0fa6bcf70be7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/16865450-da6d-49d8-968f-d620a68994ad' \
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