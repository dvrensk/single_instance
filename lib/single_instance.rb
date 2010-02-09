require 'tmpdir'

module SingleInstance
  Blocker = Struct.new :pid, :started_at
  class << self

    def exclusive_non_blocking(name, &block)
      lock_file = File.join(Dir::tmpdir, "single_instance_#{name}.pid")
      File.open(lock_file, "a+") do |file|
        file.rewind
        begin
          if file.flock(File::LOCK_EX|File::LOCK_NB)
            file.truncate(0)
            file.puts $$
            file.puts Time.now.to_i
            file.flush
            yield nil
          elsif block.arity == 1
            pid = file.readline.to_i
            started_at = Time.at(file.readline.to_i)
            yield Blocker.new(pid, started_at)
          end
        ensure
          file.flock(File::LOCK_UN)
        end
      end
    end

  end
end
