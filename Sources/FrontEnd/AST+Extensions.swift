import Core
import Foundation
import Utils
import ValModule

extension AST {

  /// An instance that includes just the core module.
  public static var coreModule = AST(libraryRoot: ValModule.core!)

  /// An instance that includes just the standard library.
  public static var standardLibrary = AST(libraryRoot: ValModule.standardLibrary!)

  /// Creates an instance that includes the Val library rooted at `libraryRoot`.
  private init(libraryRoot: URL) {
    self.init()
    do {
      var diagnostics = DiagnosticSet()
      coreLibrary = try makeModule(
        "Val",
        sourceCode: sourceFiles(in: [libraryRoot]),
        builtinModuleAccess: true,
        diagnostics: &diagnostics)
      assert(isCoreModuleLoaded)
    } catch let error {
      fatalError("Error parsing the Val module:\n\(error.localizedDescription)")
    }
  }

}
