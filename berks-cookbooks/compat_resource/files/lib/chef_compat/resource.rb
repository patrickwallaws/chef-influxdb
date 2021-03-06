require 'chef_compat/copied_from_chef/chef/resource'

module ChefCompat
  class Resource < ChefCompat::CopiedFromChef::Chef::Resource
    # Things we'll need to define ourselves:
    # 1. provider
    # 2. resource_name

    def provider(*args, &block)
      super || self.class.action_class
    end
    def provider=(arg)
      provider(arg)
    end

    if !respond_to?(:resource_name)
      def self.resource_name(name=Chef::NOT_PASSED)
        # Setter
        if name != Chef::NOT_PASSED
  #        remove_canonical_dsl

          # Set the resource_name and call provides
          if name
            name = name.to_sym
            # If our class is not already providing this name, provide it.
            # Commented out: use of resource_name and provides will need to be
            # mutually exclusive in this world, generally.
            # if !Chef::ResourceResolver.includes_handler?(name, self)
              provides name#, canonical: true
            # end
            @resource_name = name
          else
            @resource_name = nil
          end
        end
        @resource_name
      end
      def self.resource_name=(name)
        resource_name(name)
      end
    end

    # for LWRPBase
    def self.run_context
      @run_context
    end
    def self.run_context=(arg)
      @run_context = arg
    end
    require 'chef/mixin/from_file'
    extend Chef::Mixin::FromFile
  end
end
