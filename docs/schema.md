# Schema Information

# Phase 1

## profiles
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
user_id         | integer   | not null, unique, foreign_key
name            | string    | not null
profile_picture | ??????    |
location        | string    |
tagline         | string    |
industry        | string    |
date_of_birth   | date      |
summary         | text      |

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, unique
password_digest | string    | not null
session_token   | string    | not null, unique


# Phase 2

## experiences
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
user_id         | integer   | not null, unique, foreign_key
position        | string    | not null
experience_type | integer   | not null (enum)
institution     | string    |
location        | string    |
description     | text      |
start_date      | date      | how to store present?
end_date        | date      | how to store present?
degree          | string    |
field_of_study  | string    |


# Phase 3

## connections
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
connector_id    | integer   | not null, foreign_key
connectee_id    | integer   | not null, foreign_key
status          | integer   | not null, (enum)
sent_date       | date      | not null
response_date   | date      |
message         | text      | --optional--
connection_type | integer   | --optional--(enum)

## user_connections
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
user_id         | integer   | not null, foreign_key
connection_id   | integer   | not null, foreign_key


# Phase 4

## messages
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
sender_id       | integer   | not null, foreign_key
receiver_id     | integer   | not null, foreign_key
sent_date       | date      | not null
subject         | string    | not null
body            | text      | not null
reply_to_id     | integer   |

## user_messages
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
user_id         | integer   | not null, foreign_key
message_id      | integer   | not null, foreign_key
