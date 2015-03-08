# Phase 4: User Feeds

## Rails
### Models
* Message

### Controllers
API::Messages (create, index, show)

### Views

## Backbone
### Models
* Message

### Collections
* Messages

### Views
* ReceivedMessages (composite view in the Inbox view, has many MessageListItems)
* SentMessages (composite view - may need to merge with sent connection requests)
* MessageListItem
* MessageShow
* MessageForm

* --- Old Views: OtherProfileShow ---
* Add a button to send a message to the user (this will replace the "Connect" button if you are connected with the user)

## Gems/Libraries



##Notes
* Not sure if "reply" is a crucial feature or just nice to have
