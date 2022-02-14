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
      "id": "4449ce5e-0bbd-49b9-847d-d560f3f9b433",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-14T09:22:59+00:00",
        "updated_at": "2022-02-14T09:22:59+00:00",
        "number": "http://bqbl.it/4449ce5e-0bbd-49b9-847d-d560f3f9b433",
        "barcode_type": "qr_code",
        "image_url": "/uploads/207a0ab4dbcf95c59aab2648595b248d/barcode/image/4449ce5e-0bbd-49b9-847d-d560f3f9b433/940c46b9-09fc-458f-9843-bb770d955b0d.svg",
        "owner_id": "f6fcef48-60d2-4d04-b88f-487ae3d91693",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f6fcef48-60d2-4d04-b88f-487ae3d91693"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F868e88c1-e11c-4694-a305-5dcd77f03b43&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "868e88c1-e11c-4694-a305-5dcd77f03b43",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-14T09:22:59+00:00",
        "updated_at": "2022-02-14T09:22:59+00:00",
        "number": "http://bqbl.it/868e88c1-e11c-4694-a305-5dcd77f03b43",
        "barcode_type": "qr_code",
        "image_url": "/uploads/db6f3eda525ab0f10ffa50f7968704a7/barcode/image/868e88c1-e11c-4694-a305-5dcd77f03b43/4aaa0ca9-b555-4332-aa19-f11f8e770e94.svg",
        "owner_id": "5863e1e6-a4ec-41f6-ad46-7c88fc5902f1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5863e1e6-a4ec-41f6-ad46-7c88fc5902f1"
          },
          "data": {
            "type": "customers",
            "id": "5863e1e6-a4ec-41f6-ad46-7c88fc5902f1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5863e1e6-a4ec-41f6-ad46-7c88fc5902f1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-14T09:22:59+00:00",
        "updated_at": "2022-02-14T09:22:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Runte, Schinner and Hackett",
        "email": "and_hackett_runte_schinner@jones.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=5863e1e6-a4ec-41f6-ad46-7c88fc5902f1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5863e1e6-a4ec-41f6-ad46-7c88fc5902f1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5863e1e6-a4ec-41f6-ad46-7c88fc5902f1&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDBlNjJjMGItNGI5YS00Y2Q3LThhMjYtMGIzZjZmNWQ3ZTZk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d0e62c0b-4b9a-4cd7-8a26-0b3f6f5d7e6d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-14T09:23:00+00:00",
        "updated_at": "2022-02-14T09:23:00+00:00",
        "number": "http://bqbl.it/d0e62c0b-4b9a-4cd7-8a26-0b3f6f5d7e6d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/852b90a4e1cfd8c51699389b07da2d8a/barcode/image/d0e62c0b-4b9a-4cd7-8a26-0b3f6f5d7e6d/e71730d3-8fae-4514-b316-e90b1c329be3.svg",
        "owner_id": "f368e80f-60c1-4a3b-b2e0-f30773e9ddb0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f368e80f-60c1-4a3b-b2e0-f30773e9ddb0"
          },
          "data": {
            "type": "customers",
            "id": "f368e80f-60c1-4a3b-b2e0-f30773e9ddb0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f368e80f-60c1-4a3b-b2e0-f30773e9ddb0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-14T09:23:00+00:00",
        "updated_at": "2022-02-14T09:23:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Roob, Lueilwitz and Johnston",
        "email": "lueilwitz_johnston_and_roob@barton.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=f368e80f-60c1-4a3b-b2e0-f30773e9ddb0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f368e80f-60c1-4a3b-b2e0-f30773e9ddb0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f368e80f-60c1-4a3b-b2e0-f30773e9ddb0&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-14T09:22:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/eecc1828-d7f7-4cbf-8254-d9f49b8ee1f9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eecc1828-d7f7-4cbf-8254-d9f49b8ee1f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-14T09:23:00+00:00",
      "updated_at": "2022-02-14T09:23:00+00:00",
      "number": "http://bqbl.it/eecc1828-d7f7-4cbf-8254-d9f49b8ee1f9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/752e8fb4c4255f095132ee6442fbe4c7/barcode/image/eecc1828-d7f7-4cbf-8254-d9f49b8ee1f9/4a584d58-b399-4604-8632-33cd92c516c0.svg",
      "owner_id": "5aac5a4f-8a81-424d-b1ad-63097247c2a4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5aac5a4f-8a81-424d-b1ad-63097247c2a4"
        },
        "data": {
          "type": "customers",
          "id": "5aac5a4f-8a81-424d-b1ad-63097247c2a4"
        }
      }
    }
  },
  "included": [
    {
      "id": "5aac5a4f-8a81-424d-b1ad-63097247c2a4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-14T09:23:00+00:00",
        "updated_at": "2022-02-14T09:23:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Goodwin, Gerhold and MacGyver",
        "email": "macgyver.and.goodwin.gerhold@kris-christiansen.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=5aac5a4f-8a81-424d-b1ad-63097247c2a4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5aac5a4f-8a81-424d-b1ad-63097247c2a4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5aac5a4f-8a81-424d-b1ad-63097247c2a4&filter[owner_type]=customers"
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
          "owner_id": "e58c91b9-1ac0-458e-932e-469715a1f688",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "953afa7d-1c3a-46e0-8641-d92509a721e3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-14T09:23:01+00:00",
      "updated_at": "2022-02-14T09:23:01+00:00",
      "number": "http://bqbl.it/953afa7d-1c3a-46e0-8641-d92509a721e3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6380ac1affa59678b4dcdf29199ccc53/barcode/image/953afa7d-1c3a-46e0-8641-d92509a721e3/df34b9ae-6fef-4659-9b03-2abefaec5906.svg",
      "owner_id": "e58c91b9-1ac0-458e-932e-469715a1f688",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6ba9534c-7c6c-4500-aeee-a6f5f712c79e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6ba9534c-7c6c-4500-aeee-a6f5f712c79e",
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
    "id": "6ba9534c-7c6c-4500-aeee-a6f5f712c79e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-14T09:23:01+00:00",
      "updated_at": "2022-02-14T09:23:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bc0da136fe58814246c46e97da00f629/barcode/image/6ba9534c-7c6c-4500-aeee-a6f5f712c79e/7f893d7b-d504-4c0e-b24d-f4fc4b3f7833.svg",
      "owner_id": "5cae5999-178e-4bea-a1dd-55daeadd2125",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b7893a84-eb74-4c41-b1b5-420d42a8ecd0' \
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