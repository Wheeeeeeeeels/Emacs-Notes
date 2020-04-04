;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; section 1
;; c-x c-e 进行编译输出
;; s-expression
(+ 2 2)

;; s-expression的嵌套
(+ 2 (+ 1 1))
(+ 3 (+ 1 2))

;; setq 赋值给变量
(setq my-name "wheels")

;; "insert" 会在光标处插入字符串
(insert "Hello!")Hello!
;; 插入多参数
(insert "Hello " "world!" )Hello world!

;; 使用变量名来代替字符串
(insert "Hello,I am "my-name)Hello,I am wheels

;; 把s-expression 嵌入到函数中
(defun hello() (insert "Hello,I am "-name))
;; 执行上面定义的函数
(hello)Hello,I am wheels

;; 让函数接受一个叫做“name"的参数"
(defun hello (name) (insert "Hello" name))

;; 测试带参数的函数
(hello "you")Helloyou
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; section 2
;;
;; 在新的窗口中新建一个名为"*test*"的buffer
;;在新的窗口中输出"hello you" progn命令将s-expression集合起来

(progn
(switch-to-buffer-other-window "*test*")
(hello " you"))

;; 清除当前buffer
(progn
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello " there"))


;; 清除当前buffer并且回到其他窗口
(progn
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello " you")
  (other-window))

;; 使用let将一个值和一个局部变量绑定
(let ((local-name " you-test"))
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello local-name)
  (other-window 1))

;; 格式化字符串的方法
(format "Hello %s!\n" "visitor")

;; 格式化方法重写函数
(defun hello (name)
  (insert (format "Hello %s!\n" name)))

;; 测试hello函数
(hello "you")Hello you!

;; greeting 函数
(defun greeting (name)
  (let ((your-name "wheels"))
    (insert (format "Hello %s!\n\nI am %s." name your-name))))

;; 测试greeting函数
(greeting "you")Hello you!

I am wheels.

;; 有些函数可以和用户交互
(read-from-minibuffer "Enter your name: ")

;; 使用greeting函数来显示你的名字
(defun greeting (from-name)
  (let ((your-name (read-from-minibuffer "Enter your name")))
    (insert (format "Hello!\n\nI am %s and you are %s."
                    from-name ;;the argument of the function
                    your-name ;the let-bound var,entered at prompt
                    )))) 

;; 测试greeting 函数
(greeting "wheels")Hello!

I am wheels and you are  wheels.

;; 让结果在另外一个窗口显示
(defun greeting (from-name)
  (let ((your-name (read-from-minibuffer "Enter your name")))
    (switch-to-buffer-other-window "*test*")
    (erase-buffer)
    (insert (format "Hello %s!\n\nI am %s."your-name from-name))
    (other-window 1)))

'' 测试函数
(greeting "wheels")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; section 3
;;
;; 将一些名字存在列表中
(setq list-of-names '("wheels" "rookie" "jack"))

;; 用car来取得第一个名字
(car list-of-names)

;; 用cdr取得剩下名字
(cdr list-of-names)

;; 将名字放到列表前面
(push "andrew" list-of-names)

;; 对列表中的数字都使用hello 函数
(mapcar 'hello  list-of-names)
Hello andrew!
Hello wheels!
Hello rookie!
Hello jack!

;; 改进greeing函数
(defun greeting ()
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (mapcar 'hello list-of-names)
  (other-window 1))

(greeting)

;; goto-char (point-min) 将光标移动到buffer的开始
;; 由于会得到错误提示: 因此可以更改为(search-forward "Hello" nil t)
(defun replace-hello-by-wheels ()
  (switch-to-buffer-other-window "*test*")
  (goto-char (point-min)) 
  (while (search-forward "Hello")
    (replace-match "wheels"))
  (other-window 1))

;; test function
(replace-hello-by-wheels)


(defun hello-to-wheels()
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (mapcar 'hello list-of-names)
  (goto-char (point-min))
  (while (search-forward "Hello" nil t)
    (replace-match "wheels"))
  (other-window 1))

;; test function
(hello-to-wheels)


;; 给这些名字加粗
(defun boldify-names()
  (switch-to-buffer-other-window "*test*")
  (goto-char (point-min))
  (while (re-search-forward "Wheels \\.(+\\)!" nil t)
    (add-text-properties (match-beginning 1)
                         (match-end 1)
                         (list 'face 'bold)))
  (other-window 1))


(boldify-names)
