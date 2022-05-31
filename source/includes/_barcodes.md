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
      "id": "8de53049-7cb5-40a9-9259-379b34052a67",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-31T08:25:28+00:00",
        "updated_at": "2022-05-31T08:25:28+00:00",
        "number": "http://bqbl.it/8de53049-7cb5-40a9-9259-379b34052a67",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cd3f22d5b93dc2d8de281c1eb7bb3d21/barcode/image/8de53049-7cb5-40a9-9259-379b34052a67/51f0af11-136b-40bb-91b5-93a4c9609f2c.svg",
        "owner_id": "666d5cb4-23c4-41a0-bd35-e27a038c50f9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/666d5cb4-23c4-41a0-bd35-e27a038c50f9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F24d7fa30-1e60-4461-ab57-5096cbb337eb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "24d7fa30-1e60-4461-ab57-5096cbb337eb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-31T08:25:29+00:00",
        "updated_at": "2022-05-31T08:25:29+00:00",
        "number": "http://bqbl.it/24d7fa30-1e60-4461-ab57-5096cbb337eb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/36749fe1619ddb480c5b2c6f0198d7b5/barcode/image/24d7fa30-1e60-4461-ab57-5096cbb337eb/83b7b849-6e18-491e-a91f-e4898faa1cec.svg",
        "owner_id": "ef2e850b-8053-411c-a81f-f42be8daf336",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ef2e850b-8053-411c-a81f-f42be8daf336"
          },
          "data": {
            "type": "customers",
            "id": "ef2e850b-8053-411c-a81f-f42be8daf336"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ef2e850b-8053-411c-a81f-f42be8daf336",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T08:25:29+00:00",
        "updated_at": "2022-05-31T08:25:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Jakubowski, Leannon and Friesen",
        "email": "leannon.jakubowski.and.friesen@mosciski.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=ef2e850b-8053-411c-a81f-f42be8daf336&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ef2e850b-8053-411c-a81f-f42be8daf336&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ef2e850b-8053-411c-a81f-f42be8daf336&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTkyMjFiNDQtNzY0Yy00NTE5LTg3YmMtMGRmMzZkMjg5MWFj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a9221b44-764c-4519-87bc-0df36d2891ac",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-31T08:25:29+00:00",
        "updated_at": "2022-05-31T08:25:29+00:00",
        "number": "http://bqbl.it/a9221b44-764c-4519-87bc-0df36d2891ac",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7bfd7fe3b7ac6c94722232851d90ed80/barcode/image/a9221b44-764c-4519-87bc-0df36d2891ac/5f20e440-ab2c-4fdc-8553-53c9b46f00af.svg",
        "owner_id": "7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d"
          },
          "data": {
            "type": "customers",
            "id": "7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T08:25:29+00:00",
        "updated_at": "2022-05-31T08:25:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Witting, Wiza and Kuhic",
        "email": "kuhic.witting.and.wiza@powlowski-muller.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7e1e049f-cbe6-4bfa-b25c-96a0d5be7a2d&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T08:25:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b165e160-f7cb-4b60-b92c-36d4edfa66b6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b165e160-f7cb-4b60-b92c-36d4edfa66b6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-31T08:25:30+00:00",
      "updated_at": "2022-05-31T08:25:30+00:00",
      "number": "http://bqbl.it/b165e160-f7cb-4b60-b92c-36d4edfa66b6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e9ed3608bc735597a7d3a2cf94ce389/barcode/image/b165e160-f7cb-4b60-b92c-36d4edfa66b6/409075fb-f1a8-4bab-8990-d0c33278cdc4.svg",
      "owner_id": "5a4d10a2-d122-4567-bf3b-d210b18b848c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5a4d10a2-d122-4567-bf3b-d210b18b848c"
        },
        "data": {
          "type": "customers",
          "id": "5a4d10a2-d122-4567-bf3b-d210b18b848c"
        }
      }
    }
  },
  "included": [
    {
      "id": "5a4d10a2-d122-4567-bf3b-d210b18b848c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T08:25:30+00:00",
        "updated_at": "2022-05-31T08:25:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Sawayn LLC",
        "email": "sawayn_llc@harris.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=5a4d10a2-d122-4567-bf3b-d210b18b848c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5a4d10a2-d122-4567-bf3b-d210b18b848c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5a4d10a2-d122-4567-bf3b-d210b18b848c&filter[owner_type]=customers"
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
          "owner_id": "66a2ae70-db50-46d4-b675-6252eb83aa54",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dac4070e-75f0-4366-8c3b-6b53c2158171",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-31T08:25:30+00:00",
      "updated_at": "2022-05-31T08:25:30+00:00",
      "number": "http://bqbl.it/dac4070e-75f0-4366-8c3b-6b53c2158171",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6442af94b681d9c5ac395c8eb334dbe6/barcode/image/dac4070e-75f0-4366-8c3b-6b53c2158171/07973922-6fb0-44be-9277-13d0fd8be8db.svg",
      "owner_id": "66a2ae70-db50-46d4-b675-6252eb83aa54",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7edcc4fa-6532-46f3-832b-348d934c0fac' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7edcc4fa-6532-46f3-832b-348d934c0fac",
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
    "id": "7edcc4fa-6532-46f3-832b-348d934c0fac",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-31T08:25:31+00:00",
      "updated_at": "2022-05-31T08:25:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/86883f095241c92a097e0997f00c81f3/barcode/image/7edcc4fa-6532-46f3-832b-348d934c0fac/3c396a59-d715-4462-9780-6b2e576b1641.svg",
      "owner_id": "b784cea7-1eb0-4b55-87db-2ec0ac57e1cf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3e4de2f8-d2ac-4098-abf0-867279764c8f' \
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