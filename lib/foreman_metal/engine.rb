module ForemanPluginTemplate
  class Engine < ::Rails::Engine
    isolate_namespace ForemanPluginTemplate
    engine_name 'foreman_metal'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer 'foreman_metal.load_app_instance_data' do |app|
      ForemanPluginTemplate::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_metal.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_metal do
        requires_foreman '>= 3.7.0'
        register_gettext

        # Add Global files for extending foreman-core components and routes
        register_global_js_file 'global'

        # Register bare metal compute resource in foreman
        compute_resource ForemanMetal::Metal

        # Add permissions
        security_block :foreman_metal do
          permission :view_foreman_metal, { :'foreman_metal/example' => [:new_action],
                                                      :react => [:index] }
        end

        # Add a new role called 'Discovery' if it doesn't exist
        role 'ForemanPluginTemplate', [:view_foreman_metal]

        # add menu entry
        sub_menu :top_menu, :plugin_template, icon: 'pficon pficon-enterprise', caption: N_('Plugin Template'), after: :hosts_menu do
          menu :top_menu, :welcome, caption: N_('Welcome Page'), engine: ForemanPluginTemplate::Engine
          menu :top_menu, :new_action, caption: N_('New Action'), engine: ForemanPluginTemplate::Engine
        end

        # add dashboard widget
        widget 'foreman_metal_widget', name: N_('Foreman plugin template widget'), sizex: 4, sizey: 1
      end
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      Host::Managed.include ForemanPluginTemplate::HostExtensions
      HostsHelper.include ForemanPluginTemplate::HostsHelperExtensions
    rescue StandardError => e
      Rails.logger.warn "ForemanPluginTemplate: skipping engine hook (#{e})"
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanPluginTemplate::Engine.load_seed
      end
    end
  end
end
