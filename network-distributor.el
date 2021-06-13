(load-file "./recursive_solution.elc")
(load-file "./network.elc")

(defvar distributor-cube-info nil)
(defvar distributor-cube-actions nil)
(defvar distributor-mutex (make-mutex "Distributor"))
(defvar distributor-cond (make-condition-variable distributor-mutex) "Distributor cond")
(defvar distributor-recvd-count 0)
(defvar distributor-process-count 4)
(defvar distributor-proc nil)

(defun distributor-start (port client-ports)
  (make-thread (lambda ()
                 (distributor-thread (generate-random-cube 10)
                      port client-ports))))

(defun distributor-thread  (cube port client-ports)
  (let ((procs '()) (depth 5) (cube-info '()) (idx 0))
    (dolist (port client-ports)
      (push (worker-client port) procs))
    (setq distributor-proc (worker-server port distributor-server-filter))
    (setq distributor-cube-info (new-max-cube cube))
    (setq distributor-cube-actions '())
    (setq distributor-process-count (length client-ports))
    (setq distributor-recvd-count 0)
    (loop
     (print (format "%s %s\n" distributor-recvd-count (print-cube (max-cube-cube distributor-cube-info))))
     (setq cube-info distributor-cube-info)
     (setq distributor-cube-info '())
     (setq idx 0)
     (dolist (proc procs)
       (process-send-string proc (format "%s" (worker-data (max-cube-cube cube-info) depth idx)))
       (setq idx (1+ idx)))
     (with-mutex distributor-mutex
       (while (not distributor-cube-info)
         (condition-wait distributor-cond)))
     (setq cube-actions (max-cube-actions distributor-cube-info))
     (if (not (equal cube-actions nil))
         (push cube-actions distributor-cube-actions))
     (if (equal (max-cube-score distributor-cube-info) 54)
         (progn
           (print (format "%s\n" distributor-cube-actions))
           (return))
     (if (equal cube-actions nil)
         (setq (1+ depth)))))))

(defun distributor-server-filter (proc string)
  (setq cube-info (eval-string string))
  (if (eq nil distributor-cube-info)
      (setq distributor-cube-info cube-info)
    (if (> (max-cube-score cube-info) (max-cube-score distributor-cube-info))
        (setq distributor-cube-info cube-info)))
  (setq distributor-recvd-count (1+ distributor-recvd-count))
  (if (eq distributor-process-count distributor-recvd-count)
      (with-mutex distributor-mutex
        (condition-notify distributor-cond))))


