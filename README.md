Eight queens puzzle OR eight bishops puzzle solution
========================

The solution of eight bishops (eight queens) puzzle written on LISP.

The task: find the most short way to place bishops (queens) on board in position where none of figures will be under attack of another ones. Generate the random initial position of figures.

Follow the commens in code to wrap task or to enable additional output.

The algorithm uses horizontal search and search by criteria.

Example:
```LISP
CL-USER 46 : 1 > (solve 4)

(_ 1 _ _) 
(3 _ 2 _) 
(_ 4 _ _) 
(_ _ _ _) 
"-------" 

ONE OF BEST VARIANT BY STEPS (3 SWAPS):

STEP 0:
(_ 1 _ _) 
(3 _ 2 _) 
(_ 4 _ _) 
(_ _ _ _) 
"-------" 

STEP 1:
(1 _ _ _) 
(3 _ 2 _) 
(_ 4 _ _) 
(_ _ _ _) 
"-------" 

STEP 2:
(1 _ _ _) 
(3 _ _ 2) 
(_ 4 _ _) 
(_ _ _ _) 
"-------" 

STEP 3:
(1 _ _ _) 
(_ _ _ 2) 
(3 4 _ _) 
(_ _ _ _) 
"-------" 

STEP 4:
(1 _ _ _) 
(_ _ _ 2) 
(3 4 _ _) 
(_ _ _ _) 
"-------" 
3
```
