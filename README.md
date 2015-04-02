# Plugged In

Plugged In is a professional networking site, similar to LinkedIn, built on Rails and Backbone.

##<a href="http://www.plugged-in.io" target="_blank">Live Link</a>

## Features

Users can:
- Create accounts and sessions (log in)
- Create profiles with personal information and add past job/school experiences
- Edit profiles in place by double clicking the text
- Request to connect with other users and view connections
- Send messages to other users
- Search for users
- Take a website tour on login or sign in with a demo account

## Implementation
###Profiles, Users, and Experiences
- Form views on profile edit in place by inheriting from [toggleable form superclass][toggleable]
- A user's experiences are [sent down][user-jbuilder] with user data as JSON and [parsed][user-parse] into separate Backbone collections
- [User model][user-model] has built in methods to generate realistic seed data

###Connections
- Connections rely on two [database tables][schema] (connections and user_connections) to cleanly implement two-way friendships
- [Connect button subview][connect-button] allows users to issue connection requests across various user views; permits options available based on a user's connection status with the current user
- [Connected users index view][connected-users-index] displays a user's approved connections while paginating results

###Messages/Search
- Navigation between [inbox][inbox-view] pages occurs using the [router][router] and a getOrFetch method to ensure data persists across hard refreshes
- [API Static Controller][search_controller] processes search query with PGSearch and paginates results with Kaminari
- Search results view uses [infinite scroll][search-results] to improve load time and UX

### Coming Soon!
- Notifications and dropdown menus on navigation bar
- Degrees of connection
- Statistics on who has viewed a user profile (D3 for data visualization)

[user-jbuilder]: ./app/views/api/users/show.json.jbuilder
[user-model]: ./app/models/user.rb
[user-parse]: ./app/assets/javascripts/models/user.js
[toggleable]: ./app/assets/javascripts/utils/toggleable_form.js
[connect-button]: ./app/assets/javascripts/views/connect_button.js
[schema]: ./db/schema.rb
[connected-users-index]: ./app/assets/javascripts/views/connected_users_index.js
[inbox-view]: ./app/assets/javascripts/views/inbox_show.js
[router]: ./app/assets/javascripts/routers/router.js
[search-results]: ./app/assets/javascripts/views/users/composite/user_search.js
[search_controller]: ./app/controllers/api/static_controller.rb
