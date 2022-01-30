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
      "id": "5f94ee96-1d4e-47dc-8f5a-da7f78bcaca2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-29T11:14:50+00:00",
        "updated_at": "2022-01-29T11:14:50+00:00",
        "number": "http://bqbl.it/5f94ee96-1d4e-47dc-8f5a-da7f78bcaca2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/76c2953536856ec9f589ad53ae76b333/barcode/image/5f94ee96-1d4e-47dc-8f5a-da7f78bcaca2/4fc6e70d-154c-40b3-ba16-d43203c773dd.svg",
        "owner_id": "a71663a4-44db-4117-9059-7576ac13f36e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a71663a4-44db-4117-9059-7576ac13f36e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1ca35433-275c-4c86-8cc9-74acc20dd1c3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1ca35433-275c-4c86-8cc9-74acc20dd1c3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-29T11:14:50+00:00",
        "updated_at": "2022-01-29T11:14:50+00:00",
        "number": "http://bqbl.it/1ca35433-275c-4c86-8cc9-74acc20dd1c3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e1f478424ce999acfc2ba65767268a8f/barcode/image/1ca35433-275c-4c86-8cc9-74acc20dd1c3/39ccc541-10b6-4c90-8456-8084054b8d95.svg",
        "owner_id": "6fca494e-9c68-4878-8e43-2c2362b32536",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6fca494e-9c68-4878-8e43-2c2362b32536"
          },
          "data": {
            "type": "customers",
            "id": "6fca494e-9c68-4878-8e43-2c2362b32536"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6fca494e-9c68-4878-8e43-2c2362b32536",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-29T11:14:50+00:00",
        "updated_at": "2022-01-29T11:14:50+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Doyle Inc",
        "email": "doyle_inc@kiehn.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=6fca494e-9c68-4878-8e43-2c2362b32536&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6fca494e-9c68-4878-8e43-2c2362b32536&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6fca494e-9c68-4878-8e43-2c2362b32536&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-29T11:14:42Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/35ddd709-324d-4631-94e7-5a93921fff10?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "35ddd709-324d-4631-94e7-5a93921fff10",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-29T11:14:51+00:00",
      "updated_at": "2022-01-29T11:14:51+00:00",
      "number": "http://bqbl.it/35ddd709-324d-4631-94e7-5a93921fff10",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8d28d715a068648dde83ed7b7b2e60b4/barcode/image/35ddd709-324d-4631-94e7-5a93921fff10/de67455f-5b3f-4781-a724-630be0515315.svg",
      "owner_id": "3d5bb66f-3a7c-4d91-8517-a68b6b5389b5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3d5bb66f-3a7c-4d91-8517-a68b6b5389b5"
        },
        "data": {
          "type": "customers",
          "id": "3d5bb66f-3a7c-4d91-8517-a68b6b5389b5"
        }
      }
    }
  },
  "included": [
    {
      "id": "3d5bb66f-3a7c-4d91-8517-a68b6b5389b5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-29T11:14:51+00:00",
        "updated_at": "2022-01-29T11:14:51+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Connelly, Torp and Windler",
        "email": "connelly.and.windler.torp@ortiz-koelpin.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=3d5bb66f-3a7c-4d91-8517-a68b6b5389b5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3d5bb66f-3a7c-4d91-8517-a68b6b5389b5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3d5bb66f-3a7c-4d91-8517-a68b6b5389b5&filter[owner_type]=customers"
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
          "owner_id": "0e0b3cde-cd16-4c93-9849-2c12ef0e9ef0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2a88c21a-cffa-4a7a-a682-8304ceaea5c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-29T11:14:51+00:00",
      "updated_at": "2022-01-29T11:14:51+00:00",
      "number": "http://bqbl.it/2a88c21a-cffa-4a7a-a682-8304ceaea5c3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a36c8eabba1e40d761532763ed9ea833/barcode/image/2a88c21a-cffa-4a7a-a682-8304ceaea5c3/f5054b6b-b6b0-4bf7-8e0b-e3a177fa51a6.svg",
      "owner_id": "0e0b3cde-cd16-4c93-9849-2c12ef0e9ef0",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6c281b97-dfee-44f8-b705-ce58e5feeb48' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6c281b97-dfee-44f8-b705-ce58e5feeb48",
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
    "id": "6c281b97-dfee-44f8-b705-ce58e5feeb48",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-29T11:14:52+00:00",
      "updated_at": "2022-01-29T11:14:52+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/110017293ede6ecb14e8cb2dce34d8ca/barcode/image/6c281b97-dfee-44f8-b705-ce58e5feeb48/59c06d80-76d0-400b-97cf-f57f2de6d7a2.svg",
      "owner_id": "7111fdbb-b4e3-4a70-b54a-740d34839a85",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e5efa3ba-7cff-4ddf-9d28-19e462f2b153' \
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