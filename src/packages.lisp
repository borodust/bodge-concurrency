(bodge-util:define-package :bodge-concurrency
    (:use :bodge-util :bodge-memory :cl :bordeaux-threads
          :cl-muth :cl-flow)
  (:export make-task-queue
           push-task
           push-body-into
           drain
           clearup

           execute
           alivep
           make-single-threaded-executor
           make-pooled-executor

           in-new-thread
           in-new-thread-waiting
           with-body-in-main-thread
           stop-main-runner

           dispatch

           lockable
           with-instance-lock-held))
