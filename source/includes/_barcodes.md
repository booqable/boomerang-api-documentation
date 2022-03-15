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
      "id": "08a82acd-1fdb-40dc-b54e-6729bac52b89",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-15T16:23:11+00:00",
        "updated_at": "2022-03-15T16:23:11+00:00",
        "number": "http://bqbl.it/08a82acd-1fdb-40dc-b54e-6729bac52b89",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7a192d5ff7c6bc16857325363bf47301/barcode/image/08a82acd-1fdb-40dc-b54e-6729bac52b89/bdd6da2c-84bd-4342-a22f-1346629174d9.svg",
        "owner_id": "0ac0a378-2abb-4e2d-ba43-533ddcd776e4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0ac0a378-2abb-4e2d-ba43-533ddcd776e4"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdcadba25-1ba8-42f3-9617-50f6ca370638&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dcadba25-1ba8-42f3-9617-50f6ca370638",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-15T16:23:12+00:00",
        "updated_at": "2022-03-15T16:23:12+00:00",
        "number": "http://bqbl.it/dcadba25-1ba8-42f3-9617-50f6ca370638",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f88e82396b6433635004a7b8dc654845/barcode/image/dcadba25-1ba8-42f3-9617-50f6ca370638/e315373b-d960-4558-8554-5d9bed18e1de.svg",
        "owner_id": "b4736b66-b197-46e1-bef1-50eee50cc241",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b4736b66-b197-46e1-bef1-50eee50cc241"
          },
          "data": {
            "type": "customers",
            "id": "b4736b66-b197-46e1-bef1-50eee50cc241"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b4736b66-b197-46e1-bef1-50eee50cc241",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-15T16:23:11+00:00",
        "updated_at": "2022-03-15T16:23:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kreiger and Sons",
        "email": "sons_and_kreiger@kuhn.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=b4736b66-b197-46e1-bef1-50eee50cc241&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b4736b66-b197-46e1-bef1-50eee50cc241&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b4736b66-b197-46e1-bef1-50eee50cc241&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDg3ZjJjMDktMGUxYS00MWZmLThkYjQtYjdlMzMzNmRlOTY0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "087f2c09-0e1a-41ff-8db4-b7e3336de964",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-15T16:23:12+00:00",
        "updated_at": "2022-03-15T16:23:12+00:00",
        "number": "http://bqbl.it/087f2c09-0e1a-41ff-8db4-b7e3336de964",
        "barcode_type": "qr_code",
        "image_url": "/uploads/18a486a889b67678a2ca4ad5bc06c11d/barcode/image/087f2c09-0e1a-41ff-8db4-b7e3336de964/37afde98-5532-4645-9dca-1e683e66814e.svg",
        "owner_id": "2879ec1f-8c9d-424e-883f-588bc756ca5a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2879ec1f-8c9d-424e-883f-588bc756ca5a"
          },
          "data": {
            "type": "customers",
            "id": "2879ec1f-8c9d-424e-883f-588bc756ca5a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2879ec1f-8c9d-424e-883f-588bc756ca5a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-15T16:23:12+00:00",
        "updated_at": "2022-03-15T16:23:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Bergstrom-Auer",
        "email": "auer.bergstrom@kerluke.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=2879ec1f-8c9d-424e-883f-588bc756ca5a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2879ec1f-8c9d-424e-883f-588bc756ca5a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2879ec1f-8c9d-424e-883f-588bc756ca5a&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-15T16:22:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/61257af7-aefa-4511-84a0-72cca8595a08?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "61257af7-aefa-4511-84a0-72cca8595a08",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-15T16:23:13+00:00",
      "updated_at": "2022-03-15T16:23:13+00:00",
      "number": "http://bqbl.it/61257af7-aefa-4511-84a0-72cca8595a08",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8dba0d4f2eb0d71159d7c663a411a063/barcode/image/61257af7-aefa-4511-84a0-72cca8595a08/638e146e-68e8-4937-a972-1faa814ded48.svg",
      "owner_id": "9ad56e0b-2e64-4289-a227-7533b9bbc578",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9ad56e0b-2e64-4289-a227-7533b9bbc578"
        },
        "data": {
          "type": "customers",
          "id": "9ad56e0b-2e64-4289-a227-7533b9bbc578"
        }
      }
    }
  },
  "included": [
    {
      "id": "9ad56e0b-2e64-4289-a227-7533b9bbc578",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-15T16:23:13+00:00",
        "updated_at": "2022-03-15T16:23:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Blanda-Heathcote",
        "email": "heathcote.blanda@dubuque.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=9ad56e0b-2e64-4289-a227-7533b9bbc578&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9ad56e0b-2e64-4289-a227-7533b9bbc578&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9ad56e0b-2e64-4289-a227-7533b9bbc578&filter[owner_type]=customers"
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
          "owner_id": "9ffc5a4f-71b6-48bd-a511-f3195b29c24c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e12ef5e9-b66d-4d0c-b290-48e7dc051394",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-15T16:23:13+00:00",
      "updated_at": "2022-03-15T16:23:13+00:00",
      "number": "http://bqbl.it/e12ef5e9-b66d-4d0c-b290-48e7dc051394",
      "barcode_type": "qr_code",
      "image_url": "/uploads/442db9d3ff6cd4defdfff210c80ea44c/barcode/image/e12ef5e9-b66d-4d0c-b290-48e7dc051394/a8b7ff03-a31e-4698-8d12-8df849151d43.svg",
      "owner_id": "9ffc5a4f-71b6-48bd-a511-f3195b29c24c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e5012c53-1fb8-4784-a777-4ac6977a52a4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e5012c53-1fb8-4784-a777-4ac6977a52a4",
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
    "id": "e5012c53-1fb8-4784-a777-4ac6977a52a4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-15T16:23:14+00:00",
      "updated_at": "2022-03-15T16:23:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5f22108da27b7c1d9b88ea24242173d3/barcode/image/e5012c53-1fb8-4784-a777-4ac6977a52a4/a0142fad-036b-41d8-b5bb-f5e576768007.svg",
      "owner_id": "bd88fe2b-544b-460a-8965-04b36e5a7ff7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/65145d55-adc6-4276-93a6-54680bab4740' \
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