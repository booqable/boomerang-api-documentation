# Coupons

Create codes to discount orders by a fixed amount or a percentage. Customers can redeem the codes online at checkout.

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
`identifier` | **String**<br>The code that customers need to type in
`coupon_type` | **String**<br>One of `percentage`, `cents`
`value` | **Integer**<br>A percentage for type `percentage` or a value in cents for `cents`
`active` | **Boolean**<br>Whether coupon is currently active
`archived` | **Boolean** `readonly`<br>Whether coupon is archived


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
      "id": "da828ff5-36db-4a11-aa77-5e953e35ed3a",
      "type": "coupons",
      "attributes": {
        "created_at": "2021-10-07T12:18:17+00:00",
        "updated_at": "2021-10-07T12:18:17+00:00",
        "identifier": "SUMMER20OFF",
        "coupon_type": "percentage",
        "value": 20,
        "active": true,
        "archived": false
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/coupons`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-07T12:18:15Z`
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
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`coupon_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`value` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`active` | **Boolean**<br>`eq`
`archived` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon

> How to fetch a coupon:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons/7d8973a2-d39d-40cc-beb0-bd4864e488a5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d8973a2-d39d-40cc-beb0-bd4864e488a5",
    "type": "coupons",
    "attributes": {
      "created_at": "2021-10-07T12:18:18+00:00",
      "updated_at": "2021-10-07T12:18:18+00:00",
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": true,
      "archived": false
    }
  },
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/coupons/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


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
    "id": "4161a3fc-4567-4d84-bb46-ac79c063608a",
    "type": "coupons",
    "attributes": {
      "created_at": "2021-10-07T12:18:18+00:00",
      "updated_at": "2021-10-07T12:18:18+00:00",
      "identifier": "WINTERDISCOUNT",
      "coupon_type": "cents",
      "value": 2000,
      "active": true,
      "archived": false
    }
  },
  "meta": {}
}
```


### HTTP Request

`POST /api/boomerang/coupons`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String**<br>The code that customers need to type in
`data[attributes][coupon_type]` | **String**<br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer**<br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean**<br>Whether coupon is currently active


### Includes

This request does not accept any includes
## Updating a coupon

> How to update a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/1b38dc75-1e8b-4751-bcba-3ee819fe57e1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1b38dc75-1e8b-4751-bcba-3ee819fe57e1",
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
    "id": "1b38dc75-1e8b-4751-bcba-3ee819fe57e1",
    "type": "coupons",
    "attributes": {
      "created_at": "2021-10-07T12:18:19+00:00",
      "updated_at": "2021-10-07T12:18:19+00:00",
      "identifier": "SUMMER30OFF",
      "coupon_type": "percentage",
      "value": 30,
      "active": true,
      "archived": true
    }
  },
  "meta": {}
}
```


> How to deativate a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/c80c9556-15d1-469f-97ea-35a3a18b1791' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c80c9556-15d1-469f-97ea-35a3a18b1791",
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
    "id": "c80c9556-15d1-469f-97ea-35a3a18b1791",
    "type": "coupons",
    "attributes": {
      "created_at": "2021-10-07T12:18:20+00:00",
      "updated_at": "2021-10-07T12:18:20+00:00",
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": false,
      "archived": true
    }
  },
  "meta": {}
}
```

When updating a coupon the existing one is archived and a new one gets created:

### HTTP Request

`PUT /api/boomerang/coupons/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String**<br>The code that customers need to type in
`data[attributes][coupon_type]` | **String**<br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer**<br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean**<br>Whether coupon is currently active


### Includes

This request does not accept any includes
## Archiving a coupon

> How to archive a coupon:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/coupons/6afd9098-5177-469a-a387-5d3b698f77b6' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Includes

This request does not accept any includes