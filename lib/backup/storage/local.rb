module Backup
  module Storage
    class Local
      
      include Backup::CommandHelper
      
      # Store on same machine, preferentially in a different hard drive or in 
      # a mounted network path (NFS, Samba, etc)
      attr_accessor :path, :tmp_path, :final_file, :restore_file
      
      # Stores the backup file on local machine
      def initialize(adapter)
        self.path = adapter.procedure.get_storage_configuration.attributes['path']
        self.tmp_path   = adapter.tmp_path
        self.final_file = adapter.final_file
        self.restore_file = adapter.restore_file
      end
      
      def store
        run "mkdir -p #{path}"
        run "cp #{File.join(tmp_path, final_file).gsub('\ ', ' ')} #{File.join(path, final_file)}"
      end
      
      def pull
        run "mkdir -p #{tmp_path}"
        run "cp #{File.join(path, restore_file)} #{File.join(tmp_path, restore_file)}"
      end
      
    end
  end
end

