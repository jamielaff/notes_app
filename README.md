[![Codeship Status for jamielaff/notes_app](https://app.codeship.com/projects/08c9b010-8332-0138-e03d-5e63fbe942d1/status?branch=master)](https://app.codeship.com/projects/398229)
[![codecov](https://codecov.io/gh/jamielaff/notes_app/branch/master/graph/badge.svg)](https://codecov.io/gh/jamielaff/notes_app)
# README  

**Ruby version**  
2.7.1p83  
  
**About**  
This project includes full CI/CD with Codeship & Heroku.  
A live version of this application is available on http://jamielafferty.co.uk. 
  
**Login/Logout**  
- Sessions functionality

**CRUD Users**  
- Set the role (admin/team_member)
- Validate Users - no empty fields
- A team memer can CRUD themselves, an admin can CRUD themselves & all other users
- Users can register
- Admin users can change other user roles

**CRUD a note using AJAX**  
- When a note is added/updated/deleted then the user should receive a flash message  
- Validate the notes (no empty fields allowed)
- A team_member can create a note, then read/update/delete that note & any other notes they have created
- Admin user can also create notes, and read/update/delete their notes or any team_member notes

**Moderation**
- New notes created by any user (admin or team_member) go into a "pending" state. These pending notes are not visible on the home page. Only admins can approve these pending notes, which will then be shown on the main home page
- To achieve this, I have added 2 scopes to the notes model: active and pending
- The home page display all notes in an active state, while the pending page displays all notes in a pending state

**Test suite**
- Some feature specs have JS enabled (notes & users) as these have AJAX validation
- The model specs are for unit testing specific functionality
- I have included request specs to test the security of the application
- These tests cover the happy & sad paths of user journeys, along with testing the security aspect of the app in general
- While I do not have 100% coverage, I have green-lighted the main flows through the app.
