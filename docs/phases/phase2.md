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
* ProfileShow (composite view, contains JobsIndex and SchoolsIndex)
* JobsIndex (compositve view, contains JobShow)

## Gems/Libraries
