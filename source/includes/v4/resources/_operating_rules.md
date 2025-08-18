# Operating rules

Operating rules control which dates and times a customer can select
in the online store, or an employee in the back office.

Each type of rule has a corresponding setting that must be enabled
before the rules of that type are enforced.

## Types of rules

  - `hours` Sets opening hours. The key in data determines what days these hours apply to,
    data must have this format `{ weekday: { from: 'HH:mm', till: 'HH:mm' } }`,
    days without applicable opening hours are considered closed.
    Setting that enables this type of rule: `store.use_business_hours`.

  - `away` Sets away mode disabling overlapping days in the period picker,
    data must have a `from` and `till` with dates: { away: { from: 'YYYY-MM-DD', till: 'YYYY-MM-DD' } }.
    Setting that enables this type of rule: `store.use_away_mode`.

  - `timeslot_fixed` Sets a fixed timeslot, used when datepicker is in fixed time slots mode.
    Same format as hours: `{ weekday: { from: 'HH:mm', till: 'HH:mm' } }`.
    Picker mode setting for this rule: `store.period_type` set to `timeslot_fixed`.

  - `timeslot_duration` Sets a duration timeslot, used when datepicker is in fixed durations mode.
    Data must include length in seconds: `{ length: 86000 }`.
    Picker mode setting for this rule: `store.period_type` set to `timeslot_duration`.

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`data` | **hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`. 
`data_type` | **enum** <br>Determines where the rule is applied.<br> One of: `hours`, `away`, `timeslot_fixed`, `timeslot_duration`.
`id` | **uuid** `readonly`<br>Primary key.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List operating rules


> How to fetch a list of operating rules:

```shell
  curl --get 'https://example.booqable.com/api/4/operating_rules'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b24d4c09-7108-4fa8-8b48-04e8c1b4bc70",
        "type": "operating_rules",
        "attributes": {
          "created_at": "2021-05-16T15:36:00.000000+00:00",
          "updated_at": "2021-05-16T15:36:00.000000+00:00",
          "data_type": "away",
          "data": {
            "away": {
              "from": "01-01-2020",
              "till": "31-12-2021"
            }
          }
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/operating_rules`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operating_rules]=created_at,updated_at,data_type`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`data_type` | **enum** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Create an operating rule


> How to create an operating rule:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/operating_rules'
       --header 'content-type: application/json'
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
      "id": "3439c032-c0be-4e8f-82e6-c12f4d221492",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2022-11-08T22:09:00.000000+00:00",
        "updated_at": "2022-11-08T22:09:00.000000+00:00",
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
  curl --request POST
       --url 'https://example.booqable.com/api/4/operating_rules'
       --header 'content-type: application/json'
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
      "id": "84a4b222-411e-4eaa-8011-1f682dc30fe6",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2023-11-07T16:56:00.000000+00:00",
        "updated_at": "2023-11-07T16:56:00.000000+00:00",
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
  curl --request POST
       --url 'https://example.booqable.com/api/4/operating_rules'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "operating_rules",
           "attributes": {
             "data_type": "away",
             "data": {
               "away": {
                 "from": "2030-03-28",
                 "till": "2040-03-27"
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
      "id": "d554671a-cc91-4548-86cc-fb71c5e484a8",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2025-11-12T10:44:00.000000+00:00",
        "updated_at": "2025-11-12T10:44:00.000000+00:00",
        "data_type": "away",
        "data": {
          "away": {
            "from": "2030-03-28",
            "till": "2040-03-27"
          }
        }
      }
    },
    "meta": {}
  }
```

> How to set a fixed timeslot:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/operating_rules'
       --header 'content-type: application/json'
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
      "id": "cca6ca90-dc02-4ca1-83d0-9975b3ac3462",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2020-07-28T10:07:01.000000+00:00",
        "updated_at": "2020-07-28T10:07:01.000000+00:00",
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
  curl --request POST
       --url 'https://example.booqable.com/api/4/operating_rules'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "operating_rules",
           "attributes": {
             "data_type": "timeslot_duration",
             "data": {
               "duration": 1,
               "period": "week"
             }
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "d027bb89-1ddf-44ee-8a54-65861366dd04",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2022-03-08T14:51:01.000000+00:00",
        "updated_at": "2022-03-08T14:51:01.000000+00:00",
        "data_type": "timeslot_duration",
        "data": {
          "duration": 1,
          "period": "week"
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/operating_rules`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operating_rules]=created_at,updated_at,data_type`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][data]` | **hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`. 
`data[attributes][data_type]` | **enum** <br>Determines where the rule is applied.<br> One of: `hours`, `away`, `timeslot_fixed`, `timeslot_duration`.


### Includes

This request does not accept any includes
## Update an operating rule


> How to update an operating rule:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/operating_rules/89ad3c36-9f82-4c85-88aa-a39bf3289d46'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "89ad3c36-9f82-4c85-88aa-a39bf3289d46",
           "type": "operating_rules",
           "attributes": {
             "data": {
               "away": {
                 "from": "2011-04-22",
                 "till": "2013-01-20"
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
      "id": "89ad3c36-9f82-4c85-88aa-a39bf3289d46",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2016-09-07T17:09:02.000000+00:00",
        "updated_at": "2016-09-07T17:09:02.000000+00:00",
        "data_type": "away",
        "data": {
          "away": {
            "from": "2011-04-22",
            "till": "2013-01-20"
          }
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/operating_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operating_rules]=created_at,updated_at,data_type`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][data]` | **hash** <br>Content of the rule, can have keys `weekday`, `weekend`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `sun`, `all` when `data_type` is `timeslot_fixed` or `hours` or `away` when `data_type` is `away` and `length` (for duration in seconds) when `data_type` is `timeslot_duration`. 
`data[attributes][data_type]` | **enum** <br>Determines where the rule is applied.<br> One of: `hours`, `away`, `timeslot_fixed`, `timeslot_duration`.


### Includes

This request does not accept any includes
## Delete an operating rule


> How to delete an operating rule:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/operating_rules/32f66c8c-d911-43ce-8dd6-bda4a82b795f'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "32f66c8c-d911-43ce-8dd6-bda4a82b795f",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2015-03-16T16:21:03.000000+00:00",
        "updated_at": "2015-03-16T16:21:03.000000+00:00",
        "data_type": "away",
        "data": {
          "away": {
            "from": "01-01-2020",
            "till": "31-12-2021"
          }
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/operating_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operating_rules]=created_at,updated_at,data_type`


### Includes

This request does not accept any includes