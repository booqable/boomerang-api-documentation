# Price rules

A price rule contains a single pricing adjustment rule and belongs to a [PriceRuleset](#price-rulesets).

A price rule can have one of these types:

- **range_of_days**: Adjust pricing for certain days of the week, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from_day`,`till_day`,`from_time,`till_time` and `value`.
- **range_of_dates**: Adjust pricing for certain calendar days, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from`,`till` and `value`.
- **exclude_week_days**: Do not charge for certain days of the week, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from_day`,`till_day`,`from_time,`till_time`.
- **exclude_date_range**: Do not charge for certain calendar days, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from`,`till`.
- **pickup_day**: Rule determines if entire day is charged based on pickup day time, `match_strategy` must be `starts_within`, `charge` determines if day is charged when before `time` or not charged if after `time`.
- **return_day**: Rule determines if entire day is charged based on return day time, `match_strategy` must be `stops_within`, `charge` determines if day is charged when before `time` or not charged if after `time`.

and these match strategies:

- **starts_within**: Used with `pickup_day` rules
- **stops_within**: Used with `return_day` rules
- **within**: Rule is applied when the rule period fits within the order period.
- **overlap**: Rule is applied for the part of the rule period that overlaps the order period.
- **span**: Rule is applied when the rule period spans over the order period.

as well as these adjustment strategies:

- **charge**: Applies `charge` attribute to determine rule effect, either charges or doesn't charge. Used by `pickup_day` and `return_day` rules types.
- **percentage**: Applies `value` attribute to determine the percentage change to the pricing over the rule period. Used by `range_of_days`, `range_of_date` rule types.

## Relationships
Name | Description
-- | --
`price_ruleset` | **[Price ruleset](#price-rulesets)** `required`<br>The advanced pricing ruleset this rule is part of. 


Check matching attributes under [Fields](#price-rules-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`adjustment_strategy` | **enum** <br>Determines whether a price rule adjusts prices by percentage or exact cent amounts.<br> One of: `percentage`, `charge`.
`charge` | **boolean** <br>Determines effect of rules using charge attribute. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`from` | **datetime** <br>Defines start of period, used by `range_of_dates` rule type. 
`from_day` | **integer** <br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type. 
`from_time` | **string** <br>Defines start of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`id` | **uuid** `readonly`<br>Primary key.
`match_strategy` | **enum** <br>Determines how dates are matched to the rule.<br> One of: `starts_within`, `stops_within`, `overlap`, `span`, `within`.
`max_duration` | **integer** <br>Rule will only be applied when order period is smaller than max duration in seconds. 
`min_duration` | **integer** <br>Rule will only be applied when order period is greater than min duration in seconds. 
`name` | **string** <br>Name of the rule. 
`price_ruleset_id` | **uuid** `readonly-after-create`<br>Which ruleset this rule belongs to. 
`rule_type` | **enum** <br>Determines rule behaviour.<br> One of: `range_of_days`, `range_of_dates`, `exclude_date_range`, `exclude_week_days`, `pickup_day`, `return_day`.
`stacked` | **boolean** <br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules. 
`till` | **datetime** <br>Defines end of period, used by `range_of_dates` rule type. 
`till_day` | **integer** <br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type. 
`till_time` | **string** <br>Defines end of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`time` | **string** <br>Defines time for adjustment, used by `pickup_day` and `return_day` rule types. Format is a `HH:mm` string, independent of time display settings. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`value` | **float** <br>Adjustment value in percent. 


## Create a price rule


> How to create a price rule:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/price_rules'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "price_rules",
           "attributes": {
             "price_ruleset_id": "7d2b2786-70ba-41b4-82cc-05cbe8cacb34",
             "name": "Off season",
             "rule_type": "range_of_dates",
             "match_strategy": "span",
             "value": 25,
             "from": "2014-12-05T04:39:00.000000+00:00",
             "till": "2015-02-04T04:39:00.000000+00:00"
           }
         },
         "include": "price_rules"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "496355f5-1c79-4b05-86e8-fb9f00c27d78",
      "type": "price_rules",
      "attributes": {
        "created_at": "2015-01-05T04:39:00.000000+00:00",
        "updated_at": "2015-01-05T04:39:00.000000+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2014-12-05T04:39:00.000000+00:00",
        "till": "2015-02-04T04:39:00.000000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "7d2b2786-70ba-41b4-82cc-05cbe8cacb34"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/price_rules`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rules]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_ruleset`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][adjustment_strategy]` | **enum** <br>Determines whether a price rule adjusts prices by percentage or exact cent amounts.<br> One of: `percentage`, `charge`.
`data[attributes][charge]` | **boolean** <br>Determines effect of rules using charge attribute. 
`data[attributes][from]` | **datetime** <br>Defines start of period, used by `range_of_dates` rule type. 
`data[attributes][from_day]` | **integer** <br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type. 
`data[attributes][from_time]` | **string** <br>Defines start of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][match_strategy]` | **enum** <br>Determines how dates are matched to the rule.<br> One of: `starts_within`, `stops_within`, `overlap`, `span`, `within`.
`data[attributes][max_duration]` | **integer** <br>Rule will only be applied when order period is smaller than max duration in seconds. 
`data[attributes][min_duration]` | **integer** <br>Rule will only be applied when order period is greater than min duration in seconds. 
`data[attributes][name]` | **string** <br>Name of the rule. 
`data[attributes][price_ruleset_id]` | **uuid** <br>Which ruleset this rule belongs to. 
`data[attributes][rule_type]` | **enum** <br>Determines rule behaviour.<br> One of: `range_of_days`, `range_of_dates`, `exclude_date_range`, `exclude_week_days`, `pickup_day`, `return_day`.
`data[attributes][stacked]` | **boolean** <br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules. 
`data[attributes][till]` | **datetime** <br>Defines end of period, used by `range_of_dates` rule type. 
`data[attributes][till_day]` | **integer** <br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type. 
`data[attributes][till_time]` | **string** <br>Defines end of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][time]` | **string** <br>Defines time for adjustment, used by `pickup_day` and `return_day` rule types. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][value]` | **float** <br>Adjustment value in percent. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>price_ruleset</code>
    <ul>
      <li><code>price_rules</code></li>
    </ul>
  </li>
</ul>


## Update a price rule


> How to update a price rule:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/price_rules/03a98195-fad9-4128-8b3d-f8fca9458b1e'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "03a98195-fad9-4128-8b3d-f8fca9458b1e",
           "type": "price_rules",
           "attributes": {
             "value": 10
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "03a98195-fad9-4128-8b3d-f8fca9458b1e",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-06-25T00:41:07.000000+00:00",
        "updated_at": "2022-06-25T00:41:07.000000+00:00",
        "name": "Holidays",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 10.0,
        "from": "2027-11-25T15:15:07.000000+00:00",
        "till": "2028-01-25T15:15:07.000000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "8a88d3b1-8d95-45c3-8d9c-37f4189f8e18"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Updating a price rule:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/price_rules/ad06b6c5-c179-4a32-8260-11b998f79946'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "ad06b6c5-c179-4a32-8260-11b998f79946",
           "type": "price_rules",
           "attributes": {
             "id": "ad06b6c5-c179-4a32-8260-11b998f79946",
             "name": "Off season"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ad06b6c5-c179-4a32-8260-11b998f79946",
      "type": "price_rules",
      "attributes": {
        "created_at": "2020-09-12T03:59:01.000000+00:00",
        "updated_at": "2020-09-12T03:59:01.000000+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 5.0,
        "from": "2026-02-12T18:33:01.000000+00:00",
        "till": "2026-04-14T18:33:01.000000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "da082b15-8901-48df-8450-683f48eb006e"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/price_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rules]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_ruleset`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][adjustment_strategy]` | **enum** <br>Determines whether a price rule adjusts prices by percentage or exact cent amounts.<br> One of: `percentage`, `charge`.
`data[attributes][charge]` | **boolean** <br>Determines effect of rules using charge attribute. 
`data[attributes][from]` | **datetime** <br>Defines start of period, used by `range_of_dates` rule type. 
`data[attributes][from_day]` | **integer** <br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type. 
`data[attributes][from_time]` | **string** <br>Defines start of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][match_strategy]` | **enum** <br>Determines how dates are matched to the rule.<br> One of: `starts_within`, `stops_within`, `overlap`, `span`, `within`.
`data[attributes][max_duration]` | **integer** <br>Rule will only be applied when order period is smaller than max duration in seconds. 
`data[attributes][min_duration]` | **integer** <br>Rule will only be applied when order period is greater than min duration in seconds. 
`data[attributes][name]` | **string** <br>Name of the rule. 
`data[attributes][price_ruleset_id]` | **uuid** <br>Which ruleset this rule belongs to. 
`data[attributes][rule_type]` | **enum** <br>Determines rule behaviour.<br> One of: `range_of_days`, `range_of_dates`, `exclude_date_range`, `exclude_week_days`, `pickup_day`, `return_day`.
`data[attributes][stacked]` | **boolean** <br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules. 
`data[attributes][till]` | **datetime** <br>Defines end of period, used by `range_of_dates` rule type. 
`data[attributes][till_day]` | **integer** <br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type. 
`data[attributes][till_time]` | **string** <br>Defines end of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][time]` | **string** <br>Defines time for adjustment, used by `pickup_day` and `return_day` rule types. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][value]` | **float** <br>Adjustment value in percent. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>price_ruleset</code>
    <ul>
      <li><code>price_rules</code></li>
    </ul>
  </li>
</ul>


## Archive a price rule


> How to archive a price ruleset:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/price_rules/dcba05ea-7016-4ed4-8034-a823d01f4d26'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "dcba05ea-7016-4ed4-8034-a823d01f4d26",
      "type": "price_rules",
      "attributes": {
        "created_at": "2020-12-18T05:52:07.000000+00:00",
        "updated_at": "2020-12-18T05:52:07.000000+00:00",
        "name": "Holidays",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 5.0,
        "from": "2026-05-20T20:26:07.000000+00:00",
        "till": "2026-07-20T20:26:07.000000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "0f77bbbc-4358-4a67-85a9-ca319b75a498"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/price_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rules]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_ruleset`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>price_ruleset</code>
    <ul>
      <li><code>price_rules</code></li>
    </ul>
  </li>
</ul>

