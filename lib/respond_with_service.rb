require "respond_with_service/version"

module RespondWithService
  class Toto
  def self.hello
    'hi'
  end
  end


  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def foo
      'bar'
    end

    private

    def redirect_to_after_call
      if @service_instance.call
        flash[:notice] = 'Successfully update'
        redirect_to [:admin, @model_instance.class.to_s.underscore.pluralize]
      else
        # TODO notice errors ap create_account_service.errors
        flash[:error] = 'something went wrong'
        if @fail_path == :new
          redirect_to [@fail_path, :admin, @model_instance.class.to_s.underscore]
        else
          redirect_to [@fail_path, :admin, @model_instance]
        end
      end
    end

    def find_model_instance class_name
      # TODO model can be conf
      model = Object.const_get class_name
      case params[:action].to_sym
      when :create
        @model_instance = model.new
        @fail_path      = :new
      when :update
        @model_instance = model.find params[:id]
        @fail_path      = :edit
      end 
    end

    def find_service_instance
      service = Object.const_get(@model_instance.class.to_s)
      .const_get "#{params[:action].capitalize}#{@model_instance.class}Service"
      @service_instance = service.new params, @model_instance
    end
  end

  module ClassMethods
    def respond_with_service class_name, conf
      conf[:actions].each do |action|
        self.create_action action, class_name
      end
    end

    def create_action action, class_name
      define_method action do 
        find_model_instance class_name
        find_service_instance
        redirect_to_after_call
      end
    end

  end
end
