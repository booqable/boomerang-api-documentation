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
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "80e7068e-b5f8-47f4-bfff-7425cba8c0ce",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-01T09:26:07.154512+00:00",
        "updated_at": "2024-07-01T09:26:07.154512+00:00",
        "number": "http://bqbl.it/80e7068e-b5f8-47f4-bfff-7425cba8c0ce",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-105.lvh.me:/barcodes/80e7068e-b5f8-47f4-bfff-7425cba8c0ce/image",
        "owner_id": "99986c72-9ff0-4db4-8766-d7a592f3277b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff4f0cd12-4978-4ceb-bcc1-38b422fc0196&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f4f0cd12-4978-4ceb-bcc1-38b422fc0196",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-01T09:26:05.628239+00:00",
        "updated_at": "2024-07-01T09:26:05.628239+00:00",
        "number": "http://bqbl.it/f4f0cd12-4978-4ceb-bcc1-38b422fc0196",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-103.lvh.me:/barcodes/f4f0cd12-4978-4ceb-bcc1-38b422fc0196/image",
        "owner_id": "da23bc0a-5668-4574-ba05-95d582c55142",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "da23bc0a-5668-4574-ba05-95d582c55142"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "da23bc0a-5668-4574-ba05-95d582c55142",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-01T09:26:05.579720+00:00",
        "updated_at": "2024-07-01T09:26:05.631075+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-46@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGVlMjkwNDktZmYxZi00ODY0LWI1NDQtNjE4ZDNlZWY1ZmNl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8ee29049-ff1f-4864-b544-618d3eef5fce",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-01T09:26:06.464269+00:00",
        "updated_at": "2024-07-01T09:26:06.464269+00:00",
        "number": "http://bqbl.it/8ee29049-ff1f-4864-b544-618d3eef5fce",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-104.lvh.me:/barcodes/8ee29049-ff1f-4864-b544-618d3eef5fce/image",
        "owner_id": "7e1041fe-1f10-440f-85bc-b0353c1526ff",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "7e1041fe-1f10-440f-85bc-b0353c1526ff"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7e1041fe-1f10-440f-85bc-b0353c1526ff",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-01T09:26:06.415491+00:00",
        "updated_at": "2024-07-01T09:26:06.466681+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-48@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/54fb64ca-34ff-4f3f-ba16-6ac577f633a3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "54fb64ca-34ff-4f3f-ba16-6ac577f633a3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-01T09:26:10.493657+00:00",
      "updated_at": "2024-07-01T09:26:10.493657+00:00",
      "number": "http://bqbl.it/54fb64ca-34ff-4f3f-ba16-6ac577f633a3",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-109.lvh.me:/barcodes/54fb64ca-34ff-4f3f-ba16-6ac577f633a3/image",
      "owner_id": "77b1631b-3035-436b-b35e-a84f2f64e124",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "77b1631b-3035-436b-b35e-a84f2f64e124"
        }
      }
    }
  },
  "included": [
    {
      "id": "77b1631b-3035-436b-b35e-a84f2f64e124",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-01T09:26:10.417573+00:00",
        "updated_at": "2024-07-01T09:26:10.497382+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-54@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
          "owner_id": "3ce60639-324f-4ad1-bd1a-ca4bcf571f38",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a6c669bb-db48-49ca-8b60-ae41990333d7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-01T09:26:08.943592+00:00",
      "updated_at": "2024-07-01T09:26:08.943592+00:00",
      "number": "http://bqbl.it/a6c669bb-db48-49ca-8b60-ae41990333d7",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-107.lvh.me:/barcodes/a6c669bb-db48-49ca-8b60-ae41990333d7/image",
      "owner_id": "3ce60639-324f-4ad1-bd1a-ca4bcf571f38",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a30939e7-1b75-4e83-a74d-2130dd4283f0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a30939e7-1b75-4e83-a74d-2130dd4283f0",
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
    "id": "a30939e7-1b75-4e83-a74d-2130dd4283f0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-01T09:26:08.070371+00:00",
      "updated_at": "2024-07-01T09:26:08.158864+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-106.lvh.me:/barcodes/a30939e7-1b75-4e83-a74d-2130dd4283f0/image",
      "owner_id": "adebe5e2-6f80-47eb-851f-9784a4b2d174",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9503d8f8-a53c-4393-9ab9-bdce393c4395' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9503d8f8-a53c-4393-9ab9-bdce393c4395",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-01T09:26:09.688480+00:00",
      "updated_at": "2024-07-01T09:26:09.688480+00:00",
      "number": "http://bqbl.it/9503d8f8-a53c-4393-9ab9-bdce393c4395",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-108.lvh.me:/barcodes/9503d8f8-a53c-4393-9ab9-bdce393c4395/image",
      "owner_id": "c4e93740-51f7-4c83-ab10-4b2cfd6e5034",
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









