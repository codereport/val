import Utils

/// A binding to a generic value parameter.
public struct GenericValueParameter: CompileTimeValue {

  /// The declaration that introduces the binding.
  public let decl: GenericParameterDecl.ID

  /// The compile-time type of the binding.
  public let staticType: AnyType

  /// The name of the binding.
  public let name: Incidental<String>

  /// Creates an instance denoting a generic value of type `staticType` declared by `decl`.
  public init(
    ofType staticType: AnyType,
    declaredBy decl: GenericParameterDecl.ID,
    in ast: AST
  ) {
    self.decl = decl
    self.staticType = staticType
    self.name = Incidental(ast[decl].baseName)
  }

}

extension GenericValueParameter: CustomStringConvertible {

  public var description: String { name.value }

}
