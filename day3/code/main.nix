with builtins; { part, filename }:
let
  splitSack = (sack:
    let
      size = stringLength sack;
      first = substring 0 (size / 2) sack;
      second = substring (size / 2) size sack;
    in
    { inherit first second; });

  # [first, last] instead of [first, last) semantics matches `lib.range`
  range = first: last: genList (n: first + n) (last - first + 1);

  stringToList = string: map (idx: substring idx 1 string) (range 0 (stringLength string - 1));

  unique = list: map head (attrValues (groupBy toString list));

  common = (lists:
    let
      groups = groupBy toString (concatLists (map unique lists));
      bigGroup = head (filter (list: length list == length lists) (attrValues groups));
    in
    head bigGroup
  );

  sum = foldl' add 0;

  min = x: y: if x < y then x else y;
  zipListsWith = f: lhs: rhs: genList (n: f (elemAt lhs n) (elemAt rhs n)) (min (length lhs) (length rhs));

  enumerate = list: zipListsWith (elem: idx: { inherit elem idx; }) list (range 0 (length list - 1));

  prioritiesGeneric = alphabet: priorities: listToAttrs (zipListsWith (name: value: { inherit name value; }) alphabet priorities);
  prioritiesSmall = prioritiesGeneric (stringToList "abcdefghijklmnopqrstuvwxyz") (range 1 26);
  prioritiesCapital = prioritiesGeneric (stringToList "ABCDEFGHIJKLMNOPQRSTUVWXYZ") (range 27 52);
  priorities = prioritiesSmall // prioritiesCapital;

  inputLines = filter
    (s: typeOf s == "string" && s != "")
    (split "\n" (readFile filename));

  part1 = sum (map
    (line:
      let
        parts = splitSack line;
        commonLetter = common [ (stringToList parts.first) (stringToList parts.second) ];
      in
      priorities.${commonLetter})
    inputLines);

  part2 = (
    let
      sacks = enumerate (map stringToList inputLines);
      groups = groupBy (x: toString (x.idx / 3)) sacks;
      commonLetters = map common (map (map (x: x.elem)) (attrValues groups));
    in
    sum (map (letter: priorities.${letter}) commonLetters)
  );
in
(if part == 1 then part1 else part2)
