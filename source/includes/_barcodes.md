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
      "id": "200c4d47-f5c7-4afb-865f-9ea3ef012001",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T09:00:57+00:00",
        "updated_at": "2022-09-16T09:00:57+00:00",
        "number": "http://bqbl.it/200c4d47-f5c7-4afb-865f-9ea3ef012001",
        "barcode_type": "qr_code",
        "image_url": "/uploads/59751c67e38795e43325bb763d5f5074/barcode/image/200c4d47-f5c7-4afb-865f-9ea3ef012001/7f04fced-8e07-4470-b1b6-2f8741e04642.svg",
        "owner_id": "f39b8e63-92b5-4bc9-896c-1cc29b4c9a6b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f39b8e63-92b5-4bc9-896c-1cc29b4c9a6b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F45d1c5cb-6ac7-489f-89b4-ee5578bef77b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "45d1c5cb-6ac7-489f-89b4-ee5578bef77b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T09:00:57+00:00",
        "updated_at": "2022-09-16T09:00:57+00:00",
        "number": "http://bqbl.it/45d1c5cb-6ac7-489f-89b4-ee5578bef77b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cdc9b6493ba9ad0c72a8eeaf06acdb23/barcode/image/45d1c5cb-6ac7-489f-89b4-ee5578bef77b/499f3764-2439-438b-a9dc-7173af172d8e.svg",
        "owner_id": "8d974a54-fabd-49c4-9474-81a5d4d76525",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8d974a54-fabd-49c4-9474-81a5d4d76525"
          },
          "data": {
            "type": "customers",
            "id": "8d974a54-fabd-49c4-9474-81a5d4d76525"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8d974a54-fabd-49c4-9474-81a5d4d76525",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T09:00:57+00:00",
        "updated_at": "2022-09-16T09:00:57+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8d974a54-fabd-49c4-9474-81a5d4d76525&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8d974a54-fabd-49c4-9474-81a5d4d76525&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8d974a54-fabd-49c4-9474-81a5d4d76525&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzNiOWY5MmMtYTZhZC00YjBlLTljNDQtMGNmYmVlMGRjNzgx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "73b9f92c-a6ad-4b0e-9c44-0cfbee0dc781",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T09:00:58+00:00",
        "updated_at": "2022-09-16T09:00:58+00:00",
        "number": "http://bqbl.it/73b9f92c-a6ad-4b0e-9c44-0cfbee0dc781",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f3998012cb51c4cff17e4c4d11dca3c0/barcode/image/73b9f92c-a6ad-4b0e-9c44-0cfbee0dc781/9a237807-7e72-429e-a7f1-a5df109cde65.svg",
        "owner_id": "87966e59-e411-4cd8-8878-38b0538a7edd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87966e59-e411-4cd8-8878-38b0538a7edd"
          },
          "data": {
            "type": "customers",
            "id": "87966e59-e411-4cd8-8878-38b0538a7edd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "87966e59-e411-4cd8-8878-38b0538a7edd",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T09:00:58+00:00",
        "updated_at": "2022-09-16T09:00:58+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=87966e59-e411-4cd8-8878-38b0538a7edd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=87966e59-e411-4cd8-8878-38b0538a7edd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=87966e59-e411-4cd8-8878-38b0538a7edd&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T09:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0eb529d-6252-424c-bc74-9d101ee0c799?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0eb529d-6252-424c-bc74-9d101ee0c799",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T09:00:59+00:00",
      "updated_at": "2022-09-16T09:00:59+00:00",
      "number": "http://bqbl.it/a0eb529d-6252-424c-bc74-9d101ee0c799",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c820216b797f835c147b23bdb991e9b6/barcode/image/a0eb529d-6252-424c-bc74-9d101ee0c799/41262752-a165-4ec8-a0ea-be6a9d8973a4.svg",
      "owner_id": "c40abb97-3cad-4462-a85e-d600bfea2382",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c40abb97-3cad-4462-a85e-d600bfea2382"
        },
        "data": {
          "type": "customers",
          "id": "c40abb97-3cad-4462-a85e-d600bfea2382"
        }
      }
    }
  },
  "included": [
    {
      "id": "c40abb97-3cad-4462-a85e-d600bfea2382",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T09:00:59+00:00",
        "updated_at": "2022-09-16T09:00:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c40abb97-3cad-4462-a85e-d600bfea2382&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c40abb97-3cad-4462-a85e-d600bfea2382&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c40abb97-3cad-4462-a85e-d600bfea2382&filter[owner_type]=customers"
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
          "owner_id": "84522269-2012-4c27-9d23-e6345eb1f437",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "99a55298-2a4b-46e6-a328-84c8dd38d776",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T09:01:00+00:00",
      "updated_at": "2022-09-16T09:01:00+00:00",
      "number": "http://bqbl.it/99a55298-2a4b-46e6-a328-84c8dd38d776",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3be1aa81a93f6435867a9199c33d666e/barcode/image/99a55298-2a4b-46e6-a328-84c8dd38d776/c4f35dd5-85db-4898-9508-ffe254e91e69.svg",
      "owner_id": "84522269-2012-4c27-9d23-e6345eb1f437",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bf03d513-0126-4800-af19-7425db486056' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bf03d513-0126-4800-af19-7425db486056",
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
    "id": "bf03d513-0126-4800-af19-7425db486056",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T09:01:00+00:00",
      "updated_at": "2022-09-16T09:01:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/479baa48b5240e960a22bb6613db4fd2/barcode/image/bf03d513-0126-4800-af19-7425db486056/14d6f7b2-7477-414f-a3dd-778f5574be67.svg",
      "owner_id": "25dc1c7d-8736-4258-9bc7-788b24a17f6a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/09da79f3-9b93-45ca-841f-67ce8da9c08b' \
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