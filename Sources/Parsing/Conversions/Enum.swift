import CasePaths

extension Conversion {
  /// Converts the associated values of an enum case into the case, and an enum case into its
  /// associated values.
  ///
  /// Useful for transforming the output of parser-printers into enums.
  ///
  /// - Parameter embed: An embed function where `Values` directly maps to the memory
  ///   layout of `Enum`, for example the internal, default initializer that is automatically
  ///   synthesized for structs.
  /// - Returns: A conversion that can embed the associated values of an enum case into the case,
  ///   and extract the associated values from the case.
  @inlinable
  public static func `case`<Values, Enum>(
    _ initializer: @escaping (Values) -> Enum
  ) -> Self where Self == CasePath<Enum, Values> {
    /initializer
  }
}

extension CasePath: Conversion {
  @inlinable
  public func apply(_ input: Value) -> Root {
    self.embed(input)
  }

  @inlinable
  public func unapply(_ output: Root) throws -> Value {
    guard let value = self.extract(from: output)
    else { throw ConvertingError() }
    return value
  }
}