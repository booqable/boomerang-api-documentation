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
      "id": "072c3031-a134-492c-9531-24cf8e6982ee",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:23:41+00:00",
        "updated_at": "2022-05-24T07:23:41+00:00",
        "number": "http://bqbl.it/072c3031-a134-492c-9531-24cf8e6982ee",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3e3189f15d3b93985eda8719e9672c88/barcode/image/072c3031-a134-492c-9531-24cf8e6982ee/760b5604-5297-4e1c-8829-bf0725d8adf6.svg",
        "owner_id": "d263ce9d-8836-4dd9-b05c-f74899334002",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d263ce9d-8836-4dd9-b05c-f74899334002"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2ce1e8ab-f78a-47b2-8d98-c58baffb7e67&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2ce1e8ab-f78a-47b2-8d98-c58baffb7e67",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:23:42+00:00",
        "updated_at": "2022-05-24T07:23:42+00:00",
        "number": "http://bqbl.it/2ce1e8ab-f78a-47b2-8d98-c58baffb7e67",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2ca87e24c645ff77f311000a7e616bda/barcode/image/2ce1e8ab-f78a-47b2-8d98-c58baffb7e67/57d23d55-8cb9-4694-93a4-dff1e0d12efa.svg",
        "owner_id": "e8d85fc6-35e0-49ee-8ae6-beec8f76ec60",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e8d85fc6-35e0-49ee-8ae6-beec8f76ec60"
          },
          "data": {
            "type": "customers",
            "id": "e8d85fc6-35e0-49ee-8ae6-beec8f76ec60"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e8d85fc6-35e0-49ee-8ae6-beec8f76ec60",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:23:42+00:00",
        "updated_at": "2022-05-24T07:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Zboncak-Nolan",
        "email": "zboncak.nolan@murphy.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=e8d85fc6-35e0-49ee-8ae6-beec8f76ec60&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e8d85fc6-35e0-49ee-8ae6-beec8f76ec60&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e8d85fc6-35e0-49ee-8ae6-beec8f76ec60&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTk3OTg4ZTUtMzNkNy00Yzk4LWI0YzUtYWI3NmNlOWRhZWFm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e97988e5-33d7-4c98-b4c5-ab76ce9daeaf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-24T07:23:42+00:00",
        "updated_at": "2022-05-24T07:23:42+00:00",
        "number": "http://bqbl.it/e97988e5-33d7-4c98-b4c5-ab76ce9daeaf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b31730ad6b7659e94f93bef52547284/barcode/image/e97988e5-33d7-4c98-b4c5-ab76ce9daeaf/bf11a661-251c-4315-bf85-bbb75b4af5bc.svg",
        "owner_id": "a86057f9-ce14-4a7c-8533-404b9e6e01c9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a86057f9-ce14-4a7c-8533-404b9e6e01c9"
          },
          "data": {
            "type": "customers",
            "id": "a86057f9-ce14-4a7c-8533-404b9e6e01c9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a86057f9-ce14-4a7c-8533-404b9e6e01c9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:23:42+00:00",
        "updated_at": "2022-05-24T07:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Lueilwitz, Cremin and Schaefer",
        "email": "and_schaefer_lueilwitz_cremin@greenholt.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=a86057f9-ce14-4a7c-8533-404b9e6e01c9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a86057f9-ce14-4a7c-8533-404b9e6e01c9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a86057f9-ce14-4a7c-8533-404b9e6e01c9&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:23:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/254bacc9-d512-486e-8d71-8a9d6e5c0744?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "254bacc9-d512-486e-8d71-8a9d6e5c0744",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:23:42+00:00",
      "updated_at": "2022-05-24T07:23:42+00:00",
      "number": "http://bqbl.it/254bacc9-d512-486e-8d71-8a9d6e5c0744",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4d941d3b049230d4517dfc49797674e3/barcode/image/254bacc9-d512-486e-8d71-8a9d6e5c0744/9c46453b-d710-4b9d-8149-5dfdac0a2476.svg",
      "owner_id": "0741afd7-5a76-4d3a-8fa2-049969a2f417",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0741afd7-5a76-4d3a-8fa2-049969a2f417"
        },
        "data": {
          "type": "customers",
          "id": "0741afd7-5a76-4d3a-8fa2-049969a2f417"
        }
      }
    }
  },
  "included": [
    {
      "id": "0741afd7-5a76-4d3a-8fa2-049969a2f417",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-24T07:23:42+00:00",
        "updated_at": "2022-05-24T07:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Herzog, Cronin and Stehr",
        "email": "herzog_and_cronin_stehr@mcclure.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=0741afd7-5a76-4d3a-8fa2-049969a2f417&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0741afd7-5a76-4d3a-8fa2-049969a2f417&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0741afd7-5a76-4d3a-8fa2-049969a2f417&filter[owner_type]=customers"
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
          "owner_id": "3d8cdd9f-6512-4abf-acae-b6c42ebb2bfd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f3fd5a7e-136b-43ed-94ce-979839fb710e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:23:43+00:00",
      "updated_at": "2022-05-24T07:23:43+00:00",
      "number": "http://bqbl.it/f3fd5a7e-136b-43ed-94ce-979839fb710e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d3458e5f5f854ad780f4b86b8572e5e0/barcode/image/f3fd5a7e-136b-43ed-94ce-979839fb710e/e08962b6-9883-47c5-9497-a08cec8eb18b.svg",
      "owner_id": "3d8cdd9f-6512-4abf-acae-b6c42ebb2bfd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bb5cc8d4-b4f5-44bf-b5c2-c9788d8b5777' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bb5cc8d4-b4f5-44bf-b5c2-c9788d8b5777",
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
    "id": "bb5cc8d4-b4f5-44bf-b5c2-c9788d8b5777",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-24T07:23:43+00:00",
      "updated_at": "2022-05-24T07:23:43+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/926ec6a36d76a845a69356f397fea21f/barcode/image/bb5cc8d4-b4f5-44bf-b5c2-c9788d8b5777/567745e1-2145-4cbc-bd11-3a8e528c1831.svg",
      "owner_id": "ca808dc3-9a1c-4424-8359-cfe21802f86c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2c87ac22-448d-4f9b-b9e3-6bbc55ffbcb9' \
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