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
      "id": "54631645-9bb6-409f-8826-cbfbc3ddcd8c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-09T12:37:12+00:00",
        "updated_at": "2022-06-09T12:37:12+00:00",
        "number": "http://bqbl.it/54631645-9bb6-409f-8826-cbfbc3ddcd8c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/03cec59c7ed063ceb94d0971ebe51a23/barcode/image/54631645-9bb6-409f-8826-cbfbc3ddcd8c/0984c444-45ce-432f-b09e-5fcdad95bdfd.svg",
        "owner_id": "0838e75d-45af-444c-8882-5c305a2b3e6d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0838e75d-45af-444c-8882-5c305a2b3e6d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff9ab5c24-49cd-4a80-ac67-9764719ac7a4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f9ab5c24-49cd-4a80-ac67-9764719ac7a4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-09T12:37:12+00:00",
        "updated_at": "2022-06-09T12:37:12+00:00",
        "number": "http://bqbl.it/f9ab5c24-49cd-4a80-ac67-9764719ac7a4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2d98f0014e0c444c63c1a5ff28236a3e/barcode/image/f9ab5c24-49cd-4a80-ac67-9764719ac7a4/46c29899-ef21-40ca-8dce-36f42c6f6c1a.svg",
        "owner_id": "22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b"
          },
          "data": {
            "type": "customers",
            "id": "22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-09T12:37:12+00:00",
        "updated_at": "2022-06-09T12:37:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Leffler, Langosh and Reilly",
        "email": "reilly.and.langosh.leffler@runolfsson.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=22df4f9b-0281-4d0c-b3b0-7fbbea8c0b7b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMzQ2MWY0NjMtZjczYi00NGIyLTk3OWQtMDFlN2MzMWJkMzI5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3461f463-f73b-44b2-979d-01e7c31bd329",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-09T12:37:13+00:00",
        "updated_at": "2022-06-09T12:37:13+00:00",
        "number": "http://bqbl.it/3461f463-f73b-44b2-979d-01e7c31bd329",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a16a2bafbfebd3ffc16f8a3bde066035/barcode/image/3461f463-f73b-44b2-979d-01e7c31bd329/92681f7d-1498-4a51-94cb-1ccef9d0f2df.svg",
        "owner_id": "616cd78b-f19d-4383-90d4-1fd556c036e2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/616cd78b-f19d-4383-90d4-1fd556c036e2"
          },
          "data": {
            "type": "customers",
            "id": "616cd78b-f19d-4383-90d4-1fd556c036e2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "616cd78b-f19d-4383-90d4-1fd556c036e2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-09T12:37:13+00:00",
        "updated_at": "2022-06-09T12:37:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Thiel, Dach and Homenick",
        "email": "thiel.dach.and.homenick@kreiger.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=616cd78b-f19d-4383-90d4-1fd556c036e2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=616cd78b-f19d-4383-90d4-1fd556c036e2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=616cd78b-f19d-4383-90d4-1fd556c036e2&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-09T12:36:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c9d59877-346f-44d6-8aa1-e59ce7c8b278?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c9d59877-346f-44d6-8aa1-e59ce7c8b278",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-09T12:37:13+00:00",
      "updated_at": "2022-06-09T12:37:13+00:00",
      "number": "http://bqbl.it/c9d59877-346f-44d6-8aa1-e59ce7c8b278",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d2080d854f872a4364c1ab551b2422c2/barcode/image/c9d59877-346f-44d6-8aa1-e59ce7c8b278/03b9cc98-f804-4e67-ae9c-9d3283ccb393.svg",
      "owner_id": "7594a326-26f2-4efe-87ab-be86e0ecbbfb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7594a326-26f2-4efe-87ab-be86e0ecbbfb"
        },
        "data": {
          "type": "customers",
          "id": "7594a326-26f2-4efe-87ab-be86e0ecbbfb"
        }
      }
    }
  },
  "included": [
    {
      "id": "7594a326-26f2-4efe-87ab-be86e0ecbbfb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-09T12:37:13+00:00",
        "updated_at": "2022-06-09T12:37:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Mueller Group",
        "email": "group_mueller@deckow.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=7594a326-26f2-4efe-87ab-be86e0ecbbfb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7594a326-26f2-4efe-87ab-be86e0ecbbfb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7594a326-26f2-4efe-87ab-be86e0ecbbfb&filter[owner_type]=customers"
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
          "owner_id": "335d78de-8874-4abe-857b-4ab46eaa346d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a20e521d-bd0d-4e97-a034-437e84b7294e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-09T12:37:14+00:00",
      "updated_at": "2022-06-09T12:37:14+00:00",
      "number": "http://bqbl.it/a20e521d-bd0d-4e97-a034-437e84b7294e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/939487b389d97cc5a99bd0c225beb7ad/barcode/image/a20e521d-bd0d-4e97-a034-437e84b7294e/f0aff89c-5db5-4b53-9bdc-d375ce7916cd.svg",
      "owner_id": "335d78de-8874-4abe-857b-4ab46eaa346d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/01168c6d-b4b0-4252-b810-00fa354a19c1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "01168c6d-b4b0-4252-b810-00fa354a19c1",
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
    "id": "01168c6d-b4b0-4252-b810-00fa354a19c1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-09T12:37:14+00:00",
      "updated_at": "2022-06-09T12:37:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/85c3fdcc173e34adaf1c458f24e8aee8/barcode/image/01168c6d-b4b0-4252-b810-00fa354a19c1/c865f213-4b3a-4e55-9ef3-2111f4dca4e1.svg",
      "owner_id": "3683ae7b-82fc-49ef-b2ee-d4dda4793855",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fc3e0db7-715a-4f96-8e3a-ab6bea337621' \
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