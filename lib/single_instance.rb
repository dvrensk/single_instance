require 'tmpdir'

module SingleInstance
  Blocker = Struct.new :pid, :started_at

  class << self

    def exclusive_non_blocking(name, &block)
      lock_file = File.join(Dir::tmpdir, "single_instance_#{name}.pid")
      begin
        file = File.open(lock_file, "a+")
        file.rewind
        if file.flock(File::LOCK_EX|File::LOCK_NB)
          file.truncate(0)
          file.puts $$
          file.puts Time.now.to_i
          file.flush
          if block_given?
            yield nil
          else
            (@lock_files ||= []) << file
          end
        elsif block_given? && block.arity == 1
          pid = file.readline.to_i
          started_at = Time.at(file.readline.to_i)
          yield Blocker.new(pid, started_at)
        else
          false
        end
      ensure
        file.close if block_given?
      end
    end

  end
end
