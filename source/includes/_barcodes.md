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
      "id": "c9ecf87c-74a5-479c-b95c-916b955d06cc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-19T12:34:59+00:00",
        "updated_at": "2022-07-19T12:34:59+00:00",
        "number": "http://bqbl.it/c9ecf87c-74a5-479c-b95c-916b955d06cc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/01ddb985f5b26894d58c666f4e7acb7c/barcode/image/c9ecf87c-74a5-479c-b95c-916b955d06cc/2b311ac8-6c55-4ba1-bc8e-3d1929917c36.svg",
        "owner_id": "c732f7a9-1a25-47eb-bf0d-37a65ed81106",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c732f7a9-1a25-47eb-bf0d-37a65ed81106"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9128d2cb-eb7e-47a3-9a80-2f091c45c34e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9128d2cb-eb7e-47a3-9a80-2f091c45c34e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-19T12:34:59+00:00",
        "updated_at": "2022-07-19T12:34:59+00:00",
        "number": "http://bqbl.it/9128d2cb-eb7e-47a3-9a80-2f091c45c34e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1170b68fd5d6486eb92ad7341a445522/barcode/image/9128d2cb-eb7e-47a3-9a80-2f091c45c34e/7a441b53-bf6f-4964-9edf-eff4bd5b9d7c.svg",
        "owner_id": "b0f7a52a-c786-4459-8bd9-27eb10bb0780",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0f7a52a-c786-4459-8bd9-27eb10bb0780"
          },
          "data": {
            "type": "customers",
            "id": "b0f7a52a-c786-4459-8bd9-27eb10bb0780"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b0f7a52a-c786-4459-8bd9-27eb10bb0780",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-19T12:34:59+00:00",
        "updated_at": "2022-07-19T12:34:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kulas, Anderson and Crooks",
        "email": "crooks.kulas.and.anderson@torphy.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=b0f7a52a-c786-4459-8bd9-27eb10bb0780&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b0f7a52a-c786-4459-8bd9-27eb10bb0780&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b0f7a52a-c786-4459-8bd9-27eb10bb0780&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODJlN2E1NGUtOTAzZi00NTA1LThhNDItOTZlMDkyNWM4MWZl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "82e7a54e-903f-4505-8a42-96e0925c81fe",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-19T12:35:00+00:00",
        "updated_at": "2022-07-19T12:35:00+00:00",
        "number": "http://bqbl.it/82e7a54e-903f-4505-8a42-96e0925c81fe",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c51593382d15826e7218486b11493a1e/barcode/image/82e7a54e-903f-4505-8a42-96e0925c81fe/39ea6f27-e3fc-4872-b63d-b8e3e51df95a.svg",
        "owner_id": "e5ee956f-cbb4-4138-a40a-6899520375cc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e5ee956f-cbb4-4138-a40a-6899520375cc"
          },
          "data": {
            "type": "customers",
            "id": "e5ee956f-cbb4-4138-a40a-6899520375cc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e5ee956f-cbb4-4138-a40a-6899520375cc",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-19T12:35:00+00:00",
        "updated_at": "2022-07-19T12:35:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Jacobson-Swift",
        "email": "swift.jacobson@feil.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=e5ee956f-cbb4-4138-a40a-6899520375cc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e5ee956f-cbb4-4138-a40a-6899520375cc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e5ee956f-cbb4-4138-a40a-6899520375cc&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-19T12:34:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2f544abe-c751-4680-9e36-08647b1c1d6b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2f544abe-c751-4680-9e36-08647b1c1d6b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-19T12:35:00+00:00",
      "updated_at": "2022-07-19T12:35:00+00:00",
      "number": "http://bqbl.it/2f544abe-c751-4680-9e36-08647b1c1d6b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5fcfce067d07171db9d1d2a548bd2953/barcode/image/2f544abe-c751-4680-9e36-08647b1c1d6b/73e280ad-dc0b-479b-9648-074bc140465c.svg",
      "owner_id": "f8e41da6-93bc-46e1-9769-8003792884b0",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f8e41da6-93bc-46e1-9769-8003792884b0"
        },
        "data": {
          "type": "customers",
          "id": "f8e41da6-93bc-46e1-9769-8003792884b0"
        }
      }
    }
  },
  "included": [
    {
      "id": "f8e41da6-93bc-46e1-9769-8003792884b0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-19T12:35:00+00:00",
        "updated_at": "2022-07-19T12:35:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hyatt, Simonis and Stracke",
        "email": "simonis_and_hyatt_stracke@lakin.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=f8e41da6-93bc-46e1-9769-8003792884b0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f8e41da6-93bc-46e1-9769-8003792884b0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f8e41da6-93bc-46e1-9769-8003792884b0&filter[owner_type]=customers"
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
          "owner_id": "ea3ec92d-8302-48cc-aa28-51d5517ba3b7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a7c735f8-fa55-4eca-98da-c8ba3f420cfd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-19T12:35:00+00:00",
      "updated_at": "2022-07-19T12:35:00+00:00",
      "number": "http://bqbl.it/a7c735f8-fa55-4eca-98da-c8ba3f420cfd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/73c97cbc975760a51e47445bff9b3785/barcode/image/a7c735f8-fa55-4eca-98da-c8ba3f420cfd/22a57dbc-f0de-4b7d-a66b-e223be564899.svg",
      "owner_id": "ea3ec92d-8302-48cc-aa28-51d5517ba3b7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e9e1e7fd-bd2b-474c-b60d-bb314d1fe338' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e9e1e7fd-bd2b-474c-b60d-bb314d1fe338",
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
    "id": "e9e1e7fd-bd2b-474c-b60d-bb314d1fe338",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-19T12:35:01+00:00",
      "updated_at": "2022-07-19T12:35:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f12102481f7d4a3ae7c3e9c7482136bd/barcode/image/e9e1e7fd-bd2b-474c-b60d-bb314d1fe338/36fb2a43-c2b2-41fc-be5d-b418475cd1bd.svg",
      "owner_id": "b98836dd-9c9e-4997-b9dc-4e91661921d8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8f61ecb1-1a8c-40c0-b4f7-d719aab3dc02' \
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