module Library where
import PdePreludat

data Simbolo = Reversa | Mas4 | SaltarTurno deriving (Eq, Show)

data Color = Rojo | Amarillo | Verde | Azul deriving (Eq, Show)

data Carta =
    CartaNumerica { numero :: Number, color :: Color } |
    CartaEspecial { simbolo :: Simbolo, color :: Color }
    deriving (Eq, Show)

ochoRojo = CartaNumerica 8 Rojo

sePuedeJugar :: Carta -> Carta -> Bool
sePuedeJugar _ (CartaEspecial Mas4 _) = True
sePuedeJugar unaCarta otraCarta =
    tienenMismoValor unaCarta otraCarta ||
    tienenMismoColor unaCarta otraCarta

tienenMismoValor :: Carta -> Carta -> Bool
tienenMismoValor (CartaNumerica unNumero _) (CartaNumerica otroNumero _) = unNumero == otroNumero
tienenMismoValor (CartaEspecial unSimbolo _) (CartaEspecial otroSimbolo _) = unSimbolo == otroSimbolo
tienenMismoValor _ _ = False

tienenMismoColor :: Carta -> Carta -> Bool
tienenMismoColor unaCarta otraCarta = color unaCarta == color otraCarta

unasCartas :: [Carta]
unasCartas = [CartaNumerica 0 Azul, CartaNumerica 1 Azul, CartaNumerica 1 Verde]

otrasCartas :: [Carta]
otrasCartas = CartaNumerica 3 Rojo : CartaNumerica 9 Verde : CartaNumerica 0 Azul : []

-- >>> ultimaCarta unasCartas
-- CartaNumerica 1 Verde
ultimaCarta :: [Carta] -> Carta -- last
ultimaCarta [unaCarta] = unaCarta
ultimaCarta (_ : otrasCartas) = ultimaCarta otrasCartas

-- ultimaCarta (unoRojo : dosVerde : tresAzul : [])
-- ultimaCarta (dosVerde : tresAzul : [])
-- ultimaCarta (tresAzul : [])
-- tresAzul

-- >>> primeras 2 unasCartas
-- [CartaNumerica 0 Azul, CartaNumerica 1 Azul]
primeras :: Number -> [Carta] -> [Carta] -- take
primeras 0 _ = []
primeras _ [] = []
primeras n (carta : cartas) = carta : primeras (n-1) cartas

-- >>> cartasAColores unasCartas
-- [Azul, Azul, Verde]

cartasAColores :: [Carta] -> [Color]
cartasAColores [] = []
cartasAColores (carta : otrasCartas) = color carta : cartasAColores otrasCartas

-- cartasAColores (CartaNumerica 3 Rojo : CartaNumerica 4 Verde : CartaNumerica 5 Azul : [])
-- color (CartaNumerica 3 Rojo) : cartasAColores (CartaNumerica 4 Verde : CartaNumerica 5 Azul : [])
-- Rojo : color (CartaNumerica 4 Verde) : cartasAColores (CartaNumerica 5 Azul : [])
-- Rojo : Verde : color (CartaNumerica 5 Azul) : cartasAColores []
-- Rojo : Verde : Azul : []
