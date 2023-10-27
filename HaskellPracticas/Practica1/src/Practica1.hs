--1.Dada una lista de enteros, deseamos conocer cuáles son el número mayor y el número menor en dicha lista. Para ello, devuelve una tupla donde el primer elemento sea el menor y el segundo elemento sea el mayor.
minMax:: [Int] -> (Int, Int)
minMax [x] = (x, x)
minMax(x:xs) = (min x minResto, max x maxResto)
  where
    (minResto, maxResto) = minMax xs

--2.Dados dos enteros: un máximo y un mínimo; y una lista, devuelve la misma lista pero sin los elementos en el intervalo entre los dos enteros dados.
remInterv :: Int -> Int -> [a] -> [a]
remInterv inicio fin l = take inicio l ++ drop (fin + 1) l

--3.Dada una lista de enteros, calcula el promedio de los números en la lista.
avg :: [Int] -> Double
avg l = fromIntegral (sum l) / fromIntegral (length l)

--4.Dada una lista de tuplas, separa los elementos en una tupla de 2 listas de manera tal que los elementos en la primer entrada de las tuplas queden en la primera lista, y los elementos en la segunda entrada queden en la segunda lista.
separa :: [(a,b)] -> ([a], [b])
separa l = (map f l, map g l)
        where f (a,b) = a
              g (a,b) = b

--5.Representamos un punto como una tupla (x,y). Dados tres puntos, devuelve el área del triángulo que se forma al unir esos 3 puntos.
areaTri :: (Double, Double) -> (Double, Double) -> (Double, Double) -> Double
areaTri (a,b) (c,d) (e,f) = (abs(((a*d)+(c*f)+(e*b))-((a*f)+(c*b)+(e*d)))/2)

--6.Dado un entero n, devuelve una lista de longitud n donde el índice i corresponda a la suma de los primeros i números naturales.
sumasNaturales :: Int -> [Int]
sumasNaturales n = map f [0..n]
  where f a = ((a * (a + 1)) `div` 2)
  

--7.Define recursivamente una función que decida si un número es par.
esPar :: Int -> Bool
esPar 0 = True
esPar 1 = False
esPar n = esPar (n - 2)

--8.Desarrolla la función de Ackermann que recibe dos números naturales que se define como:
ackermann :: Int -> Int -> Int
ackermann 0 n = n + 1
ackermann m 0 | m > 0 = ackermann (m - 1) 1
ackermann m n | m > 0 && n > 0 = ackermann (m - 1) (ackermann m(n - 1))

--9.Define recursivamente una función que repita cada elemento de una lista dada.
repite :: [a] -> [a]
repite [a] = [a] ++ [a]
repite (a:b) = [a] ++ [a] ++ repite b

--10.Define una función recursiva que verifica si un elemento se encuentra en una lista dada.
elemento :: Eq a => a -> [a] -> Bool
elemento _ [] = False
elemento b [a] = if b == a then True else False
elemento c (a:b) = if c == a then True else elemento c b

--11.Dado un entero n, devuelve todos los números primos desde 1 hasta n. Sugerencia: intenta usar una lista por comprensión.
al :: [a] -> [a]
al [] = []
al (x:xs) = al xs ++ [x]

bolo :: Int -> [Int] -> Bool
bolo 1 _ = False
bolo n [1] = True
bolo n l = if (mod n (head (al l)) /= 0) then (True && bolo n (init l)) else False

primos :: Int -> [Int]
primos 0 = []
primos 1 = []
primos 2 = [2]
primos n = if (bolo n [1..(n-1)]) then (primos (n - 1) ++ [n]) else (primos (n-1) ++ [])