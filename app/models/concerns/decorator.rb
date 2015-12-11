module Decorator
  def initialize(component)
    @component = component
  end

  def method_missing(meth, *args)
    if @component.respond_to?(meth)
      @component.send(meth, *args)
    else
      begin
        super
      rescue StandardError => e
        Rails.logger.info "Could not perform #{meth} with #{args}"
        raise e
      end
    end
  end

  def respond_to?(meth)
    @component.respond_to?(meth)
  end

  def marshal_load
    Marshal.dump(@component)
  end
end
