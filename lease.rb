class Lease
  def initialize(store, key, ttl_s, now = -> { Time.now.to_f })
    @store = store
    @key = key
    @ttl_s = ttl_s
    @now = now
  end

  # Take the lease if nobody holds it, or if whoever did has let it expire.
  def acquire(holder)
    current = @store.read(@key)
    if current.nil? || current[:expires] <= @now.call
      @store.write(@key, { holder: holder, expires: @now.call + @ttl_s })
      return true
    end
    current[:holder] == holder
  end

  # Push the expiry out again.
  def renew(holder)
    current = @store.read(@key)
    return false unless current && current[:holder] == holder
    @store.write(@key, { holder: holder, expires: @now.call + @ttl_s })
    true
  end
end
