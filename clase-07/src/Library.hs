module Library where
import PdePreludat

data Animal = Animal {
    energia :: Number,
    tipo :: Tipo,
    peso :: Number
} deriving(Show, Eq)

data Tipo = Volador | Terrestre | Acuatico deriving(Show, Eq)

type Alimento = Animal -> Animal

aumentarEnergiaYPeso :: Animal -> Number -> Number -> Animal
aumentarEnergiaYPeso animal unaEnergia unPeso = animal {
    energia = energia animal + unaEnergia,
    peso = peso animal + unPeso
}

baya :: Alimento
baya = aumentarEnergiaYPeso 5 0.1

carne :: Alimento
carne = aumentarEnergiaYPeso 20 2

data Granja = Granja {
    animales :: [Animal],
    alimento :: [Alimento]
} deriving (Show)

instance Eq Granja where
    unaGranja == otraGranja = animales unaGranja == animales otraGranja
