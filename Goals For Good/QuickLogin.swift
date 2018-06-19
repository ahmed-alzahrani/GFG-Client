import Foundation
import UIKit

class QuickLogin {
  let auth = AuthService()

  func quickLogin(with: UIViewController) {
    auth.loginUser(email: "Enter email here", password: "Enter password here", view: with)

  }
}
