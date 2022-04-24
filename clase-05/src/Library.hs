module Library where
import PdePreludat

data Entrenador = Entrenador { cantidadPokebolas :: Number, pokemons :: [Pokemon] } deriving(Eq, Show)

data Tipo = Electrico | Fuego | Agua deriving(Eq, Show)

data Pokemon = Pokemon { tipo :: Tipo, experiencia :: Number } deriving(Eq, Show)

pikachu :: Pokemon
pikachu = Pokemon Electrico 0

charmander :: Pokemon
charmander = Pokemon Fuego 100

squirtle :: Pokemon
squirtle = Pokemon Agua 1100

juan :: Entrenador
juan = Entrenador 10 [pikachu, squirtle]

esFuerte :: Pokemon -> Bool
esFuerte pokemon = experiencia pokemon > 1000

losFuertes :: [Pokemon] -> [Pokemon]
losFuertes pokemons = filter esFuerte pokemons

esDeTipo :: Tipo -> Pokemon -> Bool 
esDeTipo unTipo pokemon = tipo pokemon == unTipo

losDeTipo :: Tipo -> [Pokemon] -> [Pokemon]
losDeTipo unTipo pokemons = filter (\pokemon -> esDeTipo unTipo pokemon) pokemons

-------------------------------------

entrenarEquipo = implementame 

atraparHorda = implementame

puedeSerLiderDeGimnasio = implementame