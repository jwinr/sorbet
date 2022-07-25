# typed: strict

extend T::Sig

# hack to ensure that there is at least one autocorrect
x = T.let(0, Integer)
T.must(x) # error: never `nil`

class Config
  @@supported_methods ||= T.let(nil, T.nilable(T::Array[String]))

  extend T::Sig

  sig {returns(T::Array[String])}
  def self.supported_methods
    @@supported_methods ||= begin
                              temp = T.let(['fast', 'slow', 'special'].uniq.freeze, T.nilable(T::Array[String]))
                              temp
                            end
    T.reveal_type(@@supported_methods) # error: Revealed type: `T.nilable(T::Array[String])`
    T.must(@@supported_methods)
  end

  @@suggest_t_let_class_rhs ||= ''
# ^^^^^^^^^^^^^^^^^^^^^^^^^ error: The class variable `@@suggest_t_let_class_rhs` must be declared using `T.let` when specifying `# typed: strict`
# ^^^^^^^^^^^^^^^^^^^^^^^^^ error: Use of undeclared variable `@@suggest_t_let_class_rhs`

  sig {returns(Integer)}
  def self.suggest_t_let_method
    @@suggest_t_let_method ||= ''
  # ^^^^^^^^^^^^^^^^^^^^^^ error: The class variable `@@suggest_t_let_method` must be declared using `T.let` when specifying `# typed: strict`
  # ^^^^^^^^^^^^^^^^^^^^^^ error: Use of undeclared variable `@@suggest_t_let_method`
  end
end
