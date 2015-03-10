# Phase 2: Editing Profiles and Adding Experiences

## Rails
### Models
* Experience

### Controllers
* API::Users (update)
* API::ExperiencesController (create, update, destroy)

### Views
* profiles/show.json.jbuilder (update existing file)

## Backbone
### Models
* User
* Job
* School

### Collections
* Jobs
* Schools

### Views
* UserShow
* JobsIndex (compositve view, contains JobIndexItem views)
* SchoolsIndex (compositve view, contains SchoolIndexItem views)
* JobIndexItem (includes a hidden form to edit)
* SchoolIndexItem (includes a hidden form to edit)

## Gems/Libraries


##Notes
* Decided to keep experiences in the same table in the database. Will now split into separate collections upon parsing the User data
* Make sure that the current user may only edit his/her own profile -- I did this on both the server and client sides
* Clicking edit on any property of a JobIndexItem or SchoolIndexItem will display the entire form to edit that item
* We'll be covering how to add pictures tomorrow
