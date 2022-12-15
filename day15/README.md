# Day 15: Futhark (+ C to parse input)

That was a mistake.

I chose Futhark for the promise of automatic parallelism. Turned out it was a bad idea:

1. Futhark is designed for GPUs, so is really limited. There’s no recursion, nor `flat_map`, nor `filter_map`.

2. Parsing in Futhark sounded like a nightmare, so I wasted C as well.

3. The `multicore` backend is broken. It ICEs on Futhark 0.22.3 and miscompiles on the latest master.

I should’ve just used C++ or Julia.
