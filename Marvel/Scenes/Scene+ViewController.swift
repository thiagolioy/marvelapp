
import UIKit

extension Scene {
  func viewController() -> UIViewController {
    switch self {
    case .characters(let viewModel):
        let controller = CharactersViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: controller)

    case .characterDetails(let viewModel):
        return CharacterViewController(viewModel: viewModel)
    }
  }
}
