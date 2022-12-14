(ns day13.core
  (:gen-class)
  (:require [clojure.data.json :as json]))

(defn compare-packets
  "Recursively compare two packets"
  [left right]
  (cond
    ;; Both are integers
    (and (int? left) (int? right)) (compare left right)
    ;; Left is integer
    (int? left) (recur (list left) right)
    ;; Right is integer
    (int? right) (recur left (list right))
    ;; Two empty lists
    (and (empty? left) (empty? right)) 0
    ;; Left is empty, i.e. shorter
    (empty? left) -1
    ;; Right is empty, i.e. shorter
    (empty? right) 1
    :else (let [lhs (first left)
                rhs (first right)
                first-result (compare-packets lhs rhs)]
            (if (zero? first-result) 
              (recur (rest left) (rest right))
              first-result))))

(defn read-packet-pair
  "Read two packets from stdin"
  []
  (let [first-line (read-line)
        second-line (read-line)
        filler-line (read-line)]
    (if (nil? second-line) nil [(json/read-str first-line) (json/read-str second-line)])))

(defn read-all-packets
  "Read all the packet pairs from stdin"
  []
  (take-while some? (repeatedly read-packet-pair)))

(defn enumerate
  "Add (1-based!) indices to a sequence"
  [xs]
  (map-indexed (fn [idx el] [(inc idx) el]) xs))

(defn part1
  "Find all the packet pairs where the left is not greater than the right"
  [packet-pairs]
  (->> packet-pairs
       (enumerate)
       (filter (fn [[idx [left right]]] (< (compare-packets left right) 1)))
       (map first)
       (apply +)))

(defn part2
  "Locate where [[2]] and [[6]] would be in sorted packets and return product of their indices"
  [packet-pairs]
  (->> packet-pairs
       (apply concat)
       (concat [[[2]] [[6]]])
       (sort compare-packets)
       (enumerate)
       (filter (fn [[idx packet]] (#{[[2]] [[6]]} packet)))
       (map first)
       (apply *)))

(defn -main
  "Solve day 13 of Advent of Code 2022. Takes part (1 or 2) as a first command-line argument."
  [& args]
  (if (= (first args) "1")
    (println (part1 (read-all-packets)))
    (println (part2 (read-all-packets)))))
