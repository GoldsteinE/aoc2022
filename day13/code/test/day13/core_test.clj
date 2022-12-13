(ns day13.core-test
  (:require [clojure.test :refer :all]
            [day13.core :refer :all]))

(deftest compare-pair-test
  (testing "simple list" (is (= (compare-pair [1 1 3 1 1] [1 1 5 1 1]) -1)))
  (testing "nested list" (is (= (compare-pair [[1] [2 3 4]] [[1] 4]))))
  (testing "empty and non-empty" (is (= (compare-pair [] [3]))) -1)
  (testing "highly nested empty lists" (is (= (compare-pair [[[]]] [[]]) 1))))
