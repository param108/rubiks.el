(defun worker (port worker-filter)
  (make-network-process :buffer "*network-buffer*" :type 'datagram :server 't :family 'ipv4 :service port :filter worker-filter :name "rubiks-worker"))

(defun worker-client (port)
  (make-network-process :buffer "*network-buffer*" :type 'datagram :family 'ipv4 :service port :filter 'worker-filter :name (format "rubiks-worker-client-%s" port)))

(defun worker-data (cube depth idx)
  (list cube depth idx))

(defun worker-data-cube (data)
  (nth 0 data))

(defun worker-data-depth (data)
  (nth 1 data))

(defun worker-data-idx (data)
  (nth 2 data))

(defun eval-string (string)
  "Evaluate elisp code stored in a string."
  (eval (car (read-from-string string))))
