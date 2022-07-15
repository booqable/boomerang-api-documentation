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
      "id": "2f26d8f5-ac76-4a50-a843-2f047609fc13",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T09:22:50+00:00",
        "updated_at": "2022-07-15T09:22:50+00:00",
        "number": "http://bqbl.it/2f26d8f5-ac76-4a50-a843-2f047609fc13",
        "barcode_type": "qr_code",
        "image_url": "/uploads/88fb7fc54cb9c7495cbedb8ad08442be/barcode/image/2f26d8f5-ac76-4a50-a843-2f047609fc13/4acd48b0-5fb9-43ce-a6da-fd90c0244215.svg",
        "owner_id": "98d347e6-7ece-42de-bcf1-bbf998061c9d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/98d347e6-7ece-42de-bcf1-bbf998061c9d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F88f145dc-b945-4256-b749-aa8a6098411d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "88f145dc-b945-4256-b749-aa8a6098411d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T09:22:51+00:00",
        "updated_at": "2022-07-15T09:22:51+00:00",
        "number": "http://bqbl.it/88f145dc-b945-4256-b749-aa8a6098411d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bd338ede9edebec9cfadfc8b7dfd3856/barcode/image/88f145dc-b945-4256-b749-aa8a6098411d/bb585fa0-025a-4ac6-a246-46d94acb7b39.svg",
        "owner_id": "aeaecc92-82e2-4375-8494-11486131e6a6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aeaecc92-82e2-4375-8494-11486131e6a6"
          },
          "data": {
            "type": "customers",
            "id": "aeaecc92-82e2-4375-8494-11486131e6a6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aeaecc92-82e2-4375-8494-11486131e6a6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T09:22:51+00:00",
        "updated_at": "2022-07-15T09:22:51+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Mertz, Willms and Welch",
        "email": "mertz.welch.and.willms@emmerich.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=aeaecc92-82e2-4375-8494-11486131e6a6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aeaecc92-82e2-4375-8494-11486131e6a6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aeaecc92-82e2-4375-8494-11486131e6a6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWM2NTg5ZjEtZGQ3YS00ZGY5LTkwMmYtN2M2NmM3ZGJmMDk2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ac6589f1-dd7a-4df9-902f-7c66c7dbf096",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T09:22:52+00:00",
        "updated_at": "2022-07-15T09:22:52+00:00",
        "number": "http://bqbl.it/ac6589f1-dd7a-4df9-902f-7c66c7dbf096",
        "barcode_type": "qr_code",
        "image_url": "/uploads/76fb79b8382de5b8896d6e3871e16088/barcode/image/ac6589f1-dd7a-4df9-902f-7c66c7dbf096/d2dee34d-7750-4962-bdba-296c92eb564e.svg",
        "owner_id": "c287f7a7-3768-4070-a0af-4c8a13bd2d71",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c287f7a7-3768-4070-a0af-4c8a13bd2d71"
          },
          "data": {
            "type": "customers",
            "id": "c287f7a7-3768-4070-a0af-4c8a13bd2d71"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c287f7a7-3768-4070-a0af-4c8a13bd2d71",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T09:22:51+00:00",
        "updated_at": "2022-07-15T09:22:52+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Kovacek Inc",
        "email": "kovacek.inc@wyman.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=c287f7a7-3768-4070-a0af-4c8a13bd2d71&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c287f7a7-3768-4070-a0af-4c8a13bd2d71&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c287f7a7-3768-4070-a0af-4c8a13bd2d71&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:22:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/50b49c15-4399-4f23-bb8e-b558697e6585?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "50b49c15-4399-4f23-bb8e-b558697e6585",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T09:22:52+00:00",
      "updated_at": "2022-07-15T09:22:52+00:00",
      "number": "http://bqbl.it/50b49c15-4399-4f23-bb8e-b558697e6585",
      "barcode_type": "qr_code",
      "image_url": "/uploads/67a9da492eca8c6d0cb5034e04e84fc8/barcode/image/50b49c15-4399-4f23-bb8e-b558697e6585/a383be92-520a-4a8d-9603-dff8186aa2e0.svg",
      "owner_id": "9124d116-9d1e-4ad7-bdfe-48154e7b4f62",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9124d116-9d1e-4ad7-bdfe-48154e7b4f62"
        },
        "data": {
          "type": "customers",
          "id": "9124d116-9d1e-4ad7-bdfe-48154e7b4f62"
        }
      }
    }
  },
  "included": [
    {
      "id": "9124d116-9d1e-4ad7-bdfe-48154e7b4f62",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T09:22:52+00:00",
        "updated_at": "2022-07-15T09:22:52+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hyatt Group",
        "email": "hyatt_group@okuneva.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=9124d116-9d1e-4ad7-bdfe-48154e7b4f62&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9124d116-9d1e-4ad7-bdfe-48154e7b4f62&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9124d116-9d1e-4ad7-bdfe-48154e7b4f62&filter[owner_type]=customers"
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
          "owner_id": "9722c051-faf8-400f-bf4b-65ec2e795efd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4c0d6430-401f-4297-8d85-86d03bc96278",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T09:22:53+00:00",
      "updated_at": "2022-07-15T09:22:53+00:00",
      "number": "http://bqbl.it/4c0d6430-401f-4297-8d85-86d03bc96278",
      "barcode_type": "qr_code",
      "image_url": "/uploads/519194918e1905a2e80f8adcc4dbf218/barcode/image/4c0d6430-401f-4297-8d85-86d03bc96278/1c736bd5-cad3-4915-95eb-ff23af784801.svg",
      "owner_id": "9722c051-faf8-400f-bf4b-65ec2e795efd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eeb87a2d-67b4-4d32-8c0f-4ce3a4abbb6c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eeb87a2d-67b4-4d32-8c0f-4ce3a4abbb6c",
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
    "id": "eeb87a2d-67b4-4d32-8c0f-4ce3a4abbb6c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T09:22:53+00:00",
      "updated_at": "2022-07-15T09:22:53+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eb6c76187e8500433586160657f3ac41/barcode/image/eeb87a2d-67b4-4d32-8c0f-4ce3a4abbb6c/76b9d4cb-b1e5-44fc-9873-ba61762a19b9.svg",
      "owner_id": "67f31837-eea7-4410-a2e2-70553c9d8c8d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/20993cb8-0e83-4f2c-a2a6-e16bb459d5c7' \
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