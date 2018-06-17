import Foundation
import UIKit

class QuickLogin {
  let auth = AuthService()

  func quickLogin(with: UIViewController) {
    auth.loginUser(email: "ahmedalzahrani94@gmail.com", password: "Spursfan94!", view: with)

  }
}
