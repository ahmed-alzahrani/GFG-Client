import Foundation
import UIKit

class QuickLogin {
  let auth = AuthService()

  func quickLogin(with: UIViewController) {
    auth.loginUser(email: "enter email here", password: "enter password here", view: with)

  }
}
