# Phase 5: Searching for Blogs and Posts

## Rails
### Models
* User (add a search class method)

### Controllers
* Api::UsersController (search)

### Views
* users/search.json.jbuilder

## Backbone
### Models
* User

### Collections
* Users

### Views
* SearchResults (compositve view with a UsersIndex view on it)
* UsersIndex view will contain a users collection and will have UserListItem subviews
* UserListItem (subview of UsersIndex with a link to the user's ProfileShow view)

## Gems/Libraries
