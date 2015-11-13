require "scope_delegation/version"

module ScopeDelegation
  def delegate_scope(name, options)
    source      = options[:scope] || name
    association = reflect_on_association(options[:to]) || raise("Unknown association")
    name        = [options[:prefix], name].compact.join("_")
    grouping    = options[:group]

    scope name, Proc.new { |*args|
      if grouping
        joins(association.name).merge(association.klass.send(source, *args)).group(grouping)
      else
        joins(association.name).merge(association.klass.send(source, *args))
      end
    }
  end
end
