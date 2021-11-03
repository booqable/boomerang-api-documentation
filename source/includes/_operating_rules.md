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
      "id": "b91c8fc7-5ba9-41ab-9ae8-504836d35700",
      "data_type": "away",
      "data": {
        "away": {
          "from": "2020-01-01",
          "till": "2021-12-31"
        }
      }
    }
  ]
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-03T12:57:36Z`
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
    "id": "3d0ea37a-9333-4b37-bc5d-9f2d24071fa1",
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
    "id": "d0b81fde-0317-4f31-a834-5b77e662c66c",
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
    "id": "38f5f2e9-41a4-4478-b648-3660b137b295",
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
    "id": "d05e1847-29ff-40b2-8d4a-b00fb7bd3937",
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
    "id": "77f2111b-ddbd-42fd-a231-d979bdc6a999",
    "type": "operating_rules",
    "attributes": {
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
    --url 'https://example.booqable.com/api/boomerang/operating_rules/0636285f-ebe9-48a0-b047-43199f2578ad' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0636285f-ebe9-48a0-b047-43199f2578ad",
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
    "id": "0636285f-ebe9-48a0-b047-43199f2578ad",
    "type": "operating_rules",
    "attributes": {
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
    --url 'https://example.booqable.com/api/boomerang/operating_rules/1c9bd84c-f7e2-4aa9-ab08-b19b7436c8ec' \
    --header 'content-type: application/json' \
    --data '{}'
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