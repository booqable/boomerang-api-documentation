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
`data_type` | **String_enum** <br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration` 
`data` | **Hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`' 


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
      "id": "0d5cfc18-0cc9-428c-b6e4-58afd40fd77e",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2023-03-09T13:50:19+00:00",
        "updated_at": "2023-03-09T13:50:19+00:00",
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
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/operating_rules`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T13:48:17Z`
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
`data_type` | **String_enum** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


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
    "id": "5c8bcd6a-d755-4401-91b4-58a089dd4df0",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2023-03-09T13:50:20+00:00",
      "updated_at": "2023-03-09T13:50:20+00:00",
      "data_type": "hours",
      "data": {
        "mon": {
          "from": "09:00",
          "till": "17:00"
        }
      }
    }
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
    "id": "b0882846-cf3e-4648-aff2-4347ed8c2973",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2023-03-09T13:50:20+00:00",
      "updated_at": "2023-03-09T13:50:20+00:00",
      "data_type": "hours",
      "data": {
        "weekday": {
          "from": "09:00",
          "till": "17:00"
        }
      }
    }
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
    "id": "6454671a-6556-4e8f-9785-1fde4c60d55b",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2023-03-09T13:50:21+00:00",
      "updated_at": "2023-03-09T13:50:21+00:00",
      "data_type": "away",
      "data": {
        "away": {
          "from": "2030-01-01",
          "till": "2040-01-01"
        }
      }
    }
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
    "id": "082288e2-5940-4a7d-8e59-f1708359a4f6",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2023-03-09T13:50:21+00:00",
      "updated_at": "2023-03-09T13:50:21+00:00",
      "data_type": "timeslot_fixed",
      "data": {
        "weekend": {
          "from": "09:00",
          "till": "12:00"
        }
      }
    }
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
    "id": "df40e13b-31d6-46c9-90e2-93bf2c1c117b",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2023-03-09T13:50:22+00:00",
      "updated_at": "2023-03-09T13:50:22+00:00",
      "data_type": "timeslot_duration",
      "data": {
        "length": 86000
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/operating_rules`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][data_type]` | **String_enum** <br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration` 
`data[attributes][data]` | **Hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`' 


### Includes

This request does not accept any includes
## Updating an operating rule



> How to update an operating rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/operating_rules/8e5f0834-1a99-4e42-956f-004b2377e9af' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8e5f0834-1a99-4e42-956f-004b2377e9af",
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
    "id": "8e5f0834-1a99-4e42-956f-004b2377e9af",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2023-03-09T13:50:23+00:00",
      "updated_at": "2023-03-09T13:50:23+00:00",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][data_type]` | **String_enum** <br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration` 
`data[attributes][data]` | **Hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`' 


### Includes

This request does not accept any includes
## Deleting an operating rule



> How to delete an operating rule:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/operating_rules/e3d7a074-ff11-4f0d-a9db-ace0f93fbdfe' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=id,created_at,updated_at`


### Includes

This request does not accept any includes