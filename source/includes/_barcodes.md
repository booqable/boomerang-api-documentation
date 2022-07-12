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
      "id": "db9a0987-5582-4881-b1d3-c4acdbb0ad40",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T08:46:53+00:00",
        "updated_at": "2022-07-12T08:46:53+00:00",
        "number": "http://bqbl.it/db9a0987-5582-4881-b1d3-c4acdbb0ad40",
        "barcode_type": "qr_code",
        "image_url": "/uploads/619d515e2e6d5386f34dc7762109937a/barcode/image/db9a0987-5582-4881-b1d3-c4acdbb0ad40/46e92d44-a832-495f-8b42-c2d0c016c6b4.svg",
        "owner_id": "7865983a-93ec-44d5-bad5-d330a0656d00",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7865983a-93ec-44d5-bad5-d330a0656d00"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fff90e730-9b6e-46f5-9d15-4c3c722d5007&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ff90e730-9b6e-46f5-9d15-4c3c722d5007",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T08:46:53+00:00",
        "updated_at": "2022-07-12T08:46:53+00:00",
        "number": "http://bqbl.it/ff90e730-9b6e-46f5-9d15-4c3c722d5007",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cac25ad9205cd5abd9c3913d9ba368a8/barcode/image/ff90e730-9b6e-46f5-9d15-4c3c722d5007/105b4a15-bcf3-4016-82b7-4ae2e417b14f.svg",
        "owner_id": "6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4"
          },
          "data": {
            "type": "customers",
            "id": "6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T08:46:53+00:00",
        "updated_at": "2022-07-12T08:46:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Lowe LLC",
        "email": "llc_lowe@klocko-nitzsche.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6b3ffa70-e63c-46ad-9ff8-9c80505ac3b4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTk5Zjg5OGUtZGVmMy00MDFmLTkxNDgtNTg0YjYxODA4ZTI2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "999f898e-def3-401f-9148-584b61808e26",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T08:46:54+00:00",
        "updated_at": "2022-07-12T08:46:54+00:00",
        "number": "http://bqbl.it/999f898e-def3-401f-9148-584b61808e26",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1eaf1d356dd7c1777c8f7b5c5f0021e8/barcode/image/999f898e-def3-401f-9148-584b61808e26/3e71eacf-c3b9-47a2-b1c6-50af8fb73958.svg",
        "owner_id": "0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456"
          },
          "data": {
            "type": "customers",
            "id": "0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T08:46:54+00:00",
        "updated_at": "2022-07-12T08:46:54+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Hermiston, Strosin and Hermiston",
        "email": "strosin.hermiston.hermiston.and@terry-jast.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0db4c8f5-44bf-4e9e-ab2d-d81d0edcc456&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T08:46:39Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a43e4812-08cc-4a3d-853e-7361e3f3042d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a43e4812-08cc-4a3d-853e-7361e3f3042d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T08:46:55+00:00",
      "updated_at": "2022-07-12T08:46:55+00:00",
      "number": "http://bqbl.it/a43e4812-08cc-4a3d-853e-7361e3f3042d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ed508d42925dc80bc8c0f09f6a437351/barcode/image/a43e4812-08cc-4a3d-853e-7361e3f3042d/1c7a2cec-30b7-46fc-8741-e983e45230a4.svg",
      "owner_id": "c9be2622-94ff-45f2-9c0a-deb19f20f798",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c9be2622-94ff-45f2-9c0a-deb19f20f798"
        },
        "data": {
          "type": "customers",
          "id": "c9be2622-94ff-45f2-9c0a-deb19f20f798"
        }
      }
    }
  },
  "included": [
    {
      "id": "c9be2622-94ff-45f2-9c0a-deb19f20f798",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T08:46:54+00:00",
        "updated_at": "2022-07-12T08:46:55+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Murray, McKenzie and Ledner",
        "email": "mckenzie_murray_and_ledner@sporer.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=c9be2622-94ff-45f2-9c0a-deb19f20f798&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c9be2622-94ff-45f2-9c0a-deb19f20f798&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c9be2622-94ff-45f2-9c0a-deb19f20f798&filter[owner_type]=customers"
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
          "owner_id": "572cf76c-cb1d-4a12-a7da-c1471f45bdb1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b7300717-8094-4783-8f7f-8351641e8762",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T08:46:55+00:00",
      "updated_at": "2022-07-12T08:46:55+00:00",
      "number": "http://bqbl.it/b7300717-8094-4783-8f7f-8351641e8762",
      "barcode_type": "qr_code",
      "image_url": "/uploads/931cd03f287675bf46dea70d254f7c6e/barcode/image/b7300717-8094-4783-8f7f-8351641e8762/67012fe8-3e51-4cfe-a303-882bd3135696.svg",
      "owner_id": "572cf76c-cb1d-4a12-a7da-c1471f45bdb1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/291e1821-9891-4c81-951c-f6d18b07cdd5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "291e1821-9891-4c81-951c-f6d18b07cdd5",
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
    "id": "291e1821-9891-4c81-951c-f6d18b07cdd5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T08:46:56+00:00",
      "updated_at": "2022-07-12T08:46:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ca2f29b997aa3b6cfd13d388b7db94af/barcode/image/291e1821-9891-4c81-951c-f6d18b07cdd5/017ad382-c8aa-45b7-b7f2-566049386f61.svg",
      "owner_id": "ec66a0bc-4e38-48f4-b6f4-f2c3712f7542",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cbb00604-bd48-4a5f-98aa-92a81784d043' \
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