# Schema Information


## connections
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, unique
password_digest | string    | not null
session_token   | string    | not null, unique

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
start_date      | date      |
end_date        | date      |

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
