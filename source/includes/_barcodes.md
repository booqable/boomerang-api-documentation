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
      "id": "a9548d87-05ed-43ea-822b-97cf68a58021",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-16T09:37:53+00:00",
        "updated_at": "2021-12-16T09:37:53+00:00",
        "number": "http://bqbl.it/a9548d87-05ed-43ea-822b-97cf68a58021",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5c233d43102bbabc574b7067bb72627f/barcode/image/a9548d87-05ed-43ea-822b-97cf68a58021/812b2823-5e2f-46c9-a3df-76a75125cf1e.svg",
        "owner_id": "8661cb20-d705-4f52-8d7f-e83b26d40e87",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8661cb20-d705-4f52-8d7f-e83b26d40e87"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F123aea89-6d3c-4e02-806e-ba7becd38400&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "123aea89-6d3c-4e02-806e-ba7becd38400",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-16T09:37:54+00:00",
        "updated_at": "2021-12-16T09:37:54+00:00",
        "number": "http://bqbl.it/123aea89-6d3c-4e02-806e-ba7becd38400",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b94c5e3f113c06b03c79fbad959d74a7/barcode/image/123aea89-6d3c-4e02-806e-ba7becd38400/160267dd-97c9-4d5c-9856-8ae059202030.svg",
        "owner_id": "cdbfa8b5-301f-4927-84b7-7a46e490018e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cdbfa8b5-301f-4927-84b7-7a46e490018e"
          },
          "data": {
            "type": "customers",
            "id": "cdbfa8b5-301f-4927-84b7-7a46e490018e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cdbfa8b5-301f-4927-84b7-7a46e490018e",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-16T09:37:54+00:00",
        "updated_at": "2021-12-16T09:37:54+00:00",
        "number": 1,
        "name": "Haag-Robel",
        "email": "robel_haag@kub-cruickshank.co",
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
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=cdbfa8b5-301f-4927-84b7-7a46e490018e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cdbfa8b5-301f-4927-84b7-7a46e490018e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cdbfa8b5-301f-4927-84b7-7a46e490018e&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F123aea89-6d3c-4e02-806e-ba7becd38400&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F123aea89-6d3c-4e02-806e-ba7becd38400&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F123aea89-6d3c-4e02-806e-ba7becd38400&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-16T09:37:45Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/193a3c45-eb82-46b2-983c-f2ae19d9d9ac?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "193a3c45-eb82-46b2-983c-f2ae19d9d9ac",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-16T09:37:55+00:00",
      "updated_at": "2021-12-16T09:37:55+00:00",
      "number": "http://bqbl.it/193a3c45-eb82-46b2-983c-f2ae19d9d9ac",
      "barcode_type": "qr_code",
      "image_url": "/uploads/40be70b1e48514ce68289b25d1122116/barcode/image/193a3c45-eb82-46b2-983c-f2ae19d9d9ac/e2a3093b-addc-4968-a9f7-7e5d2fd6c244.svg",
      "owner_id": "541650dc-8e3d-47f0-906b-ad3ed07a46e9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/541650dc-8e3d-47f0-906b-ad3ed07a46e9"
        },
        "data": {
          "type": "customers",
          "id": "541650dc-8e3d-47f0-906b-ad3ed07a46e9"
        }
      }
    }
  },
  "included": [
    {
      "id": "541650dc-8e3d-47f0-906b-ad3ed07a46e9",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-16T09:37:55+00:00",
        "updated_at": "2021-12-16T09:37:55+00:00",
        "number": 1,
        "name": "Cassin, Mills and McGlynn",
        "email": "mills.cassin.and.mcglynn@rohan-vandervort.com",
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
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=541650dc-8e3d-47f0-906b-ad3ed07a46e9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=541650dc-8e3d-47f0-906b-ad3ed07a46e9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=541650dc-8e3d-47f0-906b-ad3ed07a46e9&filter[owner_type]=customers"
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
          "owner_id": "aa1c4eeb-a4f5-40bb-b2ec-a8a5b1098e4f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "55d98a01-98c3-4cdd-8827-9b7ecfa0354e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-16T09:37:55+00:00",
      "updated_at": "2021-12-16T09:37:55+00:00",
      "number": "http://bqbl.it/55d98a01-98c3-4cdd-8827-9b7ecfa0354e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b788ba6fa00138132a1361a0b85cf235/barcode/image/55d98a01-98c3-4cdd-8827-9b7ecfa0354e/7e250ef6-86f6-4881-9ed3-f6d57b030873.svg",
      "owner_id": "aa1c4eeb-a4f5-40bb-b2ec-a8a5b1098e4f",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=aa1c4eeb-a4f5-40bb-b2ec-a8a5b1098e4f&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=aa1c4eeb-a4f5-40bb-b2ec-a8a5b1098e4f&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=aa1c4eeb-a4f5-40bb-b2ec-a8a5b1098e4f&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a3beba27-0c49-4e4e-8e38-0af01e97f480' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3beba27-0c49-4e4e-8e38-0af01e97f480",
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
    "id": "a3beba27-0c49-4e4e-8e38-0af01e97f480",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-16T09:37:56+00:00",
      "updated_at": "2021-12-16T09:37:56+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a931958309ada67489132971a444d862/barcode/image/a3beba27-0c49-4e4e-8e38-0af01e97f480/844c34f7-35ba-48e3-a584-ac0910174dae.svg",
      "owner_id": "8796d554-5198-4dc8-98ae-1057926ec48a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c73efea1-790e-4c3c-bab6-09c2faacdc1a' \
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