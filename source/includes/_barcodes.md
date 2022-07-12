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
      "id": "5e8dc5fa-e83f-414a-818b-7fb7c5e7686f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T14:13:47+00:00",
        "updated_at": "2022-07-12T14:13:47+00:00",
        "number": "http://bqbl.it/5e8dc5fa-e83f-414a-818b-7fb7c5e7686f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1101e61c1ab29afafba3c1579505bcfc/barcode/image/5e8dc5fa-e83f-414a-818b-7fb7c5e7686f/81f90c94-c2e9-45a8-972a-f7e53a9f2582.svg",
        "owner_id": "16ed5c26-06e7-481c-8b19-d8006d75671e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/16ed5c26-06e7-481c-8b19-d8006d75671e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F24e1ff63-069b-4adc-919c-bcd11fa62da8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "24e1ff63-069b-4adc-919c-bcd11fa62da8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T14:13:47+00:00",
        "updated_at": "2022-07-12T14:13:47+00:00",
        "number": "http://bqbl.it/24e1ff63-069b-4adc-919c-bcd11fa62da8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f0b5374949c8f5169da29e90b91047b8/barcode/image/24e1ff63-069b-4adc-919c-bcd11fa62da8/a030a539-85f5-4ce7-bf97-c0d64c2d1ede.svg",
        "owner_id": "b2748557-51a3-4607-96a1-46f85b103a29",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b2748557-51a3-4607-96a1-46f85b103a29"
          },
          "data": {
            "type": "customers",
            "id": "b2748557-51a3-4607-96a1-46f85b103a29"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b2748557-51a3-4607-96a1-46f85b103a29",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T14:13:47+00:00",
        "updated_at": "2022-07-12T14:13:47+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kerluke, O'Reilly and Smitham",
        "email": "o_kerluke_and_reilly_smitham@kuhlman-marquardt.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=b2748557-51a3-4607-96a1-46f85b103a29&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b2748557-51a3-4607-96a1-46f85b103a29&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b2748557-51a3-4607-96a1-46f85b103a29&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzAxMDBlODQtNTE4Yi00NDM2LTgyYzUtZWZjYzNiY2M2NTQx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "70100e84-518b-4436-82c5-efcc3bcc6541",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T14:13:48+00:00",
        "updated_at": "2022-07-12T14:13:48+00:00",
        "number": "http://bqbl.it/70100e84-518b-4436-82c5-efcc3bcc6541",
        "barcode_type": "qr_code",
        "image_url": "/uploads/485f40de520eaefba300e39679c3d726/barcode/image/70100e84-518b-4436-82c5-efcc3bcc6541/855c7835-9f76-4488-ac34-e88efff21ac7.svg",
        "owner_id": "c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce"
          },
          "data": {
            "type": "customers",
            "id": "c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T14:13:48+00:00",
        "updated_at": "2022-07-12T14:13:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Powlowski, Wisozk and Koelpin",
        "email": "powlowski_wisozk_koelpin_and@volkman-pacocha.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c7fb2a2e-f94e-4c84-8a9d-0ec748fea4ce&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:13:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ee8cf777-f2b5-4325-a7c2-3a210bc8b1df?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ee8cf777-f2b5-4325-a7c2-3a210bc8b1df",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T14:13:48+00:00",
      "updated_at": "2022-07-12T14:13:48+00:00",
      "number": "http://bqbl.it/ee8cf777-f2b5-4325-a7c2-3a210bc8b1df",
      "barcode_type": "qr_code",
      "image_url": "/uploads/de84dc9198f89990724dbea5abf4193c/barcode/image/ee8cf777-f2b5-4325-a7c2-3a210bc8b1df/e7180f7e-d37b-46a0-ad6e-c18ccd727dc1.svg",
      "owner_id": "fa29c9a6-94f1-4530-935f-ee0f457f5492",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fa29c9a6-94f1-4530-935f-ee0f457f5492"
        },
        "data": {
          "type": "customers",
          "id": "fa29c9a6-94f1-4530-935f-ee0f457f5492"
        }
      }
    }
  },
  "included": [
    {
      "id": "fa29c9a6-94f1-4530-935f-ee0f457f5492",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T14:13:48+00:00",
        "updated_at": "2022-07-12T14:13:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Zieme, Farrell and Ledner",
        "email": "zieme.and.ledner.farrell@block.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=fa29c9a6-94f1-4530-935f-ee0f457f5492&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fa29c9a6-94f1-4530-935f-ee0f457f5492&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fa29c9a6-94f1-4530-935f-ee0f457f5492&filter[owner_type]=customers"
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
          "owner_id": "aafa4099-eb20-4b77-9040-f56769bd8e90",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0e993504-7adc-4d8b-a475-8f43bc0cc98d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T14:13:49+00:00",
      "updated_at": "2022-07-12T14:13:49+00:00",
      "number": "http://bqbl.it/0e993504-7adc-4d8b-a475-8f43bc0cc98d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/89225f0d33e2a2ab5314bd5f8231fbba/barcode/image/0e993504-7adc-4d8b-a475-8f43bc0cc98d/0de3927a-d741-488e-989d-311d58ea4974.svg",
      "owner_id": "aafa4099-eb20-4b77-9040-f56769bd8e90",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bf4d107f-45c8-4f18-8d54-d6495a831f54' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bf4d107f-45c8-4f18-8d54-d6495a831f54",
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
    "id": "bf4d107f-45c8-4f18-8d54-d6495a831f54",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T14:13:49+00:00",
      "updated_at": "2022-07-12T14:13:49+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e9c2b0fe029acc1b80cdc388a8c41e42/barcode/image/bf4d107f-45c8-4f18-8d54-d6495a831f54/72f2a8c4-26e5-4f8c-838e-523af0318e56.svg",
      "owner_id": "e7b0d3ce-5dd9-4700-b20d-3862505529b6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e4468dca-33dc-4619-a99d-2cefed6b5052' \
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