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
      "id": "5b583caa-9dae-4dc3-b20e-70937f06aea7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T10:04:17+00:00",
        "updated_at": "2022-04-07T10:04:17+00:00",
        "number": "http://bqbl.it/5b583caa-9dae-4dc3-b20e-70937f06aea7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5ccfead78131d2d520fccaf86da8c24c/barcode/image/5b583caa-9dae-4dc3-b20e-70937f06aea7/8de28bba-4e00-4d85-ae4f-452918468d34.svg",
        "owner_id": "2c404cf3-8dab-41dc-a514-0b6e8b6bd036",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2c404cf3-8dab-41dc-a514-0b6e8b6bd036"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F22574489-e357-4f07-bec3-64a5270c8fe1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "22574489-e357-4f07-bec3-64a5270c8fe1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T10:04:17+00:00",
        "updated_at": "2022-04-07T10:04:17+00:00",
        "number": "http://bqbl.it/22574489-e357-4f07-bec3-64a5270c8fe1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0405f378bd6cbf6b3e65bb8554ed0429/barcode/image/22574489-e357-4f07-bec3-64a5270c8fe1/869ad50d-de11-4b86-b7c7-171edb133caf.svg",
        "owner_id": "5f441e1e-25c1-4e1b-b9d4-10a29f54067f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5f441e1e-25c1-4e1b-b9d4-10a29f54067f"
          },
          "data": {
            "type": "customers",
            "id": "5f441e1e-25c1-4e1b-b9d4-10a29f54067f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5f441e1e-25c1-4e1b-b9d4-10a29f54067f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T10:04:17+00:00",
        "updated_at": "2022-04-07T10:04:17+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kuphal, Yundt and Schiller",
        "email": "and.schiller.yundt.kuphal@johnson.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=5f441e1e-25c1-4e1b-b9d4-10a29f54067f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5f441e1e-25c1-4e1b-b9d4-10a29f54067f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5f441e1e-25c1-4e1b-b9d4-10a29f54067f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmM1NTYyNTEtNGNlNC00YTdmLTg0ODItMmI2OWYyZWMxMmQ3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6c556251-4ce4-4a7f-8482-2b69f2ec12d7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-07T10:04:18+00:00",
        "updated_at": "2022-04-07T10:04:18+00:00",
        "number": "http://bqbl.it/6c556251-4ce4-4a7f-8482-2b69f2ec12d7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/910a542648c9cc9b984140d488d861dd/barcode/image/6c556251-4ce4-4a7f-8482-2b69f2ec12d7/e0105d9d-59f5-4ae6-a116-d4675dc3da0d.svg",
        "owner_id": "69682105-64a5-42dd-9fa6-55ac56f77054",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/69682105-64a5-42dd-9fa6-55ac56f77054"
          },
          "data": {
            "type": "customers",
            "id": "69682105-64a5-42dd-9fa6-55ac56f77054"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "69682105-64a5-42dd-9fa6-55ac56f77054",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T10:04:18+00:00",
        "updated_at": "2022-04-07T10:04:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Greenfelder-Ferry",
        "email": "greenfelder.ferry@harber.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=69682105-64a5-42dd-9fa6-55ac56f77054&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=69682105-64a5-42dd-9fa6-55ac56f77054&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=69682105-64a5-42dd-9fa6-55ac56f77054&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T10:04:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/129be4bd-8f3e-4b3c-8d37-6a0756019294?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "129be4bd-8f3e-4b3c-8d37-6a0756019294",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T10:04:18+00:00",
      "updated_at": "2022-04-07T10:04:18+00:00",
      "number": "http://bqbl.it/129be4bd-8f3e-4b3c-8d37-6a0756019294",
      "barcode_type": "qr_code",
      "image_url": "/uploads/94ee0fcc19fc8fa1fc68a05d9a1ed917/barcode/image/129be4bd-8f3e-4b3c-8d37-6a0756019294/2718011e-58cb-4ee4-9862-4af43474184c.svg",
      "owner_id": "55630fbf-1d1b-4603-86d2-cf73134e6bfa",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/55630fbf-1d1b-4603-86d2-cf73134e6bfa"
        },
        "data": {
          "type": "customers",
          "id": "55630fbf-1d1b-4603-86d2-cf73134e6bfa"
        }
      }
    }
  },
  "included": [
    {
      "id": "55630fbf-1d1b-4603-86d2-cf73134e6bfa",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-07T10:04:18+00:00",
        "updated_at": "2022-04-07T10:04:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Stracke, Bailey and Wintheiser",
        "email": "bailey_stracke_and_wintheiser@mante.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=55630fbf-1d1b-4603-86d2-cf73134e6bfa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=55630fbf-1d1b-4603-86d2-cf73134e6bfa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=55630fbf-1d1b-4603-86d2-cf73134e6bfa&filter[owner_type]=customers"
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
          "owner_id": "a60fc5c1-36a3-4138-98a1-24f714049222",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a16e098f-7987-4509-8072-a81214d1611d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T10:04:19+00:00",
      "updated_at": "2022-04-07T10:04:19+00:00",
      "number": "http://bqbl.it/a16e098f-7987-4509-8072-a81214d1611d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/42042c39749302216d3c3ab5c072acbd/barcode/image/a16e098f-7987-4509-8072-a81214d1611d/810cf5ab-bd5e-4e88-b3e0-b71a1feac2d3.svg",
      "owner_id": "a60fc5c1-36a3-4138-98a1-24f714049222",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/29ae9b29-bd3a-402d-b99a-351695d31e83' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "29ae9b29-bd3a-402d-b99a-351695d31e83",
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
    "id": "29ae9b29-bd3a-402d-b99a-351695d31e83",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-07T10:04:19+00:00",
      "updated_at": "2022-04-07T10:04:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fd0d39a64b031ac3968f22b4405bd61a/barcode/image/29ae9b29-bd3a-402d-b99a-351695d31e83/baf694cd-19b1-4742-a420-44024cf2dd36.svg",
      "owner_id": "785f2e4d-7447-418f-8e3d-200b2332423f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f5128568-4e16-4068-a5e3-61b7446c31dc' \
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