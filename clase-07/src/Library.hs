module Library where
import PdePreludat

data Animal = Animal {
    energia :: Number,
    tipo :: Tipo,
    peso :: Number
} deriving(Show, Eq)

data Tipo = Volador | Terrestre | Acuatico deriving (Show, Eq)

type Alimento = Animal -> Animal

aumentarEnergiaYPeso ::  Number -> Number -> Animal -> Animal
aumentarEnergiaYPeso unaEnergia unPeso animal = animal {
    energia = energia animal + unaEnergia,
    peso = peso animal + unPeso
}

baya :: Alimento
baya = aumentarEnergiaYPeso 5 0.1

carne :: Alimento
carne = aumentarEnergiaYPeso 20 2

data Granja = Granja {
    animales :: [Animal],
    alimentos :: [Alimento]
}

instance Eq Granja where
    unaGranja == otraGranja = animales unaGranja == animales otraGranja

cantidadAlimentos :: Granja -> Number
cantidadAlimentos granja = (length . alimentos) granja

cantidadAnimales :: Granja -> Number
cantidadAnimales granja = (length . animales) granja

juntarStrings :: String -> [String] -> String
juntarStrings separador [] = ""
juntarStrings separador [unString] = unString
juntarStrings separador (unString : otros) = unString ++ separador ++ juntarStrings separador otros

instance Show Granja where
    show granja =
        "Una granja con los siguientes animales: " ++ (juntarStrings ", " . map show . animales) granja ++
        " y " ++ show (cantidadAlimentos granja) ++ " alimentos"

instance Ord Granja where
    unaGranja <= otraGranja = cantidadAnimales unaGranja <= cantidadAnimales otraGranja


-- Implementemos también:
-- Show -> que nos devuelva “Una granja con los siguientes animales: a, b, c y N alimentos“
-- Ord -> que una granja sea mayor a otra según la cantidad de animales que tiene
