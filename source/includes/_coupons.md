# Coupons

Create codes to discount orders by a fixed amount or a percentage. Customers can redeem the codes online at checkout. Coupons can also be added to orders.

## Endpoints
`GET /api/boomerang/coupons`

`GET /api/boomerang/coupons/{id}`

`POST /api/boomerang/coupons`

`PUT /api/boomerang/coupons/{id}`

`DELETE /api/boomerang/coupons/{id}`

## Fields
Every coupon has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether coupon is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the coupon was archived
`identifier` | **String** <br>The code that customers need to type in
`coupon_type` | **String** <br>One of `percentage`, `cents`
`value` | **Integer** <br>A percentage for type `percentage` or a value in cents for `cents`
`active` | **Boolean** <br>Whether coupon can be redeemed at the moment


## Listing coupons



> How to fetch a list of coupons:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bca0c401-3967-41db-b910-dab26861013c",
      "type": "coupons",
      "attributes": {
        "created_at": "2024-09-09T09:26:44.682176+00:00",
        "updated_at": "2024-09-09T09:26:44.682176+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "SUMMER20OFF",
        "coupon_type": "percentage",
        "value": 20,
        "active": true
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/coupons`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`coupon_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`value` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`active` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon



> How to fetch a coupon:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons/e45c456e-88a3-4c42-a2be-a579ddb6e803' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e45c456e-88a3-4c42-a2be-a579ddb6e803",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-09-09T09:26:47.554050+00:00",
      "updated_at": "2024-09-09T09:26:47.554050+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
## Creating a coupon



> How to create a coupon:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/coupons' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "coupons",
        "attributes": {
          "identifier": "WINTERDISCOUNT",
          "coupon_type": "cents",
          "value": 2000,
          "active": true
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f272483d-31da-487c-bc21-4a88323f8eb2",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-09-09T09:26:45.947406+00:00",
      "updated_at": "2024-09-09T09:26:45.947406+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "WINTERDISCOUNT",
      "coupon_type": "cents",
      "value": 2000,
      "active": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/coupons`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>The code that customers need to type in
`data[attributes][coupon_type]` | **String** <br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer** <br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean** <br>Whether coupon can be redeemed at the moment


### Includes

This request does not accept any includes
## Updating a coupon

When updating a coupon the existing one is archived and a new one gets created:


> How to update a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/6cae68d6-280d-4602-bcb2-3e5905922db7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6cae68d6-280d-4602-bcb2-3e5905922db7",
        "type": "coupons",
        "attributes": {
          "identifier": "SUMMER30OFF",
          "coupon_type": "percentage",
          "value": 30
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "06dda553-ac0a-4a92-97e8-629c008f3729",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-09-09T09:26:45.511080+00:00",
      "updated_at": "2024-09-09T09:26:45.529161+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "SUMMER30OFF",
      "coupon_type": "percentage",
      "value": 30,
      "active": false
    }
  },
  "meta": {}
}
```


> How to deativate a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/1cbe991c-8928-4a60-a28c-cc264a0a23e8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1cbe991c-8928-4a60-a28c-cc264a0a23e8",
        "type": "coupons",
        "attributes": {
          "active": false
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "32fba945-2bdb-40f0-b9d9-b738103cad3c",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-09-09T09:26:45.092443+00:00",
      "updated_at": "2024-09-09T09:26:45.112188+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>The code that customers need to type in
`data[attributes][coupon_type]` | **String** <br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer** <br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean** <br>Whether coupon can be redeemed at the moment


### Includes

This request does not accept any includes
## Archiving a coupon



> How to archive a coupon:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/coupons/b7973322-573d-474b-ba66-89be73125ba1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b7973322-573d-474b-ba66-89be73125ba1",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-09-09T09:26:48.233747+00:00",
      "updated_at": "2024-09-09T09:26:48.246765+00:00",
      "archived": true,
      "archived_at": "2024-09-09T09:26:48.246765+00:00",
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Includes

This request does not accept any includes