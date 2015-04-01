# Plugged In

Plugged In is a professional networking site, similar to LinkedIn, built on Rails and Backbone.

##<a href="http://www.plugged-in.io" target="_blank">Live Link</a>

## Features

Users can:
- Create accounts
- Create sessions (log in)
- Create user profiles with personal information
- Add past job/school experiences to their profiles
- Edit their profiles in place by double clicking the text
- Request to connect with other users
- Send messages to other users
- Search for users
- Tour for new users and demo user account

## Implementation
###Profiles, Users, and Experiences
- Profile forms views edit in place by inheriting from [toggleable form superclass][toggleable]
- A users experiences are [sent down][user-jbuilder] with the user as JSON and [parsed][user-parse] into separate Backbone collections
- [User model][user-model] has built in methods to generate realistic seed data

###Connections
- Connections rely on two [database tables][schema] (connections and user_connections) to cleanly implement two-way friendships
- [Connect button subview][connect-button] allows users to issue connection requests across various user views; updates available options based on a user's connection status with the current user

###Messages

###Search

### Coming Soon!
- Notifications and dropdown menus on navigation bar
- Typeahead search bar
- Degrees of connection
- Detailed search options (e.g. location, school, etc.)
- Profile show routes use the user's username instead of id
- Tracking profile views
- Statistics on who has viewed a user profile (D3 for data visualization)

[user-jbuilder]: ./app/views/api/users/show.json.jbuilder
[user-jbuilder]: ./app/models/user.rb
[user-parse]: ./app/assets/javascripts/models/user.js
[toggleable]: ./app/assets/javascripts/utils/toggleable_form.js
[connect-button]: ./app/assets/javascripts/views/connect_button.js
[schema]: ./db/schema.rb
