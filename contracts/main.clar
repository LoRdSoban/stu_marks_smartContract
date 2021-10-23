
;; Student Marks
;; A smart contract to store marks of students.

;; constants
;;
(define-constant ERR_NAME_NOT_FOUND false)
(define-constant ERR_NAME_EXISTS false)
(define-constant MARKS_NOT_EXISTS u101) 
(define-constant UNAUTH_CALLER false) 

;; store the principal of authorised caller e.g. teacher, exam cordinator. 
(define-constant authorised_caller 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)


;; data maps and vars
;;
(define-map stu_data {id: principal} {english: uint, maths: uint, science: uint})


;; public functions
;;
(define-public (add_marks (id principal) (english uint) (maths uint) (science uint)) 

(begin

;;checks whether contract caller is authorised or not
(asserts! (is-eq authorised_caller tx-sender) (err UNAUTH_CALLER))

;;checks whether marks already exists or not, if YES return (err ERR_NAME_EXISTS) otherwise continue execution.
(asserts! (is-eq (is-none (map-get? stu_data {id: id})) true) (err ERR_NAME_EXISTS))

(ok (map-insert stu_data {id: id} {english: english, maths: maths, science: science} ))

)
)


;; read-only functions
;;
;; only callers with principal (e.g. students) stored in stu_data can read its own data

(define-read-only (get_marks) 

(begin

(asserts! (is-eq (is-some (map-get? stu_data {id: tx-sender})) true) (err ERR_NAME_NOT_FOUND))

(ok (map-get? stu_data {id: tx-sender}))

)
)


(define-read-only (get_english_marks) 

(get english (unwrap! (map-get? stu_data {id: tx-sender}) MARKS_NOT_EXISTS))

)

(define-read-only (get_maths_marks) 

(get maths (unwrap! (map-get? stu_data {id: tx-sender}) MARKS_NOT_EXISTS))

)

(define-read-only (get_science_marks) 

(get science (unwrap! (map-get? stu_data {id: tx-sender}) MARKS_NOT_EXISTS))

)
