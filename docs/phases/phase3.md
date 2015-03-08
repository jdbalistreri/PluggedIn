# Phase 3: Connections

## Rails
### Models
* Connections
* UserConnections

### Controllers
* Connections (create, update, destroy, index) -- do i need a show?

### Views
* connections/index.json.jbuilder (this will probably need to include profile information for each user)


## Backbone
### Models
* Connection

### Collections
* Connections

### Views
--- New View: Approved Connections Index---
* ConnectionsIndex (composite view, contains UserShow views) - you can link to this from the navigation bar or from a user's profile summary
* UserShow (will be the same view as used for search results)

--- New View: Inbox (composite view) ---
* Link to this view will be in the navigation bar
* PendingConnectionsIndex will be a subview of Inbox, it will show connection requests the user has received and allow them to approve those connections
* PendingConnectionItem will be a subview of PendingConnectionsIndex, allowing the connection to be approved/denied
* SentIndex will be a subview of Inbox showing a list of connection requests a user has sent (this will later contain sent messages as well)

--- Old View: Profile Show ---
* ConnectionButton (displayed on user profiles for now)
* Number of total connections with link to connections index for that user

## Gems/Libraries



## Notes
* Add buttons to request connections to profile pages
* I may not want to include a message or a connection type in my connection request -- it might be better to have connections fired off by a button on the page only without a separate "new connection" view
* I will not add a Connections view on the profile show page, yet -- this may be a bonus feature
