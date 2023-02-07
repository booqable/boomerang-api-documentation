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
- | -
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
      "id": "25366670-f902-488c-8392-d0b0683f789f",
      "type": "coupons",
      "attributes": {
        "created_at": "2023-02-07T09:27:11+00:00",
        "updated_at": "2023-02-07T09:27:11+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T09:26:33Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon



> How to fetch a coupon:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons/4ff81ce2-7414-4d17-a519-f5a88adddb71' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4ff81ce2-7414-4d17-a519-f5a88adddb71",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-07T09:27:11+00:00",
      "updated_at": "2023-02-07T09:27:11+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


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
    "id": "d59d9e92-a0cd-4cc4-9eab-d93ece7004f1",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-07T09:27:11+00:00",
      "updated_at": "2023-02-07T09:27:11+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/coupons/b923fd15-1bcd-4cec-a715-ce31d1f0cea3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b923fd15-1bcd-4cec-a715-ce31d1f0cea3",
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
    "id": "0ee32908-9e06-4417-8547-b8addce8d73b",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-07T09:27:12+00:00",
      "updated_at": "2023-02-07T09:27:12+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/coupons/2d43a434-fbf8-4607-a97d-233da6f22678' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d43a434-fbf8-4607-a97d-233da6f22678",
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
    "id": "ff3af674-f667-46fe-b67e-2af9860eddb8",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-07T09:27:13+00:00",
      "updated_at": "2023-02-07T09:27:13+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/coupons/aa56083e-bebc-4c09-be53-381a72bf5650' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Includes

This request does not accept any includes