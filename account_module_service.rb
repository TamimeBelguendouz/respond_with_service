module AccountModuleService
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    private

    def redirect_to_after_call service, model_instance, fail_path
      if service.call
        flash[:notice] = 'Successfully update'
        #redirect_to [:admin, :accounts]
        redirect_to [fail_path, :admin, model_instance]
      else
        # TODO notice errors ap create_account_service.errors
        redirect_to [fail_path, :admin, model_instance]
      end
    end
  end

  module ClassMethods
    def respond_with_service class_name, conf
      conf[:actions].each do |action|
        # TODO model can be conf
        model   = Object.const_get class_name
        #service = Object.const_get "#{class_name}Service"
        define_method action do 
          case action
          when :create
            model_instance = model.new
            fail_path      = :new
            service        = Object.const_get(class_name)
              .const_get "Create#{class_name}Service"
          when :update
            model_instance = model.find params[:id]
            fail_path      = :edit
            service        = Object.const_get(class_name)
              .const_get "Update#{class_name}Service"
          end 
          service_instance = service.new params, model_instance
          redirect_to_after_call service_instance, 
            model_instance, fail_path
        end
      end
    end
  end
end

class ActiveAdmin::ResourceController
end 
