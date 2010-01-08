module Backup
  module CommandHelper
    def run(command)
      log command
      Kernel.system command
    end
 
    def log(command)
      puts "[Backup] => #{command}"
    end
  end
end
