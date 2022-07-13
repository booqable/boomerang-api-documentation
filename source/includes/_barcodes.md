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
      "id": "f5b53ee5-9730-44b8-96a7-0751be179096",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T11:49:16+00:00",
        "updated_at": "2022-07-13T11:49:16+00:00",
        "number": "http://bqbl.it/f5b53ee5-9730-44b8-96a7-0751be179096",
        "barcode_type": "qr_code",
        "image_url": "/uploads/571c455b0af3d80d6faf1419779696bb/barcode/image/f5b53ee5-9730-44b8-96a7-0751be179096/b158f244-d389-4d43-9ef8-e2f6f49145b9.svg",
        "owner_id": "68602b34-9d1a-49d1-8c6e-0e5d35112edf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/68602b34-9d1a-49d1-8c6e-0e5d35112edf"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F091a504d-986c-407a-bdf6-e4d221699567&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "091a504d-986c-407a-bdf6-e4d221699567",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T11:49:16+00:00",
        "updated_at": "2022-07-13T11:49:16+00:00",
        "number": "http://bqbl.it/091a504d-986c-407a-bdf6-e4d221699567",
        "barcode_type": "qr_code",
        "image_url": "/uploads/33a27cb269a1bc1d0cb09c78b1b37e5d/barcode/image/091a504d-986c-407a-bdf6-e4d221699567/41433dee-7c7c-4da9-a66b-c8a9e82a7ab9.svg",
        "owner_id": "b2e0c164-a69e-4212-b659-c6fbea4f5c7c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b2e0c164-a69e-4212-b659-c6fbea4f5c7c"
          },
          "data": {
            "type": "customers",
            "id": "b2e0c164-a69e-4212-b659-c6fbea4f5c7c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b2e0c164-a69e-4212-b659-c6fbea4f5c7c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T11:49:16+00:00",
        "updated_at": "2022-07-13T11:49:16+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Romaguera, Davis and Nicolas",
        "email": "romaguera_nicolas_and_davis@kiehn.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=b2e0c164-a69e-4212-b659-c6fbea4f5c7c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b2e0c164-a69e-4212-b659-c6fbea4f5c7c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b2e0c164-a69e-4212-b659-c6fbea4f5c7c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTdkNmNkODUtODlhZS00MTJhLWExMWMtMjhkODY0MGE3NmJk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a7d6cd85-89ae-412a-a11c-28d8640a76bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T11:49:17+00:00",
        "updated_at": "2022-07-13T11:49:17+00:00",
        "number": "http://bqbl.it/a7d6cd85-89ae-412a-a11c-28d8640a76bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e3cae8028f08a0e0c8921265e9c89f1e/barcode/image/a7d6cd85-89ae-412a-a11c-28d8640a76bd/c02c1ca6-35e1-43d6-84d6-03e3571a277f.svg",
        "owner_id": "eb7b46a0-1094-468a-8eac-70ffc3343183",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/eb7b46a0-1094-468a-8eac-70ffc3343183"
          },
          "data": {
            "type": "customers",
            "id": "eb7b46a0-1094-468a-8eac-70ffc3343183"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "eb7b46a0-1094-468a-8eac-70ffc3343183",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T11:49:17+00:00",
        "updated_at": "2022-07-13T11:49:17+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Dickinson Inc",
        "email": "dickinson.inc@quitzon.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=eb7b46a0-1094-468a-8eac-70ffc3343183&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=eb7b46a0-1094-468a-8eac-70ffc3343183&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=eb7b46a0-1094-468a-8eac-70ffc3343183&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:49:00Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a656916b-2da3-4cf9-9a51-eea75d88ef3b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a656916b-2da3-4cf9-9a51-eea75d88ef3b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T11:49:17+00:00",
      "updated_at": "2022-07-13T11:49:17+00:00",
      "number": "http://bqbl.it/a656916b-2da3-4cf9-9a51-eea75d88ef3b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6017a66df967134f0e9d4facd0826460/barcode/image/a656916b-2da3-4cf9-9a51-eea75d88ef3b/a4149957-0e84-421f-bb94-56c9c8857a52.svg",
      "owner_id": "6ab98f1a-0d96-43ba-810d-15c37a52f0cb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6ab98f1a-0d96-43ba-810d-15c37a52f0cb"
        },
        "data": {
          "type": "customers",
          "id": "6ab98f1a-0d96-43ba-810d-15c37a52f0cb"
        }
      }
    }
  },
  "included": [
    {
      "id": "6ab98f1a-0d96-43ba-810d-15c37a52f0cb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T11:49:17+00:00",
        "updated_at": "2022-07-13T11:49:17+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hayes-Pacocha",
        "email": "hayes_pacocha@brown.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=6ab98f1a-0d96-43ba-810d-15c37a52f0cb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6ab98f1a-0d96-43ba-810d-15c37a52f0cb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6ab98f1a-0d96-43ba-810d-15c37a52f0cb&filter[owner_type]=customers"
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
          "owner_id": "9b65b689-e89f-4ee8-9249-c686c60dafba",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fc1ba1fe-858e-4627-b655-60be3b5176b8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T11:49:18+00:00",
      "updated_at": "2022-07-13T11:49:18+00:00",
      "number": "http://bqbl.it/fc1ba1fe-858e-4627-b655-60be3b5176b8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1bbf243201f7fa8b9dbdbb6e49072a97/barcode/image/fc1ba1fe-858e-4627-b655-60be3b5176b8/aeac79a1-3181-4e54-aeab-b047db6603ab.svg",
      "owner_id": "9b65b689-e89f-4ee8-9249-c686c60dafba",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cac64ac9-852f-4ba8-9aa4-1abad2da9628' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cac64ac9-852f-4ba8-9aa4-1abad2da9628",
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
    "id": "cac64ac9-852f-4ba8-9aa4-1abad2da9628",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T11:49:18+00:00",
      "updated_at": "2022-07-13T11:49:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a0d7309c35a6eb6001dcf5a1d1299bae/barcode/image/cac64ac9-852f-4ba8-9aa4-1abad2da9628/c7f22a0b-429d-4459-b005-3ee27ae72ba9.svg",
      "owner_id": "c4f527d3-5def-4c1c-875a-4c7cf3270cdd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/64ed6fd1-6888-439b-83e9-a4633f005de5' \
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