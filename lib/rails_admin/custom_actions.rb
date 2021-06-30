module RailsAdmin
    module Config
      module Actions
        class Root < RailsAdmin::Config::Actions::Base
            RailsAdmin::Config::Actions.register(self)
            register_instance_option :root do
              true	#	this is for all records in all models
            end
        end
      end
    end
  end
  