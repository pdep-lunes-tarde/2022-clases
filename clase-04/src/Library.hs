module Library where
import PdePreludat

data Simbolo = Reversa | Mas4 | SaltarTurno deriving (Eq, Show)

data Color = Rojo | Amarillo | Verde | Azul deriving (Eq, Show)

data Carta =
    CartaNumerica { numero :: Number, color :: Color } |
    CartaEspecial { simbolo :: Simbolo, color :: Color }
    deriving (Eq, Show)

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
ultimaCarta = implementame

-- >>> primeras 1 unasCartas
-- [CartaNumerica 0 Azul]
-- >>> primeras 2 unasCartas
-- [CartaNumerica 0 Azul, CartaNumerica 1 Azul]
primeras n cartas = implementame

-- >>> cartasAColores unasCartas
-- [Azul, Azul, Verde]
cartasAColores cartas = implementame