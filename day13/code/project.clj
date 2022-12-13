(defproject day13 "0.0.0"
  :dependencies [[org.clojure/clojure "1.10.3"]
                 [org.clojure/data.json "2.4.0"]]
  :main day13.core
  :target-path "../build/lein/%s"
  :profiles {:uberjar {:aot :all :clean-targets ^{:protect false} ["../build/lein/%s"]
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})
