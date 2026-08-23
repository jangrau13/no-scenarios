class Lease
  def initialize(store, key, ttl_s, now = -> { Time.now.to_f })
    @store = store
    @key = key
    @ttl_s = ttl_s
    @now = now
  end

  # Nobody holding it means it is ours.
  def acquire(holder)
    current = @store.read(@key)
    if current.nil?
      @store.write(@key, { holder: holder, expires: @now.call + @ttl_s })
      return true
    end
    current[:holder] == holder
  end

  def renew(holder)
    raise NotImplementedError
  end
end
