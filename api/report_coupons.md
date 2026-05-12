# Report coupons

Report on how coupons are performing.

<aside class="notice">
  Availability of this report depends on the current pricing plan.
</aside>

## Fields

 Name | Description
-- | --
`active` | **boolean** `readonly`<br>Whether the coupon is active.
`coupon_id` | **uuid** `readonly`<br>The ID of the coupon.
`coupon_type` | **string** `readonly`<br>The type of discount the coupon applies.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`ends_at` | **datetime** `readonly`<br>End date for redeeming the coupon.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly`<br>The coupon code identifier.
`max_redemptions` | **integer** `readonly`<br>The maximum number of times the coupon can be redeemed.
`redemption_count` | **integer** `readonly`<br>The number of times the coupon has been redeemed.
`tag_list` | **array[string]** `readonly`<br>List of tags for this coupon.
`total_discount_in_cents` | **integer** `readonly`<br>Total discount applied across all redemptions, in cents.


## List performance for coupons


> How to fetch performance for coupons:

```shell
  curl --get 'https://example.booqable.com/api/4/report_coupons'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "700515c2-a34b-45e5-884f-a4cd150ee18e",
        "type": "report_coupons",
        "attributes": {
          "created_at": "2017-08-13T10:01:00.000000+00:00",
          "coupon_id": "700515c2-a34b-45e5-884f-a4cd150ee18e",
          "identifier": "COUPON-1",
          "coupon_type": "percentage",
          "active": true,
          "max_redemptions": null,
          "tag_list": [],
          "redemption_count": 1,
          "total_discount_in_cents": 1000,
          "ends_at": null
        }
      }
    ],
    "meta": {}
  }
```

> How to request coupon report metrics:

```shell
  curl --get 'https://example.booqable.com/api/4/report_coupons'
       --header 'content-type: application/json'
       --data-urlencode 'stats[active_coupons][]=count'
       --data-urlencode 'stats[redemption_count][]=sum'
       --data-urlencode 'stats[total][]=count'
       --data-urlencode 'stats[total_discount_in_cents][]=sum'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "77e6510d-0a63-4ec8-8b80-4e4b9f41f50c",
        "type": "report_coupons",
        "attributes": {
          "created_at": "2027-04-13T22:02:04.000000+00:00",
          "coupon_id": "77e6510d-0a63-4ec8-8b80-4e4b9f41f50c",
          "identifier": "COUPON-4",
          "coupon_type": "percentage",
          "active": true,
          "max_redemptions": null,
          "tag_list": [],
          "redemption_count": 0,
          "total_discount_in_cents": 0,
          "ends_at": "2027-04-13T12:01:04.000000+00:00"
        }
      },
      {
        "id": "ba61133d-68c6-4d97-8f13-91606298783f",
        "type": "report_coupons",
        "attributes": {
          "created_at": "2027-04-13T22:02:04.000000+00:00",
          "coupon_id": "ba61133d-68c6-4d97-8f13-91606298783f",
          "identifier": "COUPON-3",
          "coupon_type": "percentage",
          "active": false,
          "max_redemptions": null,
          "tag_list": [],
          "redemption_count": 0,
          "total_discount_in_cents": 0,
          "ends_at": null
        }
      },
      {
        "id": "bcd6ccc1-c7c4-4f7d-813e-9c776a849a37",
        "type": "report_coupons",
        "attributes": {
          "created_at": "2027-04-13T22:02:04.000000+00:00",
          "coupon_id": "bcd6ccc1-c7c4-4f7d-813e-9c776a849a37",
          "identifier": "COUPON-2",
          "coupon_type": "percentage",
          "active": true,
          "max_redemptions": null,
          "tag_list": [],
          "redemption_count": 2,
          "total_discount_in_cents": 1500,
          "ends_at": null
        }
      }
    ],
    "meta": {
      "stats": {
        "active_coupons": {
          "count": 1
        },
        "redemption_count": {
          "sum": 2
        },
        "total": {
          "count": 3
        },
        "total_discount_in_cents": {
          "sum": 1500
        }
      }
    }
  }
```

### HTTP Request

`GET /api/4/report_coupons`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[report_coupons]=created_at,coupon_id,identifier`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`period_from` | **datetime** <br>`eq`
`period_till` | **datetime** <br>`eq`
`q` | **string** <br>`eq`
`status` | **string** <br>`eq`
`tags` | **array** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`active_coupons` | **array** <br>`count`
`expired_coupons` | **array** <br>`count`
`inactive_coupons` | **array** <br>`count`
`redemption_count` | **array** <br>`sum`
`tags` | **array** <br>`count`
`total` | **array** <br>`count`
`total_discount_in_cents` | **array** <br>`sum`


### Includes

This request does not accept any includes