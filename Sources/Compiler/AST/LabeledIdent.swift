/// A labeled identifier (e.g., `foo(bar:_:)` or `infix+`).
public struct LabeledIdent {

  /// The base of the identifier.
  public var base: String

  // The argument labels of the identifier.
  public var labels: [String]

  /// The operator notation of the identifier.
  public var notation: OperatorNotation?

  public init(base: String, labels: [String] = [], notation: OperatorNotation? = nil) {
    self.base = base
    self.labels = labels
    self.notation = notation
  }

  static let empty = LabeledIdent(base: "")

  public static func == (lhs: LabeledIdent, rhs: String) -> Bool {
    return lhs.labels.isEmpty && (lhs.notation == nil) && (lhs.base == rhs)
  }

}

extension LabeledIdent: Hashable {}

extension LabeledIdent: CustomStringConvertible {

  public var description: String {
    var result = ""
    if let n = notation {
      result.append("\(n)")
    }

    result.append(base)

    if !labels.isEmpty {
      result.append("(")
      for label in labels { result.append("\(label):") }
      result.append(")")
    }

    return result
  }

}
