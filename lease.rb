# A lease held by one holder at a time, renewed while the work continues.
#
# The storage is settled: +store+ has +compare_and_set+ and +read+. +acquire+
# and +renew+ are the parts with a decision in them.
class Lease
  def initialize(store, key, ttl_s, now = -> { Time.now.to_f })
    @store = store
    @key = key
    @ttl_s = ttl_s
    @now = now
  end

  # True if this holder now owns the lease.
  def acquire(holder)
    raise NotImplementedError
  end

  # Extend a lease this holder already owns.
  def renew(holder)
    raise NotImplementedError
  end
end
