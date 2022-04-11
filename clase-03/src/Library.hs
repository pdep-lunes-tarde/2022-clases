module Library where
import PdePreludat

ochoAzul :: Carta
ochoAzul = CartaNumerica 8 Azul

-- type Carta = (Number, Color)

-- data Valor =
--     Uno |
--     Dos |
--     Tres |
--     Cuatro | 
--     Cinco |
--     Seis |
--     Siete |
--     Ocho |
--     Nueve |
--     Cero |
--     Reversa |
--     SaltarTurno
--     deriving (Eq, Show)
-- data Carta = Carta Valor Color deriving (Eq, Show)


data Simbolo = Reversa | Mas4 | SaltarTurno deriving (Eq, Show)
-- False, True :: Bool
data Color = Rojo | Amarillo | Verde | Azul deriving (Eq, Show)

data Carta =
    CartaNumerica { numero :: Number, color :: Color } |
    CartaEspecial { simbolo :: Simbolo, color :: Color }
    deriving (Eq, Show)

-- instance Eq Carta where
--     (CartaNumerica unNumero unColor) == (CartaNumerica otroNumero otroColor) = unNumero == otroNumero && unColor == otroColor
    
--     (CartaEspecial unSimbolo unColor) == (CartaEspecial otroSimbolo otroColor) = unSimbolo == otroSimbolo && unColor == otroColor
    
--     _ == _ = False
    

sePuedeJugar :: Carta -> Carta -> Bool
-- sePuedeJugar _ (CartaEspecial simbolo _)
--     | simbolo == Mas4 = True
sePuedeJugar _ (CartaEspecial Mas4 _) = True
sePuedeJugar unaCarta otraCarta =
    tienenMismoValor unaCarta otraCarta ||
    tienenMismoColor unaCarta otraCarta

-- data Carta =
--     CartaNumerica Number Color |
--     CartaEspecial Simbolo Color
--     deriving (Eq, Show)

-- numero :: Carta -> Number
-- numero (CartaNumerica unNumero _) = unNumero

-- simbolo :: Carta -> Simbolo
-- simbolo (CartaEspecial unSimbolo _) = unSimbolo

-- color :: Carta -> Color
-- color (CartaNumerica numero unColor) = unColor
-- color (CartaEspecial simbolo unColor) = unColor


tienenMismoValor :: Carta -> Carta -> Bool
tienenMismoValor (CartaNumerica unNumero _) (CartaNumerica otroNumero _) = unNumero == otroNumero

tienenMismoValor (CartaEspecial unSimbolo _) (CartaEspecial otroSimbolo _) = unSimbolo == otroSimbolo

tienenMismoValor _ _ = False

tienenMismoColor :: Carta -> Carta -> Bool
tienenMismoColor unaCarta otraCarta = color unaCarta == color otraCarta

-- fst :: (a, b) -> a

-- Queremos saber si una carta del Uno se puede jugar luego de otra.

-- Las cartas que tienen numero y color, se pueden jugar sobre cartas que tengan el mismo numero o el mismo color.

-- Las cartas de reversa o saltear turno que también tienen color, se pueden jugar sobre otra carta de la misma figura o del mismo color.

-- Finalmente, las cartas de +4 cambian el color así que se pueden jugar sobre cualquier otra carta.
