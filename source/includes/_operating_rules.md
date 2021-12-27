# Operating rules

Operating rules allow creating various rules for changing how a user can select dates in the online webshop. The rules are only enabled when the applicable setting is enabled.

**There's 4 types of rules currently available and the type of rule is determined by the `data_type` attribute:**

  - `hours` Sets opening hours key in data determines what days these hours apply to, data must have this format `{ weekday: { from: 'HH:mm', till: 'HH:mm' } }`, days without applicable opening hours are considered closed. Settting that enables this type of rule: `store.use_business_hours`
  - `away` Sets away mode disabling overlapping days in the period picker, data must have a `from` and `till` with dates: { away: { from: 'YYYY-MM-DD', till: 'YYYY-MM-DD' } }. Settting that enables this type of rule: `store.use_away_mode`
  - `timeslot_fixed` Sets a fixed timeslot, used when datepicker is in fixed time slots mode. Same format as hours: `{ weekday: { from: 'HH:mm', till: 'HH:mm' } }` Picker mode setting for this rule: `store.period_type` set to `timeslot_fixed`
  - `timeslot_duration` Sets a duration timeslot, used when datepicker is in fixed durations mode. Data must include length in seconds: `{ length: 86000 }` Picker mode setting for this rule: `store.period_type` set to `timeslot_duration`

## Endpoints
`GET /api/boomerang/operating_rules`

`POST /api/boomerang/operating_rules`

`PUT /api/boomerang/operating_rules/{id}`

`DELETE /api/boomerang/operating_rules/{id}`

## Fields
Every operating rule has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`data_type` | **String_enum**<br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration`
`data` | **Hash**<br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`


## Listing operating rules



> How to fetch a list of operating rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/operating_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2a42ed2c-6b13-4955-be21-c12dcd859523",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2021-12-27T12:58:25+00:00",
        "updated_at": "2021-12-27T12:58:25+00:00",
        "data_type": "away",
        "data": {
          "away": {
            "from": "2020-01-01",
            "till": "2021-12-31"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/operating_rules?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/operating_rules?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/operating_rules?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/operating_rules`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-27T12:57:04Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`data_type` | **String_enum**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Creating an operating rule



> How to create an operating rule:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/operating_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "operating_rules",
        "attributes": {
          "data_type": "hours",
          "data": {
            "mon": {
              "from": "09:00",
              "till": "17:00"
            }
          }
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "710666c6-975e-4b60-b77b-33c8652329dc",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2021-12-27T12:58:25+00:00",
      "updated_at": "2021-12-27T12:58:25+00:00",
      "data_type": "hours",
      "data": {
        "mon": {
          "from": "09:00",
          "till": "17:00"
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata_type%5D=hours&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=hours&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata_type%5D=hours&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=hours&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata_type%5D=hours&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bmon%5D%5Btill%5D=17%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=hours&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to set opening hours:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/operating_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "operating_rules",
        "attributes": {
          "data_type": "hours",
          "data": {
            "weekday": {
              "from": "09:00",
              "till": "17:00"
            }
          }
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1c7664f3-9545-4d8a-8e83-759ece928937",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2021-12-27T12:58:25+00:00",
      "updated_at": "2021-12-27T12:58:25+00:00",
      "data_type": "hours",
      "data": {
        "weekday": {
          "from": "09:00",
          "till": "17:00"
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata_type%5D=hours&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Btill%5D=17%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=hours&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata_type%5D=hours&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Btill%5D=17%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=hours&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Btill%5D=17%3A00&data%5Battributes%5D%5Bdata_type%5D=hours&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekday%5D%5Btill%5D=17%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=hours&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to set away mode:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/operating_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "operating_rules",
        "attributes": {
          "data_type": "away",
          "data": {
            "away": {
              "from": "2030-01-01",
              "till": "2040-01-01"
            }
          }
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "44f18fdd-df74-43ea-a67e-d04288316032",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2021-12-27T12:58:26+00:00",
      "updated_at": "2021-12-27T12:58:26+00:00",
      "data_type": "away",
      "data": {
        "away": {
          "from": "2030-01-01",
          "till": "2040-01-01"
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Baway%5D%5Bfrom%5D=2030-01-01&data%5Battributes%5D%5Bdata%5D%5Baway%5D%5Btill%5D=2040-01-01&data%5Battributes%5D%5Bdata_type%5D=away&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Baway%5D%5Bfrom%5D=2030-01-01&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Baway%5D%5Btill%5D=2040-01-01&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=away&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Baway%5D%5Bfrom%5D=2030-01-01&data%5Battributes%5D%5Bdata%5D%5Baway%5D%5Btill%5D=2040-01-01&data%5Battributes%5D%5Bdata_type%5D=away&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Baway%5D%5Bfrom%5D=2030-01-01&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Baway%5D%5Btill%5D=2040-01-01&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=away&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Baway%5D%5Bfrom%5D=2030-01-01&data%5Battributes%5D%5Bdata%5D%5Baway%5D%5Btill%5D=2040-01-01&data%5Battributes%5D%5Bdata_type%5D=away&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Baway%5D%5Bfrom%5D=2030-01-01&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Baway%5D%5Btill%5D=2040-01-01&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=away&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to set a fixed timeslot:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/operating_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "operating_rules",
        "attributes": {
          "data_type": "timeslot_fixed",
          "data": {
            "weekend": {
              "from": "09:00",
              "till": "12:00"
            }
          }
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "58bb200e-fdca-4df8-b0d7-c079164bd07c",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2021-12-27T12:58:26+00:00",
      "updated_at": "2021-12-27T12:58:26+00:00",
      "data_type": "timeslot_fixed",
      "data": {
        "weekend": {
          "from": "09:00",
          "till": "12:00"
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Btill%5D=12%3A00&data%5Battributes%5D%5Bdata_type%5D=timeslot_fixed&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Btill%5D=12%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=timeslot_fixed&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Btill%5D=12%3A00&data%5Battributes%5D%5Bdata_type%5D=timeslot_fixed&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Btill%5D=12%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=timeslot_fixed&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Bfrom%5D=09%3A00&data%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Btill%5D=12%3A00&data%5Battributes%5D%5Bdata_type%5D=timeslot_fixed&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Bfrom%5D=09%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Bweekend%5D%5Btill%5D=12%3A00&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=timeslot_fixed&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to set a duration timeslot:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/operating_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "operating_rules",
        "attributes": {
          "data_type": "timeslot_duration",
          "data": {
            "length": 86000
          }
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ec177f45-708a-4c16-b37e-d02917353182",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2021-12-27T12:58:26+00:00",
      "updated_at": "2021-12-27T12:58:26+00:00",
      "data_type": "timeslot_duration",
      "data": {
        "length": 86000
      }
    }
  },
  "links": {
    "self": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Blength%5D=86000&data%5Battributes%5D%5Bdata_type%5D=timeslot_duration&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Blength%5D=86000&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=timeslot_duration&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Blength%5D=86000&data%5Battributes%5D%5Bdata_type%5D=timeslot_duration&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Blength%5D=86000&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=timeslot_duration&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/operating_rules?data%5Battributes%5D%5Bdata%5D%5Blength%5D=86000&data%5Battributes%5D%5Bdata_type%5D=timeslot_duration&data%5Btype%5D=operating_rules&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata%5D%5Blength%5D=86000&operating_rule%5Bdata%5D%5Battributes%5D%5Bdata_type%5D=timeslot_duration&operating_rule%5Bdata%5D%5Btype%5D=operating_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/operating_rules`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][data_type]` | **String_enum**<br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration`
`data[attributes][data]` | **Hash**<br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`


### Includes

This request does not accept any includes
## Updating an operating rule



> How to update an operating rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/operating_rules/1ad1ab31-cbbe-40d6-b6fd-744c935e6b7b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1ad1ab31-cbbe-40d6-b6fd-744c935e6b7b",
        "type": "operating_rules",
        "attributes": {
          "data": {
            "away": {
              "from": "2020-04-01",
              "till": "2021-12-31"
            }
          }
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1ad1ab31-cbbe-40d6-b6fd-744c935e6b7b",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2021-12-27T12:58:26+00:00",
      "updated_at": "2021-12-27T12:58:27+00:00",
      "data_type": "away",
      "data": {
        "away": {
          "from": "2020-04-01",
          "till": "2021-12-31"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/operating_rules/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][data_type]` | **String_enum**<br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration`
`data[attributes][data]` | **Hash**<br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`


### Includes

This request does not accept any includes
## Deleting an operating rule



> How to delete an operating rule:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/operating_rules/711f203f-fe72-4b01-8851-02012d629a4e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/operating_rules/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`


### Includes

This request does not accept any includes