# Notes/Questions


## Database Design Links
http://www.databaseanswers.org/data_models/social_networking/index.htm
http://stackoverflow.com/questions/3550093/how-to-represent-symmetric-many-to-many-relationship


## Overall Questions
* Messages and connection requests are somewhat similar and are both going to be displayed in the sent view in the inbox. Do I want to make them in the same database or the same collection?

## Overall Notes
* I want to minimize the total number of views/types of pages - I would rather have compact, well-designed stuff all available on the same page

## To research
* Best way to handle the dates for my experiences table as well as my forms to input dates
* How do I handle/store profile pictures?

## Rails Design
* Phase 2: Should I make one controller for experiences and one collection for experiences? I could then make a jobs method and a schools method that would divide the two up. I believe it would be best to have an Experiences collection that has all of the experiences for a user and then use different views to show either schools or jobs


## CSS Design
* Can either choose between profiles where the profile summary box (which includes picture) spans the entire width of the content section or a version where it only takes up the left side, allowing the sidebar to go all the way up to the top
