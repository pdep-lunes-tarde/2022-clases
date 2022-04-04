module Library where
import PdePreludat
import Data.List (isPrefixOf, isSuffixOf)

-- Tomas
-- Carolina
-- Joaquin
-- Manuel
-- Juani
-- Franco
-- Martin
-- Matias

-- versión refactorizada (mas declarativa):
preguntar :: String -> String
preguntar oracion = agregarSignoDePreguntaQueAbre (agregarSignoDePreguntaQueCierra oracion)

agregarSignoDePreguntaQueCierra :: String -> String
agregarSignoDePreguntaQueCierra oracion
    | not (tieneSignoDePreguntaQueCierra oracion) = oracion ++ "?"
    | otherwise = oracion

agregarSignoDePreguntaQueAbre :: String -> String 
agregarSignoDePreguntaQueAbre oracion
    | not (tieneSignoDePreguntaQueAbre oracion) = "¿" ++ oracion
    | otherwise = oracion

tieneSignoDePreguntaQueCierra :: String -> Bool
tieneSignoDePreguntaQueCierra oracion = isSuffixOf "?" oracion

tieneSignoDePreguntaQueAbre :: String -> Bool
tieneSignoDePreguntaQueAbre oracion = isPrefixOf "¿" oracion

-- versión sin refactorizar:
preguntar' :: String -> String
preguntar' oracion 
    | isSuffixOf "?" oracion && isPrefixOf "¿" oracion = oracion
    | not (isSuffixOf "?" oracion) && not (isPrefixOf  "¿" oracion) = "¿" ++ oracion ++ "?"
    | not (isSuffixOf "?" oracion) = oracion ++ "?"
    | otherwise = "¿" ++ oracion

-- isPrefixOf nos dice si un string empieza con otro string
-- isSuffixOf nos dice si un string termina con otro string
-- ++

-- >>> isSuffixOf "ojos" "anteojos"
-- True
--
-- >>> isPrefixOf "ante" "anteojos"
-- True
--
-- >>> "hola " ++ "mundo"
-- "hola mundo"

-- Queremos que funcione así:
-- >>> preguntar "hola"
-- "¿hola?"
-- >>> preguntar "hola?"
-- "¿hola?"
-- >>> preguntar "¿hola?"
-- "¿hola?"
