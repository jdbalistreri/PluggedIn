# Phase 2: Editing Profiles and Adding Experiences

## Rails
### Models
* Experience

### Controllers
API::ProfilesController (update)
API::ExperiencesController (create, show, update, destroy)

### Views
* profiles/show.json.jbuilder (edit existing to include experiences)

## Backbone
### Models
* Profile
* Experience

### Collections
* Experiences

### Views
* MyProfileShow (composite view, contains JobsIndex and SchoolsIndex) - specific for current user's profile
* OtherProfileShow (composite view, contains JobsIndex and SchoolsIndex) - other users profiles
* ProfileView partial for shared features between profiles?
* JobsIndex (compositve view, contains JobIndexItem views)
* SchoolsIndex (compositve view, contains SchoolIndexItem views)
* JobIndexItem (includes a hidden form to edit)
* SchoolIndexItem (includes a hidden form to edit)

## Gems/Libraries
* Gem/library for storing pictures (???)


##Notes
* Make sure that the current user may only edit his/her own profile (can either toggle the edit buttons or I can have two different views; also can have protections on the Rails side)
* Clicking edit on any property of a JobIndexItem or SchoolIndexItem will display the entire form to edit that item
* I will need to look into the best way to handle the dates -- how do I store months/years only or years only? Also, how do I say present in the database?
* Need to look into ways to handle profile pictures -- maybe save this for a later phase
