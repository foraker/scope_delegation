require "scope_delegation/version"

module ScopeDelegation
  def delegate_scope(name, options)
    source      = options[:scope] || name
    association = reflect_on_association(options[:to]) || raise("Unknown association")
    name        = [options[:prefix], name].compact.join("_")

    scope name, Proc.new { |*args|
      joins(association.name).merge(association.klass.send(source, *args))
    }
  end
end
