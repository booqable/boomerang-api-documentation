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
      "id": "fc579f41-1b55-44be-927b-30e764bab7c1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-23T09:23:28.986095+00:00",
        "updated_at": "2024-09-23T09:23:28.986095+00:00",
        "number": "http://bqbl.it/fc579f41-1b55-44be-927b-30e764bab7c1",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-72.lvh.me:/barcodes/fc579f41-1b55-44be-927b-30e764bab7c1/image",
        "owner_id": "da0bd16c-141b-4f0b-8f4a-06185fec0243",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffa43e1bd-25dc-4e8e-9c69-9db22434f30f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fa43e1bd-25dc-4e8e-9c69-9db22434f30f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-23T09:23:29.474097+00:00",
        "updated_at": "2024-09-23T09:23:29.474097+00:00",
        "number": "http://bqbl.it/fa43e1bd-25dc-4e8e-9c69-9db22434f30f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-73.lvh.me:/barcodes/fa43e1bd-25dc-4e8e-9c69-9db22434f30f/image",
        "owner_id": "36d316e1-bf0a-4d68-b59f-c9694200b14f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "36d316e1-bf0a-4d68-b59f-c9694200b14f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "36d316e1-bf0a-4d68-b59f-c9694200b14f",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-23T09:23:29.432881+00:00",
        "updated_at": "2024-09-23T09:23:29.475719+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-27@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTk2NzM1YTUtMTVlNy00YTgzLWFmNzgtZWU3ZDFhZDcxNzY3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e96735a5-15e7-4a83-af78-ee7d1ad71767",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-23T09:23:30.125822+00:00",
        "updated_at": "2024-09-23T09:23:30.125822+00:00",
        "number": "http://bqbl.it/e96735a5-15e7-4a83-af78-ee7d1ad71767",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-74.lvh.me:/barcodes/e96735a5-15e7-4a83-af78-ee7d1ad71767/image",
        "owner_id": "52d5288f-2302-4413-9d34-c825e9dbe7d3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "52d5288f-2302-4413-9d34-c825e9dbe7d3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "52d5288f-2302-4413-9d34-c825e9dbe7d3",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-23T09:23:30.086212+00:00",
        "updated_at": "2024-09-23T09:23:30.127334+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-29@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/693469e8-1655-46e6-b3cb-91931916e262?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "693469e8-1655-46e6-b3cb-91931916e262",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-23T09:23:28.564998+00:00",
      "updated_at": "2024-09-23T09:23:28.564998+00:00",
      "number": "http://bqbl.it/693469e8-1655-46e6-b3cb-91931916e262",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-71.lvh.me:/barcodes/693469e8-1655-46e6-b3cb-91931916e262/image",
      "owner_id": "70cdbf59-9d75-4879-acf5-e054ddca151f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "70cdbf59-9d75-4879-acf5-e054ddca151f"
        }
      }
    }
  },
  "included": [
    {
      "id": "70cdbf59-9d75-4879-acf5-e054ddca151f",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-23T09:23:28.524610+00:00",
        "updated_at": "2024-09-23T09:23:28.566691+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-25@doe.test",
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
          "owner_id": "79cdb5ae-59c2-465f-8903-512b706f95ac",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "256a581b-69ca-4198-a341-b0bd9fad8a34",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-23T09:23:31.938080+00:00",
      "updated_at": "2024-09-23T09:23:31.938080+00:00",
      "number": "http://bqbl.it/256a581b-69ca-4198-a341-b0bd9fad8a34",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-77.lvh.me:/barcodes/256a581b-69ca-4198-a341-b0bd9fad8a34/image",
      "owner_id": "79cdb5ae-59c2-465f-8903-512b706f95ac",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f3d03549-2f0f-444a-ad79-7a46ba6f9db4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3d03549-2f0f-444a-ad79-7a46ba6f9db4",
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
    "id": "f3d03549-2f0f-444a-ad79-7a46ba6f9db4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-23T09:23:30.662633+00:00",
      "updated_at": "2024-09-23T09:23:30.731780+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-75.lvh.me:/barcodes/f3d03549-2f0f-444a-ad79-7a46ba6f9db4/image",
      "owner_id": "6f797d72-a77a-4ff8-afe2-44fe4e288cc5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8195c45d-5626-4a18-8041-a8c380b03544' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8195c45d-5626-4a18-8041-a8c380b03544",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-23T09:23:31.260295+00:00",
      "updated_at": "2024-09-23T09:23:31.260295+00:00",
      "number": "http://bqbl.it/8195c45d-5626-4a18-8041-a8c380b03544",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-76.lvh.me:/barcodes/8195c45d-5626-4a18-8041-a8c380b03544/image",
      "owner_id": "f41838fc-a486-4758-bf93-c9f1d35c9938",
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









