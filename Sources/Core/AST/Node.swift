/// A protocol describing the API of an AST node.
public protocol Node: Codable {

  /// The site from which `self` was parsed.
  var site: SourceRange { get }

  /// Reports any well-formedness violations of `self` into `diagnostics`.
  func validateForm(in ast: AST, into diagnostics: inout DiagnosticSet)

}

extension Node {

  /// The identity of a node with this type.
  public typealias ID = NodeID<Self>

  /// Reports any well-formedness violations of `self` into `diagnostics`.
  public func validateForm(in ast: AST, into diagnostics: inout DiagnosticSet) {}

  /// A unique identifier denoting the type of this node.
  static var kind: NodeKind { NodeKind(Self.self) }

}
