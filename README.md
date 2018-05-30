#  Goals For Good

### Purpose

This iOS application is to serve as a client in conjunction with the GFG-Webapp in order to facilitate charitable donations from users based on real world soccer results.

### Responsibilites

1. To provide a UI for users to register/login, browse different players to add/remove to their list, and browse different charitable causes they may wish to assign their donations to.

2. To query the GFG-Webapp for detailed player/charity information as the UI requires, and work with the resulting JSON

3. To send requests to the Web App when a user needs to make CRUD operations on themselves in the user DB, including account creation, editing their subscription list etc.

4. When a goal has been scored that is relevant to the user, the client will be responsible for sending a notification to the owner of the account on their phone

### Change-log

__25/05/18__

- minor linter errors

- added NetworkingService call to get an individual player in greater Detail when a user taps that player in the tableview

- changed PlayerDetailsViewController to have a DetailedPlayer? instead of Player? at file scope, the necessary change was made to the segue preparations in PlayersViewController

- Added search bar functionality, now players can be searched by name, team, league, position, age, id, or number to find them quicker in the tableView


__30/05/18__

- added a Decodable model for Charity object based on returned JSON from web app

- added retrieval of Charity info from web app in NetworkingService

- added CharitiesViewController and custom cell CharityCellViewController for tabBars's charity tab, similar to the playerController

- Removed a few deprecated outlets from PlayerCellViewController

- override the prepare for segue in PlayerDetailsViewController to return to the players table view with the tab bar, as opposed to without

- added a searchBar validator function for the charities search bar
