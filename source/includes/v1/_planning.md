# Planning

| Field               | Type     | Description                                   |
| ------------------- | -------- | --------------------------------------------- |
| id                  | Integer  | `Readonly` Unique primary id                  |
| order_id            | Integer  | `Readonly` ID of the associated order         |
| item_id             | Integer  | ID of the associated product                  |
| quantity            | Integer  | Amount booked                                 |
| price_each_in_cents | Integer  | Price per quantity in cents                   |
| reserved            | Boolean  | Whether the planning is reserved              |
| started             | Integer  | Number of stock started                       |
| stopped             | Integer  | Number of stock stopped                       |
| charge_label        | String   | Label of the price charge                     |
| charge_length       | Integer  | Length of the price charge in seconds         |
| created_at          | DateTime | `Readonly` When the planning was created      |
| updated_at          | DateTime | `Readonly` When the planning was last updated |
