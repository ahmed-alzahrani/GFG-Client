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

__05/06/18__

- Fixed player table view glitch that displayed players based on filtering, but would interperate the player to show details based on indices from regular players array

- Routed calls to add a user to the Firestore DB, as well as add/remove players from the user's subscription list through the server from UPS

__06/06/18__

- Migrated user auth responsibilities on logging in / creating new user from LoginViewController to UserProfileService

- Added 'Forgot Password' button on to Login screen, need to add flow that sends them a link to reset their email

- Added UI flow for logging out from the profile page, as well as navigating in between user profile and the user's subscriptions page

__07/06/18__

- Minor UI fixes, including login form and reducing warnings from 9 --> 3 by fixing some constraints

- Added PickerView to detailed player view to allow users to assign a charity to each subscription. Charities populate the Picker View and the subscription button is disabled until a charity is chosen to prevent a subscription being submitted without a charity

__08/06/18__

- Migrated CHANGELOG from README --> CHANGELOG in the root directory

- Added dependency and installation / running info to the README

- Removed deprecated Firestore pod

__09/06/18__

- Improved flow of async calls from NetworkService to use their own completion handlers in the relevant view controllers, as well as threading to allow these UI edits to happen in the main thread despite the calls running in a background thread

__10/06/18__

- Added new Models to model the request body of POST requests

- Removed deprecated Alamofire pod and reverted POST reqs in User Profile Service to recommended best practice with vanilla URLSession [here](https://developer.apple.com/documentation/foundation/url_loading_system/uploading_data_to_a_website).

__11/06/18__

- Migrated auth responsibilities from UPS --> AuthService

- Renamed UPS --> SubscriptionService and NetworkingService --> DataService

__12/06/18__

- Added Quick Login button, when working on the client, you can populate the /ignore/QuickLogin.swift with an email/pass combo to login with one click while testing

- added a search bar validator for subscriptions

- Added a FinshedSubs typealias as well as a getSubscriptions method to the SubscriptionService, this returns a JSON array from the server of the current user's subscriptions to populate the table view on the page

- Added Subscription Codable model in order to serialize JSON from the server

- Moved all UITabelViewCell subclasses to their own sub-directory of Controllers titled Table Cell View Controllers

__15/06/18__

- added new fields to subscriptions being added / retrieved including team id and team name

- added new model for Match data that will be passed back from the server

- renamed table cell view controllers and segregated them in their own sub-directory of View Controllers

- added MatchesViewController and MatchCell / configured the Matches page to function similarly to Players/Charities/Subscriptions pages, a searchable tableView to show the user data, in this case, all of the matches featuring players that the user has subscribed to for the next month

__16/06/18__

- Finished implementing of Matches table view

- Added SubscriptionDetailsViewController UI, this includes a nav bar who's title is set depending on the name of the player who this subscription is described by, a picker view for changing the charity of the subscription and a table view showing specifically the matches involving that player for the next month

__18/06/18__

- Added UI picker view and unsubscribe / update charity subscription functionality in Subscription details VC

- Added UpdateSubParams Codable JSON model

- Changed charity model so charity/charityId are var instead of let so they can be updated if the user updates the charity in their subscription

- Migrated cells into Views directory

__21/06/18__

- Re-worked PlayerDetailsViewController UI and added in an upcoming matches table view similarly to SubscriptionDetailsViewController

__24/06/18__

- Implemented some UI re-design, specifically for all table views

- added charities/match detail view controller classes and storyboard VC objects

- Refactored Controller classes to belong to appropriate sub-directory (ie: Charity/Match/Player/Subscription)
