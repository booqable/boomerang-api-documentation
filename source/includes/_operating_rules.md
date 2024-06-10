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
-- | --
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
      "id": "827d94ef-33cc-4204-9c2a-d96c893a89ff",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-06-10T09:24:36.588352+00:00",
        "updated_at": "2024-06-10T09:24:36.588352+00:00",
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=created_at,updated_at,data_type`
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
`data_type` | **String_enum** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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
    "id": "826879c0-2e43-4c77-a601-c682c432651f",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:38.630454+00:00",
      "updated_at": "2024-06-10T09:24:38.630454+00:00",
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
    "id": "cf8ea361-eb3f-4b15-a031-0c60ba3f29d9",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:39.297504+00:00",
      "updated_at": "2024-06-10T09:24:39.297504+00:00",
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
    "id": "5b0e1983-70f3-4ad6-953e-205aaed8ce84",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:40.004882+00:00",
      "updated_at": "2024-06-10T09:24:40.004882+00:00",
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
    "id": "2756719f-35f9-44af-84d6-d943c7aa214b",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:38.041407+00:00",
      "updated_at": "2024-06-10T09:24:38.041407+00:00",
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
    "id": "2ccc26f8-b497-45e4-9b0e-dc901cf01f55",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:37.310073+00:00",
      "updated_at": "2024-06-10T09:24:37.310073+00:00",
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=created_at,updated_at,data_type`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][data_type]` | **String_enum** <br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration` 
`data[attributes][data]` | **Hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`' 


### Includes

This request does not accept any includes
## Updating an operating rule



> How to update an operating rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/operating_rules/0d80ac0a-bf92-431f-b0fd-d971bed90697' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0d80ac0a-bf92-431f-b0fd-d971bed90697",
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
    "id": "0d80ac0a-bf92-431f-b0fd-d971bed90697",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:35.358093+00:00",
      "updated_at": "2024-06-10T09:24:35.402424+00:00",
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=created_at,updated_at,data_type`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][data_type]` | **String_enum** <br>Determines where the rule is applied. One of `hours`, `away`, `timeslot_fixed`, `timeslot_duration` 
`data[attributes][data]` | **Hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`' 


### Includes

This request does not accept any includes
## Deleting an operating rule



> How to delete an operating rule:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/operating_rules/523a22df-9c05-4ada-91ea-9daf874b91d9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "523a22df-9c05-4ada-91ea-9daf874b91d9",
    "type": "operating_rules",
    "attributes": {
      "created_at": "2024-06-10T09:24:35.970379+00:00",
      "updated_at": "2024-06-10T09:24:35.970379+00:00",
      "data_type": "away",
      "data": {
        "away": {
          "from": "2020-01-01",
          "till": "2021-12-31"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/operating_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operating_rules]=created_at,updated_at,data_type`


### Includes

This request does not accept any includes