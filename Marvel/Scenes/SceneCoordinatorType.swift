import UIKit
import RxSwift

protocol SceneCoordinatorType {
  init(window: UIWindow)

  /// transition to another scene
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>

  /// pop scene from navigation stack or dismiss current modal
  @discardableResult
  func pop(animated: Bool) -> Observable<Void>
}

extension SceneCoordinatorType {
  @discardableResult
  func pop() -> Observable<Void> {
    return pop(animated: true)
  }
}
