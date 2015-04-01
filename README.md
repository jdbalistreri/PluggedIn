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
###Users/Profiles
- [User model][user] hashes passwords with BCrypt and ensures a session_token on create
###Experiences
- [Experiences model][experiences] holds both job experiences and school experiences
- A users experiences are [sent down][user-jbuilder] with the user as JSON and parsed into separate Backbone collections
- Placeholder
- Placeholder

### Coming Soon!
- Notifications and dropdown menus on navigation bar
- Typeahead search bar
- Degrees of connection
- Detailed search options (e.g. location, school, etc.)
- Profile show routes use the user's username instead of id
- Tracking profile views
- Statistics on who has viewed a user profile (D3 for data visualization)

[user]: ./app/models/user.rb
[experiences]: ./app/models/experiences.rb
[user-jbuilder]: ./app/views/api/shared/_user.json.jbuilder
