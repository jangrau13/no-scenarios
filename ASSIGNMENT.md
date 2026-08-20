# One holder at a time (example assignment)

Several workers, one job that must not run twice at once. A lease in a shared
store decides who runs it, and expires so a worker that dies does not hold it
forever.

Your problem is `lease.rb`, and two methods in it.

## What to do

1. **`acquire(holder)`** — true if this holder now owns the lease.
2. **`renew(holder)`** — extend a lease this holder already owns.

The store gives you `read(key)` and `compare_and_set(key, expected, value)`.

## What you are marked on

Whether you can defend it in a viva. There is nothing to run: you are marked on
tracing your own code, not on demonstrating it.
