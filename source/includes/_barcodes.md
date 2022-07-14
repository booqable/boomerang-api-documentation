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
      "id": "4bdb0301-397f-4d91-aa93-4045b4f2e6d0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T13:03:16+00:00",
        "updated_at": "2022-07-14T13:03:16+00:00",
        "number": "http://bqbl.it/4bdb0301-397f-4d91-aa93-4045b4f2e6d0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7f58642e0101da1ca9c7d230c180f8fe/barcode/image/4bdb0301-397f-4d91-aa93-4045b4f2e6d0/b6e29d3a-f197-419c-aeca-e97251a17d0b.svg",
        "owner_id": "b5cba5d5-f471-4419-bcef-1c97dbdead36",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b5cba5d5-f471-4419-bcef-1c97dbdead36"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F659af718-2706-4585-b9e0-0fc3321c90ea&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "659af718-2706-4585-b9e0-0fc3321c90ea",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T13:03:17+00:00",
        "updated_at": "2022-07-14T13:03:17+00:00",
        "number": "http://bqbl.it/659af718-2706-4585-b9e0-0fc3321c90ea",
        "barcode_type": "qr_code",
        "image_url": "/uploads/76488d3a9c238ed06947eec33d115d43/barcode/image/659af718-2706-4585-b9e0-0fc3321c90ea/984de168-0515-476b-b5f6-f5900c15055f.svg",
        "owner_id": "d35e2b86-1d30-4bfe-9cac-07756e52ba61",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d35e2b86-1d30-4bfe-9cac-07756e52ba61"
          },
          "data": {
            "type": "customers",
            "id": "d35e2b86-1d30-4bfe-9cac-07756e52ba61"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d35e2b86-1d30-4bfe-9cac-07756e52ba61",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T13:03:17+00:00",
        "updated_at": "2022-07-14T13:03:17+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Rutherford, Schoen and Rohan",
        "email": "rohan.rutherford.and.schoen@bruen-sawayn.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=d35e2b86-1d30-4bfe-9cac-07756e52ba61&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d35e2b86-1d30-4bfe-9cac-07756e52ba61&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d35e2b86-1d30-4bfe-9cac-07756e52ba61&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjUzOGIwNGMtMjY5Ny00YTI4LWIwMTMtYWVmZThhNGZjNjhl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f538b04c-2697-4a28-b013-aefe8a4fc68e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T13:03:17+00:00",
        "updated_at": "2022-07-14T13:03:17+00:00",
        "number": "http://bqbl.it/f538b04c-2697-4a28-b013-aefe8a4fc68e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3870c0d3758d9b0984a36b39c8651655/barcode/image/f538b04c-2697-4a28-b013-aefe8a4fc68e/d40e83a0-0ac4-45d4-9591-9ff9e3ca2705.svg",
        "owner_id": "198db89a-c640-4fc0-815a-e00be2d72a10",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/198db89a-c640-4fc0-815a-e00be2d72a10"
          },
          "data": {
            "type": "customers",
            "id": "198db89a-c640-4fc0-815a-e00be2d72a10"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "198db89a-c640-4fc0-815a-e00be2d72a10",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T13:03:17+00:00",
        "updated_at": "2022-07-14T13:03:17+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Aufderhar, Hartmann and Lemke",
        "email": "aufderhar.and.lemke.hartmann@walker-labadie.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=198db89a-c640-4fc0-815a-e00be2d72a10&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=198db89a-c640-4fc0-815a-e00be2d72a10&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=198db89a-c640-4fc0-815a-e00be2d72a10&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T13:03:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/df9e93e6-5716-498c-af79-e6457daf5bab?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df9e93e6-5716-498c-af79-e6457daf5bab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T13:03:18+00:00",
      "updated_at": "2022-07-14T13:03:18+00:00",
      "number": "http://bqbl.it/df9e93e6-5716-498c-af79-e6457daf5bab",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0f9e57f32f42b04de26c7c53b26506c4/barcode/image/df9e93e6-5716-498c-af79-e6457daf5bab/448a7373-c23e-44ef-8894-1d004e6da802.svg",
      "owner_id": "0e22ea7d-946f-4050-b7c7-d1f103c6aafd",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0e22ea7d-946f-4050-b7c7-d1f103c6aafd"
        },
        "data": {
          "type": "customers",
          "id": "0e22ea7d-946f-4050-b7c7-d1f103c6aafd"
        }
      }
    }
  },
  "included": [
    {
      "id": "0e22ea7d-946f-4050-b7c7-d1f103c6aafd",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T13:03:18+00:00",
        "updated_at": "2022-07-14T13:03:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Wolf and Sons",
        "email": "wolf_sons_and@franecki.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=0e22ea7d-946f-4050-b7c7-d1f103c6aafd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0e22ea7d-946f-4050-b7c7-d1f103c6aafd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0e22ea7d-946f-4050-b7c7-d1f103c6aafd&filter[owner_type]=customers"
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
          "owner_id": "47603a18-e15e-46a2-9101-5ec2c94ccd47",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "31dc66c6-2e9b-4642-9cee-e16794bac523",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T13:03:18+00:00",
      "updated_at": "2022-07-14T13:03:18+00:00",
      "number": "http://bqbl.it/31dc66c6-2e9b-4642-9cee-e16794bac523",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c31390b65019e83bdd8512d460cd221/barcode/image/31dc66c6-2e9b-4642-9cee-e16794bac523/207c8e31-1159-4351-82a6-d23d9446e4c6.svg",
      "owner_id": "47603a18-e15e-46a2-9101-5ec2c94ccd47",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6c88a0ff-a64f-42f2-a038-75310ca79c87' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6c88a0ff-a64f-42f2-a038-75310ca79c87",
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
    "id": "6c88a0ff-a64f-42f2-a038-75310ca79c87",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T13:03:19+00:00",
      "updated_at": "2022-07-14T13:03:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/796f893f10ceb7967c29eba482d9e148/barcode/image/6c88a0ff-a64f-42f2-a038-75310ca79c87/78d6e579-be3f-4d90-a951-ae1e109a6bd3.svg",
      "owner_id": "a7cf1878-f66d-4086-befe-de0b63fa0df9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d380831a-17e9-473c-8115-cf7c5c6ac8da' \
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