# Bulk upserts

Bulk upserts are for creating one or more entries of a model with one request, supports these types: `coupons`, `operating_rules`, `checkout_fields`

## Fields
Every bulk upsert has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **String** `writeonly`<br>Type of data being submitted. One of `coupons`, `operating_rules`, `checkout_fields`
`data` | **Array** `writeonly`<br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


## Relationships
Bulk upserts have the following relationships:

Name | Description
- | -
`results` | **Virtuals** `readonly`<br>Associated Results


## Creating a bulk upsert



> How to create operating rules in bulk:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bulk_upserts' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bulk_upserts",
        "attributes": {
          "type": "operating_rules",
          "data": [
            {
              "data": {
                "mon": {
                  "from": "09:00",
                  "till": "13:00"
                }
              },
              "data_type": "hours"
            },
            {
              "data": {
                "mon": {
                  "from": "15:00",
                  "till": "17:00"
                }
              },
              "data_type": "hours"
            }
          ]
        }
      },
      "include": "results"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "068532da-2edb-534f-a3fc-0e85ce704eaa",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "3ec387cc-3130-428a-a7cf-cb558b36f1c2"
          },
          {
            "type": "operating_rules",
            "id": "1d41561c-9273-4fac-9578-314c110963f5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3ec387cc-3130-428a-a7cf-cb558b36f1c2",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2021-12-02T16:47:27+00:00",
        "updated_at": "2021-12-02T16:47:27+00:00",
        "data_type": "hours",
        "data": {
          "mon": {
            "from": "09:00",
            "till": "13:00"
          }
        }
      }
    },
    {
      "id": "1d41561c-9273-4fac-9578-314c110963f5",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2021-12-02T16:47:27+00:00",
        "updated_at": "2021-12-02T16:47:27+00:00",
        "data_type": "hours",
        "data": {
          "mon": {
            "from": "15:00",
            "till": "17:00"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=operating_rules&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&bulk_upsert%5Binclude%5D=results&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Btype%5D=operating_rules&data%5Btype%5D=bulk_upserts&include=results&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=operating_rules&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&bulk_upsert%5Binclude%5D=results&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Btype%5D=operating_rules&data%5Btype%5D=bulk_upserts&include=results&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=operating_rules&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&bulk_upsert%5Binclude%5D=results&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Btype%5D=operating_rules&data%5Btype%5D=bulk_upserts&include=results&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=operating_rules&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&bulk_upsert%5Binclude%5D=results&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=13%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=15%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdata_type%5D=hours&data%5Battributes%5D%5Btype%5D=operating_rules&data%5Btype%5D=bulk_upserts&include=results&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to create checkout fields in bulk:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bulk_upserts' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bulk_upserts",
        "attributes": {
          "type": "checkout_fields",
          "data": [
            {
              "default_property_id": "98145ed1-1c06-432d-8d52-0227dcd5a900"
            },
            {
              "name": "Delivery address",
              "default_property_id": "41472c04-0746-4287-b761-5aa225b08fee"
            }
          ]
        },
        "include": "results"
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "068532da-2edb-534f-a3fc-0e85ce704eaa",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=98145ed1-1c06-432d-8d52-0227dcd5a900&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=41472c04-0746-4287-b761-5aa225b08fee&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to create coupons in bulk:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bulk_upserts' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bulk_upserts",
        "attributes": {
          "type": "coupons",
          "data": [
            {
              "identifier": "off",
              "coupon_type": "percentage",
              "value": 25,
              "active": true
            },
            {
              "identifier": "summer-22",
              "coupon_type": "cents",
              "value": 2200
            }
          ]
        },
        "include": "results"
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a19855a6-1e9e-50c6-b1f3-4ca51320686f",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=coupons&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&data%5Battributes%5D%5Btype%5D=coupons&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=coupons&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&data%5Battributes%5D%5Btype%5D=coupons&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=coupons&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&data%5Battributes%5D%5Btype%5D=coupons&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=coupons&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=off&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=percentage&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bactive%5D=true&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bidentifier%5D=summer-22&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bvalue%5D=2200&data%5Battributes%5D%5Btype%5D=coupons&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bulk_upserts`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=results`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bulk_upserts]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **String**<br>Type of data being submitted. One of `coupons`, `operating_rules`, `checkout_fields`
`data[attributes][data][]` | **Array**<br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


### Includes

This request accepts the following includes:

`results`





