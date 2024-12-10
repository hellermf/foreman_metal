module ForemanMetal
  module Controller
    module Parameters
      module ComputeResource
        extend ActiveSupport::Concern

        # extend permitted attributes from foreman/app/controllers/concerns/foreman/controller/parameters/compute_resource.rb
        # which itself uses foreman/app/services/foreman/parameter_filter.rb
        class_methods do
          def compute_resource_params_filter
            super.tap do |filter|
              filter.permit :wrapper
            end
          end

          def compute_resource_params
            self.class.compute_resource_params_filter.filter_params(params, parameter_filter_context)
          end
        end
      end
    end
  end
end
