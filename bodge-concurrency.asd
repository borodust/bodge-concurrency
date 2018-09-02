(asdf:defsystem :bodge-concurrency
  :description "Concurrency utilities"
  :version "1.0.0"
  :license "MIT"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :depends-on (bodge-utilities bodge-memory cl-flow
                               cl-muth trivial-main-thread bordeaux-threads
                               simple-flow-dispatcher)
  :pathname "src/"
  :serial t
  :components ((:file "packages")
               (:file "dispatch")
               (:file "execution")
               (:file "task-queue")
               (:file "instance-lock")
               (:file "main-thread")))
