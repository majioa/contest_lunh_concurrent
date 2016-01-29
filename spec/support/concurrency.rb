def fork_with_new_connection
  config = ActiveRecord::Base.remove_connection
  fork do
    begin
      ActiveRecord::Base.establish_connection(config)
      yield
    ensure
      ActiveRecord::Base.remove_connection
      Process.exit!
    end
  end
  ActiveRecord::Base.establish_connection(config)
end
