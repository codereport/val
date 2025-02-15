import Core

/// Borrows an access on an object.
public struct BorrowInstruction: Instruction {

  /// The capability being borrowed.
  public let capability: AccessEffect

  /// The type of the borrowed access.
  public let borrowedType: LoweredType

  /// The location of the root object on which an access is borrowed.
  public private(set) var location: Operand

  /// The binding in source program to which the instruction corresponds, if any.
  public let binding: VarDecl.ID?

  /// The site of the code corresponding to that instruction.
  public let site: SourceRange

  /// Creates an instance with the given properties.
  fileprivate init(
    borrowedType: LoweredType,
    capability: AccessEffect,
    location: Operand,
    binding: VarDecl.ID?,
    site: SourceRange
  ) {
    self.borrowedType = borrowedType
    self.capability = capability
    self.location = location
    self.binding = binding
    self.site = site
  }

  public var types: [LoweredType] { [borrowedType] }

  public var operands: [Operand] { [location] }

  public mutating func replaceOperand(at i: Int, with new: Operand) {
    precondition(i == 0)
    location = new
  }

}

extension BorrowInstruction: CustomStringConvertible {

  public var description: String {
    "borrow [\(capability)] \(location)"
  }

}

extension Module {

  /// Creates a `borrow` anchored at `site` that takes `capability` from `source`.
  ///
  /// - Parameters:
  ///   - capability: The capability being borrowed. Must be `.let`, `.inout`, or `.set`.
  ///   - source: The address from which the capability is borrowed. Must have an address type.
  ///   - binding: The declaration of the binding to which the borrow corresponds, if any.
  func makeBorrow(
    _ capability: AccessEffect, from source: Operand,
    correspondingTo binding: VarDecl.ID? = nil,
    at anchor: SourceRange
  ) -> BorrowInstruction {
    precondition((capability == .let) || (capability == .inout) || (capability == .set))
    precondition(type(of: source).isAddress)
    return .init(
      borrowedType: type(of: source),
      capability: capability,
      location: source,
      binding: binding,
      site: anchor)
  }

}
