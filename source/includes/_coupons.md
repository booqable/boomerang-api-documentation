# Coupons

Create codes to discount orders by a fixed amount or a percentage.
Customers can redeem the codes online at checkout. Coupons can also be added to orders in the backoffice.

<aside class="notice">
  Availability of the coupons feature depends on the current pricing plan.
</aside>

## Fields

 Name | Description
-- | --
`active` | **boolean** <br>Whether coupon can be redeemed at the moment.
`archived` | **boolean** `readonly`<br>Whether coupon is archived.
`archived_at` | **datetime** `readonly` `nullable`<br>When the coupon was archived.
`coupon_type` | **string** <br>How the discount is calculated.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>The code that customers need to type in.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`value` | **integer** <br>A percentage for type `percentage` or a value in cents for `cents`.


## Listing coupons


> How to fetch a list of coupons:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/coupons'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "631bea2b-3cb8-4bbd-819d-7cb0257b110e",
        "type": "coupons",
        "attributes": {
          "created_at": "2021-07-21T18:25:00.000000+00:00",
          "updated_at": "2021-07-21T18:25:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`active` | **boolean** <br>`eq`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`value` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon


> How to fetch a coupon:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/coupons/2a057098-ccb5-4179-800a-0d295431eaa3'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2a057098-ccb5-4179-800a-0d295431eaa3",
      "type": "coupons",
      "attributes": {
        "created_at": "2026-09-19T23:57:00.000000+00:00",
        "updated_at": "2026-09-19T23:57:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
## Creating a coupon


> How to create a coupon:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/coupons'
       --header 'content-type: application/json'
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
      "id": "e2ba40bf-54f7-422e-844e-5d36bacd5bfa",
      "type": "coupons",
      "attributes": {
        "created_at": "2020-12-12T20:49:00.000000+00:00",
        "updated_at": "2020-12-12T20:49:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][active]` | **boolean** <br>Whether coupon can be redeemed at the moment.
`data[attributes][coupon_type]` | **string** <br>How the discount is calculated.
`data[attributes][identifier]` | **string** <br>The code that customers need to type in.
`data[attributes][value]` | **integer** <br>A percentage for type `percentage` or a value in cents for `cents`.


### Includes

This request does not accept any includes
## Updating a coupon

When updating a coupon the existing one is archived and a new one gets created:

> How to update a coupon:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/coupons/90aa7e25-800f-4f23-84c2-1f077eaea4dd'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "90aa7e25-800f-4f23-84c2-1f077eaea4dd",
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
      "id": "f3f44405-c4fe-424e-8fe4-bfdfe6a7f761",
      "type": "coupons",
      "attributes": {
        "created_at": "2021-03-12T23:40:01.000000+00:00",
        "updated_at": "2021-03-12T23:40:01.000000+00:00",
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
       --url 'https://example.booqable.com/api/boomerang/coupons/65932103-4890-471f-8735-ec479064aa87'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "65932103-4890-471f-8735-ec479064aa87",
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
      "id": "3f4b1251-8ce2-48c0-8a32-006aa7e5c0a8",
      "type": "coupons",
      "attributes": {
        "created_at": "2021-02-10T20:58:01.000000+00:00",
        "updated_at": "2021-02-10T20:58:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][active]` | **boolean** <br>Whether coupon can be redeemed at the moment.
`data[attributes][coupon_type]` | **string** <br>How the discount is calculated.
`data[attributes][identifier]` | **string** <br>The code that customers need to type in.
`data[attributes][value]` | **integer** <br>A percentage for type `percentage` or a value in cents for `cents`.


### Includes

This request does not accept any includes
## Archiving a coupon


> How to archive a coupon:

```shell
  curl --request DELETE \
       --url 'https://example.booqable.com/api/boomerang/coupons/48f7032a-1017-4616-82e3-be69134a1685'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "48f7032a-1017-4616-82e3-be69134a1685",
      "type": "coupons",
      "attributes": {
        "created_at": "2015-09-09T21:54:00.000000+00:00",
        "updated_at": "2015-09-09T21:54:00.000000+00:00",
        "archived": true,
        "archived_at": "2015-09-09T21:54:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Includes

This request does not accept any includes