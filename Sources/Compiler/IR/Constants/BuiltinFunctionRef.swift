import Foundation

/// A reference to a built-in function.
public struct BuiltinFunctionRef: ConstantProtocol {

  /// The name of the function.
  public let name: String

  /// The type of the function.
  public let type: IRType

  private init(name: String, inputs: [(ParamConvention, BuiltinType)], output: BuiltinType?) {
    let lambda = LambdaType(
      inputs: inputs.map({ (cv, ty) in
        CallableTypeParameter(
          label: nil,
          type: .parameter(ParameterType(convention: cv, bareType: .builtin(ty))))
      }),
      output: output.map({ .builtin($0) }) ?? .unit)

    self.name = name
    self.type = .owned(.lambda(lambda))
  }

}
