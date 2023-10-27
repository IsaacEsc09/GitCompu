data EA = Num Int
        | Suma EA EA
        | Resta EA EA
        | Mult EA EA
        | Div EA EA
        | Mod EA EA
        | Pot EA EA --deriving Show

--1. Dada una expresión aritmética, obtén su evaluación.
--Observación: Para no tener problemas con los tipos, procura siempre regresar algo de tipo entero. En el caso de la división, no usaremos la división estándar, sino la división entera (en donde únicamente dejamos la parte entera del número, descartando los decimales).
calcula :: EA -> Int
calcula (Num n) = n
calcula (Suma ea1 ea2) = calcula ea1 + calcula ea2
calcula (Resta ea1 ea2) = calcula ea1 - calcula ea2
calcula (Mult ea1 ea2) = calcula ea1 * calcula ea2
calcula (Div ea1 ea2) = calcula ea1 `div` calcula ea2
calcula (Mod ea1 ea2) = calcula ea1 `mod` calcula ea2
calcula (Pot ea1 ea2) = calcula ea1 ^ calcula ea2

--2. Dadas dos expresiones aritméticas, define una función que devuelva:
--EQ cuando ambas expresiones aritméticas se evalúan al mismo valor.
--LT cuando la primer expresión sea menor que la segunda.
--GT cuando la primer expresión sea mayor que la segunda.

compara :: EA -> EA -> Ordering
compara ea1 ea2
        | calcula ea1 == calcula ea2 = EQ  
        | calcula ea1 < calcula ea2 = LT
        | calcula ea1 > calcula ea2 = GT

--3. Para resolver este ejercicio, borra la instrucción deriving Show de la definición de EA.
--Define una instancia de Show para el tipo de dato EA, de manera que las expresiones se visualicen como:
instance Show EA where
    show (Num n) = show n
    show (Suma e1 e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
    show (Resta e1 e2) = "(" ++ show e1 ++ " - " ++ show e2 ++ ")"
    show (Mult e1 e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"
    show (Div e1 e2) = "(" ++ show e1 ++ " / " ++ show e2 ++ ")"
    show (Mod e1 e2) = "(" ++ show e1 ++ " % " ++ show e2 ++ ")"
    show (Pot e1 e2) = "(" ++ show e1 ++ " ^ " ++ show e2 ++ ")"

--Árboles Binarios
--Definimos los árboles binarios como:
data BTree a = Void | Node a (BTree a) (BTree a) deriving Show
--Define las siguientes funciones
--4. Dado un árbol binario, convierte su contenido a una lista utilizando un recorrido en orden.
enOrden :: BTree a -> [a]
enOrden Void = []                    
enOrden (Node x i d) = enOrden i ++ [x] ++ enOrden d

--5. Dado un árbol binario, convierte su contenido a una lista utilizando un recorrido pre-orden.
preOrden :: BTree a -> [a]
preOrden Void = []                    
preOrden (Node x i d) = [x] ++ preOrden i ++ preOrden d

--6. Dado un árbol binario, convierte su contenido a una lista utilizando un recorrido post-orden.
postOrden :: BTree a -> [a]
postOrden Void = []                    
postOrden (Node x i d) = postOrden i ++ postOrden d ++ [x]

--7. Dado un árbol binario, genera el mismo árbol pero reflejado. Es decir, los nodos a la izquierda ahora estarán a la derecha, y viceversa.
espejo :: BTree a -> BTree a
espejo Void = Void
espejo  (Node x i d) = Node x (espejo d) (espejo i)

--8. Dado un árbol binario, calcula el número de elementos que este contiene.
size :: BTree a -> Int
size Void = 0
size (Node _ left right) = 1 + size left + size right

--9. Dado un árbol binario de elementos ordenados, agrega un nuevo elemento al árbol asegurando que se mantiene el orden.
inserta :: Ord a => a -> BTree a -> BTree a
inserta e Void = Node e Void Void
inserta e (Node x left right)
    | e < x     = Node x (inserta e left) right
    | otherwise = Node x left (inserta e right)

--10. Dada una lista de elementos ordenables, genera un árbol ordenado que contenga a todos los elementos de la lista original.
generaArbol :: Ord a => [a] -> BTree a
generaArbol [] = Void
generaArbol (x:xs) = inserta x (generaArbol xs)

--Extra: Árboles llave-valor
--Un árbol llave-valor es aquel en donde cada nodo contiene 2 elementos: uno llamado “llave” y otro que es el valor asociado a tal llave. Es importante notar que estos dos no necesariamente son del mismo tipo.
--1. Define tu propio tipo de datos KVTree para representar árboles llave-valor.
data KVTree a = Vacio | Nodo (KVTree)(KVTree)deriving Show

--2. Define la operación insertaKV que dada una llave y un valor, inserte de manera ordenada (ordenando según la llave) un nodo en un árbol. En caso de ya existir en el árbol la llave que se pretende insertar,
--sustituir el valor que tenía anteriormente la llave. Hint: Si queremos ordenar el árbol según las llaves, ¿qué condición debe cumplir el tipo de las llaves?.

--3. Define una operación existeKV que dado un árbol y una llave, decida si tal llave se encuentra presente en el árbol.