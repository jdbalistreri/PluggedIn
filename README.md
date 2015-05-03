# Plugged In

Plugged In is a professional networking site built in Rails and Backbone
#####<a href="http://www.plugged-in.io" target="_blank">Live Link</a>

### Challenge Overview
#####Problem:
Implement the core functionality of a professional networking site (e.g. LinkedIn)
#####Solution:
Full stack solution uses a RESTful Rails API that delivers JSON to Backbone front­end (feature and implementation detail below)

### Features
- Create accounts and sessions (log in)
- Create profiles with personal information and add past job/school experiences
- Edit profiles in place by double clicking the text
- Request to connect with other users and view connections
- Send messages to other users
- Search for users
- Take a website tour on login or sign in with a demo account

### Implementation
#### Profiles, Users, and Experiences
- Form views on profile edit in place by inheriting from [toggleable form superclass][toggleable]
- A user's experiences are [sent down][user-jbuilder] with user data as JSON and [parsed][user-parse] into separate Backbone collections
- [User model][user-model] has built in methods to generate realistic seed data

#### Connections
- Connections rely on two [database tables][schema] (connections and user_connections) to cleanly implement two-way friendships
- [Connect button subview][connect-button] allows users to issue connection requests across various user views; permits options available based on a user's connection status with the current user
- [Connected users index view][connected-users-index] displays a user's approved connections while paginating results

#### Messages/Search
- Navigation between [inbox][inbox-view] pages occurs using the [router][router] and a getOrFetch method to ensure data persists across hard refreshes
- [API Static Controller][search_controller] processes search query with PGSearch and paginates results with Kaminari
- Search results view uses [infinite scroll][search-results] to improve load time and UX

###Test Coverage
- **Model tests:** initial coverage complete
- **Controller tests:** initial coverage complete
- **Integration tests:** *pending*
- **JavaScript tests:** *pending*

### Technical Choices
The features implemented in this project where chosen to replicate the core experience of using a professional networking site. These features centered around the experience of creating a profile and connecting with other users (e.g. connections, search, messaging, profiles). Features that did not demonstrate a unique programming skill set or whose presence would not significantly add to the experience of using the website were excluded in this version of the project.
- For example, company pages were not implemented because their architecture would have largely duplicated that of user profiles
- Additionally, email verification was not implemented because it would detract from the UX of a website primarily built for demonstration purposes

However, additional features whose absence might not be immediately noticed would need to be added to complete a production-grade app. Those include more expansive test coverage, email verification/notifications, profile privacy and user settings, notifications, flashes, and multiple login.

## Build

#### First steps
- Download/clone repository locally
- Open the terminal in the project directory
- Run `bundle install`

#### To host locally:
- Run `rails s` in the terminal
-Navigate to http://localhost:3000/ in your browser

#### To run tests:
- Run `bundle exec rspec` in the terminal to run model and controller tests

##About the Developer
I am an NYC-based web developer with experience in Rails and JavaScript. After graduating from Dartmouth in 2013, I worked as an analytic strategy consultant. During that time I began teaching myself to code and ultimately decided to pursue programming full time.

#### Online Presence
- [Personal website][personal]
- [Resume][resume]
- [LinkedIn][linkedin]
- [Tumblr][tumblr]

#### Other Projects
- Chess in Ruby [github][chess]
- Asteroids in JS and Canvas [live][asteroids] [github][asteroids-github]

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
[chess]: https://github.com/jdbalistreri/Chess
[personal]: http://www.joebalistreri.net/
[resume]: https://drive.google.com/file/d/13_K04Uy3gyKyTTF1SK_sSRadxEHW1FTFuaZciw9Km2R4_3po9riI8oF7-JSSapEUziy_19doEK5oo_K2/view
[tumblr]: http://jdbalistreri.tumblr.com/
[linkedin]: https://www.linkedin.com/in/jdbalistreri
[asteroids]: http://www.joebalistreri.net/AsteroidsJS/
[asteroids-github]: https://github.com/jdbalistreri/AsteroidsJS
