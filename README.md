# ExtinctIn

[Heroku link][heroku]

[heroku]: #fillthisin

## Current To Do
- [ ] Add pagination and search to the connections box
- [ ] Add number of connections to the user's show page
- [ ] Add a connect button to the users index item view
- [ ] Improve inbox view for connections to show the user


## Minimum Viable Product
ExtinctIn is a clone of LinkedIn built on Rails and Backbone. Users can:

- [x] Create accounts
- [x] Create sessions (log in)
- [x] Create user profiles with personal information
- [x] User profiles contain past job/school experiences
- [x] Users can edit their profile in place by double clicking the text
- [x] Request to connect with other users
- [ ] Send messages to other users
- [ ] Search for users

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: User Authentication, Profile Creation (~1 day)
I will implement user authentication in Rails based on the practices learned at
App Academy. By the end of this phase, users will be able to create an account using
a simple text form in a Rails view. The most important part of this phase will
be pushing the app to Heroku and ensuring that everything works before moving on
to phase 2.

[Details][phase-one]

### Phase 2: Profile Detail and Experiences (~1-2 days)
I will add API routes to serve user and experiences data as JSON, then add Backbone
models and collections that fetch data from these routes. By the end of this
phase, users will be able to edit and update their profile information in place, all
inside a single Backbone app. They will also be able to create, edit, and delete job/education experiences.

[Details][phase-two]

### Phase 3: Connections (~2 days)
I plan to add API routes to create, update, and delete connections. I will also add a route to show a current user's index of connections. I will use a connections table to keep track of each connection and a user_connections join table to keep track of each user's relation to a connection.

On the Backbone side, I will add request connections buttons to user profiles. I will also add a ConnectionsIndex view that will allow a user to see and sort their connections. Finally, I will add an Inbox view that will house the PendingConnectionsIndex subview. The Inbox view will later be used to house messages as well.

[Details][phase-three]

### Phase 4: Messages (~1-2 days)
I will add Rails API routes (create, index, show) for messages. Rails routes should be able to return either sent messages or received messages for a given user.

On the Backbone side, I will add ReceivedMessages and SentMessages views inside the Inbox composite view. Each of these views will be a composite of MessageListItem views, each of which will link to a MessageShow view.

Finally, there will be multiple links (either reply or on a user's profile page) to the MessageForm view, that will allow a user to create a new message.

[Details][phase-four]

### Phase 5: Searching for Users (~1-2 days)
I'll need to add a `search` route to the Users controller. On the Backbone side, there will be a `SearchResults` view that has a `UsersIndex`. This view will use a Users collection and will fetch from the search route. It will contain many UserListItem subviews, each linking to a given user's profile.

[Details][phase-five]

### Bonus Features
- [ ] Notifications and dropdown menus on navigation bar
- [ ] Typeahead search bar
- [ ] Degrees of connection
- [ ] Detailed search options (e.g. location, school, etc.)
- [ ] Side bar with other people's profiles (based on being viewed by similar people)
- [ ] Profile show routes use the user's username instead of id
- [ ] Tracking profile views
- [ ] Statistics on who has viewed your profile (3rd party library for graphics)

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md
