# Coupons

Create codes to discount orders by a fixed amount or a percentage. Customers can redeem the codes online at checkout. Coupons can also be added to orders.

## Endpoints
`PUT /api/boomerang/coupons/{id}`

`DELETE /api/boomerang/coupons/{id}`

`POST /api/boomerang/coupons`

`GET /api/boomerang/coupons`

`GET /api/boomerang/coupons/{id}`

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


## Updating a coupon

When updating a coupon the existing one is archived and a new one gets created:


> How to deativate a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/208daafc-08d2-4c7d-b7d9-b6829578f873' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "208daafc-08d2-4c7d-b7d9-b6829578f873",
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
    "id": "32156523-a015-41ce-b48c-343cb9feb5fe",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-05-13T09:29:45+00:00",
      "updated_at": "2024-05-13T09:29:46+00:00",
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


> How to update a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/f9eece82-f9f2-4aec-9435-8ca1372cf910' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f9eece82-f9f2-4aec-9435-8ca1372cf910",
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
    "id": "92c07181-926f-4c69-8e53-d4285c513b49",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-05-13T09:29:46+00:00",
      "updated_at": "2024-05-13T09:29:46+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/coupons/73556ef3-a133-4c77-8623-a2be4f46db48' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "73556ef3-a133-4c77-8623-a2be4f46db48",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-05-13T09:29:47+00:00",
      "updated_at": "2024-05-13T09:29:47+00:00",
      "archived": true,
      "archived_at": "2024-05-13T09:29:47+00:00",
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
    "id": "bbd985da-b953-4ef8-9750-9250deead8f6",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-05-13T09:29:48+00:00",
      "updated_at": "2024-05-13T09:29:48+00:00",
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
      "id": "a5194afe-8d58-4357-9010-f6c7616e3cb6",
      "type": "coupons",
      "attributes": {
        "created_at": "2024-05-13T09:29:49+00:00",
        "updated_at": "2024-05-13T09:29:49+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/coupons/4992da94-98be-493e-b21f-af3bf6938454' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4992da94-98be-493e-b21f-af3bf6938454",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-05-13T09:29:50+00:00",
      "updated_at": "2024-05-13T09:29:50+00:00",
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