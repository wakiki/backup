module Backup
  module Storage
    class S3
      
      # Stores the backup file on the remote server using S3
      def initialize(adapter)
        @s3 = Backup::Connection::S3.new(adapter)
        @s3.connect
      end

      def store
        @s3.store
      end

      def pull
        # TODO implement!
      end
      
    end
  end
end
