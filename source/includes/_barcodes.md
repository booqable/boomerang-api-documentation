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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
-- | --
`owner` | **Customer, Product, Order, Stock item** <br>Associated Owner


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
      "id": "4f8e6b27-91e0-4de5-909e-e27d1ac8ae5d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-14T09:24:03.260694+00:00",
        "updated_at": "2024-10-14T09:24:03.260694+00:00",
        "number": "http://bqbl.it/4f8e6b27-91e0-4de5-909e-e27d1ac8ae5d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-61.lvh.me:/barcodes/4f8e6b27-91e0-4de5-909e-e27d1ac8ae5d/image",
        "owner_id": "a843e81b-5c35-4b72-a7c3-ece1fc117373",
        "owner_type": "customers"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff45b0066-29ec-40cf-81ec-6bc158325df2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f45b0066-29ec-40cf-81ec-6bc158325df2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-14T09:24:03.712625+00:00",
        "updated_at": "2024-10-14T09:24:03.712625+00:00",
        "number": "http://bqbl.it/f45b0066-29ec-40cf-81ec-6bc158325df2",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-62.lvh.me:/barcodes/f45b0066-29ec-40cf-81ec-6bc158325df2/image",
        "owner_id": "0071c29e-bdc0-43a6-8169-599bb05f6dbf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "0071c29e-bdc0-43a6-8169-599bb05f6dbf"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0071c29e-bdc0-43a6-8169-599bb05f6dbf",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-14T09:24:03.674651+00:00",
        "updated_at": "2024-10-14T09:24:03.714339+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-28@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmRjY2M4YWUtNDEwNi00OTliLWI5MzEtODE2OTU2YjZmNDQ3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bdccc8ae-4106-499b-b931-816956b6f447",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-14T09:24:02.726337+00:00",
        "updated_at": "2024-10-14T09:24:02.726337+00:00",
        "number": "http://bqbl.it/bdccc8ae-4106-499b-b931-816956b6f447",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-60.lvh.me:/barcodes/bdccc8ae-4106-499b-b931-816956b6f447/image",
        "owner_id": "f5f93c56-7e64-49ee-9886-037498f41658",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "f5f93c56-7e64-49ee-9886-037498f41658"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f5f93c56-7e64-49ee-9886-037498f41658",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-14T09:24:02.694188+00:00",
        "updated_at": "2024-10-14T09:24:02.727721+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-26@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/c62ec6d2-ce91-40b1-844c-545dd623aaa4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c62ec6d2-ce91-40b1-844c-545dd623aaa4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-14T09:24:00.413573+00:00",
      "updated_at": "2024-10-14T09:24:00.413573+00:00",
      "number": "http://bqbl.it/c62ec6d2-ce91-40b1-844c-545dd623aaa4",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-57.lvh.me:/barcodes/c62ec6d2-ce91-40b1-844c-545dd623aaa4/image",
      "owner_id": "649a1897-f312-48d4-be7d-e4a4005494a5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "649a1897-f312-48d4-be7d-e4a4005494a5"
        }
      }
    }
  },
  "included": [
    {
      "id": "649a1897-f312-48d4-be7d-e4a4005494a5",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-14T09:24:00.376638+00:00",
        "updated_at": "2024-10-14T09:24:00.415268+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-22@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










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
          "owner_id": "0cd2b1c2-da0d-49ba-91d5-d0efe79de59a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "516375e6-985c-48fa-b449-4b4bbb96fa7a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-14T09:23:59.915884+00:00",
      "updated_at": "2024-10-14T09:23:59.915884+00:00",
      "number": "http://bqbl.it/516375e6-985c-48fa-b449-4b4bbb96fa7a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-56.lvh.me:/barcodes/516375e6-985c-48fa-b449-4b4bbb96fa7a/image",
      "owner_id": "0cd2b1c2-da0d-49ba-91d5-d0efe79de59a",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/d44e117a-6851-4f9a-85dd-9fd4ad3bcb0a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d44e117a-6851-4f9a-85dd-9fd4ad3bcb0a",
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
    "id": "d44e117a-6851-4f9a-85dd-9fd4ad3bcb0a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-14T09:24:01.171957+00:00",
      "updated_at": "2024-10-14T09:24:01.233397+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-58.lvh.me:/barcodes/d44e117a-6851-4f9a-85dd-9fd4ad3bcb0a/image",
      "owner_id": "45f66ad2-c2d6-4880-80af-c03708c071a7",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/76ca6015-490e-4ff9-97ed-137af344b0f2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "76ca6015-490e-4ff9-97ed-137af344b0f2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-14T09:24:01.978671+00:00",
      "updated_at": "2024-10-14T09:24:01.978671+00:00",
      "number": "http://bqbl.it/76ca6015-490e-4ff9-97ed-137af344b0f2",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-59.lvh.me:/barcodes/76ca6015-490e-4ff9-97ed-137af344b0f2/image",
      "owner_id": "5301d07e-a336-4b10-9358-f0ea64c52e0a",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`









