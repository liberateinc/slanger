class EventMachine::Hiredis::PubsubClient
  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s == "publish" || super
  end
end

class EventMachine::Hiredis::Client
  def respond_to_missing?(method_name, include_private = false)
    ["hdel","hgetall","hincrby","hset","publish"].include?(method_name.to_s) || super
  end
end
