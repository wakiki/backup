module Backup
  module Storage
    class SFTP
      
      attr_accessor :user, :password, :ip, :path, :tmp_path, :final_file, :restore_file
      
      # Stores the backup file on the remote server using SFTP
      def initialize(adapter)
        %w(ip user password path).each do |method|
          send("#{method}=", adapter.procedure.get_storage_configuration.attributes[method])
        end
        
        self.final_file = adapter.final_file
        self.tmp_path   = adapter.tmp_path
        self.restore_file = adapter.restore_file
      end

      def store
        Net::SFTP.start(ip, user, :password => password) do |sftp|
          begin
            puts "Storing \"#{final_file}\" to path \"#{path}\" on remote server (#{ip})."
            sftp.upload!(File.join(tmp_path, final_file).gsub('\ ', ' '), File.join(path, final_file))
          rescue
            puts "Could not find \"#{path}\" on \"#{ip}\", please ensure this directory exists."
            exit
          end
        end
      end

      def pull
        # TODO implement!
      end
      
    end
  end
end
