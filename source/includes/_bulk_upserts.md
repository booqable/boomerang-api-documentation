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
    "id": "8138d5db-a0a0-5734-a9be-d65d735faa0a",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "3f8a5f22-f131-4b33-9e1c-8dbec68f7988"
          },
          {
            "type": "operating_rules",
            "id": "8943676f-2f49-4450-90aa-e4a19372bf12"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3f8a5f22-f131-4b33-9e1c-8dbec68f7988",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2021-12-16T09:37:57+00:00",
        "updated_at": "2021-12-16T09:37:57+00:00",
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
      "id": "8943676f-2f49-4450-90aa-e4a19372bf12",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2021-12-16T09:37:57+00:00",
        "updated_at": "2021-12-16T09:37:57+00:00",
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
              "default_property_id": "b9365b97-5a97-489e-9e3c-fa64d6f0e82e"
            },
            {
              "name": "Delivery address",
              "default_property_id": "102dbaa8-a192-41ad-807a-8823e9079bae"
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
    "id": "8138d5db-a0a0-5734-a9be-d65d735faa0a",
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
    "self": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bulk_upserts?bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&bulk_upsert%5Bdata%5D%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&bulk_upsert%5Bdata%5D%5Battributes%5D%5Btype%5D=checkout_fields&bulk_upsert%5Bdata%5D%5Binclude%5D=results&bulk_upsert%5Bdata%5D%5Btype%5D=bulk_upserts&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=b9365b97-5a97-489e-9e3c-fa64d6f0e82e&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bname%5D=Delivery+address&data%5Battributes%5D%5Bdata%5D%5B%5D%5Bdefault_property_id%5D=102dbaa8-a192-41ad-807a-8823e9079bae&data%5Battributes%5D%5Btype%5D=checkout_fields&data%5Binclude%5D=results&data%5Btype%5D=bulk_upserts&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
    "id": "8138d5db-a0a0-5734-a9be-d65d735faa0a",
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





