;;; Customized c/c++ mode
(el-get-bundle company-c-headers
  :post-init
  (progn
    (with-eval-after-load "company"
      (add-to-list 'company-backends 'company-c-headers))))
