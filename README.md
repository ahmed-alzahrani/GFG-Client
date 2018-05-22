#  Goals For Good

## What to fix:

- Email text field expands upon typing on LoggedInView
- Auth service returns to LoginViewController before the completion of the task (login/create user). Find async solution so that LogInViewController can 'know' whether AuthService was successful, this will remove AuthService's need to communicate with UPS as well as with NavigationService (to handle side effects of a successful login)

- Allow Arbitrary Loads is on to allow for straight HTTP, this is too vulnerable for Apple

- When failures occur and are logged for debugging (ie: when a user tries to create account and an account already exists) the user also needs to be notified on the UI

- getTeams() currently uses a var to count in order to return teams after asynch calls 
