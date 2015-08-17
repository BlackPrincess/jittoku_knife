module JittokuKnife::Process
  module LazyLock
    def pid_file_name_base
      self.name.split('::').last.underscore.split('/').last()
    end

    def pid_file_name
      "#{pid_file_name_base}.pid"
    end

    def pid_dir
      JittokuKnife::Process.config.pid_dir
    end

    def pid_file_path
      "#{pid_dir}/#{pid_file_name}"
    end

    def current_pid
      $$
    end

    def running?
      return false unless File.file?(pid_file_path)

      old_pid = File.read(pid_file_path).to_i
      begin
        Process.kill 0, old_pid
        return true
      rescue Errno::ESRCH
        File.unlink(pid_file_path)
        return false
      end
    end

    def ensure_pid_dir
      FileUtils::mkdir_p(pid_dir) unless FileTest.directory?(pid_dir)
    end

    # ロックを開始
    def lock_start
      ensure_pid_dir
      File.write(pid_file_path, current_pid)
    end
  
    # ロックを解除
    def lock_end
      File.unlink(pid_file_path) if File.file?(pid_file_path)
    end
    
    # ロックしながら実行
    def with_lock(&block)
      return false if running?
      begin
        lock_start
        block.call
      ensure
        lock_end
      end
      true
    end
    
    # ロックが解除されたら実行
    def wait_and_run(interval = 10, timeout = nil, &block)
      sleep(interval) while running?
      block.call
    end
  end
end