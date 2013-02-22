module Veewee
  module Command
    class Kvm< Veewee::Command::GroupBase

      register "kvm", "Subcommand for KVM"

      desc "build [BOX_NAME]", "Build box"
      # TODO move common build options into array
      method_option :force,:type => :boolean , :default => false, :aliases => "-f", :desc => "force the build"
      method_option :nogui,:type => :boolean , :default => false, :aliases => "-n", :desc => "no gui"
      method_option :auto,:type => :boolean , :default => false, :aliases => "-a", :desc => "auto answers"
      method_option :checksum , :type => :boolean , :default => false, :desc => "verify checksum"
      method_option :postinstall_include, :type => :array, :default => [], :aliases => "-i", :desc => "ruby regexp of postinstall filenames to additionally include"
      method_option :postinstall_exclude, :type => :array, :default => [], :aliases => "-e", :desc => "ruby regexp of postinstall filenames to exclude"

      method_option :use_emulation, :type => :boolean , :default => false, :desc => "Use QEMU emulation"
      method_option :pool_name, :type => :string, :default => nil, :desc => "Name of the libvirt storage pool to be used"
      method_option :network_name, :type => :string, :default => "default", :desc => "Name of the libvirt network to be used"
      def build(box_name)
        venv=Veewee::Environment.new(options)
        venv.ui=env.ui
        venv.providers["kvm"].get_box(box_name).build(options)
      end


      desc "validate [BOX_NAME]", "Validates a box against kvm compliancy rules"
      method_option :tags,:type => :array , :default => %w{kvm puppet chef}, :aliases => "-t", :desc => "tags to validate"
      def validate(box_name)
        venv=Veewee::Environment.new(options)
        venv.ui=env.ui
        venv.providers["kvm"].get_box(box_name).validate_kvm(options)
      end

    end
  end
end
