# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


## Relationships
A barcodes has the following relationships:

Name | Description
- | -
`owner` | **Customer**<br>Associated Owner


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
      "id": "58032d20-02ba-41e5-a56a-21cec0851b7e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-12T15:27:16+00:00",
        "updated_at": "2021-10-12T15:27:16+00:00",
        "number": "http://bqbl.it/58032d20-02ba-41e5-a56a-21cec0851b7e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9f20d627a5aa163d19a663687d6f2dee/barcode/image/58032d20-02ba-41e5-a56a-21cec0851b7e/f85b6dbb-b412-4223-8562-8473ae2a7c52.svg",
        "owner_id": "43941fc6-f684-493c-9133-03f369cd697b",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/43941fc6-f684-493c-9133-03f369cd697b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc067bee0-996d-4231-b3e7-6519c1597bd8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c067bee0-996d-4231-b3e7-6519c1597bd8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-12T15:27:17+00:00",
        "updated_at": "2021-10-12T15:27:17+00:00",
        "number": "http://bqbl.it/c067bee0-996d-4231-b3e7-6519c1597bd8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9b3b005a5408fb0210ef8e993200397f/barcode/image/c067bee0-996d-4231-b3e7-6519c1597bd8/f2f80c60-fb9c-4add-a263-4550963125df.svg",
        "owner_id": "68fcb99a-30f7-41ef-a78e-b088a9eed84d",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/68fcb99a-30f7-41ef-a78e-b088a9eed84d"
          },
          "data": {
            "type": "customers",
            "id": "68fcb99a-30f7-41ef-a78e-b088a9eed84d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "68fcb99a-30f7-41ef-a78e-b088a9eed84d",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-12T15:27:17+00:00",
        "updated_at": "2021-10-12T15:27:17+00:00",
        "number": 1,
        "name": "Murazik and Sons",
        "email": "sons.murazik.and@oreilly.co",
        "archived": false,
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=68fcb99a-30f7-41ef-a78e-b088a9eed84d"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-12T15:27:12Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode

> How to fetch a barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/08e70f86-b12c-4a9f-9a35-3e65bc2be72a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "08e70f86-b12c-4a9f-9a35-3e65bc2be72a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-12T15:27:18+00:00",
      "updated_at": "2021-10-12T15:27:18+00:00",
      "number": "http://bqbl.it/08e70f86-b12c-4a9f-9a35-3e65bc2be72a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/509054fc5efac142081996e0f54fa5ad/barcode/image/08e70f86-b12c-4a9f-9a35-3e65bc2be72a/732121a2-97c1-4416-b671-07961a3318b3.svg",
      "owner_id": "c9fca723-94d7-4123-8ce6-530e9780b967",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c9fca723-94d7-4123-8ce6-530e9780b967"
        },
        "data": {
          "type": "customers",
          "id": "c9fca723-94d7-4123-8ce6-530e9780b967"
        }
      }
    }
  },
  "included": [
    {
      "id": "c9fca723-94d7-4123-8ce6-530e9780b967",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-12T15:27:17+00:00",
        "updated_at": "2021-10-12T15:27:18+00:00",
        "number": 1,
        "name": "Waelchi, Heathcote and Feeney",
        "email": "and.waelchi.heathcote.feeney@lindgren-ferry.info",
        "archived": false,
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c9fca723-94d7-4123-8ce6-530e9780b967"
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
          "owner_id": "c84685e1-a987-47c7-881f-5288e2859a9c",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "06f917a2-62e6-46bf-9943-8c6d137af218",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-12T15:27:18+00:00",
      "updated_at": "2021-10-12T15:27:18+00:00",
      "number": "http://bqbl.it/06f917a2-62e6-46bf-9943-8c6d137af218",
      "barcode_type": "qr_code",
      "image_url": "/uploads/60cec8932f4a2eedea7772e987441da2/barcode/image/06f917a2-62e6-46bf-9943-8c6d137af218/52b2a85a-9ccd-4598-9544-6c42993e1199.svg",
      "owner_id": "c84685e1-a987-47c7-881f-5288e2859a9c",
      "owner_type": "Customer"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode

> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0dea872-194a-4da5-82fc-9172c6669bb9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a0dea872-194a-4da5-82fc-9172c6669bb9",
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
    "id": "a0dea872-194a-4da5-82fc-9172c6669bb9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-12T15:27:19+00:00",
      "updated_at": "2021-10-12T15:27:19+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e0f7e1bab38386702816194a610f3517/barcode/image/a0dea872-194a-4da5-82fc-9172c6669bb9/376fdad0-13ea-4060-ac1a-74b0a4c55dda.svg",
      "owner_id": "13276d7d-9b0a-4a55-a4b1-33daadd6e4b4",
      "owner_type": "Customer"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode

> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/384f6572-fb1f-411d-a26b-48765606c322' \
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