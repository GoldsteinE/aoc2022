local open import "lib/github.com/diku-dk/sorts/merge_sort"

type scanner = { bx: i64, by: i64, sx: i64, sy: i64 }

let abs (x: i64) : i64 = if x < 0 then -x else x
let min (x: i64) (y: i64) : i64 = if x < y then x else y
let max (x: i64) (y: i64) : i64 = if x > y then x else y

let sentinel : (i64, i64) = (1, 0)

let find_safe_range (exclude_beacons: bool) (line: i64) ({ bx, by, sx, sy }: scanner)  : (i64, i64) =
  let safe_distance = abs (sx - bx) + abs (sy - by)
  let to_line = abs (sy - line)
  let remains = safe_distance - to_line
  in
    if remains < 0
    then sentinel
    else
      let left_bound = sx - remains + (i64.bool (sx - remains == bx && exclude_beacons))
      let right_bound = sx + remains - (i64.bool (sx + remains == bx && exclude_beacons))
      in (left_bound, right_bound)

let find_all_safe_ranges (exclude_beacons: bool) (scanners: []scanner) (line: i64) : [](i64, i64) =
  filter (\(x, y) -> y >= x) (map (find_safe_range exclude_beacons line) scanners)

let compare_ranges ((l1, l2): (i64, i64)) ((r1, r2): (i64, i64)) : bool =
  if l1 <= r1
    then true
    else if l1 == r1
      then l2 <= r2
      else false

let collapse_ranges (ranges: [](i64, i64)) : [](i64, i64) =
  let sorted = merge_sort compare_ranges ranges
  let (res, prev) =
    loop (res, (ps, pe)) = ([], sentinel) for (s, e) in sorted do
      if (ps, pe) == sentinel
      then (res, (s, e))
      else
        if pe >= s
        then (res, (min s ps, max e pe))
        else (res ++ [(ps, pe)], (s, e))
  in if prev == sentinel then res else res ++ [prev]

let part1 (scanners: []scanner) (line: i64) : i64 =
  let ranges = find_all_safe_ranges true scanners line
  let collapsed = collapse_ranges ranges
  let lengths = (map (\(x, y) -> y - x + 1) collapsed) : []i64
  in reduce (+) 0 lengths

let part2 (scanners: []scanner) (max_coord: i64) : i64 =
  let check_for_safe_spots = \line ->
    let ranges = find_all_safe_ranges false scanners line
    let collapsed = collapse_ranges ranges
    let (fs, fe) = head collapsed
    in
      if fs > 0
      then fs * 4000000 + line
      else
        let (res, _) =
          loop (res, (_, pe)) = (0, (fs, fe)) for (s, e) in tail collapsed do
            if s - 1 > pe then (s - 1, (s, e)) else (res, (s, e))
        in
          if res > 0
          then res * 4000000 + line
          else
            let (_, le) = last collapsed
            in
              if le < max_coord
              then le * 4000000 + line
              else 0

  in reduce (+) 0 (map check_for_safe_spots (0...max_coord))

let transform_scanners (scanners: [][4]i64) : []scanner =
  map (\line -> { sx = line[0], sy = line[1], bx = line[2], by = line[3] }) scanners

entry part1_exported (scanners: [][4]i64) (line: i64) : i64 =
  part1 (transform_scanners scanners) line

entry part2_exported (scanners: [][4]i64) (max_coord: i64) : i64 =
  part2 (transform_scanners scanners) max_coord
