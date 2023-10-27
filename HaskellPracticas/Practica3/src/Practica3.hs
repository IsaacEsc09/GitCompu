--Lógica Proposicional
--Considera la siguiente definición de un tipo de dato que modela a la lógica proposicional:
type Nombre = String

data Prop = PTrue
    | PFalse
    | Var Nombre
    | Neg Prop
    | Conj Prop Prop
    | Disy Prop Prop
    | Impl Prop Prop
    | Equiv Prop Prop

--En la primera línea, type Nombre = String es un alias de tipo; es decir, que una expresión sea de tipo
--Nombre es otra forma de decir que la expresión es de tipo String. Después construimos Prop, que se define
--de forma recursiva: los casos base son las constantes lógicas y variables, mientras que los casos recursivos
--corresponden al uso de operadores lógicos.

--1. Define una instancia de la clase Show para el tipo Prop, de manera que la representación de una fórmula proposicional sea lea como:
--ghci> (Equiv (Impl (Var "a") (Var "b")) (Conj (Var "a") (Neg (Disy PTrue PFalse))))
--((a → b) ↔ (a ∧ ¬(⊤ ∨ ⊥)))
instance Show Prop where
        show (Var a) = a
        show PTrue = "⊤"
        show PFalse = "⊥"
        show (Neg a) = "¬" ++ (show a)
        show (Conj a b) = "(" ++ (show a) ++ " ∧ " ++ (show b) ++ ")"
        show (Disy a b) = "(" ++ (show a) ++ " ∨ " ++ (show b) ++ ")"
        show (Impl a b) = "(" ++ (show a) ++ " → " ++ (show b) ++ ")"
        show (Equiv a b) = "(" ++ (show a) ++ " ↔ " ++ (show b) ++ ")"

--2. Define una función que elimine todas las dobles negaciones presentes en la fórmula recibida como entrada.
elimDobleNeg :: Prop -> Prop 
elimDobleNeg PTrue = PTrue                                          
elimDobleNeg PFalse = PFalse                                        
elimDobleNeg (Var a) = Var a
elimDobleNeg (Neg (Neg a)) = elimDobleNeg a
elimDobleNeg (Neg a) = Neg (elimDobleNeg a)
elimDobleNeg (Conj a b) = (Conj (elimDobleNeg a) ((elimDobleNeg b)))
elimDobleNeg (Disy a b) = (Disy (elimDobleNeg a) ((elimDobleNeg b)))
elimDobleNeg (Impl a b) = (Impl (elimDobleNeg a) ((elimDobleNeg b)))
elimDobleNeg (Equiv a b) = (Equiv (elimDobleNeg a) ((elimDobleNeg b)))

--3. Define una función que devuelva una fórmula equivalente a la recibida, pero sin utilizar implicaciones ni equivalencias. 
--Recuerda: A → B ≡ ¬A ∨ B,    A ↔ B ≡ A → B ∧ B → A
elimOps :: Prop -> Prop
elimOps PTrue = PTrue
elimOps PFalse = PFalse
elimOps (Var a) = Var a
elimOps (Impl a b) = Disy (Neg (elimOps a)) (elimOps b)
elimOps (Equiv a b) = elimOps (Conj (Impl (a) (b)) (Impl (b) (a)))
elimOps (Neg a) = elimOps a
elimOps (Conj a b) = Conj (elimOps a) (elimOps b)
elimOps (Disy a b) = Disy (elimOps a) (elimOps b)


--4. Define una función que niegue la fórmula recibida. La función debe cumplir lo siguiente:
--No deben aparecer constantes lógicas negadas. Las siguientes no son válidas: ¬⊤, ¬⊥.
--No deben aparecer dobles negaciones. Las siguientes no son válidas: ¬¬a, ¬¬(a ∨ b).
simpBool :: Prop -> Prop
simpBool PTrue = PTrue
simpBool PFalse = PFalse
simpBool (Neg PTrue) = PFalse
simpBool (Neg PFalse) = PTrue
simpBool (Var a) = Var a
simpBool (Neg p) = (Neg (simpBool p))
simpBool (Conj a b) = (Conj (simpBool a) (simpBool b))
simpBool (Disy a b) = (Disy (simpBool a) (simpBool b))
simpBool (Impl a b) = Impl (simpBool a) (simpBool b)
simpBool (Equiv a b) = Equiv (simpBool a) (simpBool b)

negar :: Prop -> Prop
negar p = simpBool (elimDobleNeg (Neg p))

--5. Define una función que devuelva una lista de todas las variables proposicionales presentes en la fórmula (sin repeticiones).
rep [] l = l                                                                                                    
rep (x:xs) l = filter (/= x) (rep xs (l))

vars :: Prop -> [Nombre]
vars (Var a) = [a] 
vars PTrue = []
vars PFalse = []
vars (Neg a) = vars a
vars (Conj a b) = vars a ++ rep (vars a) (vars b)
vars (Disy a b) = vars a ++ rep (vars a) (vars b)
vars (Impl a b) = vars a ++ rep (vars a) (vars b)
vars (Equiv a b) = vars a ++ rep (vars a) (vars b)

--6. Define una función que devuelva el número de operadores presentes en una fórmula.
numOps :: Prop -> Int
numOps (Var a) = 0
numOps PTrue = 0
numOps PFalse = 0
numOps (Neg a) = 1 + numOps a
numOps (Conj a b) = 1 + numOps a + numOps b
numOps (Disy a b) = 1 + numOps a + numOps b
numOps (Impl a b) = 1 + numOps a + numOps b
numOps (Equiv a b) = 1 + numOps a + numOps b

--7. Define una función que aplique las siguientes reglas de De Morgan en todos los casos donde sea posible: 
-- ¬(A ∨ B) ≡ ¬A ∧ ¬B,     ¬(A ∧ B) ≡ ¬A ∨ ¬B
deMorgan :: Prop -> Prop
deMorgan PTrue = PTrue
deMorgan PFalse = PFalse
deMorgan (Var q) = Var q
deMorgan (Neg (Disy p q)) = Conj (Neg (deMorgan p)) (Neg (deMorgan q))
deMorgan (Neg (Conj p q)) = Disy (Neg (deMorgan p)) (Neg (deMorgan q))
deMorgan (Neg p) = Neg (deMorgan p)
deMorgan (Conj p q) = Conj (deMorgan p) (deMorgan q)
deMorgan (Disy p q) = Disy (deMorgan p) (deMorgan q)
deMorgan (Impl p q) = Impl (deMorgan p) (deMorgan q)
deMorgan (Equiv p q) = Equiv (deMorgan p) (deMorgan q)

--8. Define una función que simplifique todas las instancias de identidades para la conjunción y disyunción.
--A ∨ ⊥ ≡ A,     A ∧ ⊤ ≡ A
elimIdentidad :: Prop -> Prop
elimIdentidad PTrue = PTrue
elimIdentidad PFalse = PFalse
elimIdentidad (Var a) = Var a
elimIdentidad (Disy a PFalse) = elimIdentidad a
elimIdentidad (Conj a PTrue) = elimIdentidad a
elimIdentidad (Disy PFalse a) = elimIdentidad a                                 
elimIdentidad (Conj PTrue a) = elimIdentidad a
elimIdentidad (Neg a) = Neg (elimIdentidad a)
elimIdentidad (Conj a b) = Conj (elimIdentidad a) (elimIdentidad b)
elimIdentidad (Disy a b) = Disy (elimIdentidad a) (elimIdentidad b)
elimIdentidad (Impl a b) = Impl (elimIdentidad a) (elimIdentidad b)
elimIdentidad (Equiv a b) = Equiv (elimIdentidad a) (elimIdentidad b)

--9. Define una función que simplifique todas las instancias de valores nulos para conjunción y disyunción.
--A ∨ ⊤ ≡ ⊤ ,   A ∧ ⊥ ≡ ⊥
elimNulos :: Prop -> Prop
elimNulos PTrue = PTrue
elimNulos PFalse = PFalse
elimNulos (Var a) = Var a
elimNulos (Disy a PTrue) = PTrue
elimNulos (Disy PTrue a) = PTrue
elimNulos (Conj a PFalse) = PFalse
elimNulos (Conj PFalse a) = PFalse
elimNulos (Neg a) = Neg (elimNulos a)
elimNulos (Conj a b) = Conj (elimNulos a) (elimNulos b)
elimNulos (Disy a b) = Disy (elimNulos a) (elimNulos b)
elimNulos (Impl a b) = Impl (elimNulos a) (elimNulos b)
elimNulos (Equiv a b) = Equiv (elimNulos a) (elimNulos b)

--10. Define una función que decida si una proposición recibida se encuentra en forma normal negativa.
--Una proposición está en forma normal negativa cuando cumple lo siguiente:
--La fórmula no contiene equivalencias.
--La fórmula no contiene implicaciones.
--Las negaciones sólo están presentes sobre variables, nunca sobre fórmulas proposicionales más complejas.
esFNN :: Prop -> Bool
esFNN PTrue = True
esFNN PFalse = True
esFNN (Var a) = True
esFNN (Conj a b) = (esFNN a) && (esFNN b)
esFNN (Disy a b) = (esFNN a) && (esFNN b)
esFNN (Impl a b) = False
esFNN (Equiv a b) = False
esFNN (Neg (Var a)) = True
esFNN (Neg a) = False