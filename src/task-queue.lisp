(cl:in-package :bodge-concurrency)

(defstruct (task-queue
            (:constructor %make-task-queue))
  (queue (make-guarded-reference (muth::make-fifo)) :read-only t))


(definline make-task-queue ()
  "Make trivial thread-safe task FIFO queue."
  (%make-task-queue))


(defun push-task (task-fu task-queue)
  "Push task function to the end of the queue. Thread-safe."
  (when (null task-fu)
    (error "Task function cannot be nil"))
  (with-guarded-reference (queue (task-queue-queue task-queue))
    (muth::fifo-push queue task-fu)))


(defmacro push-body-into ((task-queue) &body body)
  "Push block of code to execute as a task to the end of the queue. Thread-safe."
  `(push-task (lambda () ,@body) ,task-queue))


(defun drain (task-queue &optional invoker)
  "Execute tasks in FIFO order once. If `invoker` function provided, invoke it with task
function as an argument instead. Thread-safe."
  (loop with count = 0
        for task = (with-guarded-reference (queue (task-queue-queue task-queue))
                     (muth::fifo-pop queue))
        while task
        do (if invoker
               (funcall invoker task)
               (funcall task))
           (incf count)
        finally (return count)))


(defun clearup (task-queue)
  "Remove all tasks from the queue. Thread-safe."
  (with-guarded-reference (queue (task-queue-queue task-queue))
    (setf queue (muth::make-fifo))))
